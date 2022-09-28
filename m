Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F6FEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFBaq8N4JU2D5FoUGbJQ7eC8KOfqg7ZfoAOSCy1LDBLJwMROFyw+GOn6FAav/Td4U2V0RtsmRdITHS0k0EfFCWJiCnODckTN2HjxAtyDQvjnT+lyZUTEA/2H3sHL/YkFFZ2AC0oc3b6YQcO85hn9VOUKqxbqb+nls2Ji87+CSzHXjODL2KayuPthHhJQ87NAiGLzO9hG8QhZHiQI4WxDl3UYpvV55ct/s7L8H6TsuWd963eAUQgIfd3b8gMdwLeB29BJ+fjzaSUBaKwyp9LKS0IW5tKjVoB+yFkH4k0dJwEzXyi15+HbEM4JmFlgBHxOnJRJeQNS9hyVLJ3lH87T2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QNVrTQQHqCurZBU6hljQLSvzgzsLyj8gAo0y5ArL98=;
 b=jla0O7LTDO6aHrvif4iiVnej2kI62D2MihBd5Y5ePFAc+tc/i8cs1ZUatZ0eYu/0teDddDq5gDjwbZh1doLzNW0NSSjBQNIBXNFOZdlkxEo1sryN20ki4lA02xwfrhXRgMrniMAjjdLaClLlZMY20RcKYX6FhvV9vrM6B4LV904RJXT5SMicUeKH/FQnzdWySzxdQ1PMe9RfQXwocwLq7K+Fw4yFGJTfMwbdk3D3Nqy/7z0B/QWwdVUfKwNXTfhmVGu+oHgr4zbc6RGjZxYcprZbFHMzwXpy8Y+Pg8Jajdz48MArEnYDXIyMMmz9r0wX1lDenziaF15kpYsU9ezuNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QNVrTQQHqCurZBU6hljQLSvzgzsLyj8gAo0y5ArL98=;
 b=kaNxxPp5FzKLnpi8hFa3Dj1rZdahXFvZ7BWjEK6vb1MXh2JcOM1+goRqYJv0vrAvAkz1k5onLjonbhawtHXtZY2CMcOhymAzw/EK8bOWhUbobXq1d3b8P9keMFsEWiFvlPJFRLVQujDzpDjQz8A5O0NNSkGt0IP9kScnrfrNvVSvwM04KnFl7R4UvtPjS9EDbl1N3V818AOPNL0ZmXfFbMWyjyeuHauAuG9eyjYcBImSWGuy/yfNrRS7KlUajf/grJUETgSwnOjioWCag9hYPn2MzQ8vy1EaqOirAD19tYii0zyzC3hkawotbJPduiXfK6R/g63SMiDA9sbmUl+0/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by PA4PR04MB7502.eurprd04.prod.outlook.com (2603:10a6:102:ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 09:47:29 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::247c:645d:3f4e:d907%6]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:47:29 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/4] refactor push pending
Date: Wed, 28 Sep 2022 17:48:02 +0800
Message-Id: <cover.1664358100.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3503:EE_|PA4PR04MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 684003f9-f6e6-47b1-3a39-08daa13674f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V6W5LyNo3U6YE5z3fikWhLfrUSuowq6GPC1IpF1eTez+TAC4pfs4azzdh0leitbI1g2XpA0DVpmX3xlGTy/2OzqhgOGiRgb9wZvv0ZHDgUN1Nsw/E4FhcCt15rqsc8JTb2mHcLhwrgtXxLdKmnG08uaxlUu+1GyWeqi25SQja87qngj/FWS8243bz9jAea5BQDLsKtrlvsfmE904s9yTEae73Pf7mXplKzzke3pukt6zFVONHnCn11Nk+9OJMXkXCAfBhPu/Ti64roDFBi4CS0k0qNRr2X0eWq1azql+wRFuJ/xFMcDdNmPrcmdCsd3YD1VKz+1hgiSmxV9wJAlCHfl52Ci81vsSTNQss8JszbRdF3DFnMDWAVd7PpBgy2PTwcFRqvpUZFuzCo8NTk3ajn+1jgSF5vEphYoM0xjkW0YhywzrPtR+qZAA90jZIE2bAAF2y20quPFKpDTYDrx/DSDPDkLfQ+CMWT1zs4BQA8SDWtFQMnaYWUFyFmDaCPs/Ig8ssGLrvXRaBruTnKdRSx6I+va9AlbZmT9VRaz3c5JexbzLJPFXqpw/xfo5Ychhg+tl3eLgNTtd412P6WKHAXO04Yp+F8/X8BlZd22P8zEqGormvhIDalXkRPo1fF6TyVz9phwVNlB0vp5XNiwqD+2DK/Ipko3BVnNsKpIE/St9xIzOnDTcul8+4J1man5G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(26005)(6512007)(6506007)(38100700002)(8676002)(6916009)(66556008)(66946007)(66476007)(86362001)(316002)(36756003)(4326008)(478600001)(6666004)(107886003)(2616005)(186003)(8936002)(6486002)(4744005)(44832011)(83380400001)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EFHh6FbPmn6DUaPIxvlP9ra9LL/ydCc7eEHCGeujAXI/EF/deM3V3Uxu0nH?=
 =?us-ascii?Q?yrLz4YlHtUF4OG0koN74DWVpdmOF2u2fYmgAbjffymX5ZoqRWcmj+emdGf3B?=
 =?us-ascii?Q?478X8qX+iCpIOtjz8DPdS8jEKX3NA5Vzr1ju5uQUMRVaYGDBd7Xu9gtx6wPl?=
 =?us-ascii?Q?ij8R3VzzSQbIiVcAC+Oc1IuQIIPkEaHlRYdEXURGP+20K+ZCdhvL1B/j6rEL?=
 =?us-ascii?Q?+Fmg6tFgDAeHSnxIkKA8iGZnYV3fgnGo6imtoF4UA0R3PuM4INm9nV4GUO3j?=
 =?us-ascii?Q?Zjvuab3LuTQYxQ2YI3jA4F4yS/GmalFmIegXqRPQhr0NDOvuy+Gd5mfjYChw?=
 =?us-ascii?Q?szAyAvx4/mR4ionD9wH1I+rEyT27I11oOu6Yu9eByGjUiptItmkuDIwyndG6?=
 =?us-ascii?Q?2KOvNaPzT1ItvIelZCgiJwbLg84imL+6uHDUf7ehTsb859odCK9ymRsAeDZY?=
 =?us-ascii?Q?dnXO7PoFjxTI2Y8AbMXV+Ok9anYaSXDbwfbxOUsnUEXs9bGbFJI8Jco5Daib?=
 =?us-ascii?Q?eyrcpH1HW7mXeoi4gkRbjY/msp5n0m+Fp0d+0r66UDOf2px76L/1rcpWl30W?=
 =?us-ascii?Q?IkBXRrft7H3sVxLCNdU/Za4aR3PJWiZkGiJ2WpnW83iV1QhlYnuOlGsrMml9?=
 =?us-ascii?Q?OswM/YZQeMUQ6ONoCNHLOQDSZaJqhPL2vzLcNZiU2r1EeLRvdQcWQQ5hb0qW?=
 =?us-ascii?Q?XMza99nth1uZdMuUiG64f/3dekJQYXy7XNdYxJpqg79D/6Rf5tnBSeERV0o+?=
 =?us-ascii?Q?TFspbVq3K0SF/eUTNOONa52kL1iVQ43H8rwxi1Js32aYWzF8WVNE7WHdT4PY?=
 =?us-ascii?Q?5lBQggROS1bzkG6zGo7Q0zKGA4RE1BvZ81DQILcwzhgjcj5tryBCLPv2o00b?=
 =?us-ascii?Q?+6UPtn8R6zmVlRdRaHMFihoXoVdcPYS0Be0Irgf1+Mn0/rL7941OBZnPXMIp?=
 =?us-ascii?Q?0b8tccpm8wQilKSFEIQuOflFPO6y/izXNWyskF7iyCXz29MI9nBL4qH8KHY/?=
 =?us-ascii?Q?VYn2wEorxQecHbGuqhBjgkWk5+3ru5M/fSH7qiPTOMMK+1pmhBAzlzv9vn8i?=
 =?us-ascii?Q?aND1TcxMsqMKU6OrnC58RUa85ARhEfCb1zbTsNt0f0mfAvBDcmK6ktiW7ODA?=
 =?us-ascii?Q?M50GoYnl18K39VOg9l774TXed28L0S/ntr7ORCH+vazrwfWof1JjXr+L8puT?=
 =?us-ascii?Q?mWuOgLtZdArHs9omtGiUw3U0lsiC3fL+FsiG6Ei5SPIEKlD6n/LIVd2UG7Tw?=
 =?us-ascii?Q?0FI7/7PltlKl24HhdM/ow1bIjOdicaaf10ZeY88QixrnH087ju5tMH4e5AHc?=
 =?us-ascii?Q?LGcT9vyc/OJ95t8FnlH8nPIjAxiQ1+wSXNq0NKhwQGrpdytSyIHgEcSwA9Zc?=
 =?us-ascii?Q?eTC23VJcxC7XSVAPU1NhXjcxKa9Z+OLlfuV7e8BAz9sIf0Nia2NZnn1pJF0O?=
 =?us-ascii?Q?1mf5kvUBPZ8N4mDLgAQp0d3ICHeVAVxSbAbSuMxi/iXt0zeegjaWjhtVLIpU?=
 =?us-ascii?Q?oZpqAEOy75KFfIeOA5LJVQ7u92gIqKPGEQi6vHTevIc4Hb1JCQi5d1wXTz4a?=
 =?us-ascii?Q?4h/vvrt2+56L2LJE/gxniYG2zt8gIFFfw/pwhuvU?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684003f9-f6e6-47b1-3a39-08daa13674f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:47:29.2202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03jgkHxFF2Ec2JuoUg76YRBoX5MDpv2IPE2S3dFxRLxLvj4CONsTlFD7Vbt+iuSrWKCUjAkohjZCvQZz/OS0HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7502

Refactor __mptcp_push_pending() and __mptcp_subflow_push_pending() to
remove duplicate code and support redundant scheduler more easily in
__mptcp_subflow_push_pending().

Geliang Tang (4):
  mptcp: update __mptcp_push_pending
  mptcp: add do_push_pending helper
  mptcp: update __mptcp_subflow_push_pending
  mptcp: simplify __mptcp_subflow_push_pending

 net/mptcp/protocol.c | 137 ++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 87 deletions(-)

-- 
2.35.3

