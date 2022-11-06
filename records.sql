-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 06 2022 г., 19:17
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tires`
--

-- --------------------------------------------------------

--
-- Структура таблицы `records`
--

CREATE TABLE `records` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` varchar(5) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `records`
--

INSERT INTO `records` (`id`, `date`, `time`, `name`, `phone`, `email`) VALUES
(1, '2022-10-30', '10:30', 'Ivan', '79111243222', 'kaunas16@gmail.com'),
(15, '2022-11-01', '10:00', 'Юрий', '89111243222', 'kaunas16@gmail.com'),
(37, '2022-10-26', '14:00', 'ddddddddd', '2222222', 'zzz@xxx.c'),
(40, '2022-11-01', '10:30', 'fffffff', '11111111', 'xxx@eee.h'),
(41, '2022-11-01', '11:00', 'sssssss', '1111111', 'xxx@eee.h'),
(42, '2022-11-01', '14:00', 'sssssss', '222222', 'zzz@dd.h'),
(43, '2022-11-01', '16:00', 'ттттттттт', '2222222', 'xxx@ss.x'),
(44, '2022-11-01', '13:00', 'gggggggg', '222222222', 'aaa@www.c'),
(45, '2022-11-01', '14:30', 'ввввввв', '22222222', 'xxx@dsds.v'),
(48, '2022-11-01', '16:30', 'dddddd', '222222', 'xx@ss.f'),
(58, '2022-12-02', '10:30', 'gfdgd', '23423423', 'xx@cc.x'),
(60, '2022-10-07', '11:30', 'dfgdfgdg', '43242342', 'xxx@ss.c'),
(83, '2022-11-02', '09:00', 'qqqqqqq', '111111111', 'sss@dd.c'),
(84, '2022-11-02', '10:00', 'dddddddd', '222222222', 'sss@dd.c'),
(85, '2022-11-01', '09:00', 'ddddddddd', '555555555', 'sss@dd.c'),
(86, '2022-11-02', '10:30', 'ggggggg', '222222222', '2323@ddd.e'),
(91, '2022-10-31', '17:00', 'zzzzzzz', '333333333', 'sd@dd.v'),
(92, '2022-10-31', '10:00', 'dfsdfsdf', '2222222', 'sd@dd.v'),
(93, '2022-10-31', '13:00', 'cccccccccccc', '1111111111', 'sd@dd.v'),
(96, '2022-10-31', '11:00', 'пвыпавапвап', '11212112', 'sadasd@sd.c'),
(99, '2022-11-03', '10:00', 'fdgdfg', '234234234', 'sss@dd.d'),
(100, '2022-11-03', '10:30', 'dfgdfg', '123123123', 'sss@dd.d'),
(101, '2022-11-03', '11:00', 'sdfsdf', '234234', 'sss@dd.d'),
(102, '2022-11-03', '09:00', 'fghfhfgh', '42424234', 'sss@dd.d'),
(103, '2022-11-03', '09:30', 'ghfghfhfgh', '1231231231', 'sss@dd.d'),
(104, '2022-11-03', '12:00', 'xvcvxcv', '32424234', 'sss@dd.d'),
(105, '2022-11-03', '12:30', 'fgdfgdfg', '423423423', 'sss@aaa.e'),
(106, '2022-11-03', '13:00', 'dfgdfgdf', '424234234', 'sss@aaa.e'),
(107, '2022-11-03', '13:30', 'qqqqqqq', '22222222222', 'xxx@ss.r'),
(116, '2022-11-01', '09:30', 'fdgdfgdfg', '234234234', 'xxx@ss.r'),
(118, '2022-11-07', '11:00', 'ddddddddd', '1111111111', 'xxxxx@x.x'),
(120, '2022-11-03', '16:00', 'gggggggg', '22222222222', 'dsd@dd.c'),
(123, '2022-11-04', '09:00', 'sdfsdfs', '2323222', 'ddsd@s.r'),
(125, '2022-11-04', '09:30', 'qqqqqqq', '111111111', 'ss@ee.t'),
(126, '2022-11-04', '10:00', 'hhhhhhhhhh', '222222', 'ccc@s.r'),
(127, '2022-11-04', '10:30', 'dddddddd', '3233333333', 'ccc@s.r'),
(128, '2022-11-04', '11:00', 'ffffffffff', '23232323', 'ccc@s.r'),
(129, '2022-11-04', '11:30', 'dffdfdf', '22222222222', 'ccc@s.r'),
(130, '2022-11-04', '12:00', 'bbbbbbbb', '11111111111', 'ccc@s.r'),
(131, '2022-11-04', '12:30', 'fffffffffffff', '3333333333', 'ccc@s.r'),
(132, '2022-11-04', '13:00', 'ggggggggg', '555555555', 'ccc@s.r'),
(135, '2022-11-04', '14:30', 'jjjjjjjjjjj', '121221212', 'ccc@s.r'),
(136, '2022-11-04', '15:00', 'hhhhhhhhhhh', '2222222222', 'ccc@s.r'),
(137, '2022-11-04', '15:30', 'mmmmmmmmm', '999999999', 'ccc@s.r'),
(138, '2022-11-04', '16:00', 'hhhhhhhhh', '67867868', 'ccc@s.r'),
(139, '2022-11-04', '16:30', 'ewwwwwwwwwwwww', '44444444', 'ccc@s.r'),
(140, '2022-11-04', '17:00', 'bbbbbbb', '5798797089', 'ccc@s.r'),
(141, '2022-11-04', '17:30', 'bvnvbnvbnvnb', '542342342', 'ccc@s.r'),
(142, '2022-11-04', '13:30', 'ggggggg', '222222222', 'asas@d.u'),
(144, '2022-11-09', '10:30', 'sdfsdfsfd', '2323232323', 'sds@hgh.t'),
(146, '2022-11-04', '14:00', 'ssssssssss', '22222222', 'zsdzs@ds.g'),
(147, '2022-11-05', '09:00', 'Ivan', '1111111111', 'zzz@z.r'),
(148, '2022-11-05', '09:30', 'rfgiurtf', '2134214', '21r1.22@vg.vc'),
(149, '2022-11-05', '10:00', 'xcvxvc', '424234234', 'zxczcz@sa.r'),
(150, '2022-11-05', '10:30', 'aaaaaaaa', '111111111', 'd@e.e'),
(153, '2022-11-05', '11:00', 'оооооо', '227777777', 'ds.e.e@d.d'),
(154, '2022-11-05', '11:30', 'aaaaaaaaa', '9878888888', 'xz@s.r'),
(155, '2022-11-05', '12:00', 'fghfghfg', '312312312', 'sdzs@ad.r'),
(156, '2022-11-05', '12:30', 'fgfgfgfg', '11111111', 'ddd@dd.t'),
(157, '2022-11-05', '14:30', 'ssdssss', '77877878', 's@sdsd.r'),
(158, '2022-11-05', '13:00', 'sssssssssss', '22222222', 'zsdsd@zdszd.r'),
(159, '2022-11-05', '13:30', 'fdgdfg', '231231', 'zsd@sd.r'),
(160, '2022-11-05', '14:00', 'dsfsdfsdf', '2134234', 'zxczx@r.r'),
(161, '2022-11-05', '15:00', 'vxcvxcvx', '312312342', 'asd@asd.r'),
(167, '2022-11-03', '15:00', 'ddddddddd', '77777777', 'df@sd.y'),
(168, '2022-11-05', '16:00', 'nnnnnnnnn', '88888888888', 'sd@ds.t'),
(169, '2022-11-09', '17:30', 'dfddddd', '345635345', 'df@sd.t'),
(170, '2022-11-05', '16:30', 'ffffffffffffff', '3333333333', 'ccczxc@zdsz.r'),
(171, '2022-11-06', '13:30', 'xvxcvxcvxcv', '31231231231', 'zzdzdz@sds.e'),
(172, '2022-11-10', '09:00', 'cvzxcz', '4324234234', 'dfsf@fdfdfs.hh'),
(173, '2022-11-06', '09:00', '2022-11-06', '222222', 'sd@sa.r'),
(174, '2022-11-06', '09:30', 'sdsdsd', '23232332', 'xcc@zxz.r'),
(176, '2022-11-06', '11:00', 'cccccccc', '23423423424', 'cxvx@sdasd.r');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `records`
--
ALTER TABLE `records`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `records`
--
ALTER TABLE `records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=177;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
