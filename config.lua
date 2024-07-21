Config = {}

Config.ImpoundLots = {
	Sandy = {
		Pos = {x=489.48, y= -1309.04, z= 29.32},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 2,
		DropoffPoint = {
			Pos = {x=489.48, y= -1309.04, z= 29.32},
			Color = {r=58,g=100,b=122},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 2
		},
		RetrievePoint = {
			Pos = {x=498.39, y= -1334.18, z= 29.0},
			Color = {r=0,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 2
		},
	},

	Sandy2 = {
		Pos = {x= 492.68, y = -1319.08, z = 29.04},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 2,
		DropoffPoint = {
			Pos = {x=481.68, y= -1316.8, z= 29.0},
			Color = {r=58,g=100,b=122},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 2
		},
		RetrievePoint = {
			Pos = {x=498.39, y= -1334.18, z= 29.0},
			Color = {r=0,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker = 2
		},
	}
}

Config.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Config.Garage = {

    ['Garage_A'] = {
        ['ritiro'] = vector3(219.4549, -811.4374, 30.71204),
        ['deposito'] = vector3(231.65, -796.08, 30.57),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_B'] = {
        ['ritiro'] = vector3(-899.275, -153.0, 41.88),
        ['deposito'] = vector3(-901.989, -159.28, 41.46),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_C'] = {
        ['ritiro'] = vector3(275.182, -345.534, 45.173),
        ['deposito'] = vector3(266.498, -332.475, 43.43),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_D'] = {
        ['ritiro'] = vector3(-833.255, -2351.34, 14.57),
        ['deposito'] = vector3(-823.68, -2342.975, 13.803),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_E'] = {
        ['ritiro'] = vector3(-2162.82, -377.15,13.28),
        ['deposito'] = vector3(-2169.21, -372.25, 13.08),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_F'] = {
        ['ritiro'] = vector3(112.23, 6619.66, 31.82),
        ['deposito'] = vector3(115.81,6599.34, 32.01),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_G'] = {
        ['ritiro'] = vector3(2768.34, 3462.92, 55.63),
        ['deposito'] = vector3(2772.88, 3472.32, 55.46),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_H'] = {
        ['ritiro'] = vector3(1951.79, 3750.95, 32.16),
        ['deposito'] = vector3(1949.57, 3759.33, 32.21),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_I'] = {
        ['ritiro'] = vector3(1899.46, 2605.26, 45.97),
        ['deposito'] = vector3(1875.88, 2595.20, 45.67),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_J'] = {
        ['ritiro'] = vector3(-739.4506, -278.3868, 36.94653),
        ['deposito'] = vector3(-738.1714, -268.8791, 36.94653),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_K'] = {
        ['ritiro'] = vector3(570.24, 2797.07, 42.01),
        ['deposito'] = vector3(588.78, 2791.1, 42.16),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_L'] = {
        ['ritiro'] = vector3(889.24, -53.87, 78.91),
        ['deposito'] = vector3(886.12, -62.68, 78.76),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_M'] = {
        ['ritiro'] = vector3(-1184.85, -1510.05, 4.65),
        ['deposito'] = vector3(-1183.01, -1495.34, 4.38),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_N'] = {
        ['ritiro'] = vector3(362.28, 298.39, 103.88),
        ['deposito'] = vector3(377.9, 288.46, 103.17),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_O'] = {
        ['ritiro'] = vector3(2434.69, 5011.78, 64.84),
        ['deposito'] = vector3(2451.71, 5033.78, 44.91),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_P'] = {
        ['ritiro'] = vector3(-73.28, -1835.79, 26.94),
        ['deposito'] = vector3(-60.76, -1834.67, 26.75),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_Q'] = {
        ['ritiro'] = vector3(1036.67, -763.43, 57.99),
        ['deposito'] = vector3(1020.1, -766.99, 57.93),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_R'] = {
        ['ritiro'] = vector3(1366.22, -1833.79, 57.92),
        ['deposito'] = vector3(1359.46, -1849.11, 57.23),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_S'] = {
        ['ritiro'] = vector3(-73.04, 909.85, 235.63),
        ['deposito'] = vector3(-68.1, 897.9, 235.56),
        ['heading'] = 150.0,
        ['showBlip'] = false
    },

    
    ['Garage_T'] = {
        ['ritiro'] = vector3(-281.08157348633, -888.11169433594, 31.3180103302),
        ['deposito'] = vector3(-300.7912, -887.6176, 31.06592),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_Sofia'] = { -- 801
        ['ritiro'] = vector3(-3192.29, 822.778, 8.925293),
        ['deposito'] = vector3(-3197.604, 816.6989, 8.925293),
        ['heading'] = 175.748,
        ['showBlip'] = false
    },

    ['Garage_U'] = {
        ['ritiro'] = vector3(2763, 1346.56, 24.52),
        ['deposito'] = vector3(2732.62, 1329.28, 24.52),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_V'] = {
        ['ritiro'] = vector3(392.31, -1631.9, 29.29),
        ['deposito'] = vector3(391.43, -1620.23, 29.29),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_W'] = {
        ['ritiro'] = vector3(-1676.86, 66.82, 63.89),
        ['deposito'] = vector3(-1671.11, 74.16, 63.72),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_X'] = {
        ['ritiro'] = vector3(100.1011, -1073.367, 29.36414),
        ['deposito'] = vector3(132.3033, -1080.765, 29.17871),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_Y'] = {
        ['ritiro'] = vector3(-1679.68, 494.712, 128.87),
        ['deposito'] = vector3(-1668.27, 499.63, 128.39),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },

    ['Garage_Z'] = {
        ['ritiro'] = vector3(-3051.178, 135.6, 11.57068),
        ['deposito'] = vector3(-3037.398, 142.5626, 11.60437),
        ['heading'] = 150.0,
        ['showBlip'] = true
    },
}

Config.AuthorizedRanks = {
    'superadmin',
   'admin'
  }