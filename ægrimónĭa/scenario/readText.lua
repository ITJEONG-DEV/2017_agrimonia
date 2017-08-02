-- { who, context, face }
-- <who>
-- nil : no image
-- -1 : 벨소리(띠링)
-- 0 : 주인공(독백 포함)
-- 1 : 손님1
-- 2 : 손님2
-- 3 : 손님3
-- 4 : 시험관
-- 5 : 수련생A
-- 6 : 페리스
-- 7 : 루크
-- <face>
-- default : nil
-- smile : 1
-- 침울 : 2
-- 놀람 : 3
-- 어리둥절 : 4
-- 당황 : 5
-- 슬픔 : 6
-- 지침 : 7
-- ** 주인공 이외 인물들의 독백은 전부 nil로 처리
-- 방백: {화자, 내용, (표정)}
-- 독백: {nil, 내용, 화자}
local M =
{
	{
		--0        1      2       3       4       5         6      7        8         9        10
		"바텐더", "손님1", "손님2", "손님3", "시험관", "수련생 A", "페리스", "루크", "직장상사 A", "유화린", "직장상사 B",

		-- 11         12        13         14         15         16
		"직장동료C", "직장동료D", "직장동료E", "직장동료F", "직장동료etc", "대학동기A"
	},
	--chapter 0 : Prologue
	{
		
		"세상에는 수많은 이야기들이 있습니다.",
		"소설 속에나 존재한다고 여긴 마법사들의 이야기\n또는 과학의 세계 이야기",
		"사실 이 모든 것들이 우리가 모르는 어느 머나먼 곳에는 실제로 존재합니다.",
		"여러분이 상상하는 그런 세계들 모두 말이죠.",
		"여러분이 상상할 수 있는 모든 경우의 수를 제외하더라도\n셀 수 없이 많은 수의 차원이 존재 하니까요.",
		"이 이야기는 그 수많은 차원들이 연결되어 있는 곳에서\n하나의 존재가 자기 자신을 찾아가는 이야기에요.",
		"하지만 이곳은 ‘호기심’이라는 것이 존재하지 않는 세계.",
		"수많은 차원에서 여러 존재들이 다녀가지만\n아무리 소설 속에서만 보던 존재가 눈앞에 있더라도",
		"결코 그 존재를 의심하는 일 없이 지나쳐갑니다.",
		"그들이 이곳을 떠날 때면\n이곳에 대한 기억은 꿈처럼 두루뭉실하게 되겠죠.",
		"하지만 이 하나의 존재는\n언제나 이 세계에 머물러 있습니다.",
		"어디서 태어났는지",
		"나이는 몇 살인지",
		"남성인지 여성인지",
		"심지어 왜 이곳에 있는지 조차도 모릅니다.",
		"이 존재가 자기 자신을 찾을 수 있을지,\n혹은 찾지 못하고 영원히 이곳에 머무를지는",
		"이 이야기를 이어나갈 여러분께 달렸습니다.",
		"하지만.."
	},
	--chapter 1 : Tales of the Wanderers
	{
		{
			{ -1, "bell" },
			{ 0, "음..." },
			{ 0, "술집인가요?  " },
			{ 1, "여어   아가씨,  가장   싼   에일   한   잔   줘.  " },	

			{ 0, "아,  그렇군요.  " },
			{ 0, "전   이   술집   주인인   듯   합니다.  " },

			{ 0, "네,  잠시   기다려주세요.  " },

			{ -1, "bell" },
			{ 0, "또   손님이   왔나봐요.  " },

			{ 2, "아가씨가   바텐더에요?  " },
			{ 0, "네,  그렇습니다.  " },
			{ 2, "가게   주인?  " },
			{ 0, "네,  제가   가게   오너입니다." },
			{ 2, "젊은   나이에   대단하네요.. 전   생맥주   한   잔   주세요.  " },
			{ 0, "네,  잠시   기다려주세요.  " },

			{ -1, "bell" },
			{ 0, "이번   손님은.. 어머  " },

			{ 3, "음.. 혹시   아인은   받지   않으십니까?  " },
			{ 0, "그럴리가요!  어서   들어오세요.  ", 1 },

			{ 0, "엘프   손님이시네요!  " },

			{ 0, "음.. "},
			{ 0, "다른   손님   두   분은   엘프를   처음   보실텐데", -1 },
			{ 0, "역시   아무렇지도   않으시네요." },

			{ -1, "bgm" },
			{ 1, "...  " },
			{ 2, "...  " },
			{ 3, "...  " },
			{ 2, "아   저기.. 가게   분위기가   참   좋네요!"},
			{ 2, "이런   곳이   있었는   줄   몰랐는데..  " },
			{ 1, "어,  음.  그렇네.  조용하게   마시기   좋네.  " },
			{ 3, "그건   점장님께   실례인   듯   합니다.  " },
			{ 1, "아,  미,  미안하네.  그런   의도가.. " },
			{ 0, "괜찮아요.  저희   가게   장점인걸요?  " },
			{ 2, "그럴   땐   한   번   째려봐도   괜찮아요.  점장님.  " },

			{ 0, "정말로   전   아무   생각도   안했는데   말이죠.  " },
			{ 0, "오픈한   지   몇   시간도   안   지났고   말이죠.  ", 1 },

			{ 1, "아,  아내가   이런   분위기   좋고   조용한   곳을   좋아해서   말야!  " },
			{ 2, "당신,  자기   무덤만   더   파고   있는   거   알아요?  " },
			{ 0, "음..  " },
			{ 0, "역시   조용한   것보단   소란스러운게   좋다고   생각해요.  ", 1 },
			{ 3, "그런가요?  " },
			{ 0, "음.. 손님들이   서로   푸념이라던가.. " },
			{ 0, "각자의   삶에   대해서   이야기   하시는   것을   듣는   게", -1 },
			{ 0, "제   유일한   즐거움이거든요.", 1 },

			{ 0, "정말이에요.  손님의   이야기를   듣는   것   외에는", -1 },
			{ 0, "아무   것도   할게   없거든요.  " },
			{ 0, "가끔   아무   말도   하지   않고   가시는   손님이   있는데", -1},
			{ 0, "그   때는   정말   지루했어요.  " },

			{ 1, "삶의   이야기라.. 아,  한   잔   더   주겠어?  " },

			{ 0, "사실   아까부터   드리던   술은"},
			{ 0, "주문하신   싸구려   술이   아니라   고급   술이에요.  " },
			{ 0, "말씀   하신   술이   없던   것은   아니지만.. "},
			{ 0, "어떤   술을   드려도   저에겐   손해가   없으니까요!  "},

			{ 0, "네,  안주는   서비스에요.  " },
			{ 1, "오우,  고마워.  " },
			{ 1, "음.. 사과하는   의미로   내   이야기를  해주지.  " },
			{ 1, "그다지   재미있는   이야기는   아니지만   말야.  "},
			{ 2, "우와   정말   재미   없을   것   같아.. " },
			{ 1, "그렇게   딱   잘라   말할   것   까진.. " },
			{ 0, "후훗,  고마워요.  ", 1 },
			{ 2, "음.. " },
			{ 2, "원래   난   내   이야기   같은   건   잘   안하는   편이지만.. " },
			{ 2, "그래!  점장님이   맘에   들었으니까,  " },
			{ 2, "나도   뭔가   말해볼게.  " },
			{ 2, "당신은   어때요?  " },
			{ 3, "전.. " },
			{ 3, "... "},
			{ 3, "좀.. 생각해   보겠습니다." },
			{ 2, "괜찮아요!  원래   자기   이야기를   막   말하는   게   더   이상한   거니까요.", 1 },
			{ 1, "어이,  우리가   이상한   사람이   되버렸는데?  " },
			{ 1, "크흠.. 나도   푸념이나   고민에   가깝지만.. " },
			{ 2, "됐고,  어서   말해봐요.  저도   궁금하니까.  " },
			{ 1, "음.. 뭘   이야기하면   좋을까.. " },
			{ 0, "혼자   술을   마시러   온   사연이라던가   어때요?  " },
			{ 1, "!  ", 3},
			{ 2, "!  ", 3},
			{ 3, "!  ", 3},
			{ 1, "그래.. 그게   좋겠네. " },
			{ 1, "별로   유쾌한   얘긴   아니지만!  ", 1 }
		}
	},

	--chapter 2 : It is Not that Soldiers Are Afraid of Death
	{
		-- 1
		{
			{ nil, "나는   스페스라는   시골   마을   출신이야.  ", 1 },
			{ nil, "나   같은   시골   출신   남자는   도시에   나가   병사가   되는   것을   목표로   하지.  ", 1 },
			{ nil, "어렸을   때부터   부모님이  ", 1 },
			{ nil, "  '넌   커서   병사가   되어야   한다'  ", 1 },
			{ nil, "라고   말씀하시는   걸   언제나   듣고   자랐거든.  ", 1 }
		},

		-- 2
		{
			{ -1, "bgm"},
			{ 4, "마지막   시험까지   도달한   것을   축하한다.  " },
			{ 4, "마지막   시험은  2인  1조로   대련이다.  "},
			{ 4, "그리고   승리한   자들   만이   진정한   병사가   될   수   있다.  "},
			{ 4, "번호가   짝수인   자는   바로   앞   번호,   홀수인   자는   바로   뒷   번호와   조를   짜게   된다.  "},

			{ 1, "당신이   내   상대인가.  "},
			{ 5, "젠장,  난   반드시   병사가   되어야   한다고!!  "},
			{ 1, "미안하지만   이쪽도   양보할   수는   없어서   말이지.  "},
			{ 1, "마지막으로   보는   얼굴일텐데   통성명이라도..  "},
			{ nil, "수련생   A가   갑자기   공격해온다.  "},
			{ 1, "이봐,   무슨..  "},
			{ 5, "죽어!!!  "}
		},

		-- 3
		{
			{ 5, "제길...  "},
			{ 1, "이봐,  내가   이겼다고.  이제   그만   받아들여.  "},
			{ nil, "그   자식은   힘이   풀린   듯이   쓰러졌고  ", 1},
			{ nil, "나는   그를   뒤로   하고   시험관에게   보고하러   갔지.", 1}
		},

		-- 4
		{
			{ 5, "이 XXX가!!!!  "},
			{ nil, "그런데   갑자기   달려들더라고?  ", 1}
		},

		-- 5
		{
			{ 1, "ㅁ..뭣?! "},
			{ nil, "그   때는   이미   죽었구나   생각했지.  그런데,  ", 1},
			{ 4, "괜찮나,  21번   후보생?  "},
			{ nil, "시험관이   날   지키다가   오른쪽   팔을   다쳤지.  ", 1}
		},

		-- 6
		{
			{ -1, "bgm"},
			{ 1, "그   후   치료는   잘   되긴   했지만..  "},
			{ 1, "오른쪽   어깨   근육을   제대로   다쳐서   두   번   다시   검을   들지   못했지.  "},
			{ 0, "저런.. 그럼   시험관님과   그   수련생은   어떻게   되었나요?  "},
			{ 1, "그   수련생은   그   즉시   끌려가   이후   사형당했고,  "},
			{ 1, "그리고   시험관은   내   아내가   되었어.  "},
			{ 2, "..네?  "},
			{ 3, "에?  "},
			{ 0, "네?!  "},
			{ 1, "그   뒤에   시험관은   어쩔   수   없이   퇴직하게   되고   내가   항상   찾아가며   이것저것   해주다가  "},
			{ 2, "그러다   사랑이   싹텄다던가..  "},
			{ 1, "그렇지.  "},
			{ 2, "무슨   드라마   속   사랑이야기야..  "},
			{ 2, "그런게   실제로   존재한다니..  "},
			{ 0, "금발   벽안의   미인이라..  "},
			{ 3, "시골   출신   병사에게는   엄청난   행운이네요.  "},
			{ 1, "오우!  나도   내   생애   최고의   선물이라고   생각하고   있..  "},
			{ 1, "어라?  아가씨,  내   아내를   알고   있어?  "},
			{ 0, "네?  "},
			{ 1, "방금   금발   벽안의   미인이라고   했잖아.  "},
			{ 0, "그러고   보니   그렇네요."},
			{ 0, "어라?  "},
			{ 0, "왜   그렇게   생각했지..?  "},
			{ 2, "최근에   금발   미인   손님이   온   적   있어서   미인이라   하면   그렇겠거니   하고   상상하다가   착각한   거   아니에요?  "},
			{ 1, "아하!  그렇네.  "},
			{ 1, "나도   미인   하면   그   생각밖에   안   나니까   말이야!  "},

			{ 0, "아뇨.  전   그녀를   직접   본   것처럼   정확히   연상하고   있었습니다.  "},
			{ 0, "음.. 역시   모르겠습니다.  "},
			{ -1, "단서"},
			{ 2, "그래서   그   아내분은   잘   지내시나요?  "},
			{ 1, "지금은.. 좀   아파서   말이야..  "}
		},

		-- 7
		{
			{ -1, "bgm"},
			{ 1, "페리스,  나   왔어.. "},
			{ 6, "어서와   루크.  기운   없어   보이네?  "},
			{ nil, "내   아내,  페리스는   아파서   몸져   누워   있는데도   늘   나를   밝게   맞이해주었지.  "},
			{ 7, "아냐아냐.  그보다   배고프지?  "},
			{ 7, "조금만   기다려.  금방   밥   해줄게."}
		},

		-- 8
		{
			-- 거울을 봤을 경우
			{ nil, "...어?  "}
			-- goto kitchen
		},

		-- 9
		{
			{ 7, "혼자   먹을   수   있겠어?  "},
			{ 6, "괜찮아   괜찮아~  "},
			{ 6, "그보다.. 무슨   할   말   있지   않아?  "},
			{ 7, "..."},
			{ 6, "괜찮으니까   말해봐.  새   여자   생겼다고   해도   괜찮으니까.  "},
			{ 7, "그럴리가   없잖아!  "},
			{ 6, "그렇게   말해주니까   고맙네.. "},
			{ 6, "매일   민폐만   끼치는   나를   아직도   사랑해 주는구나?  "},
			{ 7, "난   지금까지   단   한   번도   민폐라고   생각한   적   없어.  "},
			{ 7, "나같은   시골   출신   남자에게   생애   최고의   선물이자   너무   과분한   선물인걸.  "}
		},

		-- 10
		{
			{ 2, "손과   발이   오그라들어   사라질   것   같아요..  "},
			{ 7, "아직   이야기   중이니까   방해하지   마!  "},
			{ 3, "음...   연인들은   저런   부끄러운   이야기도   서슴치   않고   말할   수   있군요.  "},
			{ 7, "크흠...   그   부분은   조금   넘어가도록   하고  "}
		},

		-- 11
		{
			{ 7, "...  "},
			{ 6, "...  "},
			{ 7, "페리스.. 나   말야.. "},
			{ 6, "응.. "},
			{ 7, "원정대.. 참여하기로   했어..  "},
			{ 6, "뭐   그럴   거라곤   생각했어.  "},
			{ 6, "밖에서   영주가   뭔가를   토벌한다고   원정대를   결성했다며   난리가   났었거든.  "},
			{ 7, "미안해.. "},
			{ 6, "꼭.. "},
			{ 6, "꼭   돌아와야해.. "},
			{ 7, "나.. 반드시   살아   돌아와서..  "},
			{ 2, "안돼애애애애애애애애애애애애애!!  "},
		},

		-- 12
		{
			{ 7, "뭐,  뭐가?  "},
			{ 2, "서,  설마   그걸   말했어요?  ", 3},
			{ 7, "뭐,  뭐를..?  ", 4},
			{ 0, "아하하하..  "},
			{ 2, "그,  그거   사망플래그잖아!  ", 3},
			{ 7, "프,  플래그..?  ", 4},
			{ 3, "음...   그   말은   잘   모르겠지만   의미는   알겠군요..  "},
			{ 7, "뭐,  뭐야   그게?!  "},
			{ 0, "엎질러진   술은   다시   잔에   담을   수   없습니다..  "},
			{ 2, "뭐.. "},
			{ 3, "괜찮겠죠   설마.. "},
			{ 7, "왜   그래   자꾸   불안하게!  "},
			{ 7, "뭐   어쨌거나.. "},
		},

		-- 13
		{
			{ 7, "나.. 반드시   살아   돌아와서   페리스를   평생   행복하게   해줄테니까..  "},
			{ 6, "그,  그런   말   기쁘지만..  "},
			{ 6, "반드시.. 꼭   무사히   돌아와야   해.  "}
		},

		-- 14
		{
			{ 7, "그리고   내일   원정   전에   술이라도   마시는   거지.  "},
			{ 7, "마지막이   될지도   모르니까   말이야.. "}
		},

		-- 15
		{
			{ 2, "굉장히  "},
			{ 3, "슬픈   이야기이긴   하지만.. "},
			{ 2, "오그라드네요.. "},
			{ 7, "이쪽은   심각한   이야기라고!  "},
			{ 7, "어,  어라?   아가씨   울어?"},
			{ 0, "네?  아.. "},
			{ 7, "내,  내가   소리쳐서   그런거야?! ", 5},
			{ 0, "아,  아뇨...   그게...  "},

			{ 0, "사실은   계속   옆에   있고   싶죠?  페리스씨   옆에.. "},
			{ 7, "응.. 그렇지.. ", 6},
			{ 7, "내가   다녀올   동안   페리스에게   무슨   일이라도   생기면.. "},
			{ 0, "그리고   만약   페리스씨를   혼자   남겨두게   될   때를   걱정하고   계시죠.  "},
			{ 7, "...", 6},
			{ 7, "반드시.. 페리스를   혼자   남겨두지   않을   꺼야.  "},
			{ 3, "홀로   남겨지는   것   만큼...   괴로운   일은   없어요.  "},
			{ 2, "그딴   괴물   후딱   무찌르고   예쁜   아내랑   평생   예쁜   사랑   하셔아죠!  "},
			{ 7, "...다들   고마워!  "},
			{ 7, "반드시.. 살아남겠어.  "},
			{ 7, "그러니까   아가씨도   그만   울어.  "},
			{ 0, "...죄송합니다  "},
			{ 7, "좋아!  "},
			{ 7, "돌아오면   병사   때려치고   아가씨처럼   술집이나   차려볼까!  "},
			{ 0, "좋은   생각이에요  ", 1},
			{ 0, "루크씨와   페리스씨라면   분명   잘   될거에요!  "},
			{ 7, "하하   말이라도   고마운걸?  ", 1},
			{ 2, "자,  그럼  "},
			{ 2, "이제   제   차례인가요?  "},
			{ 7, "나보다   더   재미없을   것   같은걸?  "},
			{ 2, "뭐,  그럴지도   모르죠.  "},
			{ 7, "의외로   순순히   받아들이네..  "},
			{ 2, "정말   평범한   이야기니까요.  "},
			{ 2, "음.. 뭐부터   말해야   할까..  "}
		}
	},

	--chapter 3 :
	{
		-- 1
		{
			{ 2, "저는   뭐.. 그냥   평범한   가정에서   태어나서  "},
			{ 2, "공부는   어느   정도   해서   나름   알아주는   대학에   들어갔어요.  "},
			{ 2, "뭐.. 컴퓨터   다루는   거를   좋아해서   컴퓨터공학과에   들어갔었고  "},
			{ 2, "졸업   후엔   전공   살려서   지금   다니고   있는   모   IT기업에   프로그래머로 입사했어됴.  "},
			{ 2, "창업을   할까   고민도   해봤지만  "},
			{ 2, "우선   돈을   좀   벌어야   뭐든   할   것   같아서  "},
			{ 2, "아무   곳이나   지원한   거긴   한데..  "}
		},

		-- 2
		{
			{ -1, "keyboard"},
			{ 8, "저기   화린씨!  "},
			{ 9, "네,  부르셨나요?  "},
			{ 8, "아까   부탁한   일   언제쯤   끝나나?  "},
			{ 9, "아,  곧   끝납니다!  "},
			{ 8, "오,  빠른데?  그러면   이것도   좀   해줄래?  "},
			{ 9, "아,  네!  "}
		},

		-- 3
		{
			{ nil, "4시간   뒤  "},
			{ 9, "겨우   퇴근   전에   다   끝났다..  ", 7},
			{ 10, "화린씨,  지금   손   비지?  "},
			{ 9, "네.. 그런데   저   이제   퇴근..  "},
			{ 10, "벌써   퇴근한다고?  "},
			{ 9, "지금   퇴근시간   아닌가요..?  "},
			{ 10, "뭐.. 퇴근해도   되는데   그러면   일이   좀   밀릴텐데   괜찮겠어?  "},
			{ 9, "지금   맡은   건   다 했..  "},
			{ 8, "화린씨   큰일났어!  "},
			{ 9, "..왜,  왜   그러세요?  "},
			{ 8, "인사부쪽에서   뭔   짓을   했는지   여러가지   더   추가해야   돼!  "},
			{ 9, "네?! "},
			{ 8, "여기   그   내용이야"},
			{ 9, "이.. 이런   말도   안되는..  "},
			{ 8, "입사   첫   날에   미안해..   우리   회사가   좀..  "},
			{ 9, "잠깐   기한이..  "},
			{ 9, "내일?! "},

			{ nil, "" },
			{ nil, "네.  흔히   말하는   '블랙기업'에   들어간거죠.  ",9},
			{ nil, "진짜   한   달간   집에   못   가고   일한   적도   있었죠.  ",9},
			{ nil, "그리고   제가   그   회사에서   가장   프로그래밍을   잘하기도   해서.  ",9},

			{ nil, "" },
			{ 11, "화린씨!  이거   왜이래?  "},
			{ 9, "뭔데요.  "},
			{ 11, "이거   갑자기   실행이   안   되는데?  "},
			{ 9, "거기   세미콜론   빠졌잖아요.  "},
			{ 11, "아.. 그러네.  "},
			{ 12, "화린씨   여기 좀   봐줘요.  "},
			{ 9, "또   뭐에요?  "},
			{ 12, "이   부분   어떻게   해야   할   지   잘   모르겠어.  "},
			{ 9, "음.. 제가   전에   만들어   놓은   거   보내드릴게요.  "},
			{ 12, "오!  고마워!  "},
			{ 13, "화린씨   잠깐!  "},
			{ 14, "화린씨!  "},
			{ 15, "사축씨!  "},
			{ 9, "마지막   누구야   나와  "}
		},

		-- 4
		{
			{ nil, "어쨌거나   이   회사   다니면서   성격이   많이   거칠어졌어요.  ",9},
			{ nil, "사축은.. 직장   동료들이   나한테   붙인   별명이고..  ",9},
			{ nil, "뭐.. 부정할   수   없지만..  ",9},
			{ nil, "..."},
			{ nil, "맨날   야근의   반복이고   대부분   일을   내가   하기도   하고..  ",9},
			{ nil, "밥도   제대로   못   먹고   항상   에너지   드링크같은   걸   마시다   보니까",9},
			{ nil, "언젠가   한   번   쓰러지더라고요",9},
			{ nil, "그제서야   회사에서   몇   일   정도   휴식하는   시간을   줬어요",9},
			{ nil, "저는   거기에   밀린   연차까지   써서   좀   오래   쉬는   시간을   가졌어요",9},
			{ nil, "그때   대학에서   알고   지낸   동기가   연락이   와서   한   번   만났어요",9},
		},

		-- 5
		{
			{ 16, "아,  여기야!  "},
			{ 9, "응,  오랜만이네.  "},
			{ 9, "그런데   무슨   일로   만나자고   한거야?  "},
			{ 16, "아,  아니.. 요즘   뭐하나   해서.  "},
			{ 16, "취업했다면서?   좀   어때?  "},
			{ 9, "뭐.. 이제   한   4개월   정도   되어가는데  "},
			{ 9, "솔직히   힘들어.. "},
			{ 16, "확실히   지쳐보이네..  "},
			{ 16, "눈가에   다크서클이   엄청   내려와있어.  "},
			{ 9, "야근이   좀   심했어.  "},
			{ 9, "너는   좀   어때?  "},
			{ 16, "나,  나는   아직   대학생이지..  "},
			{ 9, "아   맞다.  군대   다녀오느라   같이   졸업   못했었..  "},
			{ 9, "어라?  그러기엔   좀.. "},
			{ 16, "졸업.. 연기했지.  "},
			{ 16, "요즘   취업하기   여간   어려운   게   아니라서..  "},
			{ 9, "아.. 그렇긴   하지..  "},
			{ nil, "나도   여러   곳   찔러서   겨우   들어간   곳이   블랙기업이었으니..  ", 9}
		},

		-- 선택지 모듈에서 사용할 부분임
		--QUESTION
		--[[
		{
			{ 화자, 질문 },
			{
				"긍정 선택지" , "부정 선택지"	
			},
			--긍정 지문과 부정 지문은 chatBox.lua를 사용하여 출력할 계획임
			{
				긍정지문
			},
			{
				부정지문
			}
		}
		]]--

		{
			-- A
			{
				{ 16, "아,  일단   뭐라도   시킬까?  뭐   먹고   싶은거   있어?" },
				{
					"음.. 허니브레드에   아메리카노.  아,   물론   내가   살게",
					"음.. 아무거나   괜찮아."
				},
				{
					{ 16, "아,  아냐   이런   건   남자가   해야지" },
					{ 9, "나중에   취업하고   나서   더   맛있는거나   사줘", 1 }
				},
				{
					{ 16, "어.. 그러면   쇼트케이크에   라떼   어때?  " },
					{ 9, "뭐.. 괜찮아" }
				}
			},

			-- B
			{
				{ 16, "회사에선   주로   무슨   일   해?" },
				{
					"처음에는   게임   이벤트   하나   개발하는   역할이었는데.. ",
					"뭐.. 그냥   이것저것.. 프로그래밍하지"
				},
				{
					{ 16, "였는데?  " },
					{ 9, "우리  2학년   때   프로젝트   과제   생각나?  " },
					{ 16, "아,  그거?  " },
					{ 9, "그   때   우리팀   과제   결국   내가   다   했잖아.. " },
					{ 16, "그랬었지.. " },
					{ 9, "똑같아.. " },
					{ 16, "그래서   그렇게   힘들어   보였구나... "}
				}
			}
		}
	}
}

return M