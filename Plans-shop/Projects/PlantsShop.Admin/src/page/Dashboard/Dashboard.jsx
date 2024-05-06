import {
    Box,
    Button,
    Card,
    CardActions,
    CardContent,
    CardMedia,
    Grid,
    Pagination,
    Stack,
    TextField,
    Typography,
    Modal,
    MenuItem,
} from "@mui/material";
import { DownloadOutlined } from "@mui/icons-material";
import Header from "../../components/Header";
import { useState, useEffect } from "react";
import axios from 'axios';

const PRODUCTS_PER_PAGE = 7;

const Dashboard = () => {
    const [page, setPage] = useState(1);
    const [open, setOpen] = useState(false);
    const [editProduct, setEditProduct] = useState(null);
    const [apiHost, setApiHost] = useState("");
    const [products, setProducts] = useState([]);
    const [subcategories, setSubcategories] = useState([]);
    const [selectedCategory, setSelectedCategory] = useState(null);
   

    
    const fetchProducts = () => {
        axios
            .get("/src/assets/Constants.json")
            .then((response) => {
                const apiBaseUrl = response.data.API_HOST;
                setApiHost(apiBaseUrl);
                return axios.get(`${apiBaseUrl}/api/Products/all`);
            })
            .then((response) => {
                const productsData = response.data.map(product => {
                    
                    return {
                        ...product,
                        categoryName: product.subCategories.category.name
                    };
                });
                setProducts(productsData);
            })
            .catch((error) => {
                console.error("Error fetching products:", error);
            });

        axios
            .get("/src/assets/Constants.json")
            .then((response) => {
                const apiBaseUrl = response.data.API_HOST;
                return axios.get(`${apiBaseUrl}/api/SubCategories/all`);
            })
            .then((response) => {
                setSubcategories(response.data);
            })
            .catch((error) => {
                console.error("Error fetching subcategories:", error);
            });
    };

    useEffect(fetchProducts, []);


const handleOpen = (product) => {
    setEditProduct(product);
    setOpen(true);
};

const handleClose = () => {
    setOpen(false);
    setEditProduct(null);
};

const handleEdit = (field, value) => {
    setEditProduct((prev) => {
        switch (field) {
            case "Name":
                return { ...prev, name: value };
            case "Description":
                return { ...prev, description: value };
            case "ImageUrl":
                return { ...prev, image_url: value };
            case "Quantity":
                return { ...prev, quantity: parseInt(value) };
            case "Price":
                return { ...prev, price: parseFloat(value) };
            case "Rating":
                return { ...prev, rating: parseFloat(value) };
            case "sub_categories_id":
                // Find the selected subcategory
                const selectedSubcategory = subcategories.find(
                    (subcategory) => subcategory.id === parseInt(value)
                );
                return {
                    ...prev,
                    sub_categories_id: parseInt(value),
                    subCategories: selectedSubcategory,
                };
            default:
                return prev;
        }
    });
};

const handleSave = () => {
    axios
        .get("/src/assets/Constants.json")
        .then((response) => {
            const apiBaseUrl = response.data.API_HOST;
            return axios.put(`${apiBaseUrl}/api/Products/update`, editProduct);
        })
        .then((response) => {
            setProducts((prevProducts) =>
                prevProducts.map((product) =>
                    product.id === response.data.id ? response.data : product
                )
            );
            alert("Product updated successfully!");
        })
        .catch((error) => {
            console.error("Error updating product:", error);
            alert("Error updating product.");
        });
    handleClose();
    };

    const filteredProducts = selectedCategory
        ? products.filter(
            (product) =>
                product.subCategories &&
                product.subCategories.category &&
                product.subCategories.category.name === selectedCategory
        )
        : products;




    const startIndex = (page - 1) * PRODUCTS_PER_PAGE;
    const endIndex = startIndex + PRODUCTS_PER_PAGE;
    const displayedProducts = products.slice(startIndex, endIndex);
    const totalPages = Math.ceil(products.length / PRODUCTS_PER_PAGE);
    const uniqueCategories = new Set();

    subcategories.forEach((subcategory) => {
        if (subcategory.category) {
            uniqueCategories.add(subcategory.category.name);
        }
    });

    const uniqueCategoryArray = Array.from(uniqueCategories);

    return (
        <Box p={1}>
            <Stack direction="row" justifyContent="space-between" alignItems="center">
                <Header
                    isDashboard={true}
                    title="DASHBOARD"
                    subTitle="Welcome to your dashboard"
                />

                <Box sx={{ textAlign: "right", mb: 1.3 }}>
                    
                    <TextField
                        color="primary"
                        select
                        label="Filter "
                        value={selectedCategory}
                        onChange={(e) => setSelectedCategory(e.target.value)}
                        sx={{ minWidth: "150px", marginRight: "10px" }}
                    >
                        <MenuItem value={null}>All</MenuItem>
                        {uniqueCategoryArray.map((categoryName) => (
                            <MenuItem key={categoryName} value={categoryName}>
                                {categoryName}
                            </MenuItem>
                        ))}
                    </TextField>
                </Box>
            </Stack>

            <Grid container spacing={2} mt={0}>
                {filteredProducts.map((product, index) => (
                    
                    
                    <Grid item xs={12} sm={6} md={4} lg={3} key={index}>
                        <Card sx={{ display: 'flex', flexDirection: 'column', height: '100%' }}>
                            <CardMedia
                                component="img"
                                height="190"
                                image={product.image_url}
                                alt={product.name}
                                sx={{ objectFit: "cover" }}
                            />
                            <CardContent sx={{ flex: '1 0 auto' }}>
                                <Typography
                                    gutterBottom
                                    variant="h6"
                                    component="div"
                                    noWrap
                                    sx={{ overflow: "hidden", textOverflow: "ellipsis" }}
                                >
                                    {product.name}
                                </Typography>
                                
                                <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                                    Rating: {product.rating}
                                </Typography>
                                <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                                    Quantity: {product.quantity}
                                </Typography>
                                <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                                    Price: ${product.price}
                                </Typography>
                                <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                                    Category: {product.subCategories?.category?.name}
                                </Typography>
                                <Typography variant="body2" color="text.secondary" sx={{ mb: 1 }}>
                                    SubCategory: {product.subCategories?.name}
                                </Typography>
                                
                            </CardContent>
                            <CardActions>
                                <Button
                                    size="small"
                                    color="primary"
                                    onClick={() => handleOpen(product)}
                                >
                                    Edit
                                </Button>
                                <Button size="small" color="secondary">
                                    Delete
                                </Button>
                            </CardActions>
                        </Card>
                    </Grid>
                ))}
            </Grid>


            
            <Box display="flex" justifyContent="center" mt={2}>
                <Pagination
                    count={totalPages}
                    page={page}
                    onChange={(event, value) => setPage(value)}
                    color="primary"
                />
            </Box>

            {editProduct && (
                <Modal
                    open={open}
                    onClose={handleClose}
                    sx={{
                        display: "flex",
                        alignItems: "center",
                        justifyContent: "center",
                        backdropFilter: "blur(5px)",
                    }}
                >
                    <Card sx={{ width: { xs: '90%', sm: 600, md: 700 }, p: 2 }}>
                        {/*<CardMedia
                            component="img"
                            height="200"
                            image={editProduct.imageUrl}
                            alt={editProduct.name}
                            sx={{ objectFit: "cover", mb: 2 }}
                        />*/}
                        <CardContent>
                            <Stack spacing={2}>
                                

                                <TextField
                                    fullWidth
                                    label="Name"
                                    value={editProduct.name}
                                    onChange={(e) => handleEdit("Name", e.target.value)}
                                />
                                <TextField
                                    fullWidth
                                    multiline
                                    rows={2}
                                    label="Description"
                                    value={editProduct.description}
                                    onChange={(e) => handleEdit("Description", e.target.value)}
                                />
                                {/*<Button
                                    variant="outlined"
                                    component="label"
                                    color="primary"
                                >
                                    Change Image
                                    <input
                                        type="file"
                                        hidden
                                        accept="image/*"
                                        onChange={(e) => handleEdit("imageUrl", URL.createObjectURL(e.target.files[0]))}
                                    />
                                </Button>*/}
                                <TextField
                                    fullWidth
                                    label="Rating"
                                    type="number"
                                    sx={{ flex: 1 }}
                                    value={editProduct.rating}
                                    onChange={(e) => handleEdit("Rating", e.target.value)}
                                />
                                <TextField
                                    fullWidth
                                    label="Quantity"
                                    type="number"
                                    value={editProduct.quantity}
                                    sx={{ flex: 1 }}
                                    onChange={(e) => handleEdit("Quantity", e.target.value)}
                                />
                                <TextField
                                    fullWidth
                                    label="Price"
                                    type="number"
                                    sx={{ flex: 1 }}
                                    value={editProduct.price}
                                    onChange={(e) => handleEdit("Price", e.target.value)}
                                />
                                <TextField
                                    variant="filled"
                                    select
                                    label="Subcategory"
                                    value={editProduct.sub_categories_id}
                                    onChange={(e) => handleEdit("sub_categories_id", e.target.value)}
                                >
                                    {subcategories.map((subcategory) => (
                                        <MenuItem key={subcategory.id} value={subcategory.id}>
                                            {subcategory.name}
                                        </MenuItem>
                                    ))}
                                </TextField>
                                </Stack>
                            
                        </CardContent>
                        <CardActions sx={{ justifyContent: "center" }}>
                            <Button fullWidth color="primary" onClick={handleSave}>
                                Save
                            </Button>
                        </CardActions>
                    </Card>
                </Modal>
            )}

        </Box>
    );
};

export default Dashboard;
