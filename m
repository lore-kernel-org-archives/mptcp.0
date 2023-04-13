Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0A28F8
	for <mptcp@lists.linux.dev>; Thu, 13 Apr 2023 09:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDEG6Nub+dRKPqS2XeAtVw1NkN/XqoSsORK39+X3q+R/3H3Rl843Y9rOEGbdse03xgWDyGKWoIeEQjMz9Y8gHYeOm8N1MfgvyQtB9a3IFXXHcQxUlvB1GbrsdTGbikgc2iNNFWu2JXhzmSkt05KgUPCY/PhmGSWjHt0yn1Z10cuV/nBNTxJ7F0lq19vyPbyDF+Hw+WUdLSMfMGlOMz+msZ+i6GtJg958WwsCeYqrRwk4Y6BUB3JHhotC9XPBKB4eVirCfOymx00m58nlaaR8N9UCAqLokVbl/Cr4tNWXsRTSSJ4eQ4etb+uPZF1X5/ZrKqHhV3wy25hozngl3/Cu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uK7Cws7wsJh2et9fUZc1EZgUM6tIYdGHZ0vifayZEVY=;
 b=gIjdHcP8WonVKFgrvtBEmSxPF/RezLqHcXx+Br3BfthzGIWwdWxQQWvYywBwOyAOzvzF/duLmMhXv7WoVX5nLCphr2UY0rZ45FYrWaykNDHwXiTqKw91PL7pwU79RLm83T1FsQJSYZDbHmJ/F+jb8T4e8ST30gPJdClqBa2iZ01ynlCZpbOhrFOwrkE2PuLVE6dJ3n4s4DfN9L1kdqPUGOrbCXopPAxTL241y7b3ipG03L2zi82X4Gxe1fxvpFesQ8blkyHjOBafEFbmMtBc1jOUhChy76sRYY1avoykiX6ckF/9hrLVo4FIdBbcrtqavSOfXD/YCMpx5DMhdTanqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uK7Cws7wsJh2et9fUZc1EZgUM6tIYdGHZ0vifayZEVY=;
 b=1R35rGddsTZhS/4k3AriQnYwuqf/9VXzLMM2MvfqHGdn0s/Sq7G82mU/L61tn4Y5mqvnOmYUy/MKSysLbK8uPuVHgYTR9WXDc7Cd90063ulukMvmZJtAmmMiGYYShhvbksbpeEZBJkDo7bbcAC/MLP6NfJmGbaYKOlvsUUGEaVy0jOeKeTF39H+fcLGy2McGfYU53H3Z4eqruX03VN7I0yqVrCLglL3xaWxEn4mu4fdHJkSQJaj87e5cW3B/PbLZTSyV4nVysAuPMkRVRLd+GGLYu36pMAmtSvJ4RS6C/PJWf77qZPGV5MS3tRPkxiM8ct7CTCkMxw3g24uWWHUDnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7559.eurprd04.prod.outlook.com (2603:10a6:20b:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:12:47 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:12:47 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 0/7] mptcp: update userspace pm mptcp_info fields
Date: Thu, 13 Apr 2023 17:12:35 +0800
Message-Id: <cover.1681376983.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::13) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS8PR04MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: e551cbce-cb8b-4b3b-67a7-08db3bff3f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9JrecSb9pQ7MAhmFz9e09kFKbjfug9cCroE9NnwGxN6nyxIR7/t8Q2cAtqNJKR6hvcNrY9X1gXJt/J1nhQFSRtSo6RmNx0uzOPRCDB7HFhSd/V3Ms+D6lAP8MkvtNtY9Sdksf82oJMgR/r3WnMoBDV0+XV/vtf4cvUn8+Jzd0xWRBESQFhfqMRzE/TmcMdAuMFLRF5h0sIJH5YjkC+Wx8xDrFjNTS0LIWApkWytuJERut6tHTguPnTYKFehm2tF8BTZrEy3GYNnXzm1xe4U7PVBFuc8/fIV5YYcpx2SmRs4GpDNx/0PABMbtQnuK/12UXKVeNmlZkFQMrURykvGjubYy0K4gGAI32zr+Tji/8R7BGK4ALSHP7XAU9JAgvmYFRE9EEJBTvUtXcaKnzYQLgl2uDbzPh6LlMUHp/2rzM51Apse+QsBhTSOLhldDlXMY59BmkCljRwlYlfy8rTtmvKrSnoO/ndlSV4oOOEXaLshIf6/ibAxabXk3LZyFs7MoA+ZBEGxybt7bCxAFzodBLkSeS6AvxBdqjB8eEKl98vX5SzeU5hTiC9TEaRsDHRF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(2906002)(4744005)(8676002)(8936002)(5660300002)(44832011)(15650500001)(478600001)(41300700001)(316002)(66946007)(66476007)(83380400001)(36756003)(66556008)(6916009)(4326008)(186003)(86362001)(38100700002)(6486002)(6506007)(6666004)(26005)(6512007)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m2d8DspXdwUSjBonkCNzoOcc3htzpD+hYYZYEd0O/LscpRadNEgj5eCFbIjJ?=
 =?us-ascii?Q?koPYzVVHNSMcJvDyPNL4gCqVZtNqJijYAoQLlTo3OgckKvzFQSKi8Xh6n3db?=
 =?us-ascii?Q?rCFQCoBqqMin0Ge0QWJiun6MXd2gm1ugVYuNG0YPL3IGF8ntPz0KZG/EJHmi?=
 =?us-ascii?Q?1o7R4WV0zrg628RCg5EGlaEjGdfx7Et2jxjCVMwR5vTypPwcvOE0TiEQn/yH?=
 =?us-ascii?Q?tnwOyVZYTw98NT5/ySxv+Rm8oaqLBl1QKDoNMRzjBkERKGctCbdUtdnQh7pa?=
 =?us-ascii?Q?+lXLvj2ta3rQI6hZhCfn8WmdtaXK4AkD9dCcDaY5/VH/jMnsGqvpo4xCjI+7?=
 =?us-ascii?Q?JIMQ/rGfXBXyMLdQ3utFClwTJ55A8ZhWTg8B/lWd795BfcYuhl97wPwYiGTG?=
 =?us-ascii?Q?4peBwizhnlsC6qPa5cwKUAiI8B2h5kF8ToTNwYImzlSg+lwZeVflVeomRvm/?=
 =?us-ascii?Q?Nfkn+szgINiwr+gYM4YyJhImvNBH+/BpFQOVPIhzJkr7RF1kUXLUVaMuGTJn?=
 =?us-ascii?Q?7H7vKc/YPgZwKCL2xcnPTwjGRUXjxJ9NwIX/3PTwnVN7de9xrAsRiPbtqOYm?=
 =?us-ascii?Q?G5zvl8twCXN4fQnoYuAih8ItKSnuW6lkYWnkLckCVUa1ZvNy1/PRsFLLpqW+?=
 =?us-ascii?Q?W1QnCqhYw5AooL4Si9w/aI660/c4vy5ORCEGngg4lUSwDb683cVCtZMVGF8d?=
 =?us-ascii?Q?y7UsC1OHCToet+N9IsTuCKL0ZkeAGER6bnTCZ1BrEQ37vXzvMc2478SMTNg3?=
 =?us-ascii?Q?FVgIsaWRlgkEjrdqguH690AQQz5aKZ053gNA6zEVWan87exvBv94q38w8UyY?=
 =?us-ascii?Q?42yHp01ogRYvEGAz8MjSdMIZAkOwOoNjuSlQ5G3OrsI+AnqtK3g3+V9OVkkt?=
 =?us-ascii?Q?OGLuq6xHiLDx+OwwPosEl34z/NOJ6Kerf6xJ+OC73Rsciywod5DY3kbPIMkB?=
 =?us-ascii?Q?BPcrCs546Y0ESEKTv1BQkRo1sNFOCwTKSGb1Hln4x4x8RN1UEMonqS+2RF8W?=
 =?us-ascii?Q?AM0oeGZJh1EeffwFyyOHEayADVBH01aQHux0P+tyXt4AGtKVynVctRDobcdG?=
 =?us-ascii?Q?Mk7PrAaiPmVIOZ29bbl0zXu19/VXZKIdre5+JFhSW1yJ59xeDmT3DrAEY00h?=
 =?us-ascii?Q?WYWujtQZAOscD4LfuwDAfG7lKlvXvkVft6EvX2Ts8u+iiIPpNPFAL5vP4AH8?=
 =?us-ascii?Q?YDBBgAIgP6q9nFPfKHSunAaHk8huwHxOPo9/sHAXlw+E4XiBKIS26P03jqhW?=
 =?us-ascii?Q?VC/Rfv6o+UoPrRUi697v53ec3MkwFs07yXa5I4UohsudLAeUEEM2n7ezUWqD?=
 =?us-ascii?Q?+y2+VbDt1JNF/N81Tu3xj2aQQ/iI1PdTKeU8DpNCim2Tqj7IvaN9CzFRzcug?=
 =?us-ascii?Q?vijegdEKA4bVBfJwELJJL5tFBF7YwNd/b5d8wbU3IIBQVqyhO35JxTXFVMum?=
 =?us-ascii?Q?ZhSDgoesFPhiIV6TGGtn+AmW0miogeqmqTriochd/S1XbhoEzPqdc8Dw007y?=
 =?us-ascii?Q?QZuSR8GDArKWBPbNrd4XTKAq+Z4Va1xMoRZnd7HYs2ZjYefmLvYJLiSFPvZQ?=
 =?us-ascii?Q?tjbz3ZQoRixW6Z03AydsX5Z3u6pkVY/lrcQRftgE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e551cbce-cb8b-4b3b-67a7-08db3bff3f53
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:12:47.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wYpnOkg8eMDSisAx/HcyywN/h6uw8kffSZM6dxCOki1Jan24TJfd5O/auqk2cPSGNeDVVYJQgrRgKGgkSKgYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7559

v6:
 - send a RM ADDR from userspace.

v5:
 - fix a memleak error reported by CI.
 - add more delay for userspace pm tests.

v4:
 - add more patches
 - add selftests

v3:
 - update local_addr_used and add_addr_signaled

v2:
 - hold pm locks

Geliang Tang (7):
  mptcp: pass addr to mptcp_pm_alloc_anno_list
  mptcp: don't clear userspace pm addr id
  mptcp: add addr into userspace pm list
  mptcp: close remote subflow when destroying it
  mptcp: increase userspace pm add_addr_signaled
  mptcp: update userspace pm subflows
  selftests: mptcp: check userspace mptcp_info

 net/mptcp/pm.c                                | 21 +++++++++++++++----
 net/mptcp/pm_netlink.c                        | 10 ++++-----
 net/mptcp/pm_userspace.c                      | 16 ++++++++++++--
 net/mptcp/protocol.h                          |  2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++-
 5 files changed, 49 insertions(+), 13 deletions(-)

-- 
2.35.3

