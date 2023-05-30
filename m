Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523F134C8
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 13:18:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJS2eg6BMd9DAUszLYOMt9XPXkeHusQqQBEpvFrRBhmx680o0DNUVJ7j1bpuLu1zrTXP0oiHpmEat1GuJpQzsOIj1zCXc/4XOtaf8Pj+gwKfBo5DV+Y0IV2Uq532eNfxdPWOJ2/vpJ6CzirogNLLzNoCshrj2hO20eiwhuyoneOsMHZ/t8zHV83etFV1sb/yzkeuCmx2hqN0N92gtjq52vi3Up+BA5y2I/9D1rVGdHF5wjYXhHXc1KB9vxkIZROxBbPOOoYrFXmuFtNEgry3WsVR+sG7BAJLcVGVESuG6UiyFUa8H/ysQ0jxDzsoIRIrqw3WScqOjGH0YAyb7XkOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puN7Ju8xAG6uhz9ziMMRXJK5F0/kzFu+emTcHl40/m0=;
 b=d8FfAE3zO1iaE55hLmokW6FoYEoQS36xDrsEgcPorsnDXXqeDezqgXn1MuLV42rG1bN/ti/XcIwfyzC5PFw50pFjhFgME5rof8mssV46aoJebMs6X8wbZm+eJP2bPMUDIEJjaH4lEQdGaAe1WACYIBwKBGYZquS4yvOc1tutEVoBsxp2gr6Tfmmz9qSJhRSVkpyrjiCOY7Dlohqk8Va+rYarrIOGE9Y0kHRe2dokS8h2baiS7wT4HK146H1gTDtGi6sNKlu4JmG4PI69+reLIE/AG8qo/57QLDvcm11l8Dm43I5RGQBxFiLYXn70Q5HMk7cV6aY2mdIW0UV2JoVDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puN7Ju8xAG6uhz9ziMMRXJK5F0/kzFu+emTcHl40/m0=;
 b=CLBsl86PXtdXOzUtaKda0nwNO3T0jujjhhpLQGYFq8Vt7NugxiKWOfO+aX8fcSO0svOWDFyoivhNQDH3QVh1OaFbFLavlhnsQIonsm5gi1fqV1T8/ojDwLxooSkKr7CgNHKzL/kGZ82Y/K8QcomVxMylzKUotYhPqhGM7Tw1jimUQcNloiFDB96FsmUHckhyfIVAj9c5U5d53R1yMLxK3gAOjjYxuEGpY4MlYNFIcms+p9veTbZzWnSEI+JDZwKpARsTMT12nFFtPgEWuN9nPr3gccYGit/6OqPL4bwdO2bMbSPk9M+6r1gMsRG5PgHsEivD8QEZwK/My/GSI3STNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8622.eurprd04.prod.outlook.com (2603:10a6:102:219::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 13:18:40 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 13:18:40 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v3 06/15] mptcp: register default scheduler
Date: Tue, 30 May 2023 21:17:26 +0800
Message-Id: <f609650ac34ff3b66ef283a1df23203914a07aec.1685452619.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685452619.git.geliang.tang@suse.com>
References: <cover.1685452619.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0106.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::22) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8622:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b196dc-7575-4cee-2a14-08db61106245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tKz8ciUAr41CHJRsC/+/Mr48mSEFSi+DlQL4umvjNeOKSGaOcVGS6KxgADDmkl21/Fepd2HaqWqZwsJ+irjTnqmigYD3EvZdlRXkyMzssy4Cl5fuiYMOxIdnP9TmUlf9B7eJydB2wtnsZiCuKD8glxHo0MeJBTnQhI83Q0hG26nomnTLTOs2Nqvhihblw2m5akzFWsEZDflyRW7UwGO2tP1JImvBeZrqgGnBxIE5p+T7AxRwX1lpo8DdDFpC2kDpTcuDyiVUR0lY7DEixrrAZ9BnkElBP7U/iOzEjJAdzfxrcK6w8lVjWTIylLmAlvL/nFiY94YmVlaVGzCy/+HNCOB0ZK+jroumZaT9AzW03qbOUsPR5ReKf/IP9QmqHRIemhvr1ReQmqZTfRSgewrAgRSZhLuJ64biNfkFQzlV3i3mMeNVlLC7lf8NSyb6T8j23bF76s9BRHy7O3QgWtEyc92hxgF0pT9g/9jwOO3Wlm24uHhZJf1GZxn+0RdtwCzGLwrqd7933ZvN1xbIJBzTaG9pcKm7KfEJFm6dSmdsoKocY+tIy+SGClEQfUjV6h6o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(39850400004)(376002)(451199021)(186003)(107886003)(2616005)(38100700002)(41300700001)(83380400001)(6506007)(6512007)(26005)(6486002)(6666004)(478600001)(4326008)(66556008)(66476007)(66946007)(6916009)(316002)(8936002)(8676002)(5660300002)(44832011)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2wDQU6Y6HTuH89p7pQaPNDlgDLi2o1dvNrGTYjZkB/P7QgFDCtf7qM6pUMj?=
 =?us-ascii?Q?5J8goeRPrjo8FTD75Do0KaYgHOKawojC9jYsh0pXGRU1dV7e9Kigm5S2Tqu7?=
 =?us-ascii?Q?vXuCe8rXlFKlWetX3HObBmv2xeIFSGzaNcbbmLPFEQQnOHEnNxQ0k6+tuZYz?=
 =?us-ascii?Q?C8IS7sraI3FRcc/XlnDGNEmDF80/XXxB4ibLGGsEgEOAro6D5gy4WK5AZVmY?=
 =?us-ascii?Q?YxDQaK95q3Q+KapGKbmAiejIGsC0hNYr8fFz/lKMtQQ+UyRG6S4VuMFrIR70?=
 =?us-ascii?Q?qwPwH2N+rKFolWJt/9i0N1fIuzNpol6RdqvAvSEph0cB5TRqk9XOy8gwPwTI?=
 =?us-ascii?Q?DkkmFy3AjZ/T/7or1QjOxpOgUqObqxYJLzMxinYi//l/FpY5v15nPj9fl8zZ?=
 =?us-ascii?Q?seOvu96s8jNNwJP4yX1GuwvHhLUlzgEqAiDtqwc9H7HuXrBeQRvmJHDYlGWS?=
 =?us-ascii?Q?WRMeFD9AAsVzwYJTeKoIkOI84OlU6AWQ04u7000+zkyRqP6aWemuf+t0P07D?=
 =?us-ascii?Q?IiD+x4hF97sRqUsTPHU0ztUpp2nZFT6c+m9lZZDSrA7ZC7s96Xn32HMeWtTu?=
 =?us-ascii?Q?LNo6UQAAp0vk7je0E9impPbqI+9zz3QiYUuq3kzFyAJGgFslgiV0p+LOGhTb?=
 =?us-ascii?Q?nfGZ274qtvpBgppDkqNpy2AdbIKr/+e+4FFjcmr0TvdkhuittkBjIQV0HDlO?=
 =?us-ascii?Q?uFA5Zw5ruxWlBPtPN/+C+yg9LhL88pvG6x2wMXHjVfV28iFUOvRc8zODTDXf?=
 =?us-ascii?Q?dTWzWDIVYC55gLSrBjFBgqmSfePl60Nv8QFgTEskUwR9LMizLKa0YzaMvdcm?=
 =?us-ascii?Q?g5cIGTVvV334/g04IrRRF5GnfsrkPA/FQplCLLaTU7vQ+OARQr9Qzh4SwqCz?=
 =?us-ascii?Q?7QAhsJTmB5ocADfm5/5woY+r1U8dgAQfckNK0J3J6zY0HSNBRjo98t5wVqMo?=
 =?us-ascii?Q?Y9n6Ko6aNAUnbUeE6kXOWTdNP3gQiwd49MklNHrLrU70PJMftzhMBgVSSaRi?=
 =?us-ascii?Q?5Qnp9t7lQUgeUeciPNalBl5ZeO/xQ3tG240nX0pYtvn+6bH+qndkwTl2uCr9?=
 =?us-ascii?Q?oBxuHFfvkO1X1Cq5ec8Z20z2pCOC3xfEGDYilT3kxi5e0aql6YKobBiMluWR?=
 =?us-ascii?Q?YDR0Z7B7AWAI6lAkpKf57IjEsKLrdn3DbZHHYV8frmgp1bY7UlT8lqY7WZKK?=
 =?us-ascii?Q?lOTqgU5plX0e63EoCExsC8jJn9cWnMs+av0CucNgUZFlLPit89bA4J+PWfgZ?=
 =?us-ascii?Q?H3Wl3dKo9/y/pQBgZ7bQKSku5MW3cxq/nn1BFdgR9yqXQMArZDTF4DncNUUV?=
 =?us-ascii?Q?utROyzMevVLKtpVlEmR+xvc8SuG10b5Izna4Eldk4OoP9eJj4jwU78Vxmn5L?=
 =?us-ascii?Q?MzClxsvhQ6qadu8vwms9B5TGmiLBDToKMbArDZYo4WFOlSeVapkgmLrJrMK1?=
 =?us-ascii?Q?nJTKltl7hZNaDxj1d1pAuHoy89By+wnguIXV1++T+46uKRN9tfOl3y913kGa?=
 =?us-ascii?Q?n2szv5zgZbxSUD1reJK+7MLGOEyxpAOJBp6iN+lbKyaGCjvPRMVCBTFIMGSD?=
 =?us-ascii?Q?33XxxyFexKn2cP5X6V2ROP9ql9BucD8YXHRfhxZS?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b196dc-7575-4cee-2a14-08db61106245
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 13:18:40.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzq9mPbHdmqTaNiYaHFD9HjygzhUQ90Q5aq3O3eID+nN1RK4uJAD1NA9VoFAVIJP/w3obqShsSwTiGIjf4NXYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8622

This patch defines the default packet scheduler mptcp_sched_default.
Register it in mptcp_sched_init(), which is invoked in mptcp_proto_init().
Skip deleting this default scheduler in mptcp_unregister_scheduler().

Set msk->sched to the default scheduler when the input parameter of
mptcp_init_sched() is NULL.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/protocol.c |  3 ++-
 net/mptcp/protocol.h |  3 ++-
 net/mptcp/sched.c    | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a178cd841d82..0d85add4c8dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2278,7 +2278,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4006,6 +4006,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37f5cb898b45..41468a3a0d0e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -651,6 +651,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp);
@@ -661,7 +662,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index a6210ec4ba5f..fdf2459a0fcc 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -16,6 +16,33 @@
 static DEFINE_SPINLOCK(mptcp_sched_list_lock);
 static LIST_HEAD(mptcp_sched_list);
 
+static void mptcp_sched_default_data_init(const struct mptcp_sock *msk,
+					  struct mptcp_sched_data *data)
+{
+	data->snd_burst = 0;
+}
+
+static int mptcp_sched_default_get_subflow(const struct mptcp_sock *msk,
+					   struct mptcp_sched_data *data)
+{
+	struct sock *ssk;
+
+	ssk = data->reinject ? mptcp_subflow_get_retrans(msk) :
+			       mptcp_subflow_get_send(msk, data);
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
@@ -50,17 +77,25 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
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
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp)
 {
 	if (!sched)
-		goto out;
+		sched = &mptcp_sched_default;
 
 	if (!bpf_try_module_get(sched, sched->owner))
 		return -EBUSY;
@@ -77,7 +112,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

