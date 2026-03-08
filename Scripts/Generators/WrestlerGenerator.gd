@tool
extends EditorScript

# CRITICAL: Preload WrestlerResource to ensure consistent enum values
# This prevents enum mismatches when script is loaded via ResourceLoader.load()
const WrestlerResourceScript = preload("res://Scripts/Data/WrestlerData.gd")

# Hierarchical Country → Continent structure for 1000 wrestlers across 23 countries
var regions = {
    "North America": {
        "USA": {
            "male": ["Jax", "Knox", "Maverick", "Colton", "Wyatt", "Brooks", "Sawyer", "Bennett", "Weston", "Ryker", "Ace", "Nash", "Beau", "Wilder", "Gage", "Ford", "Tanner", "Briggs", "Dusty", "Duke", "Clayton", "Colt", "Gunner", "Trey", "Brock", "Dash"],
            "female": ["Skye", "Willow", "Sable", "Amber", "Piper", "Harper", "Hadley", "Shelby", "Sloane", "Raven", "Ivy", "Scarlett", "Ruby", "Jade", "Sierra", "Dakota", "Savannah", "Misty", "Summer", "Blair", "Phoenix", "Storm", "Blaze", "Nova"],
            "last": ["Sterling", "Blackwood", "Thorne", "Vanguard", "Steele", "Rhodes", "Rollins", "Reigns", "Styles", "Mercer", "Creed", "Vaughn", "Cade", "Cage", "Chase", "Dixon", "Ford", "Gunn", "Hart", "Nash", "Cross", "Wolf", "Knight", "Stone"]
        },
        "Canada": {
            "male": ["Owen", "Bret", "Edge", "Tyler", "Brett", "Connor", "Liam", "Noah", "Ethan", "Lucas", "Mason", "Logan", "Jackson", "Aiden", "Jacob", "Matthew", "Nathan", "Ryan", "Dylan", "Hunter", "Evan", "Cole", "Alex", "Adam"],
            "female": ["Emma", "Olivia", "Ava", "Sophie", "Chloe", "Emily", "Madison", "Abigail", "Hannah", "Grace", "Ella", "Victoria", "Lily", "Mia", "Zoe", "Nora", "Harper", "Scarlett", "Aria", "Luna", "Hazel", "Ivy", "Ruby", "Violet"],
            "last": ["Tremblay", "Gagnon", "Roy", "Cote", "Bouchard", "Gauthier", "Morin", "Lavoie", "Fortin", "Gagne", "Pelletier", "Belanger", "Levesque", "Bergeron", "Leblanc", "Paquette", "Beaulieu", "Girard", "Simard", "Boucher", "Carrier", "Dube", "Page", "Young"]
        },
        "Mexico": {
            "male": ["Rey", "Santos", "Místico", "Penta", "Fénix", "Drago", "Bandido", "Laredo", "Hector", "Andrade", "Hijo", "Negro", "Volador", "Atlantis", "Caristico", "Diamante", "Valiente", "Dragon", "Guerrero", "Ultimo", "Rush", "Terrible", "Mephisto", "Averno"],
            "female": ["Faby", "Princesa", "Estrella", "Lady", "Reina", "Tessa", "Keira", "Thunder", "Dalys", "Sienna", "Maravilla", "Stephanie", "Zeuxis", "Amapola", "Marcela", "Lluvia", "Sanely", "Skadi", "Keta", "Metálica", "Mystique", "Tiffany", "Ayako", "Viva"],
            "last": ["Guerrero", "Mysterio", "Almas", "Phoenix", "Zero", "Azteca", "Dragon", "Santo", "Mil", "Lucha", "Canek", "Solar", "Blue", "Panther", "Casas", "Villano", "Perro", "Perros", "Konnan", "Mascara", "Sagrada", "Rayo", "Psicosis", "Juventud"]
        }
    },
    "Latin America": {
        "Brazil": {
            "male": ["João", "Pedro", "Lucas", "Matheus", "Gabriel", "Rafael", "Felipe", "Bruno", "Gustavo", "Thiago", "Vitor", "Diego", "Leonardo", "Rodrigo", "Guilherme", "Fernando", "Marcelo", "André", "Carlos", "Ricardo", "Paulo", "Renato", "Eduardo", "Fabio"],
            "female": ["Ana", "Maria", "Juliana", "Camila", "Fernanda", "Amanda", "Bruna", "Gabriela", "Larissa", "Mariana", "Beatriz", "Carolina", "Letícia", "Priscila", "Rafaela", "Vanessa", "Daniela", "Patricia", "Natália", "Isabela", "Bianca", "Renata", "Aline", "Julia"],
            "last": ["Silva", "Santos", "Oliveira", "Souza", "Rodrigues", "Ferreira", "Alves", "Pereira", "Lima", "Gomes", "Costa", "Ribeiro", "Martins", "Carvalho", "Rocha", "Almeida", "Nascimento", "Araujo", "Barbosa", "Cardoso", "Dias", "Monteiro", "Reis", "Campos"]
        },
        "Argentina": {
            "male": ["Mateo", "Santiago", "Alejandro", "Diego", "Javier", "Carlos", "Manuel", "Joaquin", "Hugo", "Luis", "Felipe", "Rafael", "Marco", "Angel", "Bruno", "Emilio", "Ricardo", "Sergio", "Pablo", "Fernando", "Andrés", "Mauricio", "Ignacio", "Rodrigo"],
            "female": ["Valentina", "Sofia", "Isabella", "Elena", "Camila", "Rosa", "Luciana", "Carmen", "Lola", "Marisol", "Juana", "Beatriz", "Paz", "Alma", "Gabriela", "Fernanda", "Paloma", "Catalina", "Natalia", "Daniela", "Mariana", "Valeria", "Carolina", "Ximena"],
            "last": ["Rodriguez", "Garcia", "Martinez", "Fernandez", "Lopez", "Gonzalez", "Perez", "Sanchez", "Romero", "Diaz", "Torres", "Alvarez", "Ruiz", "Flores", "Morales", "Jimenez", "Herrera", "Medina", "Castro", "Vargas", "Ramos", "Cruz", "Mendoza", "Guzman"]
        }
    },
    "Europe": {
        "England": {
            "male": ["Jack", "Oliver", "Harry", "George", "Noah", "Charlie", "Jacob", "Alfie", "Freddie", "Oscar", "William", "Thomas", "James", "Henry", "Archie", "Leo", "Arthur", "Ted", "Theo", "Finley", "Arlo", "Isaac", "Reggie", "Max"],
            "female": ["Olivia", "Amelia", "Isla", "Ava", "Emily", "Isabella", "Mia", "Poppy", "Ella", "Lily", "Freya", "Sophie", "Grace", "Evie", "Charlotte", "Daisy", "Florence", "Alice", "Sofia", "Sienna", "Matilda", "Evelyn", "Phoebe", "Elsie"],
            "last": ["Smith", "Jones", "Taylor", "Brown", "Williams", "Wilson", "Johnson", "Davies", "Robinson", "Wright", "Thompson", "Evans", "Walker", "White", "Roberts", "Green", "Hall", "Wood", "Jackson", "Clarke", "Hughes", "Edwards", "Hill", "Moore"]
        },
        "Scotland": {
            "male": ["Alistair", "Callum", "Fergus", "Lachlan", "Hamish", "Ewan", "Angus", "Duncan", "Graeme", "Colin", "Stuart", "Gregor", "Ross", "Craig", "Murray", "Fraser", "Logan", "Cameron", "Andrew", "Blair", "Rory", "Magnus", "Brodie", "Finlay"],
            "female": ["Isla", "Eilidh", "Freya", "Erin", "Skye", "Maisie", "Elspeth", "Kirsty", "Fiona", "Morag", "Catriona", "Morven", "Ailsa", "Kenna", "Heather", "Shona", "Mairi", "Rhona", "Struan", "Kirsten", "Fenella", "Iona", "Màiri", "Sorcha"],
            "last": ["Macleod", "Campbell", "Fraser", "Stewart", "MacDonald", "Murray", "Morrison", "Robertson", "Thomson", "Anderson", "Scott", "Reid", "Ferguson", "Grant", "Cameron", "Ross", "Henderson", "Kerr", "Watson", "Duncan", "Mackenzie", "McLean", "Wallace", "Gordon"]
        },
        "Ireland": {
            "male": ["Cillian", "Declan", "Conor", "Liam", "Sean", "Rory", "Padraig", "Niall", "Ciaran", "Tadhg", "Ronan", "Aiden", "Oisin", "Darragh", "Eoin", "Cian", "Fionn", "Killian", "Donal", "Cathal", "Brendan", "Shane", "Colm", "Finn"],
            "female": ["Saoirse", "Siobhan", "Maeve", "Orla", "Caoimhe", "Keira", "Aisling", "Niamh", "Sinead", "Aoife", "Deirdre", "Moira", "Grainne", "Sorcha", "Nuala", "Eileen", "Roisin", "Clodagh", "Ciara", "Eimear", "Brídín", "Nessa", "Treasa", "Eilis"],
            "last": ["O'Sullivan", "Murphy", "Byrne", "O'Neill", "Gallagher", "Boyle", "O'Connor", "Kelly", "McCarthy", "Walsh", "O'Brien", "Ryan", "Kennedy", "Quinn", "McLaughlin", "McMahon", "Doherty", "McGrath", "Doyle", "Brennan", "Burke", "Fitzpatrick", "Kavanagh", "Maguire"]
        },
        "Wales": {
            "male": ["Dylan", "Rhys", "Owen", "Gareth", "Evan", "Morgan", "Dewi", "Llewelyn", "Gruffydd", "Iestyn", "Dafydd", "Cadell", "Emrys", "Gethin", "Iolo", "Idris", "Hywel", "Aneurin", "Bryn", "Carwyn", "Geraint", "Owain", "Rhodri", "Taliesin"],
            "female": ["Megan", "Cerys", "Eira", "Angharad", "Bronwen", "Carys", "Gwen", "Rhiannon", "Seren", "Bethan", "Branwen", "Catrin", "Elen", "Ffion", "Gwenllian", "Lowri", "Mair", "Nerys", "Olwen", "Rhianu", "Siân", "Tegwen", "Tesni", "Nia"],
            "last": ["Williams", "Jones", "Davies", "Evans", "Thomas", "Roberts", "Lewis", "Hughes", "Morgan", "Griffiths", "Edwards", "Owen", "Rees", "Jenkins", "Powell", "Price", "Pritchard", "Phillips", "Lloyd", "Parry", "Watkins", "Richards", "Ellis", "James"]
        },
        "France": {
            "male": ["Bastien", "Remy", "Thibault", "Luc", "Etienne", "Julien", "Olivier", "Hugo", "Marcel", "Pierre", "Laurent", "Antoine", "Alexandre", "François", "Nicolas", "Vincent", "Maxime", "Thomas", "Christophe", "Guillaume", "Philippe", "Jean", "Bernard", "André"],
            "female": ["Amelie", "Camille", "Clémence", "Elodie", "Manon", "Léa", "Chloé", "Adeline", "Sylvie", "Fleur", "Juliette", "Sophie", "Marie", "Nathalie", "Céline", "Isabelle", "Monique", "Sandrine", "Brigitte", "Veronique", "Aurelie", "Delphine", "Elise", "Margaux"],
            "last": ["Beaumont", "Leroy", "Moreau", "Fournier", "Lefebvre", "Mercier", "Dupont", "Fontaine", "Rousseau", "Garnier", "Blanc", "Martin", "Bernard", "Dubois", "Thomas", "Robert", "Richard", "Petit", "Durand", "Lambert", "Bonnet", "Perrin", "Laurent", "Simon"]
        },
        "Germany": {
            "male": ["Gunther", "Wolfgang", "Klaus", "Dieter", "Hans", "Otto", "Stefan", "Fritz", "Kurt", "Lukas", "Viktor", "Helmut", "Heinrich", "Gerhard", "Matthias", "Jürgen", "Manfred", "Reinhard", "Konrad", "Bernhard", "Rainer", "Uwe", "Thomas", "Michael"],
            "female": ["Greta", "Heidi", "Anika", "Elsa", "Hanna", "Petra", "Inge", "Leni", "Marta", "Ursula", "Ingrid", "Helga", "Brigitte", "Liesel", "Monika", "Sabine", "Anneliese", "Gabriele", "Renate", "Christa", "Margot", "Karin", "Ute", "Kerstin"],
            "last": ["Wagner", "Richter", "Schmidt", "Schneider", "Hoffman", "Becker", "Weber", "Fischer", "Meyer", "Schulz", "Müller", "Klein", "Wolf", "Zimmerman", "Krause", "Lange", "Keller", "Koch", "Braun", "Schwarz", "Schroeder", "Neumann", "Bauer", "Vogel"]
        },
        "Italy": {
            "male": ["Alessandro", "Lorenzo", "Paolo", "Marco", "Enrico", "Giovanni", "Luca", "Matteo", "Nico", "Dante", "Sergio", "Fabio", "Dario", "Stefano", "Tommaso", "Filippo", "Giancarlo", "Massimo", "Adriano", "Roberto", "Andrea", "Claudio", "Emilio", "Franco"],
            "female": ["Giulia", "Bianca", "Elena", "Lucia", "Sofia", "Isabella", "Clara", "Francesca", "Alessia", "Chiara", "Martina", "Serena", "Gabriella", "Antonella", "Elisabetta", "Simona", "Veronica", "Paola", "Cristina", "Silvia", "Elisa", "Valentina", "Carla", "Daniela"],
            "last": ["Rossi", "Moretti", "Ferrari", "Russo", "Bianchi", "Romano", "Conti", "Gallo", "Ricci", "Costa", "Mancini", "Lombardi", "Greco", "Bruno", "Marino", "Barbieri", "Parisi", "Caruso", "Colombo", "Esposito", "Vitale", "Santoro", "Leone", "Longo"]
        },
        "Spain": {
            "male": ["Javier", "Rodrigo", "Mateo", "Raul", "Esteban", "Carlos", "Angel", "Hugo", "Diego", "Alberto", "Sergio", "Pablo", "Miguel", "Andrés", "Luis", "Francisco", "Antonio", "José", "Manuel", "Rafael", "Alejandro", "Fernando", "David", "Jorge"],
            "female": ["Carmen", "Valentina", "Rosa", "Elena", "Sofia", "Isabella", "Lucia", "Maria", "Pilar", "Dolores", "Consuelo", "Mercedes", "Teresa", "Beatriz", "Cristina", "Ana", "Paula", "Rocio", "Silvia", "Laura", "Marta", "Nuria", "Sara", "Patricia"],
            "last": ["Castillo", "Vega", "Garcia", "Ortiz", "Sanchez", "Martinez", "Lopez", "Fernandez", "Gomez", "Gonzalez", "Perez", "Rodriguez", "Diaz", "Alvarez", "Moreno", "Jimenez", "Ruiz", "Hernandez", "Suarez", "Vargas", "Castro", "Ramos", "Gil", "Navarro"]
        }
    },
    "Asia": {
        "Japan": {
            "male": ["Hiroshi", "Hideo", "Kenji", "Akira", "Takashi", "Yoshi", "Taro", "Kazuo", "Shin", "Haru", "Ichiro", "Keisuke", "Naoki", "Ryu", "Daichi", "Haruto", "Yuji", "Koji", "Masaru", "Ryuji", "Kaito", "Shiro", "Tetsuo", "Noboru"],
            "female": ["Sakura", "Yuki", "Hana", "Aoi", "Rin", "Kiko", "Momo", "Keiko", "Nanami", "Akari", "Hina", "Yua", "Haruka", "Mei", "Natsuki", "Aya", "Saki", "Yui", "Miho", "Kaori", "Asuka", "Reina", "Mika", "Ayame"],
            "last": ["Sato", "Suzuki", "Takahashi", "Tanaka", "Watanabe", "Ito", "Yamamoto", "Nakamura", "Kobayashi", "Saito", "Kato", "Yoshida", "Kimura", "Hayashi", "Sasaki", "Matsumoto", "Inoue", "Fujita", "Ogawa", "Goto", "Okada", "Hasegawa", "Murakami", "Kondo"]
        },
        "India": {
            "male": ["Arjun", "Ravi", "Sanjay", "Aman", "Siddharth", "Rohan", "Amit", "Vikram", "Rahul", "Aditya", "Karan", "Dev", "Ajay", "Nikhil", "Pranav", "Vishal", "Kunal", "Manish", "Tarun", "Neel", "Yash", "Dhruv", "Ankit", "Varun"],
            "female": ["Ananya", "Priya", "Ishani", "Saira", "Priyanka", "Deepika", "Kavita", "Sita", "Tara", "Aarti", "Neha", "Pooja", "Riya", "Meera", "Shreya", "Nisha", "Anjali", "Divya", "Simran", "Preeti", "Maya", "Swati", "Kiran", "Asha"],
            "last": ["Singh", "Sharma", "Gupta", "Malhotra", "Khan", "Patel", "Reddy", "Kumar", "Iyer", "Verma", "Chopra", "Kapoor", "Nair", "Joshi", "Das", "Rao", "Pillai", "Menon", "Agarwal", "Bose", "Desai", "Mehta", "Banerjee", "Kulkarni"]
        },
        "China": {
            "male": ["Wei", "Jian", "Ming", "Jun", "Long", "Feng", "Qiang", "Lei", "Tao", "Bo", "Chen", "Yang", "Hao", "Lin", "Kai", "Peng", "Rui", "Xin", "Yong", "Gang", "Jie", "Chao", "Hui", "Dong"],
            "female": ["Li", "Mei", "Yan", "Ling", "Xia", "Jing", "Fang", "Min", "Hua", "Qing", "Yun", "Na", "Lan", "Hong", "Xiu", "Ying", "Juan", "Hui", "Ping", "Rong", "Shu", "Xiao", "Yu", "Zhen"],
            "last": ["Wang", "Li", "Zhang", "Liu", "Chen", "Yang", "Huang", "Zhao", "Wu", "Zhou", "Xu", "Sun", "Ma", "Zhu", "Hu", "Guo", "He", "Gao", "Lin", "Luo", "Zheng", "Liang", "Song", "Tang"]
        },
        "South Korea": {
            "male": ["Min-jun", "Ji-ho", "Seo-jun", "Do-yoon", "Si-woo", "Ye-jun", "Yu-jun", "Ji-hu", "Jun-seo", "Geon-woo", "Hyun-woo", "Woo-jin", "Joon", "Tae-yang", "Sang-woo", "Jin-woo", "Seung-hyun", "Jae-min", "Dong-hyun", "Min-ho", "Sung-min", "Chang-min", "Kyung-soo", "Dae-jung"],
            "female": ["Seo-yeon", "Min-seo", "Ji-woo", "Ha-yoon", "Seo-hyun", "Ji-ah", "Yoon-seo", "Soo-ah", "Ji-yoon", "Chae-won", "Ye-eun", "Yu-na", "Eun-ji", "Hye-jin", "Su-bin", "Mi-young", "Joo-hee", "Hee-jin", "Soo-jin", "Na-young", "Da-eun", "Bo-young", "Hae-won", "Yoo-jung"],
            "last": ["Kim", "Lee", "Park", "Choi", "Jung", "Kang", "Cho", "Yoon", "Jang", "Lim", "Han", "Shin", "Seo", "Kwon", "Hwang", "Ahn", "Song", "Hong", "Jeon", "Moon", "Yang", "Baek", "Nam", "Ryu"]
        },
        "Thailand": {
            "male": ["Somchai", "Somsak", "Prasert", "Sombat", "Chaiwat", "Wichai", "Surachai", "Chai", "Anon", "Kittisak", "Narong", "Pongsakorn", "Anucha", "Sarawut", "Thanawat", "Jirawat", "Nattapong", "Sirichai", "Worawut", "Apichat", "Kritsada", "Manop", "Boonsong", "Adisak"],
            "female": ["Siriporn", "Siriwan", "Sasithorn", "Suwannee", "Chanida", "Pimchanok", "Waraporn", "Rattana", "Somying", "Porn", "Pranee", "Wanida", "Pensri", "Kamolwan", "Nattaya", "Chananya", "Duangjai", "Ploypailin", "Suchada", "Apinya", "Arunee", "Busakorn", "Kanokwan", "Monthira"],
            "last": ["Nguyen", "Tran", "Le", "Pham", "Hoang", "Phan", "Vu", "Vo", "Dang", "Bui", "Do", "Ho", "Ngo", "Duong", "Ly", "Srisai", "Kaewkong", "Thongchai", "Rattana", "Sukjai", "Charoensuk", "Boonmee", "Panya", "Wongsuwan"]
        }
    },
    "Africa": {
        "Nigeria": {
            "male": ["Olufemi", "Bamidele", "Chike", "Ade", "Uzoma", "Folarin", "Tunde", "Kwame", "Akeem", "Obi", "Chidi", "Emeka", "Olu", "Femi", "Dele", "Tayo", "Yemi", "Bayo", "Taiwo", "Lekan", "Niyi", "Gbenga", "Tolu", "Segun"],
            "female": ["Nneka", "Oluwa", "Bisi", "Fola", "Adana", "Abena", "Ayana", "Ama", "Akua", "Yaa", "Efua", "Amina", "Makena", "Amara", "Thandiwe", "Naledi", "Lesedi", "Tumelo", "Zola", "Ife", "Nala", "Oluwatoyin", "Ngozi", "Adaeze"],
            "last": ["Okoro", "Adeyemi", "Okonkwo", "Nwachukwu", "Abiola", "Eze", "Okafor", "Igwe", "Onyeka", "Chukwu", "Azubuike", "Nnadi", "Nwosu", "Obiora", "Udoka", "Chukwuma", "Nnamdi", "Ikenna", "Ebube", "Chibuike", "Ifeanyi", "Obinna", "Kosisochukwu", "Chimamanda"]
        },
        "South Africa": {
            "male": ["Thabo", "Sipho", "Bongani", "Mandla", "Jabu", "Sbu", "Andile", "Nkosinathi", "Mpho", "Tshepo", "Zweli", "Sandile", "Lucky", "Welcome", "Gift", "Blessing", "Prince", "Justice", "Wisdom", "Knowledge", "Freedom", "Xolani", "Musa", "Vusi"],
            "female": ["Thandi", "Nomsa", "Zanele", "Precious", "Faith", "Hope", "Grace", "Mercy", "Princess", "Queen", "Angel", "Charity", "Patience", "Bontle", "Lerato", "Kgothatso", "Palesa", "Refilwe", "Tebogo", "Mpho", "Keletso", "Naledi", "Keabetswe", "Boitumelo"],
            "last": ["Nkosi", "Dlamini", "Mthembu", "Zuma", "Khumalo", "Mbatha", "Ngcobo", "Sithole", "Mtshali", "Cele", "Shabalala", "Mkhize", "Buthelezi", "Zungu", "Gumede", "Ndlovu", "Hadebe", "Ntuli", "Nxumalo", "Khoza", "Madonsela", "Vilakazi", "Phiri", "Mokoena"]
        },
        "Ghana": {
            "male": ["Kofi", "Kwesi", "Kwame", "Kweku", "Yaw", "Kojo", "Akwasi", "Ebo", "Fiifi", "Ekow", "Ato", "Manu", "Kumi", "Nii", "Tetteh", "Adjei", "Mensah", "Agyeman", "Boateng", "Osei", "Asante", "Ofori", "Owusu", "Appiah"],
            "female": ["Abena", "Akua", "Ama", "Yaa", "Efua", "Esi", "Adjoa", "Afia", "Akosua", "Adwoa", "Aba", "Afua", "Serwa", "Maame", "Afi", "Araba", "Baaba", "Enyonam", "Comfort", "Patience", "Mercy", "Gifty", "Esi", "Ama"],
            "last": ["Mensah", "Traore", "Diallo", "Keita", "Sow", "Diop", "Barrow", "Kamara", "Jalloh", "Bangura", "Sesay", "Koroma", "Conteh", "Fofana", "Kante", "Toure", "Sidibe", "Coulibaly", "Dembele", "Sylla", "Bah", "Barry", "Kone", "Ouattara"]
        }
    },
    "Oceania": {
        "New Zealand": {
            "male": ["Tama", "Tane", "Rangi", "Maui", "Anaru", "Wiremu", "Pita", "Henare", "Rewi", "Rawiri", "Hemi", "Tamati", "Aperahama", "Hohepa", "Mikaere", "Paora", "Kahu", "Matiu", "Ropata", "Ihaia", "Nikau", "Moana", "Arama", "Manaia"],
            "female": ["Aroha", "Hana", "Kiri", "Marama", "Pania", "Whetu", "Ataahua", "Kaia", "Manaia", "Ngaio", "Awhi", "Hine", "Mere", "Anahera", "Wai", "Rina", "Waimarie", "Hinewai", "Awhina", "Kahurangi", "Maia", "Tui", "Hinemoa", "Kura"],
            "last": ["Smith", "Barrett", "Savea", "Ioane", "Retallick", "Read", "Nonu", "Lomu", "Williams", "Tuipulotu", "Vunipola", "Tu'ungafasi", "Talanoa", "Taukei'aho", "Frizell", "Sotutu", "Perenara", "McKenzie", "Reece", "Jordan", "Clarke", "Taylor", "Whitelock", "Cane"]
        },
        "Australia": {
            "male": ["Jack", "Liam", "William", "Oliver", "Noah", "James", "Mason", "Lucas", "Henry", "Cooper", "Charlie", "Thomas", "Harrison", "Ethan", "Max", "Joshua", "Leo", "Oscar", "Samuel", "Hunter", "Jacob", "Archer", "Hudson", "Flynn"],
            "female": ["Olivia", "Charlotte", "Amelia", "Isla", "Mia", "Ava", "Chloe", "Emily", "Harper", "Grace", "Ella", "Sophie", "Zoe", "Ruby", "Lily", "Matilda", "Evelyn", "Scarlett", "Lucy", "Sienna", "Poppy", "Willow", "Ivy", "Piper"],
            "last": ["Smith", "Jones", "Williams", "Brown", "Wilson", "Taylor", "Johnson", "White", "Martin", "Anderson", "Thompson", "Nguyen", "Thomas", "Walker", "Harris", "Lee", "Ryan", "Robinson", "Kelly", "King", "Davis", "Wright", "Evans", "Roberts"]
        },
        "Samoa": {
            "male": ["Keanu", "Manu", "Laki", "Iosefa", "Sione", "Tua", "Teiva", "Vaea", "Makoa", "Kofi", "Koa", "Matai", "Niko", "Peni", "Sefa", "Tasi", "Uale", "Vito", "Filo", "Ioane", "Lupe", "Mose", "Paulo", "Simi"],
            "female": ["Moana", "Leilani", "Kalani", "Hana", "Teuila", "Tiare", "Vaitiare", "Nohea", "Lani", "Sina", "Losa", "Mele", "Telesia", "Vaiola", "Sefina", "Ofa", "Alofa", "Peta", "Seini", "Ana", "Faleula", "Gagana", "Lupe", "Maria"],
            "last": ["Fale", "Tuilagi", "Latu", "Taumoepeau", "Finau", "Seumanutafa", "Tuiasoa", "Tuivasa", "Aiono", "Anoa'i", "Fatu", "Afa", "Sika", "Tonga", "Fifita", "Haas", "Manu", "Folau", "Koroibete", "Tupou", "Talanoa", "Taukei'aho", "Vaai", "Luatua"]
        }
    }
}
