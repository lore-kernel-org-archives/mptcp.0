Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F117B
	for <mptcp@lists.linux.dev>; Sat, 12 Nov 2022 09:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7c280Lq/1XIlkG2udF7dcSM4q9eotxLNPXaFa1u6jWRHf4N3X8LU91MlRcIiLOgUhtP6J6jGuVitmu4wirdDRd35QN3WiN76XnKJSAyprJNCPOEXwH1+4r+ZubIjB3EXH9yqmCcap4lOZBnDUrsF2bQ1xwK/y8GDxPx/SIYtic/V+N7ze8eWNWfVCAX3AQ8N8JY3vwB4l1jedpBOGuMZFTYIrzm9+NHmMcZrE3uJyFqxRqBt4VVitwxIt8XYhq8hCiGxQQ4nFEnbwk2CPyiu2dd8r2m3R1hzOXJeBvPNLK0T0YSuGXVZRlQVGtG1+TO4LmlXTmxSyXYfk4RAkAs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIKzQ85HYxAZq6lw9OVs3QEFlyfJQT7zq81Xq0UGgb4=;
 b=TK+tEvWRMtuw0KzlxfqRH6zneLp7dyM9BcfEP4a4UTaYyutc9ThUh2Vo7AgphnjOjrVEQ77JYbRBz/czlD1WqBCzrhsrVjAphexGuvTg54O4gwC6TvYF2OJRncJC/TcawodXt9GS4Wdj+DZmmQ0uJLNuwaiOhcGDuu8MognWK+VyWuT9cIXmNnp25l0i5Tlb73Mzg/Fv/SbVGRz3iFyIkszm/09I4oHjIFtco0qL03+3+b/pxN4YaxGHQeESmZKtmGQxMB+/vjgFJN7SrhoGN9S2Vfht5tvRzTlmGQPFgq6x0BW+WiJ9Nu51z9R+FC2rfG3fKNOu7x1IR4xRTun5BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIKzQ85HYxAZq6lw9OVs3QEFlyfJQT7zq81Xq0UGgb4=;
 b=H7VOyBeM1QuQ+EYeHOBzL2XxpX1WCf/2wRGPr4iyOn0po6F6YbOksKaeuPq7R1qq5RnX+uHTeGOe5SfD0fCVywtSn/jHhKCBgoxEX+rXSmZcpyehuWlRRbDzpC/YGjiq+ABLX7PNdIX0KIhu2pXwZ3z5uBuajQgD/lk7ioFZJUAMrn7k2c98fHpXQA0ce8o4vNpFJphGaIwNC4JtPymfVoxUhDazm2u2ZZ7MX37PMhCkdkZoQSgr3DQ2IryStlkicPOlhk7MAhqbZ1h16rfa5W5e6keoxRllpFRfBomMTSiUDh3+lYcDXe9EwrTKDiYAi6RGEPIw2mhBW6/G1hxVfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 12 Nov
 2022 09:28:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::40e6:908c:5bd1:7bb4%6]) with mapi id 15.20.5791.027; Sat, 12 Nov 2022
 09:28:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 0/3] add pm listener events
Date: Sat, 12 Nov 2022 17:28:52 +0800
Message-Id: <cover.1668245254.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd5efb6-8d08-4feb-4b6d-08dac4904948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TpF8a/O/N/C4uf/UdjRRD3lcQ2AjQsF7svArqQ4CVGv7eFBs9DRCqGf37+US53pUftxweRtE881ZDKuoAFdApDPHZYXS7q90hN60H/oF3P6ZjIdDT5R2LaU5AcQ0lqFt7FdV3bQhvFUMtWx/W1HarTchCiABmRVX92vqeTfKzeP4prKxqpT7P9wIZ6sXvLx28rmFZpeigPNs7G5qwys6JL7E3PNjy2SJKH64Q8P+TMCgad0tb0J5Bcnxa0veTSBh6Ww9Odeg//pld7D/gl2c0nG2rCHj6eXpUmB3cEqmgrYvLYX6whpUPfWzfIy1TgSnkD9TUWQHsOTroAykWsIRQqMgqc4IDCt4iYdO5IsGfWda0YdvgCGHL8UKVyvGq6fIGT8vHfwUwova7ntBXSa0HXgQwXIOSnWWSSICd226W4G4Ry2vdvhrgSb7EW8JTfAAxfECyS8yjtQmIHQp1hUU9RRQHMZK4aBXL8VIVfnQrz9Na8YD1irz5UiF0sYM90T8jBB54dVvJY3wbam5kxM8REiek3dcL0p+8/iK0RfdC/gEbC9dzU7+A4qJskKFGpg9d+TtUyjdGGuF1zVNBmhkyVvg6TP65bbyexzPOG3TxJvaA/YDiELvOJCRrEhE2hYZ1EhCbR66a/jeAfm8IplocneYDrwPik284+PFSBkRDUDcAlUjDdqtX8WvccH/7XZKR0tmodYUJhzm7h2Eh2rPFY1KafM8Aa3gF4d3T5htHDk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(36756003)(26005)(6512007)(38100700002)(83380400001)(186003)(44832011)(4744005)(6506007)(2616005)(2906002)(66946007)(41300700001)(5660300002)(8676002)(86362001)(66556008)(6486002)(4326008)(478600001)(66476007)(8936002)(316002)(107886003)(6916009)(6666004)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PeTaJLOkMmO3LXb7rokkUH0nMK54opnU0pgktfgF/nZw3NYlp1peCY/DRyqY?=
 =?us-ascii?Q?fSEwMCcD/6Qeg2FdLwpIrZT7a021gHL/r4sKhWWkcktpUOoDCTHUO6bCnGQt?=
 =?us-ascii?Q?OjwIQ5Yggj2aLvKGCKRi7EUoWKt6UvBAdeSGpf8I1gNFRrvkFs69ITHkkoA6?=
 =?us-ascii?Q?NS2Bf9/5u+WpYLWXTrWT6L0ddFHgQYldD1WTjCBTUgITu/5unDgfVog2pbiv?=
 =?us-ascii?Q?/O1TZyNFlfyu+xf9J3ygY8S4ajS4YLClyPUUi/Odm8/ERiqWUJDXjqLxGpyt?=
 =?us-ascii?Q?rFTyWj6D5SFADzEEC68cMURkSLauFu73skVQ3zchBNTuk462GFUBOsm8vYG2?=
 =?us-ascii?Q?cTf6FUSADad8TrUMW0MoGN9wdYNeEVJx1iADAfOLB9U/OT6tL5N5T2FMbMGY?=
 =?us-ascii?Q?IatDmjPaSj5bVjdtprqxXsq1N6LxqOvdYCScb1lSJskTDGHdD8v8K9mv5WFO?=
 =?us-ascii?Q?eoSnjshlqg7zGWoYlnLqR9KgLfc2YiKk/1/JfStXATbctCWstCfmxZEY8hSe?=
 =?us-ascii?Q?E117+RIr5g7iqMewkRJ8RMiEqMta7JKU6bQyDt9ooPgdFh/0alryDbdpdhdL?=
 =?us-ascii?Q?lYLGIY9maDRDq3S2HmdMdt+btd5nsqakNt5XddZadbUxBUubi2rVkIiZKXmS?=
 =?us-ascii?Q?72UVCzWYfWfrPC81f8JmA5Gfz4meqZcoWWzWvOgZkjcWW7qFK6DsYsAOKsBt?=
 =?us-ascii?Q?Po17G/B2fn/Bu5SC1JPEgvnXRFGhB1qlP3CfbmWMsNUJ2C45qnhnagXxRukH?=
 =?us-ascii?Q?WYUKJw1L3nzGecEKqHxaNtf4Q6uOXUZEdj/3x+StZli0Iy6RAbRLiftunnD2?=
 =?us-ascii?Q?CIF2IM7jBifgzroyg9/+9gt6QigmDD9kQZmobUD7uzVE3B2SEeYo1fZ5CCFZ?=
 =?us-ascii?Q?+9Ta/A3P0hjfz6k3G0ggfE3PbjOtO5b5cEox74DfKnJw8FgHq3h4zwaggUK7?=
 =?us-ascii?Q?DE1cS1UKUcPmn3BcSlo65Ed+UTdJajDOD4p6X1XK7LKWGEQtOF2NTjDEL1kf?=
 =?us-ascii?Q?TNPBltyqNjraO9qwmoAb/p87CwaN/61H/67lu0FAn89WI5wSM7DrpGdHQ0mj?=
 =?us-ascii?Q?ZXXKQOU/OViTskcNyReyCGkhR+vlXYTw5bXF4pfZrbHUVmJtOpQCoA/jILP0?=
 =?us-ascii?Q?YnF7Az3/MgQRXhDzBaHoDrO2WWZL3bQKmri8OA58Dm+rANQt/U3h0CTCGLjf?=
 =?us-ascii?Q?QbkbQCNO2i8AIqtZjDhOKohr6YYBt9kgkSFOSzuxawW58TaFaXKX0/rbcjdv?=
 =?us-ascii?Q?iPS00ywuMPiudhUGjRy8m4uUnft+BTGddJ/GnHQqV7gm+emUFS1P+tnyBdro?=
 =?us-ascii?Q?PlTanvtlCU1kcj2XZ3//sxjHf+cmEY/l3fICDDeiZzfZlNfxlPycAlhrF4vj?=
 =?us-ascii?Q?zfnCATUjSZHWBc+y/Vj8SQKmoQ0oPnaNHqDJJ4uMrZoVzrzQ+sA/yukoe4Wj?=
 =?us-ascii?Q?H8//3SFUPNfG0ruEAcyVQaccARfg9OnHWAbk3NWGrHq1mdnJ2XrB4fTxyv5l?=
 =?us-ascii?Q?FoXcwh+qktTALZZVvFwWkO1WYrtCMSnwJdnaUgQme9wzwnLofTKwyIJhcxsR?=
 =?us-ascii?Q?D2expjPEEh2lpBF6eRUkTffOWxenkeaWboWWfqyCTdFxurROk9fPcB5ibXah?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd5efb6-8d08-4feb-4b6d-08dac4904948
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 09:28:41.1405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dALV2O3OFYtRJEm896OQBBFg/qdTnqC/RJFomXc7k+Ao9o0IMvGkLwzl2PrVpGE8E1cjhRQaTWg4FeGUHQcnYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

v3:
- add selftests.

v2:
- send created event from mptcp_listen.
- add a new patch, use entry->lsk directly.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/313

Geliang Tang (3):
  mptcp: add pm listener events
  selftests: mptcp: update userspace pm tests
  selftests: mptcp: add pm_listener tests

 include/uapi/linux/mptcp.h                    |  9 ++
 net/mptcp/pm_netlink.c                        | 57 ++++++++++++
 net/mptcp/protocol.c                          |  3 +
 net/mptcp/protocol.h                          |  2 +
 .../testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++++++++++-
 .../selftests/net/mptcp/userspace_pm.sh       | 89 ++++++++++++++++++-
 6 files changed, 228 insertions(+), 4 deletions(-)

-- 
2.35.3

