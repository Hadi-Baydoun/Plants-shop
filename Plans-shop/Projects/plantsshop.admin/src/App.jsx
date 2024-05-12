import * as React from "react";
import { createTheme, styled, ThemeProvider } from "@mui/material/styles";
import Box from "@mui/material/Box";
import CssBaseline from "@mui/material/CssBaseline";
import TopBar from "./components/TopBar";
import SideBar from "./components/SideBar";
import { getDesignTokens } from "./theme";
import { Outlet, useLocation } from "react-router-dom";

const DrawerHeader = styled("div")(({ theme }) => ({
    display: "flex",
    alignItems: "center",
    justifyContent: "flex-end",
    padding: theme.spacing(0, 1),
    // necessary for content to be below app bar
    ...theme.mixins.toolbar,
}));

export default function MiniDrawer() {
    const [open, setOpen] = React.useState(false);
    const location = useLocation();

    const handleDrawerOpen = () => {
        setOpen(true);
    };

    const handleDrawerClose = () => {
        setOpen(false);
    };
    const [mode, setMode] = React.useState(
        localStorage.getItem("currentMode")
            ? localStorage.getItem("currentMode")
            : "light"
    );
    const [searchTerm, setSearchTerm] = React.useState(""); // Add searchTerm state

    const handleSearch = (event) => {
        setSearchTerm(event.target.value);
    };
    const theme = React.useMemo(() => createTheme(getDesignTokens(mode)), [mode]);

    return (
        <ThemeProvider theme={theme}>
            <Box sx={{ display: "flex" }}>
                <CssBaseline />
                {location.pathname !== "/" && (
                    <>
                        <TopBar
              open={open}
              handleDrawerOpen={handleDrawerOpen}
              setMode={setMode}
              handleSearch={handleSearch} // Pass handleSearch to TopBar
            />
                        <SideBar open={open} handleDrawerClose={handleDrawerClose} />
                    </>
                )}
                <Box component="main" sx={{ flexGrow: 1, p: 3 }}>
                    <DrawerHeader />
                    <Outlet context={{ searchTerm }} />
                </Box>
            </Box>
        </ThemeProvider>
    );
}
