Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB87FA
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 02:23:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPQRYw37S7vPhm2wTQ5ryrLn40dDiaORfydRPhGGJ/h6lFRuMlPZJb4D0RzdhhF65jcGgpSwuWi27zTPljWrMq0ZWvSrIf9ZP04f3VuKURcoIMhvq/AOdtL3mOMGZ3ED8yfg3QAG5YFi6uPwb0Rtfc3zN8SXSWhDIIhFSgfcQNv0HL6HCKFH/wDOwcW7U8ZVahtktut4yYKilhGDFiuklibPcHxg7Wu8BPUlXRWUcDESyXU1e0+nCOFtp7wTuKOK1N8FCnaP0aWYjh9D76HemjQasey7qAELEHFR/peBVDjE8VyY9n7Aux6pMTv9e4Sdcl5wCaI4+VIyZAZyMGfDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUnWy3Uxwr30w+QK9cl6w8ugU4KeuI76tBk0ZcfpRtU=;
 b=iOyOKr1qVsbLEfntXs2uLTbsNUu7+D7951eW1TSR4iWoY04F8+ElIyJMf8/AlxSWoG2kIVZ3pjQaz9TPai3zCivkQP4cuaz/9qndgHU3KH1u5tHDQxyC7ekY13QDbzVvM91p7TSeohUUkAsa8xU+n3qepyTzDAi8o024QSaycDyelszmQLoYW8lfPF/UGvNc78mXpLzrXtWAIhZQDmOHRDikdHj5LD/pOl/a2k6/ylUbMSFNaZN2sI56kD20crXs8vOykJaOzBct+XdyQvK7j8MtbUqRQWpNc/w1hgLX4UH5K39r3JK+Pkoi4R4fZ9pIE2d4FjNeXmmmRVMu6E15kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnWy3Uxwr30w+QK9cl6w8ugU4KeuI76tBk0ZcfpRtU=;
 b=FbAHOQCWr6zCzbQ4sori18v2UCJRVqZmqTqNh+IAGmhbKkeubg+4zh5iA97TRGaDZTysLu/PSIJL8yoI11LAbvCM3cuo1bz8V91zo9fy1Jw7cEGRvbg6PypoK+88/wu9xVhXpHnrjnJnaVEX24wj9+SGyz9UAY0ePjW2iavaozlA5RmJOwi8ZCxmfwF8QgptYz2I2Q+UWxuVr3bEF6n1hkk5STZk3OG41JbQH8OUBxcxnCvOgqbRx6tQzaZrW0yo/aPmJEV2mgM3X2sipbm76T8Cp7wcqP31dXhvZ4FPOckr6n8xmOeFaPH6hI0YL6sMZDGhs98/ZT/73feHOLG2rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 02:23:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 02:23:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v10 04/13] mptcp: register default scheduler
Date: Mon, 26 Jun 2023 10:23:05 +0800
Message-Id: <40f5e342066db2331695a4de80f0d22bf5c48e3e.1687746021.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1687746021.git.geliang.tang@suse.com>
References: <cover.1687746021.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f92a82-ade3-419b-395c-08db75ec5bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6CcnIOzRd3V+0BdHBZ1ppNt4I4+1fkw2wMdJM8xdhpWTb45OxHszFk7QQjnjSMvle0aKtutbOvp66DKCgmSyJ0PkBRMnUB3j71R7V4Avoar1q9VmMBoZSI+d7IkKfLDxXDFZxiDaRmrTn4zfh0q2Ki/amy8bSFTOd+WUL3fCH7FEJXFOc8mOqRNyL7/6trs7Q589yTheZYmCAFp9boPW8gy/WswOZ07+/LFu+Hdvi2cUoDXZbb2x0MDhGgYdG+wbYS88eMdklaRoRnC5qcgj7fmxHk1u3b7AiUfG52/SsWzzTevO2hRf3twIArkP+Y+IXEwzWQhd3p4k/ciPZGI6YlcXhnqwfBh8D/FTbCU8IDlA5VCLEoEiJn7/zdbthNG/rIVQJ30Sxykr3A5VtEQc7zylldZxC1NiZ3TG3Y+UukUz7VqbwEIadWG0soPFKbpgyN0Q3nRVY5ztgcJWA0hNs0f/sNGOgR/mUc8G7NwImcG7jF9SI+AYLmEfuqChQIpkVktdGPb/kgzlaZdeeNU6IezjRHsq84C70hOIhRQIR0SG/aSo/flyvCEF+N7z3aV+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(6666004)(6486002)(478600001)(83380400001)(2616005)(86362001)(66476007)(107886003)(186003)(26005)(6506007)(2906002)(6512007)(6916009)(36756003)(4326008)(316002)(66556008)(66946007)(5660300002)(38100700002)(8936002)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uSWSECOj6DKspfhFITEzDu9ey2VdSxpcNG0pQXD2+XNKJB12IT1KwnMddyfl?=
 =?us-ascii?Q?T2jx9JTrK3xIYpxrMZINkzajKMJjbDW2BG/IjxDunU8kuWLPGLkZvB3fODZQ?=
 =?us-ascii?Q?4VVrJntHnZp/FUSDmoCKGhWQ8PSVFtKH+7xp+vAnPJjK7CsqM+vMt74C2Efc?=
 =?us-ascii?Q?eVL6zP246A8n0AAiYWiygJP72jjO+/FvXZKMK9C2enqFsz7TVccGrKYIPpOo?=
 =?us-ascii?Q?9Mf0IF2NjpuyDs73Gm9h/2EoJ29lUBk9kP5xs31PtU7Ks7MfrW6Dsq5kCk9T?=
 =?us-ascii?Q?lZKuuKp3RNlztdckd79Eh13hqkrpmA1YO6PR1fFPgsPeQo5RAnrGoEnzEh35?=
 =?us-ascii?Q?wSEazUynO2aErmvTR2t91EZBHsc12chlx/oXbEkQPOVwYA/3/mcYCohmmUFi?=
 =?us-ascii?Q?WEpoC4aB7M/Dw9aQhL1rrEg/N20ooDEYh453N+rfskIIQ38UPx8001w4Rxh1?=
 =?us-ascii?Q?otFMfgqqecnvCE0xo3Y5O00ZKnsPRYTvt5WxxPgFZ+yhU8bP7HNFIdua77mf?=
 =?us-ascii?Q?nClK6JCIHWT6j1cjXSunwi7AXFBlPsNMLbQfah6nkB7T79QQzC+eUCu4Hkgx?=
 =?us-ascii?Q?PdXJvoIEtjaoAf7/r69qlxXpwGisICTpRrjYDPPN3f218PUS9HYZyLHS3ShU?=
 =?us-ascii?Q?d9zPA6VMm7pCVt0kBkNGup9UbTYfzJQLF9AeoTve5dt04Ayp9fE/uB73OsHn?=
 =?us-ascii?Q?xelDxxoRuYfxYA36YVA3LJJfR/lmrKDi+IOSxV2RpKhqeQ8J42oMhKQ2tWWU?=
 =?us-ascii?Q?Vc/sOhLAe0igppVfRtXUzq8cSrx6mgrq9PhBZDVwvDUT4K7D0Tt4i/lPbeVg?=
 =?us-ascii?Q?RRjdKljcflww8mIIZelRehfoVxa82CcGBmuRbMh7DKF3luVhNl3oFqNNg2x8?=
 =?us-ascii?Q?+AXqWAnRGVZXe+ktmQvdqvR2tUF76YcNWjxWs+1D6Z+PMMnLLa//7qQ79/YP?=
 =?us-ascii?Q?tGckYtE/liQe6YiKTT8P3+K3dvPXE+mGPd95lwZFTI/+JCFpy1kMWQoh5q9D?=
 =?us-ascii?Q?x6oUTdGSlgxUJEbmnNocjVCNrQ81LQmuGs/fYiUIgHIqpM1wnGcPKrJhTm2W?=
 =?us-ascii?Q?QicCBUi0RUS7jFSPX9TgCZWXy9LmPp0p/pZogoGhSOQTRHA/T24mOED0+YSa?=
 =?us-ascii?Q?Vq4VPvlGoyAF37Qxbdi803Ao6FUt7PaNWDyZNuQouFz4dfgO0zlYyvpVkwKV?=
 =?us-ascii?Q?Ayp189dHxkvNUpHaGyMnXm78pjkv8qju5+Qp9vRw53462lnkAxQ3i2x0OtvX?=
 =?us-ascii?Q?hm27XYs9KZyNAgijHN8limfBfc5h9ny8kfORPTp8DN/L+f99N3OVTiLHWPpu?=
 =?us-ascii?Q?aU5BijDvDG7K/pF/FCZ6gWdcEhE1ZYrxmnVdHAVnaGvV/U2Nsi3wVNtxASC6?=
 =?us-ascii?Q?C4kAN9uc/v0OcLNPdhXatYONLq6Uj+xRNdd/2qCWKR9eqM5G6oHHtPY/LMwe?=
 =?us-ascii?Q?+Blxgn2vCg8+llvPYYwcAYZ7JxGX6V8wPXpZlqrMdUR/x5kWtFRnelupqotb?=
 =?us-ascii?Q?vXX3n578v4jIMMA6xvxvS77WvjV4+7aOcWLapj3e2u7DVTot3jA3XqKxNdXe?=
 =?us-ascii?Q?GFfVbuXixvZkXc15DqB/G2hNJ8UEzB3C5kIhCrTv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f92a82-ade3-419b-395c-08db75ec5bef
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 02:23:42.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtzqMb/q8d8yOu1OIsHEUWR/fM+ROpc7x0d3DFrUZA4nrq0qcfnM0H7u6SGZSp2C2/DS5hqtJlSbXFriSVcvsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 37 +++++++++++++++++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ae0b94d25c0..5f9f046b2124 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3970,6 +3970,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index cb2f34c8ed09..bb4d50c8c398 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -657,6 +657,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 82665263bb94..a80cf0481edf 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,32 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+}
+
+static int mptcp_sched_default_get_subflow(struct mptcp_sock *msk,
+					   const struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk);
+	if (!ssk)
+		return -EINVAL;
+
+	mptcp_subflow_set_scheduled(mptcp_subflow_ctx(ssk), true);
+	return 0;
+}
+
+static struct mptcp_sched_ops mptcp_sched_default = {
+	.data_init	= mptcp_sched_default_data_init,
+	.get_subflow	= mptcp_sched_default_get_subflow,
+	.name		= "default",
+	.owner		= THIS_MODULE,
+};
+
 /* Must be called with rcu read lock held */
 struct mptcp_sched_ops *mptcp_sched_find(const char *name)
 {
@@ -50,16 +76,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched)
 {
+	if (sched == &mptcp_sched_default)
+		return;
+
 	spin_lock(&mptcp_sched_list_lock);
 	list_del_rcu(&sched->list);
 	spin_unlock(&mptcp_sched_list_lock);
 }
 
+void mptcp_sched_init(void)
+{
+	mptcp_register_scheduler(&mptcp_sched_default);
+}
+
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -70,7 +104,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

