Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2043.outbound.protection.outlook.com [40.107.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3D7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 09:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxuF8Y4ejlXwxk9zOqytRegRGRrv+fDHXlmS1L6MvH2Tto6clC7XqFSHJZ7o7Lc1joranggrkZ2/r9oxYOJiGKbHeQhgcf1uqI4WTPedEgfmWZeTOltOu2aFkJvdUCZi3WtNBQZvwPbJ1Eo+K/NuRGAqWNZ6EEpT8sUjPyBqsPMn6OaygNrdQFKJUbus7oCOPiTTivB18RAab4kXzhzjbDJZdpxSxiKTF2boGoUg6Ik1gLx2G440C+pswQPn11m/f2El+vz9UNfzrNmh38EJFnKmWf7NhZDMGWvi2cj/UhJv0R8x3MyrmjwSggZI18IMM95r5b4KKnStiWwKkOV9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsNdCBQR/LJCj0TlWLObgtkAgDperzgu9oW49c6Jupk=;
 b=N2vll/f0tfQ/uJeed/0wTKs/QwcottE2mYmKop7jOpYdDMu9thlANQHCsbaGZbWUv3g6TALV1WSOWLZI49RdR4pX/6d68SzHplQVvKnWUkehf1ljXDZw+aEiLswd13DbNz+qQVzk1mj12ukguTuEr8wGIp9KdwUYKv9F+XCilcLmhrlzHZ752FzRsibRWRKwxnoc9HNiAPrOpT954AZcHgl/KUaeZnq1UCXg6HnQPeGT50oPndoNsgNqLrOzGpwFHmSxfTLdsTMB+Er+fVE9oeTUTzzmkekLVIQutKjGGfrvfniTBgdixZ86BYv3+eslXRwTElYcZ1tfBoee5bE9DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsNdCBQR/LJCj0TlWLObgtkAgDperzgu9oW49c6Jupk=;
 b=OcZrhq/I0yONgzuzZUZuIhBCAy6xNejFzQuJe21DR04mb1vgUus/I2otevriBp/QCrQXl5cHv/8ZQbDeHeMcxg80xNxwBGIXFDX1AYyBUexOjfTbh6flF69qs+BCbw3yuUBFOF1Dwq1HkDt8N6yw0d8c0x1kSojNPPwVQdMWfMeDfQJex/2jMW17OfbALVMJ5gk4gb1G/J1pL+r8TEI1PmB7PdUZVPE9zd8x78VBrh5EkRABHcQzFYeqSAyUQu+Bbhpx9xZfjbjglEBUdrwk3qZK3+sqziIHGJKw/J6t4xwx2yAYzmWs0eOp7bShp5lr4Y+H9S11VNyYPx2H8jSIKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PR3PR04MB7321.eurprd04.prod.outlook.com (2603:10a6:102:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:18:19 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6433.015; Mon, 29 May 2023
 09:18:19 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/12] mptcp: register default scheduler
Date: Mon, 29 May 2023 17:17:20 +0800
Message-Id: <24bc7831ec27824f5d5b7287713be33704b6bcc0.1685351620.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1685351620.git.geliang.tang@suse.com>
References: <cover.1685351620.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PR3PR04MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 193dff6f-8642-418b-15c2-08db6025a482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3y2h9bl3ijw9nmjvKScYqP04aCke5FW1sd43GwKeey1T/SpSDrpXYZKJL2s5VJ+ewPvpIJ8vVtMwbeVO0D3ZVyFKSQ91AaBxo4JzzYjGVqJUlUll6WzF8b2xx39MPlSsmYkK60nzTQtQ7gFbeh3RxYDOpWC8SHP8Ywnp4DmCZILGE+H/9bjkChn8MMJnHjcDbxMjxasJvdjcvGUgqhWHkSZsn8m8RIfPuM/VOg/Bp5Kn1T3msmz2it3xRWAiPAFE9AU4dFfwXnhC4inwKGEZmhfMOV97rACc0JCXbXjBo+gH1TW+k38ZjHiiJIe0SuLlTb/BUSlkuUznamr98d1i1PbGxpekG6gp5Izlu4XrNTYqrWJfi+aMJBsM1YWWzW2pfLPPoOPMHOIHx0BCfxnALI2kxJUbK7YNAzBlR1azHIQyO88cCAfQ75r6jbpYbpbm+twd9HavTGYURVssD6Csc38Heg44flyvMZk7ViAgVs2qOVJqpi4IwNjwM2l2JuXvrt60beHpWNNg5McHPRplcvLKOh6Bncxq6EgGk7KJmQn9vsMrP+PHh/Z79c3qWBF1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(66946007)(4326008)(6916009)(36756003)(66476007)(66556008)(83380400001)(5660300002)(107886003)(44832011)(86362001)(41300700001)(38100700002)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(6512007)(6666004)(6506007)(316002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/OeO2UTcbmgZJNsC2VPEB9wyHDyPnYlMRdW3qmOWoc6Qa9sI2ImBOnnuiIn?=
 =?us-ascii?Q?7ESQcv1sU2j7IzizEmLONjhZ/UtfLLZKVA7gYf9w8EuX4kn36mZo9VUnsO0M?=
 =?us-ascii?Q?04nCnO65leRDuyX9Wq4xniynzG7mL1lMIEAE8lCAC+8l0e5lP1KdvVrXFlNv?=
 =?us-ascii?Q?lCTOnN0melfe+ym7f+/xqGFBuU2moi+w9NkAyAogPPBAVxZXJa9mdR+HhIw4?=
 =?us-ascii?Q?Gzc83BKVaRklM6NaOyPnEF921aeQt3uSsHGBqmXj2Tbp+h8vF2kFfm84jdlL?=
 =?us-ascii?Q?GPI5SDehTGHt93rRVsZTO/3rPVTJoc6qOqexD1bvilEaI6b2l5xkjqSycXrr?=
 =?us-ascii?Q?8j//W16vT3UGWcPITkt08B0Q+nJtTbVZMWkVHYA9olmiAAUQlh6IP2cOPgo/?=
 =?us-ascii?Q?8AJ6RcGsrbFTYBuFQrPPfGsIdMw0ZUWYo8sGUI6ZnO5IajLbuI/O0bowpxj3?=
 =?us-ascii?Q?/Klup3Y9eezWuWyv4ZNcX+dxfywuaKmRL6oUe+3PMtKTzl2AyUiXc+Av4VFi?=
 =?us-ascii?Q?QjLDCHctxQxFWlRVNhLAAlfHVmNf/061ecCbjOiH4wSvR2VufZsW+wO414q5?=
 =?us-ascii?Q?FHHEKfGVkrgpGdEEA3Noo423gLqq/CATx44lVkbvM8rt51H6E8RyS/ikYlLO?=
 =?us-ascii?Q?qm3HioyXcDmW0W64qj4c52e31JvwmN8Mqjl9q4Dp/5Ww1hFYGI7hVZGk4nJu?=
 =?us-ascii?Q?lY7/VqixZTHm1F317nyTsmBtqM78xhM+TFSKnGtka0KTvuUROXSPFNunizBZ?=
 =?us-ascii?Q?VAPnKWJXkoWIQswULZ27pOwoQaBSXJS5GBLGUQuE7XNP7sUMr18/k0GtM+IG?=
 =?us-ascii?Q?A//CzBfVKoHgYfz3yFecfqnaNFpy9Xy1yEluxAuYDyaAsnE+j6+WgiWTXiM9?=
 =?us-ascii?Q?zlaC5reOQj/NFF0mcYhFo8QpLbhAfAHcxRoDnmtD8OXGiGpDgJSQHSbtK/PU?=
 =?us-ascii?Q?92P/kI7ZGgZDkJLIWSjEniakposgX/CyFB3B355xtdIImQmZ+DVk5GS3qEVr?=
 =?us-ascii?Q?P7tXEQjNRGAFNdpnd6T+n10qJx4mhZv6Vowdqo3zKtdP2hp3SI6JPBnvNIr2?=
 =?us-ascii?Q?Rpw9ElFIy8ZVnz11fFtucrZYlss7DXkTHL9cHPBDPpjei3tR24E8LdW8QBfG?=
 =?us-ascii?Q?JD0CRbyoO+ulW+ccRoEUW4np9GE/Ny1oIicyID4OAYgdwcl+jTe14aRyP7M6?=
 =?us-ascii?Q?x2vOBcqkzp0zesXMR1raOys5Zb2ocrpBh7WAMk1fCVHcvkGdAIV32kjyiz+T?=
 =?us-ascii?Q?mhjU0W1uj6U2wMNJ7AWH+CjCFZsiIh0iqyJzoWyXEXsfz+LU0QaO+Fu9JEIY?=
 =?us-ascii?Q?hn4rZQnZtXhmYBrV4i+WGs4xHFJhGi5h9HKnjczFRCEfJY13CP7ma2Ag79qh?=
 =?us-ascii?Q?bCmVbgZWsrpXCSZr9AWYTdFmxXyq+iLF8au3J2qOXYRWzNNWoPps7FgADqa/?=
 =?us-ascii?Q?JIDAyux0ctjxBTzfjD5EKZ32Z9btmhtV79s0ZTt+pLzA3FsQEsnI0+7PXpvy?=
 =?us-ascii?Q?ByIcYRVEEPll67ly5bL4DoeqGbar+GIXM+mQ3dc/OFsaD5+Xov72J5WzK8zH?=
 =?us-ascii?Q?OMClIMWv5FHraiW16+Tim/4zLcNiziLapkQIgzwz?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193dff6f-8642-418b-15c2-08db6025a482
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 09:18:19.7537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpnyFTEXdIDYSaKyJlVXOdvrRAElk5CqiQ5YaM5lYSeBXIxbZ9wevehNC6bGkZgTgqG8rkTvu7ShVpKNGxRVXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7321

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
index c523e394307c..27e86a2cc16c 100644
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
@@ -4005,6 +4005,7 @@ void __init mptcp_proto_init(void)
 
 	mptcp_subflow_init();
 	mptcp_pm_init();
+	mptcp_sched_init();
 	mptcp_token_init();
 
 	if (proto_register(&mptcp_prot, 1) != 0)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 760fdd888e31..9552d5f581f6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -651,6 +651,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
+void mptcp_sched_init(void);
 int mptcp_init_sched(struct mptcp_sock *msk,
 		     struct mptcp_sched_ops *sched);
 void mptcp_release_sched(struct mptcp_sock *msk);
@@ -660,7 +661,7 @@ void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
 				   struct mptcp_sched_data *data);
 struct sock *mptcp_subflow_get_send(const struct mptcp_sock *msk,
 				    struct mptcp_sched_data *data);
-struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk);
+struct sock *mptcp_subflow_get_retrans(const struct mptcp_sock *msk);
 int mptcp_sched_get_send(struct mptcp_sock *msk);
 int mptcp_sched_get_retrans(struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 81cf278b0435..3a7dcde726db 100644
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
@@ -50,16 +77,24 @@ int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 
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
@@ -74,7 +109,6 @@ int mptcp_init_sched(struct mptcp_sock *msk,
 
 	pr_debug("sched=%s", msk->sched->name);
 
-out:
 	return 0;
 }
 
-- 
2.35.3

