Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B54811
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 14:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKqGYDbY8D9U9rzs2BOEAJNIfZT4MPHr4oAikTRN5WMcLxvr+Q+pX3N/zn/6gQzJdfL0tGM99wPKauV69OuEoI5wFL1vtIeTITtozcfcEfHJOioJPLmg8NvdyHgo4K4IpzHsZDbk439fSZ8mbG0aUYdZFmAyNRPmiCjeC8StuoANWkplFw+/tHPxvCaiY90rgJ+TU7WjQwLKdx57UEahkXCil80tR2MbblJnPbnhew2BkeElDbFSvhvHx2sEHGjuBk8KdQYWfcPG4l2oquxKGs2Dd5C4Cqk/N+hKM+s414E+W1kHGmanXgT2qXNh07mBxnOi0clQtB4l6LLKJNuqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PF6+tje67sNzf/owMKbPzMyGdRYjOFORmLPP9b4Rjik=;
 b=Sm95HO1pz5AGNR7l+GTXu68YkVWithDYNZ3SH445QmT2MqP2bauFL/c1Fzl4PpaqD2MPeAYnjyIust6sjmKPtTAncpQ1dm3ODCce/9/1jPeynBjlpcZx0AN2dAXiY6DcDeRX8VyDGsvMQCV92uSCOT4DYaI118xu4SlxeXcE0ZSy+og/Pfh3KLo77UGLmH1NZhVvVSniKSlcyUbz8wfRrFNtiBZE/svLL9SOpckrU7NjZ4xnrxqS1/YJmIKJqtIXSkY1UE1QStKNdgP3JWbwH+F4e4uwmQXdrBNoZYzVSubE6vwCDz/5dkqLUlCYkPdjqAXapdzRtdXs1FOJY0TqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PF6+tje67sNzf/owMKbPzMyGdRYjOFORmLPP9b4Rjik=;
 b=y1CJHnwtMkYDLrPiHoUFQ+Glz7dwaV22eM4aFIXhos2QsKfWh+hX9KWcE3SUkVJ/oA6WY8g1OdXMhkApZDZgBSIy4i03e7h39HxEjITXGM8vPLe7v8XmYyTO1OkngOFfisZZWDHvZvYayRt9LBrvvVc1j3u4UK/q0uEf5uoxk1imo5RvwMU6OXsET7vAvh63g3nBJ4IL81/Y5j4E25Pws2jVv0i38iulIplAqaMpecR+pnAlvvs/dc+1YuHLNcCqy4YGBDpR5hBUokvO1zNBue0fbleO01bzQsCt1R1fsaBdn7EPykQOBEQKXgkynWpWsJkWz4u3l9qjAE8NWmJ3ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB4944.eurprd04.prod.outlook.com (2603:10a6:803:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Sat, 11 Jun
 2022 14:54:46 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 14:54:45 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 0/5] mptcp_join userspace pm tests
Date: Sat, 11 Jun 2022 22:54:34 +0800
Message-Id: <cover.1654958401.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910bf8ca-ba75-49fc-efc8-08da4bba5305
X-MS-TrafficTypeDiagnostic: VI1PR04MB4944:EE_
X-Microsoft-Antispam-PRVS:
	<VI1PR04MB4944F5F02DDA235EE4441C23F8A99@VI1PR04MB4944.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YL/mz+sJQynpFvDbNDAYhuBL/EhP75Uz+uVSpdYjrKKmWEcuuULZAvcStfLeCM3q1gh1FSYFBhRvgliG1pyyfpSEmzFz9J0IUj7+UsuaaN9Pb2MrLsJ70OWjYk2jupFXIPcV8zux4O/RyqRQHWAp+f1jY5Lmr3n0mFcyKSIlk1D1UapD9f0OhF3pLtObfklGUiAZ+0i0paapdAVlfO4ICWJ8nY+emUa9pcUGiYRB13LEVlOeJXRfTuNPzGqkPVOKH1mja8xmiOXtryo9GrDL4SjAZlZUr/q0N4KLcFT3AVEYhyFfBxDtc2GIUsyrtSxr754b/ufdJhEYzKioDijnmatUiiHiA9gp3uGdWgCZG0rouDNzK/xVSSq5ecc70rYGoCnbMjMRvQgTLk4/+hDcxE/KUmCfZ8C8P32li9zF8XnAQCj04RYg1Vz5X3VJvwk+koYMmM4B+GdQr9ZnHVo1HycMKLOBtZULVTnw+UtS64s4BR+Hii6gsY+tcXR/cOaY+X+sqFvJgd3AmzZ05UTPNfzw9EVf8onhxBB1Qwf3b1mcosUL/JEDweCl5dsXoHCrUkF9BfxEFs7nPLUrwpmco6PzranAmdORpUfRsVilEKZB9HDDli1b1Pih8tc6RyOrXlPBto0KjpRpfqTH83yNJdtzTItkDzbP63pgfKWShpB46PgRvZtvCcnQB6OSn33S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6916009)(107886003)(38100700002)(316002)(36756003)(2616005)(508600001)(6506007)(66476007)(66556008)(66946007)(8676002)(83380400001)(86362001)(186003)(6666004)(44832011)(5660300002)(4744005)(2906002)(26005)(6512007)(6486002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?35uKyK694gWNRhD/EQQ4Uz+ogyOT/ptnkAQImmCzxsFhDjml57WzDWx7zb7u?=
 =?us-ascii?Q?hbblphNMxPR9Xg5aiLpGRsJK1P/aw77uKs+d1s02+WUPDwaVmT/Bo36x93gc?=
 =?us-ascii?Q?oy9XAfs0uRnb+Gd0lhrEoMmGc2uznrMZYXZfEnPBEVcqiHym81QM3lrAuGbx?=
 =?us-ascii?Q?dLS2Y716/GMOkYQw17GzBvCv8Zyhjjg6YSxef0mwqPToO6ux5zMnbVZxfUHu?=
 =?us-ascii?Q?GUPhZZHCIS0LehxsULTq98ZBG3EfDUIr1HLc65HKTj9PbyvYY8Ew9cYMwDmm?=
 =?us-ascii?Q?BZAXnRIWI5mBqe9TR25pjgH/xmD2DNbU6LtiWm8SFZ8JpzdhlqZKb014afF2?=
 =?us-ascii?Q?0lRWjdh/SoXPvTyKBbQ4truIq8Cw09pPGv2GYKQPXeDRZ7N/95LzjDNvPk+1?=
 =?us-ascii?Q?26J2V0pwzlO0RSdsmb7x35N2pB4qc115mfayGRXebz/MuFFuDNnIdhFtbm2+?=
 =?us-ascii?Q?dT8mkibEE+SSLTwvO+l1kaABpqAuOSsc2R/txb0ZaVTYgi46subv4zhG6WJp?=
 =?us-ascii?Q?egntfJo3GtDiz80hySg4Wh4B/AX6lSMbxV0FH0VhQySAhg0ArmxpyqXWbzC9?=
 =?us-ascii?Q?NoMbT8FDBcYVU544kvHcdEMIvgp0wiA7fSUv9sC33mmOYUcxD5Cb1WMh12LX?=
 =?us-ascii?Q?vTPQBXI3mzANR7ipcNsy+Dd+wV4C3aKCwkm3UXot5yFeC9Z5e5Ioddxo9gf5?=
 =?us-ascii?Q?7KxizknBYSIjXkLzNXF43FyuteR8Fn3K/JOtywoPkwgMit483lTu+xZZ4dPO?=
 =?us-ascii?Q?yKsuBQEYozdkuy5nAlqdvSdAgdrOUr3LcJq/zuQA3QDWaCOzz7Awok+HCpxo?=
 =?us-ascii?Q?DR3pTczAs8cQpx9zRB3bHjJEWVYtfaYlnXCfMtKwa6dxbgQ9kAaIdTLFMBYX?=
 =?us-ascii?Q?26ULUYb32PLcSwDDf5jMpDRX4nNqS3UHLLSUX4gRMAaNuGHAUBHtMRP3eLmC?=
 =?us-ascii?Q?Xk110TF7xsPhZMHaT75azRQ861LK7XdM4X9XwOFldhN09MraaxwqfK1HKQh2?=
 =?us-ascii?Q?oqbhTUF3n6g8fIRHpfx4y9+U/lpdyPCldYgSEHvmRutA10KYM4PULtn2MuwF?=
 =?us-ascii?Q?nktNRO3f4F1GfnCUL3LqCXzK6txJCXgRgrILtd2kiWFCPHA0qsKmomqjer2I?=
 =?us-ascii?Q?+aqx7nZPoc78Ire2YQOH34LL9kBDTeMhvz+X1w75LE9qoFSF1YfTvOWUb27t?=
 =?us-ascii?Q?f0eHnm38R2R0yPd+p+YqMrRuL8QInBrS/uA5A2L70kaPmOV4OnLk1Ape8o/B?=
 =?us-ascii?Q?gu9xklTJZHnyIqLuCuVwSrtdQcvPRhX0dgc46bY51z7Pxugz4hsYDWWu6i5C?=
 =?us-ascii?Q?eMDD0Z/P6AkgUZBrqiu2b9IB2peahV/3nPIlsYgyBKLdlBFff/UY0qXHywpG?=
 =?us-ascii?Q?u6djj+NjNIG6x6Wv/eVhJhCk6ofys27PLx4Q/bjbnJc29AfvJdsVPP3tTxZK?=
 =?us-ascii?Q?3LS5SEc/173ZLKTPIYaQiR28TCUsLubL3ZwC4cvhJUyQozBTZNe6sFv61gP4?=
 =?us-ascii?Q?T8WdXfho6o9CqEXb2tt/y6GeGP57Pup8SEdP7Gcrh5hKeflFBjEkiifSTLLu?=
 =?us-ascii?Q?jM0cxzfzxVuIghrPgGS2IUFgQWZ52iwmU1l6SZSSnSi2COa50UatM127E9y/?=
 =?us-ascii?Q?2lL/QOL0OkWa/em3YqqTWVyJKwGz2XJzvPrStiAO/60qHurUOk56US+G1kFz?=
 =?us-ascii?Q?lKPSI53GOb7NVAAlMA4LtvxhAqxZLVqqEbam36h5v5P3ERPoY5X3+1/yYf4a?=
 =?us-ascii?Q?SKbTNdAKmoHzbqd+b7c43fUsC1Nzq6Q=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910bf8ca-ba75-49fc-efc8-08da4bba5305
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 14:54:45.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 93IuIdihdtWdnjawBUq7uLFLg/9f7j6NiA50pvc3ec3Rgw4GWdzY1zKNVYAllh+luDNE5HmerCUcsqMXCTLpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4944

This patch set add add address, remove address, create subflow, and
destroy subflow test cases for userspace pm in mptcp_join script.

v2:
 - add more tests in mptcp_join.sh
 - patch 4, add kill_wait helper as Matt suggested.

Geliang Tang (5):
  mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
  selftests: mptcp: userspace pm address tests
  selftests: mptcp: userspace pm subflow tests
  selftests: mptcp: avoid Terminated messages in userspace_pm
  selftests: mptcp: update pm_nl_ctl usage header

 net/mptcp/pm_userspace.c                      |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 84 ++++++++++++++++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  2 +-
 .../selftests/net/mptcp/userspace_pm.sh       | 40 +++++----
 4 files changed, 108 insertions(+), 20 deletions(-)

-- 
2.35.3

