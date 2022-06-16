Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6137A
	for <mptcp@lists.linux.dev>; Thu, 16 Jun 2022 05:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7y44FdALjkUMR6WwGCfpr2eJCPa9G4k8A9YOL6vMnJqZFtZrRuI6PpANw0PFzVvDT6FWIpvUEDYTlwhikjBXXfVdxAstFGWlockdyL8tfmnDQC0T4nFk71LYhqpre9RTdT5dMseNydTixgo1lzWFpMqlzSXizYemfqiCDt/6INzgvvrAy1tQVzlruijam9rn6/uDxoL35ocu0swSwoam5hQD40fba/W8r+GzfktcBu4B0O1q8V6ZbQTpHfFjJG3+IlmESWx08zEB62236yd3qoyPXBK2xbYY5GEj8llXnHFxlb9rUQkbe7AtVnZx3gccjwFNz+DsmbTtvN2UabUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXgX2HBq50glYCcQ33RefzHFwER9Pmf1gD/1RYA8rio=;
 b=TOeN3pDcPnj2bwxh5HQd2H/NJpxI6mD9gPNmxppRd6r66dORUN4EtHdI6BP2M0dB/oT2Z3G5dV0JgJDdlYnNdAI9gnF3OUrk4In+IcWvzlNmob1rEoW1e3UT1QGN6P9q+0JtcZwGwkoBsmUEl3hAsFVQm9s4kgf8as4jo84f2qgHC2TnV+0FX/iRPMeqIXNDkVy2FFqAB2FkMHt7asdYyDltkxtqGJqCcoVWz73VMDkdem+Id0B9S12j8REO3k5RediEqoxsvgO8WWVcXJefEuz11QUGfozLO9XUSmA6YFUVvzr1XFtgRTdmIuyIW5osLmQ4E+JCBsa3Yc8MUVUNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXgX2HBq50glYCcQ33RefzHFwER9Pmf1gD/1RYA8rio=;
 b=Zz8QCa/44X4j2JxunxbLqRlx/Tx2w4m1/NLMcR8PRwjuFgzPDOwdkpbOti+hFUDBnhKShC3i1qZGAsi0ZIKGvj59EDXs2Q93XXQv7EoDDF4QW4w1WJMM2nx+63aOBqSanpvf8JRMhxSJl8vBT1NUhiKuS2HpN/oWOCFJc3LQFbQX62bSZBhpdCkBevJK88caPydF13py+KCrgjBZY6ZCXNz7H04uh6SevvzKC+ZpounixffwcHWc2i6GDEE9jmdtzkjB2anL07CZ1A5SexGIZqB6wjBEsio6ZsolnrEk/hQ9AsYXf2Hf6Ibw0uTnRJc3bcL8SY/UYh3KbgmhNYvh7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB7880.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.21; Thu, 16 Jun
 2022 05:02:41 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::8002:50a5:a57a:d8fe%5]) with mapi id 15.20.5332.013; Thu, 16 Jun 2022
 05:02:41 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 1/5] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy
Date: Thu, 16 Jun 2022 13:02:22 +0800
Message-Id: <723d61d82730b996132925686b43f9c3c79bc747.1655355422.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1655355422.git.geliang.tang@suse.com>
References: <cover.1655355422.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 092b0ee7-41a7-4f5d-ac45-08da4f5570d8
X-MS-TrafficTypeDiagnostic: AS8PR04MB7880:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB78808ADA4A77A240614EE383F8AC9@AS8PR04MB7880.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S8yl0Fmruar3LIKsMQzQ+kKbPgqEgeX6prKpYiGr1Nu5rmre2ukszotBsDBmuOKpfWWz0M2BzISJ4UkL5dGgyz08lRxpKEa5NjUGGOSGBFurLvm4dlu61YRy0TBf41Ty2bsc0Z4C7HELe7sgMalsXn/0y3rJdIDCzijZxGYJqoJO4nPdDtTkQyUuqBUFR2NWAeur0Il2oOC4oCGyZZtre0wBPxjSU9AvktNayCmc4iDnWpPVBhUaTEKp4au1KPkqTyhzaVW3XDVrU8ku4B+sdUlui3S21hBSfulMTqoVojncZlAq95XkMDcXoTd1KHMXs/e+2iiH4fBSxpMu20TxdfYalQJ4dozIgylmAPKBbHSGy7G7vUMM9Y4+e3W1QEnWgq5Ge16lYEZiymLuJRblN3YWv36jVGUbvyjz94JFQmiXSIM1DqvsmQtaaxx703Ud2fI6bTQBliBNcsHhlknN+kumVZhH0fB/qkOtKP1TE+HjQa4UveNWGyDOGjXXgk2fYcfi5mOvAG+tg6hkN1ASMVakMZztDHQ85Xacu6UyOGHYV42yS+4gFVWZHXUwkWK47+Em/bmq3Tt8n+nre1BoYPkPVXZYZvzQSzkgj7chzEwyAO0psw3o/ygWz/O9K3y/a/pxBvugmpoSM9epmG/d7XGraJE38PJO0mWtKwyow/hmk5PgwJLtbOaGH5gt3seXpRX8MfzgC2vMWNfZagk/2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(2906002)(5660300002)(8936002)(38100700002)(4744005)(508600001)(6486002)(186003)(44832011)(36756003)(66946007)(66556008)(6916009)(4326008)(6666004)(2616005)(6506007)(6512007)(316002)(66476007)(107886003)(8676002)(86362001)(26005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e8eKI8dDTC7+rVGtGUnlJW612HcYbgj7IcMSPhXK+lbOynAEplkddLqg75LG?=
 =?us-ascii?Q?DCYjgBRlMIz2GqiUsvXuVocGMPlHqJXC/eo3+Khlg5W+whyUHpWz/Q5WkNFp?=
 =?us-ascii?Q?ceMo2j3goRyCthgMCsbn2Xz71F6tdkVv34ehV7vlDJHDWQV54hYfq7aHlwuL?=
 =?us-ascii?Q?AfFEZFFscbgmQ4gSkA0rHPMFVe6YE1He3lP7npNaNGmUJrOtERc43yp1TcHr?=
 =?us-ascii?Q?jq6G5MhK+hDiOdR1ZQScsVpIHZQfK45HnR5DltN4TSomv4iPcr9wmioTeooD?=
 =?us-ascii?Q?+jf/FvWoj0DzZtM80WdovhWIsJQ3cSJNo73q9KoS9iOHe4IR23P3mrqRrGR1?=
 =?us-ascii?Q?zrcak7A+G0D159ActVlRFfDfgBQuqRMuJn9z1Fcusy6OTRkckbYX01Thk9VQ?=
 =?us-ascii?Q?Jc/fxI+qA5yWtvEq/Z1Ln5Tio4pdncLWFZhl/MHXIu3lyu9F8w55w0rhvq02?=
 =?us-ascii?Q?ruy+HdsS0IsH8l5l5naroI3vtDj+p4vQ1iPI0amnqhk5h5LhhP/oxwKPQDBi?=
 =?us-ascii?Q?29U4gaBgYK3aBS+Ag/4Es1Or/eEGOctWXdMgIZCN3IRWp607rhyvTF5wfFrn?=
 =?us-ascii?Q?H/omNU2yumTzrUb8SBYJT5wpZyK3yGqTVG9BOuKN0HO1m1ReeOKuwxNC0pGj?=
 =?us-ascii?Q?YgJYxJXlO+0hzhzPkU2xpxfLZoSzwZqVyslXJW5LedLPwWBJgKKR1bmDAeII?=
 =?us-ascii?Q?+EOu+18dL2hiHxgdvatwKWXZtYIncyYL+roiwHe++Gg7xUr5Bd2UTCTYAC/G?=
 =?us-ascii?Q?MBD64kzQeBKNm9hRYhW0JLWxOyRp87r+n/flWK+qSb4N8FGP/FGy9uZhRmZB?=
 =?us-ascii?Q?hhysZ9ArYG+cBQY7/712x9EdRPfxxdp5+dcACwgyUgTXcxxB9f4uW7GK/NL1?=
 =?us-ascii?Q?FeBArFQ+/VG4otUq2wghii646wPMcbpgV5UZC/R8h8IiEJYi6lpZbBYVjgI5?=
 =?us-ascii?Q?1uJ4ql5xntmu+KJdCl6q26eC/HVkl3n9sFj/AgzLuyYB0r0fgm9Gc4ThEoLH?=
 =?us-ascii?Q?H76QkLb7ntNXA44xq6wpCKvuXcOBxRZZ8zs3VZjVUdlNDrbcGXNhPfEFXt9j?=
 =?us-ascii?Q?991paC36jeidb4IOxv/OUZ83IlbUFl1cZSPBzf+pFS4w2ZIJiTroe0iN55MJ?=
 =?us-ascii?Q?MUipb1qs1nMui7aXPUfNAZ103iyay+5WHU1od1q/4RdZrl7GqXNX5NuvfWVt?=
 =?us-ascii?Q?B2hFToa3lx5OlbzaFVLC2iEYnnfvNvDxJXwIONJyFmk70heWaacsmfctVvhm?=
 =?us-ascii?Q?Kly6BsTC7nk/wIrvAhKsHr7eq9XZtb+2+hKLosnHkZGLGpDgY9CY9p9aftOJ?=
 =?us-ascii?Q?n6U/UR96HXt6mO8OuOYnEUZ5RlAutlRyvm3Azf2xvBLN59oR/vzWh96W//jv?=
 =?us-ascii?Q?Ng2E5Yy6+5QuHNS33O+f8hrD1TksRw7g+tqfWgXUT273foUXXX18gdxlnl0r?=
 =?us-ascii?Q?qK3Lnuo+4XCljqjeNv9MqCZXqhk0ZJmOz8Kjaq390AFgTk+jG754eBZqbhgX?=
 =?us-ascii?Q?Jtb/PTkOONGulrW5cgzwiy3JS64I3sfhWBHUwN/WnJmK508Br+dKUtIcD8hZ?=
 =?us-ascii?Q?5i3bs+vQykzUVfbUPTx5PsVom3NIy2Ki07oN6grsiLIXktH5nLnH4ziiDCW5?=
 =?us-ascii?Q?p0hzoxBoSZbQRfIXsEbMAW1kdVEWwLsh1OeCxU91PdnrcmTcbr2QOjIg/kzU?=
 =?us-ascii?Q?9UdX0B08lLJMdXtA8X2UhiG3VhgrcCXdRSjILjfESos2XfV28ge+yTkerleR?=
 =?us-ascii?Q?PidfPBwacs7rnOakKgmmAsPyRy4UmfI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092b0ee7-41a7-4f5d-ac45-08da4f5570d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 05:02:41.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JtN5x6Piq3czlNQhbvg7eG4N1d0/rwS4hoXFfw6J6B4Z/S0HoKOgaFM+UPYhlXXzWMcBSiryKB38WQ78LQPmqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7880

This patch increases MPTCP_MIB_RMSUBFLOW mib counter in userspace pm
destroy subflow function mptcp_nl_cmd_sf_destroy() when removing subflow.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f56378e4f597..3d1d365e9c6f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -5,6 +5,7 @@
  */
 
 #include "protocol.h"
+#include "mib.h"
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 {
@@ -418,6 +419,7 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RMSUBFLOW);
 		err = 0;
 	} else {
 		err = -ESRCH;
-- 
2.35.3

