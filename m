Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667F1107
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceEuBgg8MKUADIKLZftCKgFvwIG79eWkKRk+ZcPgZZB0R5dFig3st4ZniLglkgZdXyPNO7iRKdQKzOpFfrP9pA03TVDx4wO0HtFIv7VI1ahRKXEbyjpDUgi0vcsVO3LFFN+OV3q+3CLwkhooP3wHtWLdhbePsCFL4mFGTNh/ErTlIKEz6KonV1uQVFyRSGivZNF0Te5UTwS6o8F+CVccG8eFV6Lq5hbc69u0ZKoOy6cLSAyZITAonvBnQ+zeDK7PthR4JYr9JLHH2ji05tVstiCKX3qfD6rQp/ir/RdBtox+TFHnJoGLSGUwkcSNJwOGD6udQhF0i261fVdyTqF7gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqvqUhIHA33Uf04vpAJZDvD/1Ge3ODWPeK5hOa4sHeY=;
 b=JR60fMV38bxb3AR/Xsep3vC/BuwIWmbpTgfIPQCaCA8KYMPl964akWr7U+PBhENZrT6RNGgo2krM9c+e8w/3kqHBmBnB9sAKcWQbwVbevSHGVofBBPRlKenbgEZmuUA1u4omPhJOkGV2lIqZyGxvIg9ujdck/pXxCpdQbxpIBamlZCtdm4/aArhem9EJhd/amIA5JOlh09jCpIoC0VtTTdeB0GZCQp9c+k5i603fICPdH2Tva3zUq2cJfpL65k6/8C5MvLwXw3aw8vBjClYtVpQXjmXxwBvGq8pCztwBy2MNlK/7MLvQRN2xViFW3eNB4q45/i9mzddfRcFffcCyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqvqUhIHA33Uf04vpAJZDvD/1Ge3ODWPeK5hOa4sHeY=;
 b=xMBFdzICU7qZFmIpBwFdZM0NY3ig8dr8My4NPFPGJkh8bVSNOVDa0CglQqkFE/VO3/ZRYPMij4pju0DrIgX/XnX0f6eNH0zhOlp2e4zz9BFQvc005xA14dOB2lZu/Jkk/85SoBZ/Ows9G2cCEBo2SojNxnzHgShW4t4oCEorHN2nP506APNUVMM1G7bqc3xqZIAQgnd/m50uCLMq9GpsPduvLqW1Tn5TFyOFX8+oyY5hNz77yTOuD+6hZvA9bviQH1z+voz8M2XnqQShu3UbphV/A9BV8jmgvhj0rJoHp7d0uCusk+CsuqmmxhiDN98iEmMi11FdcX3LrAcN2LODvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9371.eurprd04.prod.outlook.com (2603:10a6:10:35a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Sat, 16 Sep
 2023 11:37:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.021; Sat, 16 Sep 2023
 11:37:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 0/7] some small cleanups
Date: Sat, 16 Sep 2023 19:38:34 +0800
Message-Id: <cover.1694864093.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9371:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cdbe0f-bfcb-4888-7c5b-08dbb6a95f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TJJeh4E732cfeI3h5QYGOs6nb/qaBr1FTdjetxHJ/QF3OPbzUTFnAlYjCDKSVVU4R74wp9KGpyf3ST7hKXrE0F3pVY5K9D97hGq6FOlBQjFDfNvCfcAaM/7tjCB6J3byTmoZVXzZRSzLiTnduaSEufq87yu/jG+XGGqqg4RabSwZzUqJWx0gKru1ODVvjH+xypZ4SM/u+LTgCSdm/+OCyxlIrXgz7e3nMkgmOqm7/2ZUKm+i0mYUtlojUVHZvtbkfTnjZc/YdUn0dqZ4n81wGRvXC87nphRCnHEJk/0WtPMrMGFTnxbkYMljq0Quy9j5W/MHPWMXa5Y5yLu6YukK7cXG3M5pX3iuvryMswI4O5pXvUtGu6/kS8TzDrb2ZK1+ZoPgUPQrwrjIxbihJzUTyhheS2B9QD+xvirDZt9MH26NomhjzzCBmdwKQk4XPpPxCW0g6lqr5rMOh/uiicVj42GQNU0bga9hv3/NCo6i8V0PBLz7tUqzqGke18aEegkt87pUsr83vsU8r3Bm3EJa2EeKXyJRbuRbAi92oVG4rUmqRCsvJF36Qhsk0l4qDWdIgFMxFiLsSLbPSPHUXqu8ZKFrCXwDlN3y+7AiCAzGktI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(1800799009)(451199024)(186009)(36756003)(41300700001)(38100700002)(6486002)(6666004)(86362001)(2906002)(2616005)(478600001)(83380400001)(107886003)(6506007)(6512007)(26005)(66476007)(4744005)(66556008)(6916009)(316002)(66946007)(4326008)(8676002)(8936002)(5660300002)(44832011)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g35ELlJBDnoLNgyoviDUngMNvC+Fc7XXUSeL/RP4ZwAmUoVC0gP7ezCFJtZn?=
 =?us-ascii?Q?HFaLoFJ/E70GTd218b1TvYPOh4DLnniaLa3LmSCIZljGkxGHpG/IXfzsLTJc?=
 =?us-ascii?Q?E1/wjcd2dTO9tCX1Ablug7M4PKJinD3qKaMIFRpkhep8XGirAUdfX4ArY4Ad?=
 =?us-ascii?Q?T8kuYSl3ov5BAo3Sf872fnO2a4kY2U9xXezfdYOA+F4QKdTRQrYo6tWUCAJp?=
 =?us-ascii?Q?3LQiGcyEmFhIdpP5IYqGHmXBi+SpsPAmxE3GeU2kabq1mtoh/irZySjTOB7k?=
 =?us-ascii?Q?PLveo3kD9W3D5qUR3NVW+kPFxrtS87iTFX1umlCf6ZEE/R8dFIWZPP4CntYo?=
 =?us-ascii?Q?4DEIzcaIh/4bxgtepagyeYy/YNUHRwMW3/V/5XMKW5i6XL+5IqrOZdIWm7wC?=
 =?us-ascii?Q?U/4YffYSR7d6ykFF5R6KfcECtc4EJ1f15dUg70zYsDC43gtN3gxo5n+vksCK?=
 =?us-ascii?Q?Nn581qlPhongPeQgIJ1fNsyIJTljjQiVNZYa277Ia8ZGPAxU9Wo7d1ijv3DF?=
 =?us-ascii?Q?Xw4f7KFGy3o0XTfFnfuLsGi5dQcLkBvCXMUq8OhqZeoQh/y6h8KAkpcAy9Xk?=
 =?us-ascii?Q?swQPVB/+VpBzlS69hBRNhpmhkR0k1khYI2zgLGRvaF2MnvsJ7x4sLU2o6COt?=
 =?us-ascii?Q?yFEMtLZF4uGgCEU7a5TLBAh+SyA3CDBE96735kLvPKDBavx2OBXTf3cwCRHt?=
 =?us-ascii?Q?17MT7EqJbgJYp2KH7GoCh+GOuGBFd3ETFJEsRNNIfqLnw+xa/aVtHNgXsdy/?=
 =?us-ascii?Q?mi9yWEFy0Am/L8A2eqtnFp65jgpbU8Lf+sOyfCMG/oebjKUbITZRiUTUZKK3?=
 =?us-ascii?Q?rHTZ2KFllDtvnK0zHtom1TlT10hs8djx+yV1bBq95/drstFjx7EA+ZqWvqCV?=
 =?us-ascii?Q?SZBuvN9Xg4m7lfOC59eE9lI8A4sMYnAZi9Xc3G0YaZnljmaFuSUEruysu58+?=
 =?us-ascii?Q?LnLwCYFtQsFltDeQFCK1hozGR804Fa64+989kXdA+AQOIWIf98fVsw0rdmuO?=
 =?us-ascii?Q?IUpnWG9g2rtMnHNIJrIGNkYaU4VHhYpTk5JIkhZ94wpiipeoVWCYqGhG0eWl?=
 =?us-ascii?Q?WWSmHZE1iyQn1YqLh0UpUGMc8md9+2VtXJ1VwnYrsas18tJDkAXIY+vC2u9v?=
 =?us-ascii?Q?fx9oqRmNs9W/jX2Z6uuMDEoPB5VbaPWOtpWSxXPkuPpvyh89NsyVTc6WL9e/?=
 =?us-ascii?Q?8GKBuCprGHLSaJ/Wt9FR82xzgib8ttEZAPpm2bvKP8HyXyQsouROQkpYZtAO?=
 =?us-ascii?Q?5TPqeX+ibnsXYUXRNOMCJ5zwo11HG962OTEUMMiLLt738Xb8vSsKYNH2T0ju?=
 =?us-ascii?Q?GiOugjv75tQglB4C1EUXOM8RYsV/azX1eEUTZobzRYhJzbjMIpUR+AgnrW2a?=
 =?us-ascii?Q?TAHqgQoQAbwfmEhD9heqp0z+mAIzLR9l4xe2mEsD9f/vPERojaV/D8niX3mW?=
 =?us-ascii?Q?+hab8Y05aomZs773gDpjNWKnKQrUIsXtGvLBo8BiSlWsi6dgwczcVVRWrtpR?=
 =?us-ascii?Q?X8sX0KWHXfgum7AfXhANi5bJK5EuVQoS87Y7wW2yU26G/WMJb9h0rqZ/WDKR?=
 =?us-ascii?Q?aUNveRFjHnq9hOu6S1UXny39ixjlPpHwHGtWrg+U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cdbe0f-bfcb-4888-7c5b-08dbb6a95f30
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 11:37:56.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMObXQrlvlewIBjofYBzvwKn7johbLuCa+BJz+KBGM+kM+eTxeDiQlnNz0+5d2/7mlwgNUwLrSflKXaGojnZ5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9371

Some small cleanups to note when modifying the userspace pm code.

Geliang Tang (7):
  mptcp: drop useless ssk in pm_subflow_check_next
  mptcp: use mptcp_check_fallback helper
  mptcp: use mptcp_wnd_end helper
  mptcp: move sk assignment statement ahead
  mptcp: define more local variables sk
  selftests: mptcp: sockopt: drop mptcp_connect var
  selftests: mptcp: display simult in extra_msg

 net/mptcp/options.c                           |  2 +-
 net/mptcp/pm.c                                |  2 +-
 net/mptcp/pm_userspace.c                      | 42 ++++++++++++-------
 net/mptcp/protocol.c                          |  2 +-
 net/mptcp/protocol.h                          |  4 +-
 net/mptcp/sockopt.c                           |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  4 +-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  1 -
 8 files changed, 35 insertions(+), 24 deletions(-)

-- 
2.35.3

