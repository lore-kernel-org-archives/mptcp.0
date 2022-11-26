Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2051.outbound.protection.outlook.com [40.107.105.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3E193
	for <mptcp@lists.linux.dev>; Sat, 26 Nov 2022 13:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjL3rZ3nh4AWazGT+cnPJtG+rGUuEaCOagf0LCgeabJRCJG0RnmGjxpLtUCd6J9WeyE+D1LTFH0bG5jjc+bhFxI16ftWhNkDRLd3WG8unJmA5PtZy8lKnHVV+qim0C6JeLH2DcXavwj9yN1acIMRMMB1JfzQ62IhQAEGbRW21XsGNKCEDAjfPnPyf52rBgRzQrNgZ50Ae7Jnqnc+Ju/t6VIKdVMDovRpINT+/R9yzgBwUWijdTE3lQuoQqfj++Ewb5wCmDXOaHS7Hpw5fKmRduyoaiDfRYIlpL12cikulMFqiO46S69bSQcH4h/UqNDih64ESs27KlLcCG30vnNV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp8fG2GrainhiDBl/jPwdpTTfdteB4jOpue9hIr/Z48=;
 b=V0txA2PINn7g4BFkFmJBSlW9aDE85D94c9V9tmCeXcMmqjs5/Yt/8SoIzcsmMKjAKBa4j4Dp+rPNJ46lsJv7fpr7xAQfxvavDtnx4Ugaa9i7T8D0Fm4LquychO5o7IqHRe8EcSUt+irICQTDTJYs1XMWU6RTbhc2JRpTe7IOoTJbqDy1wnbwkyY1OVH1+WHG83eZzft6j793gu0BQxeJmFFeMgAtw86GJs8nnhEGlBV/hi51l9mYnL03M4fObCh7rmxPhNekA8N8FWoxgyfm+MTcjSF5zqvBnXYhjGV0MMusB76teFp6jKmyBIGWVAFMsirG5e+gVwWE+Tg4MFySkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp8fG2GrainhiDBl/jPwdpTTfdteB4jOpue9hIr/Z48=;
 b=Ojf6jt1ajCb6QQSjbmWdyaqDuuOnI+1dVtJn7KY4ImLPRNdIQ9/wpcBKbw1/e0uuKt9hXVpBxeW2FgINg930oQSRFG+Xvxk08A+IfVET0JevdyFqHqsh5j4uYvwieXkrpVcsX7dn44ZapARg7kzvADaddDESB8vSnkAtLWxQNeoTKZzccDRxdMjf35yf8xmHqGJNNGBCy2qnsSwior6biOhCawpbktkdYDggoMPL7+qyu/Mvl4ZUOOLRFJdRAiLw4OvY2qT9lZttJDjyYB64bxhNPIag4ZGU6uufSZZAzADU32p9hH11Ma4bCjIDtj/ZxVxRtHMdjdrt/+3pJWzcmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Sat, 26 Nov
 2022 13:14:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::62bf:d98a:f54a:2852%7]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 13:14:52 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/4] cleanups for pm listener event tests
Date: Sat, 26 Nov 2022 21:15:18 +0800
Message-Id: <cover.1669468340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a934731-d14a-42fc-8042-08dacfb03428
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xht29H9hdfSUn3RviyPE/sDUw/zh4KRanShgTd3ODuYPNqQN9ZQn4cnWZNX0dDw4M9FW94Xm8lcnJyRRxvLPZMP3fr6s15KASJ3r+Lwr6T9dcxnR9lrMqv1IXmUFZD3uT+EwoPaO0fJCsnzWVNdSruXmmJQnLafXauOPKSiXY1kZoD4WeZQlUoF5KBCtVk/mZXNhrCOBzRC5DYiWs8wkaPIhSlY/QSTf5ldIEtmMz7fJZKPG/iOzGsdT2Z1GGvstOAoCn4PGG925TBhV9nUPPd+G7yDji6lFXnEQRNPueXs206dVR+guFMcehxV0Br17Alo886gBZwETChzIjNvobmPWQ1wqC9zVW1TowX1jrCAzPnfd4rwiYS7KtelwcR8fcY0Y3n4l69UbPBtFFt14m6+UEZjTG7tXR+TtGIcECZOCU2w4FRz0qrZX7Gt+jRhJ+s0sJhAS1JZzrf8lNVwsuOR+EV3ClDEvV6NjtwKU+6IEsaibXBhMNSkFr0C+UlZ1tb/P0TaTkQtHmjOxIhFSqlSWl/X3Zb3vrNr0XKuZBELj4UtfcMbllSSxc2TzeUyMbslfKQm8vdXpN6lHFoqCFle49P8DKlutkt9Xe16sdh3aUoNRUdzOrloioIaJQybqaDwuaMlwGNC5RGxnIuHjpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199015)(6512007)(26005)(36756003)(41300700001)(4326008)(8676002)(66476007)(66556008)(66946007)(38100700002)(86362001)(186003)(6506007)(2616005)(478600001)(107886003)(6666004)(6486002)(316002)(6916009)(8936002)(2906002)(44832011)(83380400001)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SvI+jD29Q4pZ503qI/aJnj5v07Yo6k1gLb/uu3Mp3U4ts+XMlRdiLBD9MJul?=
 =?us-ascii?Q?0I/EfQ14CfX2B2RwNk78Vso6huLrs+W7I43qa9rFjOarUgL4bpoo7By7nmBo?=
 =?us-ascii?Q?RGXNLn5vkoWFE6JpC8wp2O1CWLfttkCCBQqiwcj2Zb0mxiFagDA+s/0OtxSV?=
 =?us-ascii?Q?1gKE+e9gsHvhykEQbNLE2HMLK9axGAWoGjvE8d+v2fxgwRefBTiyH3rQms5L?=
 =?us-ascii?Q?TSFxb7ahNrL6nBb1OIncDAXwUvxi4eOybySIFWqF5xl8bdbIqnjTOb68H8Kg?=
 =?us-ascii?Q?9IjykSQQwaOF33OLNffeSfXXT8EixKs/h4nQtAyS2rvP/J7zLSJTYcbxoZt5?=
 =?us-ascii?Q?tQfVDFm7ekFBjtZOOT5EDZRKHj1H5TBvvUWZIKU25/EqJs15Ok+JtaGLJoOz?=
 =?us-ascii?Q?830e3qGfNN718MdejG1yYnEwh9NIx7Q1hH8PbFzMS0nK4JB8bDgdGFwAfC/V?=
 =?us-ascii?Q?tztXU7diwsPcCtxTJs8rxyHO4Y73v8E8A2HuVSKhdXQRlKswWxYXvRf7ZaqC?=
 =?us-ascii?Q?CFfHYp32T8uOEbupWN5mc/0sOc/U50VXOjbMHxMOjMSc1yxaol/mbNW8W4bH?=
 =?us-ascii?Q?de+rj0a9jzrq6idic8SWS2BDJBQIrT0C+QeaFfN99LCXzOIWLGUn9C/1K9gK?=
 =?us-ascii?Q?cMGykbuYiyP1/D9PFH/RLr/ll9W95J8xNrI64ZvFWHOFC2kvsWP9N8wIzX0R?=
 =?us-ascii?Q?FlMh8adqHQiJcB/Zisnk9071LRtj7uNdr8pt4pfCDr+D1c+WvLn33Pbbo2YK?=
 =?us-ascii?Q?sMfkK6Ti+u0B3m1ytWaI1irUlIlADFAj7qOCTORZM0k8NpK9j4ah7zUK5+ph?=
 =?us-ascii?Q?mkToumY9ZluVkb5lZTX471aEPfnwKnaLcuuouK+td7ffz2pVM0EOiJcExdNQ?=
 =?us-ascii?Q?eR5O78013aWTj6Fcf5Cm5y7F5bB1kW+cgaxFTYdSTaogRrmN3F9+bDTGt8Wu?=
 =?us-ascii?Q?dwOWF5R9pZUhGoaYGeMLrG7/VqJ5KN1szvWGEPHJeFWMpFsEPkowWgfqVpCe?=
 =?us-ascii?Q?aBhpP7WT3ZA1Mm1Et2OvN9BKFxxkokEnudOVKwuOYPo4/uhfZkvhYLtD98Yn?=
 =?us-ascii?Q?VOwvX/24MpObhTm8jX6A3ZCoJ3eL4u0gS6x+xNKIjvgEc9R/tJh+pdXVM8P8?=
 =?us-ascii?Q?RXo1A/ayhg9ghweWCL4YXCnpimrUkSOkNkjuIBhVuRpEquJVYxCOF6youC5z?=
 =?us-ascii?Q?71e0C8lYN85FcnGiTNl5NcWh9p7XV2Fmn+RKEGgYzwjzcgYVTycfDB/Fz+f5?=
 =?us-ascii?Q?M4f9Y3p0Ln1dgnJt1WNQNK0JHhdh82j6RX+oEC5l2r//jsM1S7D0/u1/WfRI?=
 =?us-ascii?Q?G5YWGcEcoa3tBxG97mjixpxrYBFdP43VGAai3hNwDqW7qYPiuStDraBD9txd?=
 =?us-ascii?Q?WqnQCAdWiL11IcsEQiNoro5wk/n6Vf3BfXkJbwy1bpfdpM0XcEhP0uMLXX8k?=
 =?us-ascii?Q?UknqdItVPMCM8oQAmwCSRDalgWzGfaZ1yB3wT8UsmS/PQuVcjt6meh27pQFD?=
 =?us-ascii?Q?rBgkes4EKDZkamTokRJ+dwMqGPcKvqlJ6UJNhrkWVPfuCwp2DDI/WD1Ine8g?=
 =?us-ascii?Q?hgLL8ZypXpPNndtMxNr9YD4mwK5Y5Uy0EMWZ3lTsKq1F3ll+6oALUA5du+KC?=
 =?us-ascii?Q?wg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a934731-d14a-42fc-8042-08dacfb03428
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 13:14:52.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Saamb90GBL4TeP5dUqp0FIryrejN25cpNCjuDrxisGqGWkBrIbV01MdoeV18Bjd/PSzgpLL0+0K+6yGIEyu44A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083

v3:
 - fix CI errors in v2.

v2:
 - add make evts global patches

Order of these patches:
  selftests: mptcp: listener test for in-kernel PM
  selftests: mptcp: make evts global in mptcp_join
  selftests: mptcp: listener test for userspace PM
  selftests: mptcp: make evts global in userspace_pm
  selftests: mptcp: enhance userspace pm tests
  mptcp: add pm listener events

Geliang Tang (4):
  selftests: mptcp: make evts global in userspace_pm
  Squash to "selftests: mptcp: listener test for userspace PM"
  selftests: mptcp: make evts global in mptcp_join
  Squash to "selftests: mptcp: listener test for in-kernel PM"

 .../testing/selftests/net/mptcp/mptcp_join.sh |  78 +++---
 .../selftests/net/mptcp/userspace_pm.sh       | 232 ++++++++----------
 2 files changed, 138 insertions(+), 172 deletions(-)

-- 
2.35.3

