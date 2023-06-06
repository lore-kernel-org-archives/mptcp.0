Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05F128C07
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 09:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEhWk0CrdP0fSTe+dyoMYRCV2wxJ9eqjp8idO7H2acqa/CBDvQPE17csHhiddMnNPsATp1WAHyK8d4LZafZBAsyKk/USzhfpiLNOJUOjIRO4Ip6Q8MjeuMMr8nSb75zOvrvPqW205ialWG84NJXNC6U1egaQOwj1EUOK3cc/I6/WGb/sovGep4dyPVCDpFaGuNTeeKIkQxEfbCCHpP2PFelErQypkdQ/UaaV4gL2KegCGAU/I3+FmdF16VrEJgS3fLxkmERz+lh9kdyjdynTTbzsymV2crK2j54LF4wBV4qvaJT+JnlCV34xHZqZNS0Yn7JU5xmIY3Oa/JXYX6zziA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=oaLZZyetWJl4fxltypsaF1rXtidMe8jQ3TyqRMsK4SJyMkmqHqULxPHfVR2ZQAELDktZfqIQRkE9OVuDnl4yeulnJSQDJkq+R2dhNgjgZ6N4I1ZcdDbgNF+8LgNFDgaQqn23zLtjTOz0+dbpGw62CsyDrDEIWaO3xwKkVZv0a37hjbCpEOZqx1pFDNtTsoctSJVXlqfxvxo4B18eXtl7VpXb1QMRoLCBH3g7v5pBniswmL4ZbrcsRQSkwAmc4wvFBtkWlg82cL1G+4EbbDydd7+IZJe8ztlU4sfFzOP0P1G1W21WvwZsdCQq7FZ9ZhZyUkgW+7Zwr2QilqD8gZunkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS8c1EqXR3krYfxygTOEkOTHUBOuEaLcpjUYibQkHjA=;
 b=GXbdEYnUcuTwymd2oARq9jws/0UqWV71LRVOGGomirJeUdiI1TYHFAhkqk0uykz7oPn/aV45IwmpqaT3TyEYZLWGWXxDpxQScxcHHmvSwzgkY7mr21NEJPAhQH6D3szGRl/WPYbqI6KDKarlnQoYdFdou6VFd172pQXGPBYHbyoAWY84Vg8iC7anPtiq8Njeew6xIzoUmrOnbNTELby4iNFAHnLzTVZsijtcSuGY0lI5PGCoFCSkCeH/kUcl1vPI2Ye9WjWjLoCCnRQ62iRj5WvnIJtZ1RfQa0kf2evD3kCqcy4L+c+ab+l45vX/09AgK1+I73Ty5W08hJYWabepkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.26; Tue, 6 Jun
 2023 09:01:05 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:01:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v6 06/18] mptcp: register default scheduler
Date: Tue,  6 Jun 2023 16:59:20 +0800
Message-Id: <288dd136623517b207b1a315030bb51ecdd0a829.1686041504.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1686041504.git.geliang.tang@suse.com>
References: <cover.1686041504.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0224.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::20) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 228d57ea-25dd-42c6-72e3-08db666c8f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9k7/TKKOe19NfTlqgv1BkJtcMWhESHCJXUTQQBszNfg1EIDQlOxAJIVpvpV829C0k/afx8+9sb3uqro6VDaAFzW3frSwf/0/qR4nNS520fq8X/A8V1F0DTAKtaFQo/weBz+67VwdhkitgQgt6K/b0oS1HlvtrAwiQBENnGoz6m2VojZHYXujM9iJ7m8XnZ6Ob1ECTPWKnnbSpiHBAVDPUutYxGzACqjqOIhg7U938SQjKP3q00IzKKvE+qqXdhbiY3dTen18up9YBlw8lvreN74zWFF7+P1yMGthhiS6AzzQTU6eMezPJFdGwcWGu//XstblZE9lWQZbgHpsrfYTIQHRTrB5oMBVIy+y1YSCiGI/92U+xjKgZF7ynTev1Rp3KbXvdOsn3FDxKpooo21wj+o16nlbMJcgcRpRJe9Jz5pCIomsvJK1PHbNZSDxe/6AUhGoBP9fkt0b9IlGAuMqqm6RGOjJY6cBQBXgMjxHNemKrHVoLPjJgiX9S99t3e+KtZF9fQRqsIlZ4iUjU625p1XZXU12Y0vUwiUjAPH3RV99iDoHayPM2rp6fdmeALT7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(6486002)(38100700002)(6512007)(26005)(186003)(5660300002)(83380400001)(6506007)(2616005)(8936002)(2906002)(107886003)(44832011)(41300700001)(8676002)(6666004)(66946007)(36756003)(478600001)(6916009)(66556008)(4326008)(66476007)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z95MBC2/iA4UMD0k+WZg2j8A4n3miB2fHREVrJohK6rVnVf37BYOYIlegbaz?=
 =?us-ascii?Q?LUEDfeVaGhyN+acrYtXtcBwb4c1psjDB79bdT5kwItN5VmqojkeES5CeWpAS?=
 =?us-ascii?Q?LFbuSgQUx0GnP7PuDcuyOzTSeV/q7PqysJQMpn+zWf5k3+asnk6n1Zy9CbVg?=
 =?us-ascii?Q?gmYq5P76+RUp4FFFiPY3h7FHk2Mwb2yR8t4MMvs8BD7pTLVSOdtEvl3VRLJ5?=
 =?us-ascii?Q?FrthhRFAm+MN6BozdqBQVq12Vnwu7TAU9rQSkDapPr6t1xxfKtYbTWsdc1Yf?=
 =?us-ascii?Q?drmqv/56BGEGWV2edE0vz7+PoeNNSRFpfzazvdBbMb8to/PLuiQC0NQPtSxu?=
 =?us-ascii?Q?JTTcnNTZCKtLs0aGZTGoomNAN9mqNIG0Tmg6BFxsOWHnfc6Dh7UDWy6utgc/?=
 =?us-ascii?Q?ft7q5kdObLz3Ls2AnDHkpfoZA2HNl7u8CekPn2eQC2klGo3fxvabqrjvUAtp?=
 =?us-ascii?Q?DY0B4zu1HagJiHGfzBJlyELpXqHLm2AzxVfF3z23fJuEAm2VTHfcCUo8eGlh?=
 =?us-ascii?Q?O5WTF1aPoGvFsAIpYCT1JwaAY7rT49KKW8y6ejGKBY18kp2gsxkeaphSqVRK?=
 =?us-ascii?Q?1DbPEv9hU3716LWoBuShGVLs63Se+eqE4furiub81fHw7L0mhwx7UyQp33hf?=
 =?us-ascii?Q?coaks+pjjaTkIXIdWjFu5LpDa35xg7QfRvgyaMegntRutz9jUny/6m4xSPz0?=
 =?us-ascii?Q?pN/8Xuxfe8YDM5wi72KeTQJsLVijXHeYSXKPmcS5MSVR39PGi644euR1rQCY?=
 =?us-ascii?Q?BWpZi9b2SYa7U6q8kXckfBE4dRU1aXc76zTVxtpYmg+VvzPleAJGH2GyK97c?=
 =?us-ascii?Q?HbpK3E1xSsoMcUHcC9t4ZJ5F9owWCDJcS8xGKr/Hb1OmO8Ww3Lor9jxUFII0?=
 =?us-ascii?Q?pEPbkKnZA0W3IC+hkTdyaxPP3BDjN6e6ARORbWNbZfNlzv8eKZWKmp1iuso/?=
 =?us-ascii?Q?+q+1yfFBNDKAQSp2X6iXge7i9Fyzqw4ePUFzcnPUqTiF2tzUzt29aCPmKYAq?=
 =?us-ascii?Q?z3zgo2W1mayXwpf/SeEV+Pa8QZODRrwgl9ZO0KJpYKK+u5OQ9Ec9KcrXjUmT?=
 =?us-ascii?Q?WC5+8wL8QgWcbpvYHy35f/blK1dxbrom43e3VBkf0zi6Arug1VCiakvxKmNl?=
 =?us-ascii?Q?81LIrKsrKMkTjrCXTfr8pF30OuhXcogdr71sAfqnwuqjh7CW9F52YKOH3QIJ?=
 =?us-ascii?Q?IJJgwZvaERe/e9O074WG51+MqBQiW6aAyXLMU991CVZqZDp85n5fnMARi8Hs?=
 =?us-ascii?Q?qaUmjM6iuHg7cu9OnSZ0MZTaVzJFwphsQRzJiplW+4ivKrY5LIdxj0OwAXa7?=
 =?us-ascii?Q?tk64svXo2VB+j2Aqdhp9a+rlXPZoLVnP5uVm56QdtDHIo0Sb73bcu5VpIDY+?=
 =?us-ascii?Q?/6k10E5O5Z0k56p+diSmX0jVEWD7s/h81vXyx/0JHmOKafqu95TiOgcZ1Uts?=
 =?us-ascii?Q?Anw1l4jv4UhTm82R9J/zUCPcUQGLGn5qXy+sYPdQCmLkJM3MsOIVfXphlX4s?=
 =?us-ascii?Q?KMK7vag4zgTstp+6ahnfjOLJxvXjyTaRGla0TvY+/IdIr7/wEma1bJijHmVQ?=
 =?us-ascii?Q?uCJkVkbf9kYiJ3mMdAyfwH1T8CbS8x61F77J/ip8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228d57ea-25dd-42c6-72e3-08db666c8f50
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:01:05.4209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wtk2hYNU1Rp+MzNZv/jccrRZ6YravEueGjSSzXu1J5SftDDEWd2wZi0GCdbBUu8iIBp5Vhvs5cKy/z+Dt3w9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

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
index 27feabd92b3e..27407b48f3ff 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2284,7 +2284,7 @@ static void mptcp_timeout_timer(struct timer_list *t)
  *
  * A backup subflow is returned only if that is the only kind available.
  */
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk)
 {
 	struct sock *backup = NULL, *pick = NULL;
 	struct mptcp_subflow_context *subflow;
@@ -4030,6 +4030,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a4db0f8f00f4..12c8c95abf52 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -659,6 +659,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched,
 		     gfp_t gfp);
@@ -669,7 +670,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
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

