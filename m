Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E56B7B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 10:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPIULbojZosX9D2ULo+8/tZxWGxUgNUaWJBgHIZ+ored0haot8ntyYgXXJmo8sbO2NpnHqBX53ihLPucXaS4UPa42FVnj30Hx8yGu9Y0lp+JDFQWabeoYn0LPeMk3HphJfIu5nk/j4zoPQyzHK1Xp/Kcz+4n9vnQkibkI6lBwdOHqt99pPDnlGGt40zLpUqtrxbQXi3+Mrfq/7bXWt4a4F8e/Z92pYa/hoIszX1vvFZr6DPGbKTwd4Ei/8oAaDxKEaR8Fh2SRQcAkx0Hbz0vJ73C6KT5J1HvfvwS2XCRWJiBOvq381R2xy+gYaOFfgJ73MWlqjHBUGSLl83GMO1prQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsl/YtDktc0N8/4qwb37gHBdbU2WlsBtgUlkDgJG0VI=;
 b=V4CSxjJFK464W7hXQDSTv6YJGWqVsTcfZro8FmT+m3tXwGGk7SBNxDhIRd/nvi95YM5yQCxdBEV77WF7ESaWDAWU4RUipEI1mnl6/dOC9OKgM3aV+lvGHm8PT3abvcKGAQEJOcNLpDjFyzePE4agoDHXcFHm87Q6q1sBvPL+uyMgIpYIfTZfnILRIayjUtAC0YpdC8f4JwUtAXbw3UvMP4M/FyInHrR7DuH1eVoMbvYmwaQFS/Q3X18BtgWMLDMkm5Si9riElDTJe8IZxDgCof+s5mUEeXfhrpP2P9ZUlZ5j/ZNif4WIOcGHuJwOwn9DKz7ayGQuyBw7OUszqGztaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsl/YtDktc0N8/4qwb37gHBdbU2WlsBtgUlkDgJG0VI=;
 b=j8+A8dthdw/fl+/79gKGTadJi0Rq0BSpCFZMvK0ldyCfwCxTj/2PkTTeqx+H+EiziY+G7FPjEqScvO64ZUxsPQPOUuNWQMtGOsYoDsg+CK3vp6/4OFoJ3dDSufRd6KQUeqbn0A5J5w8z53Dmj+1lCICjTvl+UzAens98M7bv9UBGdedWUR5wpJJpfpElZd8gTdzlyou5ypba5LKeTQ7g0afSDp9WoGcC5ZOlBogU3ZD+IRKMON3l3qsgJjxsGRsBowVhWV+Vi4lkYdAGI0xKBZW2zmpEqUAfbYbwJXDPUtQtld5w2QSwOVLIfvmM1V52PGOiF8NAxFnDwFUHPa9Nlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM6PR04MB6741.eurprd04.prod.outlook.com (2603:10a6:20b:fb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 10:49:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::e50b:e0b:7b9c:a79e%7]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 10:49:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops"
Date: Thu, 30 Jun 2022 18:49:51 +0800
Message-Id: <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:3:18::33) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89ff33e6-21eb-490c-b3e7-08da5a863c0e
X-MS-TrafficTypeDiagnostic: AM6PR04MB6741:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yd2Udg0Klevk2jRoboTzIbQQ+B0DbZNGzl19HjoIh+W2RwHrjUSn1u8FxcgiofZJQjzZKpLcrH8hrXgI3cchndt6Z1wwONyhGzcok1ck/ZoNb0Rq9u1jK8zLFpfd5gA4lpO1SQAsC/ui6r4JOswcHGy7KDub8GooNLqcK4J1yfQdxN9cU2Mfmj4Mxp/YmNBW9t3OKSMFVS/nDaYB36Zldit0svU+3UACuydL5pL9jFIdTW/Rrpqp29KS+QQxUL1+faumg9WtqcSzeh02C8ZLURqCK3tckL8AwN3LuS2IwuDBFoujBRl05ZDpFItpF3UZCfoFwGcv1G32MvyU4hMBYIFdJz8aN7pb91tKeJwLUMDXVcGwb9iTqqcgpsaVV6RmEURbBdhFGaCqjRXV/aYFGWDidJO16MI/XiX5Ed3N7wI9i4vmzS6YGs+auNObiEwftDmMfRl3dAy6yWknPda8RIM8ojVVfPmPNefEF2VuQ7sxhKqjR+4/PT0D2JL3IPyDxTVkm6BYZNwfZeAgkWRxstD/uXW9z4VqyIQ7+vZ17Q3fkfnZ8XFLeXxHVjk3LeqxJt0ZtHplgc6/esmkLuAmHMhvxv1+0K6uKD7Sju8RnK1HS00/MBHRO/heoUDBghwFWVtQrd6V/tYrD3ID8V2HL2RQje0KzLQGAU0hU2YiJwCny7gjJx4v/DmEgJDRISZWzLQoPLW+qHt14SptLsvdt3Hh0oUYoXHYuMpgAma2bFj+Ln/VS7kzOjoExjqn4/5NmI2UXkpsZ6kWOQgCyBnELbhdHDi5eOgClZiK6x2+60M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(5660300002)(6486002)(478600001)(44832011)(6506007)(26005)(86362001)(6666004)(2906002)(6512007)(8936002)(66476007)(38100700002)(186003)(41300700001)(107886003)(2616005)(6916009)(83380400001)(4326008)(66946007)(8676002)(36756003)(316002)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wca7W09byOT1ozZpPXZeoqb3aqEtwjMO/ANc6R1PNX9iqeyaFoT8KAzje41J?=
 =?us-ascii?Q?LNpvZ6331+U92WrG4C/95aG72KT1O6HTttT4fPcbMPcY4N11N5hQNRdRtg0k?=
 =?us-ascii?Q?pSy0bYcf73Q0nZ4JM7FAO6EPAQnwafE+f0PTyxynx/p/+MGniTNT7ymnCu1h?=
 =?us-ascii?Q?Z9XGGuW4P42o7XeFkJB1+D7lreFTOeQXzxWwc2671AEqxcMtjnX+SsUhFLcR?=
 =?us-ascii?Q?7H/wMGfXWxDtXNnc0bmPmxo/czFNGB8Pfl5aZBMZlSrNKmPONehO8oEalgni?=
 =?us-ascii?Q?i4OmWT+/rWvVKVbn70cxplbalfW6XAJhVJMawkGuVEi3egBJDrrwCmkXjpiw?=
 =?us-ascii?Q?hoICmfZEKkBQTNRz/EHqKrpZWALH8Lp1+o1uGutZ1+6EE1cWKBTISLtVOzHP?=
 =?us-ascii?Q?WB4Cv/8YWOu/aUJbapmxiV79CN8kemJmPz+4kDltHJMyi6m0UBiPRNz8Jgnx?=
 =?us-ascii?Q?4o4VePEX0NKOyD7T2XF+gjpq69ctELaVUUVq/EkW8WozIeROSN+OYeI6A+1D?=
 =?us-ascii?Q?OU6U5Q+GKlIUEi41uwrFQvLGJLkWW94T2tW2Nh0/OdWi1XEZFAGiZ2gz7dd5?=
 =?us-ascii?Q?fR34f/XAC74yEDq3jyZgqc5g0/WHqkeDgl8QEa6gSjVhVNsP2/G7X97juqxr?=
 =?us-ascii?Q?62Y35Y0KjcPnnA4toHwKAKoXvhF/xGMYSQBdCaX+4z4cxkF1YdHB7KUv54aL?=
 =?us-ascii?Q?rVoU8eTgP1mMTt4NRuW7pGw4lGVOOVxuaK6cXHnGKWNI0t/5XILS9Z/YHo09?=
 =?us-ascii?Q?k2EGOSItfOW40liReKjDBVceaGo37PqjUh2jVNWUUqRPmOjyIr4BAyHQnUSE?=
 =?us-ascii?Q?EwZ6ixWaF+orcV93XIInioIRj260+f4McJlqrkwSFipQGQ8XmH4LlpT3wppW?=
 =?us-ascii?Q?R6t3nd+Wd4LD80sNnrZPY9M3PzKHahU1wCnAYWJviNnszEuNNzWpvZG0T+3l?=
 =?us-ascii?Q?TaoZVBF9FU6g/MY0xgL9w/WPac4AbQFlSQKKn6wLWmgr343AUkdcjFpw5qR/?=
 =?us-ascii?Q?H2X7KKmF3opADn/OycFG1+krMV4ZzG49Vv3SglxSpVLEwQCcZrRT2bJT8PJj?=
 =?us-ascii?Q?5OxqCwyo4zAoC5ST59nRfrj73NlUkOVo2/s5LRqyx2V89AQYHwBhdm3DlPs0?=
 =?us-ascii?Q?KYPieJZTReFevYaxrY3dTpCrFIPARPXYXpcaqtZruzI1YGuiNmpGG3tlt/2n?=
 =?us-ascii?Q?aoH+RQGpw+2KKRrwp7n3zAC1/klJdwuzyuqmmr10tkjVXa2uP+Y0TY9KY0+1?=
 =?us-ascii?Q?I5rgBPb4+chdyAM6hbfTPmW9R3t268AFxvApPwweYH5fqJiZnuN5/8PomYjf?=
 =?us-ascii?Q?MHHhOmqzGVeOAJ/sHFM3M8U1fZl6BL87wVfc49wDvowxnXWRsZsPLy4mleG1?=
 =?us-ascii?Q?tR/aIIyZNSiBhWDQqED1VkouTIsBnoCPr4OHzdYVfg92w25O35mWyVV+5Xbl?=
 =?us-ascii?Q?78mAOW+6fyl925n/QEmMGJt/9g045vzlHNaV0mJP2PwwMyYsPw6fhq2lo69C?=
 =?us-ascii?Q?qQPiH8oG238t2/IPGMHY5YgM8Ju66VxY4Zl1J4Tur1r646qK/Wpun7qIFPJg?=
 =?us-ascii?Q?klcB4uMtQyQuKXAOM0nPh3Md2oskcMHvn6XmFshPWdZQs+Wj2pnXxORHIn/m?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ff33e6-21eb-490c-b3e7-08da5a863c0e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 10:49:40.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaJq3NaxjhuOGxqYyuFW28OLm/jMDoskkoHMJ0HcB7+TsuFeuVy4yWyMItKhX81YyoK+bw7V5GNYqzbk1jIT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6741

Rename optional_ops to optional_sched_ops, rename is_optional() to
is_optional_sched(). We may add optional_pm_ops and is_optional_pm()
in bpf.c in the future for BPF path managers.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index e86dff4272d5..a450b0521ef6 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -21,7 +21,7 @@ extern struct btf *btf_vmlinux;
 static const struct btf_type *mptcp_sched_type __read_mostly;
 static u32 mptcp_sched_id;
 
-static u32 optional_ops[] = {
+static u32 optional_sched_ops[] = {
 	offsetof(struct mptcp_sched_ops, init),
 	offsetof(struct mptcp_sched_ops, release),
 };
@@ -92,12 +92,12 @@ static int bpf_mptcp_sched_check_member(const struct btf_type *t,
 	return 0;
 }
 
-static bool is_optional(u32 member_offset)
+static bool is_optional_sched(u32 member_offset)
 {
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(optional_ops); i++) {
-		if (member_offset == optional_ops[i])
+	for (i = 0; i < ARRAY_SIZE(optional_sched_ops); i++) {
+		if (member_offset == optional_sched_ops[i])
 			return true;
 	}
 
@@ -132,7 +132,7 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
 
 	/* Ensure bpf_prog is provided for compulsory func ptr */
 	prog_fd = (int)(*(unsigned long *)(udata + moff));
-	if (!prog_fd && !is_optional(moff))
+	if (!prog_fd && !is_optional_sched(moff))
 		return -EINVAL;
 
 	return 0;
-- 
2.35.3

