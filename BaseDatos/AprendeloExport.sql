-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-08-2017 a las 09:12:55
-- Versión del servidor: 10.1.16-MariaDB
-- Versión de PHP: 5.6.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nodoscognitivos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `ID` int(11) NOT NULL,
  `PASS` varchar(10) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL,
  `NICK` varchar(15) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `ESTADO` bit(1) DEFAULT b'1',
  `IDCARGO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`ID`, `PASS`, `NOMBRE`, `NICK`, `EMAIL`, `ESTADO`, `IDCARGO`) VALUES
(1, '123', 'Genaro Alvarez', 'Naro', 'naroalvarez97@gmail.com', b'1', 1),
(3, '123', 'Natalia Oviedo', 'Naty', 'natalia_o_95@hotmail.com', b'1', 1),
(4, '123', 'Eddy Escalante', 'Eddy', 'eddy,escalante.u@hotmail.com', b'1', 2);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `IDCARGO` (`IDCARGO`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`IDCARGO`) REFERENCES `cargo` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
