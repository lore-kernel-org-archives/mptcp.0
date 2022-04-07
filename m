Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2420EA
	for <mptcp@lists.linux.dev>; Thu,  7 Apr 2022 04:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
	t=1649304217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9bKNns0WKPtoPGR1Yav8hetGtaj7+evRF/dqMYzWuA=;
	b=n8R9NLXXPM43GZMoq/oW7OkYIBoTaRl3lVIET6cSXkdeVwxi/L+KSMOSmda2XjhCOWHLEG
	2jXZuNe/GR5RjB4wFIuH3XQYh85lfapBA5VyXRnaYsU4J54RVPHtlpqZRwtQvN6PLL+tFT
	0eDI+Ym+KiWXW7uxL/sckmoAIgWpuIw=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2057.outbound.protection.outlook.com [104.47.9.57]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-yKPy07wNNzyHaKQis6RhcQ-2; Thu, 07 Apr 2022 06:03:36 +0200
X-MC-Unique: yKPy07wNNzyHaKQis6RhcQ-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq1aJkDicpYrwyxTZw+39/zLOXOrbpnNR79/iEdkYfUdYpJ0QoFxv5nlrva55mlhEty+RYnTyDMKcV6gPly2Xv+UFkLiNXe6Tetii8LdUC6kJMrgDcLuhlKC41gG7VDidUqqx5xpboMt0+R1QEYzSYgEh6amq+gf5G8UnPGlZPL9iqWQlgjY3FyQ3ROXuAJo4+eNEO/U11XKj5LIl2bWZ+Gxdo46Xw2HMl6hegC8Buzv6urcLGzjSXrjm8Jz2gC3foRER3HCJXLnlBbX2DqQ6d7NgcCXbOZqX92iHf79XMzssKYNk+zzJKVKLa7EwzP4ac6zU0un/xqKcTwKPwI8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDimTEZvw0pFT5GFgXHly73uwPmnpfTzyITsok+hkpM=;
 b=FcnDhV2kHz7GW5nePZ2PZPxhkH8QtUv+EZ3098DXW6D4LQfppSONPVsb8OL3y1i6QDsCsO62uLcAjlRgXYR2EKpvxYKMeCcCZ+tYNRt6sW22m9ePgw2FQDFigPTrW9WAnExyBPfdzz0zpRDH8xAlN5p17faqOcd+fLM/svqlax5X/itOjQcyh2rK/+HsMRd7Q6w7EnD2Geq/Z6Oez95nRr6vliqzIafg5qAgbxAAo4GU3FEfpU48qnD8e/dNu7Wbs5+WgyXfau075X/EL6zpQ/vVzLARyxhHl14SxY3voTq0vDTsCbn1oH/eU4TZMYjnNoIewOXe+7BrKwwAiyQJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 04:03:35 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::9974:fd5e:e3c0:14dc%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 04:03:35 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
CC: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 2/8] mptcp: register default scheduler
Date: Thu,  7 Apr 2022 12:03:14 +0800
Message-ID: <58abb17417c3cac4054bb022b1ec0d8c72f79792.1649303876.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649303876.git.geliang.tang@suse.com>
References: <cover.1649303876.git.geliang.tang@suse.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0011.apcprd03.prod.outlook.com
 (2603:1096:404:14::23) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62428441-f483-4aba-6916-08da184b9691
X-MS-TrafficTypeDiagnostic: AS8PR04MB8818:EE_
X-Microsoft-Antispam-PRVS:
	<AS8PR04MB881850532E4171AFB63F9160F8E69@AS8PR04MB8818.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T343i4q9FzKJC5GzKOnW5vpq+RkP6hXelaFS6vpbmnrqhZLQeT8BM9VzuHrC0obgsZfr0XeaBkzFizBy1VYbmvyo3Sf208BnRo0bw5CeLEbdEZ7WPOnv8ARyY20DkD8L9hgAeVICkh0N6j6sQP9OSBWb+eXBGhYhWlf/KXviG+fwS7JiB3lfibdR0rJWO4puSt4TptFczxH1dZl+uJA5ZJ7FN4hzt4ny+FLEg0ZhXK+ClI+/u42hsVerEKYwJfhqa4JbjxlCWj3dUEOaYq0XO0s6ORQ6+i4FmVnzMqVLjohVktGrSppcR9i+6xiwEG+KoxL2IV/AwP+uJvqDROZ76bXwtfAmi+Ggf/7hm60MsRr+kOz5kEq2cFrhYkz8sUMvI0tHCaVN7MEXFZoIzNXFEOg/fFG+eAN/H1dAehtCqyR+XWynwb70YyZM4llYTzIwpqKkl12xcDbYaRnbU8P5RrrvprNbzyi6fzRxMmn7gpDVvdMH/2DY5vN5hv430WvLCiRAF0Hc0GKk998q/cW5YalzMtTv7S9ZIIzsmeAPvmSijQXFFvq9+OBGkQWryH2bOyLgmOr6mQ4bYgb4GwR9q0fKDnJjy3ZB33Dp3hgaTqhzbrsVyUdsgqj9VRue8MGrnZDOFS57ntBkRUI2Y7Cj/MOJE+FAFC2S4Eqo/Ci0ui+Dsl30OmUyKfSn5ZAeydRf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6666004)(6506007)(508600001)(8936002)(6512007)(6916009)(2906002)(4326008)(316002)(36756003)(6486002)(8676002)(107886003)(66556008)(66476007)(26005)(66946007)(2616005)(83380400001)(44832011)(38100700002)(186003)(86362001)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FIKUQ1xuW4JlS6mDZCbSaS7H7vTNsx4zkRam5Dysxa404mYjwfs59y/RNX0U?=
 =?us-ascii?Q?Qru9OlzVInKnmVrIH7WqW3pwzxzVhXlHN4RK0/NEwFppk1X79GkNzy0iwT2H?=
 =?us-ascii?Q?ob3jmrUg/fyui89D+WbphNDka/2cU9jqFLBKkWVO9ClL3cuCvqdpLrGbtJbc?=
 =?us-ascii?Q?XNkJpL7IhT8IoYmpyKEDRCvc4mGV+oxwdjR0eG3AIiqNhDUiJpvmrxpLMcwU?=
 =?us-ascii?Q?2Vhgem+cTgg6UMeBhyAXiOsppjmvFFw2BJmY4SIFZ3o23BL4JE4HdB/VlNOL?=
 =?us-ascii?Q?VBsI72gXPEfKmVdH9Mk9A8iJAyMvWK8REB/bejzUoFqkcOgL2ovcDmV5hu1C?=
 =?us-ascii?Q?TS/Vh7jq/BC1XP20OzyLzdiDsftnNbLauutVK8sqzNYVOHRHL3S8boRXS1o1?=
 =?us-ascii?Q?bP2MMJypYgrskujPFNNenrW4X8pjZVlvHVZzZTeRa+X6UMnbQzk3Q8Utvpoe?=
 =?us-ascii?Q?BCRMvZTzJmkpgiWH8kxLKa2zzWOqYIT3hHMK5O0+ONS8x5CuBcPdNe6zPI2h?=
 =?us-ascii?Q?UsTGHehsvNmBF2lssirWYKZMUmWmpCC1Me4fOMl3siR1wYu+Tfq5Pluy1cXx?=
 =?us-ascii?Q?anHBCeHo0BKwfHAZW4zLcSMIeSCCQ83FiAyzznAybYt9Uj+OntWZJKOJXcVx?=
 =?us-ascii?Q?1B46DqVZPbUm1nFxb2hmlxP8Jgk9Nf7XaAnQwObJQgEQC6AbEGxuVs+W7BvV?=
 =?us-ascii?Q?Ox0yznhkpaaSB8Hzru1eBt0r2TVjDY6NDeeK5qAm1nuJcxL4qWTrTG4cCh1v?=
 =?us-ascii?Q?bL0FuX+92cbHy3v+Xu0Hx39P1Ns3V3cUUw+Qwrc3f/5FIoSpDWj8N81kh9ol?=
 =?us-ascii?Q?ve5/8960Q0VHTIW9wJsAT9OmeGQv0qMG3lOKt4GwLirA9y8qqbcciOSZoc95?=
 =?us-ascii?Q?0LCu71kv9Go9KmZZ8FTYl1iHiA7U9rSWAcbkPjdbmKDGvkEJ4SkdKjKepvwS?=
 =?us-ascii?Q?E1SPU9o03A9QEQqgQ1OJQD67EvUCCVAbV+y4UToIS1c2acmL0K3fN6zrxNFB?=
 =?us-ascii?Q?STppXb4KSpoELiaVrqmBCCd0qYORFlma/6M2X3Mp3IzrjBVUIlBeJ8KjmDKc?=
 =?us-ascii?Q?IKBobDfAoFEbkfS9LsQwETTQDOQgoLoY/Qd1iKYNhGd/qcz2QaMZY2zT3Tz3?=
 =?us-ascii?Q?n8W/0QUuaDeKy4QBj+tskK4oFbMFvS/zJhsexhmhjx1hLYgpyytRGPRJf7PZ?=
 =?us-ascii?Q?KRPOn2u3M9cO5oVMKwACNhx4qJUN6XTjeNjyCBkvmzElPRdNtWosVtFBrHR0?=
 =?us-ascii?Q?82LaLttsMFZy2j6Adr4rNdG6yfwJpGVL8dKREotZyqRz4UdW4ZVRCbonO5sj?=
 =?us-ascii?Q?B8UrlwosZABTsS2EGuq+r1pz87Vg4W9AccKphb4DElbB5K4a+HKIdUTA31Gl?=
 =?us-ascii?Q?uCpwboMc8f/phOex0m8KPhq4jVC1DVgVArfKoVTBhyJGj/o1OozVuO10gifw?=
 =?us-ascii?Q?tYYVb0ygtRa0UCcX59SRs33PcRubdlab7o2EcurthiG8gmqfFmh+aFBdLZnL?=
 =?us-ascii?Q?AMPCPiEUjj9+cuAGu0MI/HsOiQ+VUnu5xn6Bs2sXm+FOuScgcPpMETG/9hY2?=
 =?us-ascii?Q?o2OJUkuSU2RfK38+66DG0dJPRPUZcTNQi0OV+NFaDGvPAIbdL40i1Pmgn75c?=
 =?us-ascii?Q?NCGwI0vp4MO/bDjkOs+ScTvykDKJ5tuedRL232YB3ds+hhOhzo/X3gg++9fs?=
 =?us-ascii?Q?R04nVEqoBuVWVKYMo7N8wpzPoRbmWtn+vFHcCadfwoYkvXYS6LPQgzaknVVz?=
 =?us-ascii?Q?oN/XbWS8ig2ocuA1zxFKjy9b10iEhcI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62428441-f483-4aba-6916-08da184b9691
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 04:03:35.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCqP+Or/zeA0VmkNwswtY2Yc8k6GVMYaNFxjOlf0NsYxoSWMzkjk5Y7OOip4fEit9pnJWWu1NmLIuYXa2C4WSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

This patch defines the default packet scheduler mptcp_sched_default,
register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  2 ++
 net/mptcp/sched.c    | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b2c654992de0..8f0e71c38336 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,7 @@ bool mptcp_subflow_active(struct mptcp_subflow_contex=
t *subflow)
  * returns the subflow that will transmit the next DSS
  * additionally updates the rtx timeout
  */
-static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 {
 	struct subflow_send_info send_info[SSK_MODE_MAX];
 	struct mptcp_subflow_context *subflow;
@@ -3804,6 +3804,7 @@ void __init mptcp_proto_init(void)
=20
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
=20
 	if (proto_register(&mptcp_prot, MPTCP_USE_SLAB) !=3D 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7cd2c1c3d25c..a264964f8d95 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -611,6 +611,8 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *=
info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk);
+void mptcp_sched_init(void);
=20
 static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *su=
bflow)
 {
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index c5d3bbafba71..52828eb741c0 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -13,6 +13,12 @@
 #include <linux/spinlock.h>
 #include "protocol.h"
=20
+static struct mptcp_sched_ops mptcp_sched_default =3D {
+	.get_subflow    =3D mptcp_subflow_get_send,
+	.name           =3D "default",
+	.owner          =3D THIS_MODULE,
+};
+
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
=20
@@ -50,7 +56,15 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sch=
ed)
=20
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched =3D=3D &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
+
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
--=20
2.34.1

