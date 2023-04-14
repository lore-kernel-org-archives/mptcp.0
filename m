Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC57A45
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp1jNk6yagUbXa9A9z4dThsW8aBFiJ00OSQZB8RyVCf6h41HkXwEBUYCoBDRd5FlNR0YzhhQ/QHw9JJgzHiGpVK6o5BEqyKXjoG5oYZlC03CWoMQOgpxDO2/oZocSAgjWcUYf0lKJzwCeoPMmjpKbHb/KwIhnbzyQt7p1bBLvSIdjSDkqOBVehai4e/uqmQXqs/lv6ZF6n0g3oPPhiYtqi/73V2wnvrtaPgY5bT8pVwfCYKgnpb2vaL2YCpNHN7WT5VjAhqMQBxzZniHvtCABdLs1MFMgyrbJd4hoZG+UfbnFbXAlOOoESBb893tUMomUT59/xUzYPgBHESYKxSV1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6XN6Wuz3ZTBOexgqx9C1aDjo2LBPx9eylk4rW7wtws=;
 b=FCNjMJvmVAIanbQH5TZXkoQ+rJCV4QsGqbf5kB4TpyBq64mjeZU6I465W5KQm+BtlhRYjs6zehuWY/ILqF3VeMrGoAat0UnlB3966UyzjR/2hWPTGn7q+F40TDfNf9k6A3PhjRfYYkEYwrezIh5+y2MCaa/x4go7L1Bu50Dyh+tF+1QQYpV7hxN0y7T5BqoDs5YhtSDT1b7DXLARqOuawEDprgfSDLw8TWNLXIIbp/B48hqLNvLdOQqshygA39Y2Cav71YC2LQbTJNgykJ1PKg+J07CuHqthQ27MqujUWf20es5zJG8JNmGy8t2v38O020u+2hbtd5LDWC4vIdOcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6XN6Wuz3ZTBOexgqx9C1aDjo2LBPx9eylk4rW7wtws=;
 b=FO9eO0GMv3kgnPVmGsPUY9e62t4fAff6fUIKHD9dKvQZ7JVFR35Q1Tc4clc0RBMFf5Oy0t3TebrUdfFkw6nUdHil6s0C7+sYtgUra29r6P+2G8+PFA+xa8SGrqgJZuXgTsEREDurhHIGrWLeQopFc2z8vfk+2PRjrDzfTdtJGUjtJBP/WHlEWLiCI+maojF5XkeUQNmc6Ubp8iCYdUaSUhiIDka2beBC7N8iC9F6o8k7IEv0z6L9GmU/m8AN/4yBbGENBLMqE0D8Ff9I2XMJlPVQDz9fM+b4DUshay7bwU9XQod5PxdikwUwI+pCjkz6dFrm3o3LemVxABA+PiQ7nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 09:11:44 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7feb:1f7:3ce8:327a%5]) with mapi id 15.20.6298.030; Fri, 14 Apr 2023
 09:11:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v7 3/7] mptcp: don't clear userspace pm addr id
Date: Fri, 14 Apr 2023 17:11:06 +0800
Message-Id: <63539b68194e4eb842fa5d784ed5803b0bf69f32.1681463340.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1681463340.git.geliang.tang@suse.com>
References: <cover.1681463340.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: dedc74ef-f5fd-4831-90ea-08db3cc842bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tl6E4f5D/FAZVGoWZJTt6mcmwf7uC9GPJ8eSjIxtdENUYBKT7b1ZH+iGYOAWpvBFBVg881BImS+plWOJPqhAeDFl68shmjsm07PeR9INx0uNIZk8nKhG3llIb77oZ0Xwmg7sp5Jklpmf6Z1TbSRibuSov/yKpVuUTpAFm4erzoWgTu+LJSa6Fhs8TjjiD1pdV5SwN+7wPCBWNTYSIZ6YBmDMgDbZxUaARAQcTuSDu83geyMHuH4ArioDGG8MQelnIKVBkt4RLxJAz2kjtvvic/1gWScg83av9EZmQOcqlF2oLgph2BGKPVHVLAQMBcCfTyJGJs4J12zuI3+Nw0q2KXAPGfd9MxS8bvKNqteMMm7IQq+U7nXrsQa1cI9jjqsKzT7/wQ3MJOAxEIiQHpCFGgVGMpDhlWqR3S8v/icNKJusvhQyB4Dc/MQ1BbYqpudRcDdTvBXjao4P5oWaBu3tiIsdcjmbm0hhgK4cEOVOFwlQ4YD9LH20SZWq9ejrz/KLhUmV+Hi70SOysVMfomFAKKxW6Occ/JzXkt8a2oi1dyD0dY3M9aSEpS0sw91Q1fc8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(478600001)(6512007)(83380400001)(36756003)(2616005)(86362001)(38100700002)(2906002)(316002)(5660300002)(44832011)(26005)(186003)(6506007)(66476007)(6916009)(66946007)(6666004)(4326008)(6486002)(66556008)(8936002)(41300700001)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZtHuDuhQpxUsiPWT9BiTRHeeQvlS9bghqFnB3PEAlGOj2CiRD0BVRPtv2nZu?=
 =?us-ascii?Q?T55OqxkBonPnrTE1PNi1Jlh+xYd5/IRuj9PcfWpnR4orFStjWRrgNYvE21vm?=
 =?us-ascii?Q?+1vhZskeD8Wvz1/AW2v8r8cfzCbTamllvQ1IWhwBIP42nnkr7X/CylMOSUiQ?=
 =?us-ascii?Q?OHlaJpgpt1AgzvVGoMmQajZu+IwmxP3+k9YqclX/d9KcwWjg3GFqVpPWHAUg?=
 =?us-ascii?Q?hNN5byIbJeeO6QCbv7v0ZGzudJka+EcuaevJceu/yxLgDLinhW2wrlIzDBA0?=
 =?us-ascii?Q?eAmABIV1TQ79EmOSR6PjmKVNA0HeoFItatAnjCbhLP9Exr/Gk0rJIzaNzDuE?=
 =?us-ascii?Q?ZUtWsRE9tXfLM3Yvh6Kx8P9YjPjnCpMwB92cttcSKW3ls/xUfV39aC9jp5te?=
 =?us-ascii?Q?MZUAu240iBueGHG9ZpPaf72Ono5fy5LTObgDQWfDhFT38vDjLxGUBse/D17n?=
 =?us-ascii?Q?tkeIiifux6FGmFqksTbQftnlxltx/1csZORNpdf7Tqj3OIrAiP22SeBN61ub?=
 =?us-ascii?Q?lfAgj5RVKLb48Lzke4D/1IvoE6f3vQHHU6U67paDdfoRM55cINWenP7gfhQv?=
 =?us-ascii?Q?CDoJP8Qcszx7moOQqa/ukQjNz+yjiFWDl1gBeFwsm3wC3k4q5VPF3MPmBa7g?=
 =?us-ascii?Q?x+VfF5lJuD19DCn+CvktFIg6RNCwIpaj5kZPtbriHjVF7sjl2fr/n0JZ1IA+?=
 =?us-ascii?Q?wUWToLdS1ZYGLJ17MQPx2bjFnJv+SBhVRPS+qjhbYMWlGLY/t42dtRj0S81+?=
 =?us-ascii?Q?nLyxi/kBxr+sAoQSSw2d8rY+ZWE1o/t7eOkPTR14dOjMoj5/tFxUDTNx2nSO?=
 =?us-ascii?Q?qiXZWvSSpCjJKC0lpvH7Ft0Snwvwtomig2izZTugW8j33XWJsnYaMANW8UhL?=
 =?us-ascii?Q?5FA49RbmWBNZ0pfzIvVnn01LDK2MeuE/xG+3rS/IEmP2PYwnuYHv2iC78wX0?=
 =?us-ascii?Q?YGJPFvEKylwlGI/hZmEc/DVjEXRK2aWiOdaI50ZIXi3DGaUewrZ8MaOOVYNp?=
 =?us-ascii?Q?KzNezsBBtXEux7dRA9YDTepgS4RTaM/hl2rXRi8C3HfR9e0r97r4+0qhvJ3u?=
 =?us-ascii?Q?2Iq+2nkY9Z8wLSbMNZ6w90T8h+t87N+//mt+vajTPODdcpm/fT9c51SfX8cG?=
 =?us-ascii?Q?On0aGq72atmH1hmKRVsmjumMjXwQDCXCEoAfQI5A8qapWWTLFHg44DZpGomN?=
 =?us-ascii?Q?u1DKQo5Rr1rqZZBr+Awwvx0pwZIvuo2couMMIsd8Qt3z5qHE273CgifCKC0y?=
 =?us-ascii?Q?P8RtrEVJLX47VWgXnnT5nNywPC/eNc3VSXcrNMiSNRpAx7Z/4Br4/km6Glz+?=
 =?us-ascii?Q?kMixtaCM0+5bxs7JZ83fzLBF4yk21ynUsm31VSD/lAD/8j0HdDPNLqe3gBQv?=
 =?us-ascii?Q?a+E8eGuCfdHD57RpkhxXmlrWg9cr+qQafx/R+qiF0vjgoqigzDJzrvvvrnzv?=
 =?us-ascii?Q?YKLCmshUfsaiEUDec6akmyzxkzS5v0h49DjAjBd3GCgs5W1zG2x3yilBQ8xy?=
 =?us-ascii?Q?piXwAIgL58iQ5OGyH/eaB+rNnHgv5YkEQKOCpA1mzH6oeVmsOTv8Ek/9h1nb?=
 =?us-ascii?Q?wybK8p9QNC+o8f/7Z51ZQQPIJOEVdobe/EQUYhZt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dedc74ef-f5fd-4831-90ea-08db3cc842bd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 09:11:42.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MqT6ezWqyY0xlQxDHA6HfqAJ9fj2sr1lDOrulWaDbdBQcvCIOWps1EadoqQS7CDxkvbjx9YZxR8QpP7jABqJwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

Don't clear the addr id in mptcp_userspace_pm_get_local_id(), clear it
in mptcp_pm_nl_get_local_id() instead.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   | 2 +-
 net/mptcp/pm_userspace.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index dd15ed96fae8..ca1d141e3a93 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1055,8 +1055,8 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 {
+	struct mptcp_addr_info skc_local = { 0 };
 	struct mptcp_pm_addr_entry *entry;
-	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
 	int ret = -1;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 07714edb9086..312fdce174fa 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -113,7 +113,6 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 
 	memset(&new_entry, 0, sizeof(struct mptcp_pm_addr_entry));
 	new_entry.addr = *skc;
-	new_entry.addr.id = 0;
 	new_entry.flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 
 	if (new_entry.addr.port == msk_sport)
-- 
2.35.3

