Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553947F
	for <mptcp@lists.linux.dev>; Wed,  1 Nov 2023 04:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MflQGB2T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6TYjN7rzTzmz83CO0KFgvHRlcC9RDUdRoa6o2kBt7inuvZl1g0XUpU6pqiBsDybCaugx3TUj9CUco+PgwAn0iYLoPUq2wkPYXZ2c2DKi7699yijldc8NaEPTo8BIEPnc9qhLDaj5Hh5A40PnanHiQ9/RNcDaweo2v5BKaWHqdNvrdo/oC7cwJyzHPyhewFPqQ8K0ImA3x+3n4tzzfz+f8oFl+ONpxac5+c+u4QaEv+F5+sl89OgZoLZGYaMQIg49/B5JFM9UkUd3aMnZuZTkH4mVReTbeVpbdo+PWpf/gwKk6EWOjt7UsYosDjm+CaZIox5JLSR5ujuakURBmkpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo34Xi9c6t7qgBylaIhRYQX+s6J3Rhm+ooKKg9dl5Ts=;
 b=HjCqxhk3OpqNPMngcm1ZTgzUzKIxifEtvuVR6ZqGDFkwgyaCPVcz/a37DOQhWDI3XaQ4hRy8FVslLToq8RlpdKvk8lhr9oejDjyJ4Shc7eiyNsRFW0MCnLBcrOJAIq4Z5p+QCYTs8p8XtFucPid7DPrvt26FHvhXR70QAt34/Xqo+Fvj4IKBZBjfwOdGmpqAQhTCCXuOC3rOtWXAFYGBYP/tUSNeCRp2rVZY88z3bJkdfGrvtCSO6U7JCz3aDtSR68UKqfpEvfZeXG+khfLzG1XjFZqZ32TSWGVNlqMEmogErPzlM8mq2CKVHI9QqSBuhtBKz/q+u+vg7NqNvZg7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo34Xi9c6t7qgBylaIhRYQX+s6J3Rhm+ooKKg9dl5Ts=;
 b=MflQGB2Tq8cKfzwFp6TB7bkg6KESjDV7ZC64wfyCJWuxKY7GCjmGVcbwbOq+RkczLDp3qy7K9EzdPuM09PPeUYoZP0fmgwHM/LFpru/X7QMnH4TWlicGG5AJvc13kiGXy7Ht33MKlgXytcMfkRIlNf58ESwZzyP8/hp5s4tH4AWtHNYED4e3LybGMYAIzaeEHdAQX88ULa480JidTlAiQtB+6BuoH7AK5WcFYu3+xNOgYcST7f0lns9iMtH0KGGj7yTOX94QNQPdeVog1r0r1JBhn77oZ4rg45meSShqisni3hLhbgVN/hxtrxkNdd1f8+GogNTwUpsZIZhA19swgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Wed, 1 Nov
 2023 04:38:53 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Wed, 1 Nov 2023
 04:38:53 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 6/9] mptcp: flush userspace addrs list
Date: Wed,  1 Nov 2023 12:38:21 +0800
Message-Id: <38cfd24ccebe49543c557545fad909a4615a53bd.1698813419.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698813419.git.geliang.tang@suse.com>
References: <cover.1698813419.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::15)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: be994891-4eef-4651-fec4-08dbda9473c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WDOhABYpknBhP5IenN5zljyj6qURIUQwUcLBLsUgIaN64ld1Su0ShROTKahs6Fok2oLjKuCEKgmPYVvVC/InoryBpF5hfj8RenJD1sWa/DH2N02eFCXRJrnuEB+Imdx3qq3aUQok5hMvvbzuyqXtVMdQ/ESPWM5xOuuMfYCSmac1hyZ84KJFaR6ZICBeud3DgM9sHy3DG4+yK0zU31b2XFAdhQZA54jUWj6LxgU/YwGSGvopvb5w7Yb5YWIArsWtCrOimjxelhZf4HneJdwKocKL2biaHyxMxyQ79x8ZvNVFlOeKDx75FUvCLm7vDrPi5xe8A7X2y7/j1nWiCPSbytk0TOpRbo0Ry7BTVAIcS0cK/21rnGXL3u9kOtYN6f7k7etdasXipcDU4VPvx4vlCtE+lTM9kc0PP7PRcD/qsb0qUOy5Oqrd/h9q1tASvdk94TtjOecgYQaQkppoXtakZxbXUEKRZzJPmjsASGIUBQH7Q3xPcSRwh+Utfr3qX0TqiKb4gziGtxCbf8RYn5ZhR1eWR3oylEbxKifCDlVjboLVE6ymaa1m+pnQ/IjWaMZneNrlTXfAQehaNyJLZqhvOxlfTG9JdyHYZDj6HpF99Rk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(38100700002)(66556008)(66946007)(66476007)(36756003)(2906002)(6916009)(41300700001)(316002)(8676002)(8936002)(83380400001)(4326008)(6512007)(26005)(86362001)(107886003)(5660300002)(2616005)(6666004)(478600001)(6506007)(6486002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GzHjncR06v8DOOYeeV+kX3NlOtlY0sXVl76/qxU1D3RL+XPTQyq+I7kvfE36?=
 =?us-ascii?Q?JEVO8e4rcSEaOmsVgrggxqnF8PDeGiW0uwqZaIPbf/iidQr3glNP1FxzG1Zq?=
 =?us-ascii?Q?zd4iuLQqCMwY2xYV7xSj9FcM9Kaxeec8lItKAjfhdSlh1uAUOT29jBglYjBj?=
 =?us-ascii?Q?wvUDhD+H1nbGVZFTV1DoQUMcoRfFBXSmHzZMvbbr1vyxlsn7pDiwsb9syb6X?=
 =?us-ascii?Q?IQfnD0XHgGNdsSZQhjf/uSlZJ1f6WcG0NVFJMjo8lb0AcAOURJREylTSCJSj?=
 =?us-ascii?Q?fqKvPGphfCLlkyTCDP33Vk9lsjD+etZ9jBjFOulU/nzrwAgFCThyp6tyiQ+p?=
 =?us-ascii?Q?yccqA457lkpdz5j8Tw6qxBQINRNc2gLTinshsTjHKrrCRTehUzVbOXZxl8I5?=
 =?us-ascii?Q?dl//xz0BKjKvI3ck2Z5rSHJZMXVfmYRZXKc0ZBwCN0DnjGHW8XPa4Zuf5FwI?=
 =?us-ascii?Q?/7fYxUeeTqrBirtwplV/cWcfJcy8HxnwhajdqdEDKvTDLNuUOP8cjjAXju+h?=
 =?us-ascii?Q?xd5E1jcqr5LbhCsnYsOYXqrNmxkYxDcV/k0USq5xe78edeTVqbtbvDPwHfdD?=
 =?us-ascii?Q?8L7xc+c+DO7v0uCnv/BlhXgceoRuMwLx1GWmHa0PY/qJlm0QwsmfS1mS7lEr?=
 =?us-ascii?Q?5CtITzDv22WS27huXFBALUsiDlyar2T9KA7WhWpgCYycQeE8RLXQeE213zQj?=
 =?us-ascii?Q?7LRH1yJKxS5nJnM2Y1KxMQ2nzIwSUdKcMdD44c+o2oQUbqbRhHLhLlq9ujNs?=
 =?us-ascii?Q?iezik6TpNFXwgCL+dEm2TbefB8eIa7ecVheHGjEn+M4/CF5g0d4waAWQ3X03?=
 =?us-ascii?Q?XE5Wv1VT7xtvxb43ZNU8Q57pj+uQIqEvr2RWBnF9KEvWWIVRMKgNR6sMtv1N?=
 =?us-ascii?Q?QEH+36Z/RnOU4YdQvVPjhgq9yWkGAQ+mpM6UYIpsvtSVc7CLkkUx7jsydWxI?=
 =?us-ascii?Q?NXtaWb4ZbBAO6XzgKuiKlX8WpC5c60KAPjr5ZsoZANGQz+s1hd/j4nKU3LvM?=
 =?us-ascii?Q?wM67xRdHRmLtHTChtEzQcOe9N8fNELaLoqdd4P01AFmb98juM9K1WyEJDd8q?=
 =?us-ascii?Q?CFmIYrLWHeUmRAqh4RZrgcI7ToO4eDFGZenxyNxpu/f3pehxGW14nj4R4LZK?=
 =?us-ascii?Q?ILcFPRZjHKt4LIvzCY2Bnlr4uWBAfE/JooiE1LhuXhH6GE33DQFS5rya1JSv?=
 =?us-ascii?Q?motD+UrTCcmmv1Wyr3+2VF5DvF3LhNMvg6PfwwoMVyVl1kV58VetreJTL9eo?=
 =?us-ascii?Q?2VGTXGfc1QJGLrIH3JlVYg14YrvXT+oXp/w9MudQ+I7ynFTQTX0vfkjkVcd1?=
 =?us-ascii?Q?Q+KBOMneCW+O+ROmk7ZODquBTodiVMaN7Lhx6WCRSLKkptuTD22lrJssp/t4?=
 =?us-ascii?Q?9Ici/JgsdgZKAzxnVreSpIEIYR+0afZdC5IFKLE1Vy9u3WKiOrevXpkkkMLH?=
 =?us-ascii?Q?Y2h3hpcdWlalTXhB1RSGIi+dysEfOInUYIHyoJkR2D28yAW62e1HzELUeAAR?=
 =?us-ascii?Q?vTlucGLo7uRyEK1ktmaq5lyLNfWSRAoNGekJOV5WiCP+NVuJcw71Kvj6xhmF?=
 =?us-ascii?Q?Gy43f9qqrRLrzMRpBaoAeE2ZRJBpXJcjFgcr8LXx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be994891-4eef-4651-fec4-08dbda9473c7
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 04:38:53.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8oRNUFgb5vPMtKRmPU0ILzf7NDPxnClJRhLBA41wWGGqo47sjeyUreRlYsFOk882EuNsVTn8H/PAGaDEJ02tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

This patch adds a new function mptcp_userspace_pm_flush_addrs_list() to
free the userspace local addresses list. Invoke it when flushing addresses
from netlink commands.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_netlink.c   |  2 ++
 net/mptcp/pm_userspace.c | 19 +++++++++++++++++++
 net/mptcp/protocol.h     |  1 +
 3 files changed, 22 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1529ec358815..e5deb05293c6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1610,6 +1610,8 @@ int mptcp_pm_nl_flush_addrs_doit(struct sk_buff *skb, struct genl_info *info)
 	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	synchronize_rcu();
 	__flush_addrs(&free_list);
+
+	mptcp_userspace_pm_flush_addrs_list(sock_net(skb->sk));
 	return 0;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 5602d9db8d85..30639d049ce5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -583,3 +583,22 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	sock_put(sk);
 	return ret;
 }
+
+void mptcp_userspace_pm_flush_addrs_list(struct net *net)
+{
+	long s_slot = 0, s_num = 0;
+	struct mptcp_sock *msk;
+
+	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+		struct sock *sk = (struct sock *)msk;
+
+		if (mptcp_pm_is_userspace(msk)) {
+			lock_sock(sk);
+			mptcp_free_local_addr_list(msk);
+			release_sock(sk);
+		}
+
+		sock_put(sk);
+		cond_resched();
+	}
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 31058be1ef3d..e0bc66915257 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -946,6 +946,7 @@ void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
+void mptcp_userspace_pm_flush_addrs_list(struct net *net);
 
 void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
 		 const struct sock *ssk, gfp_t gfp);
-- 
2.35.3

