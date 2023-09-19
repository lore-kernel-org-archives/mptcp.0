Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2048.outbound.protection.outlook.com [40.107.105.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19231A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+dmMljwOsWTs/8MgiPyEp02hrtWdXDApsD+YL+o1moOwsaGMeyWEdbweIvtvDfjOuIGP6bsV14yvQcpbooY9IATGQpyVolyca+/4PgYAHduVMwB07wawc5qDmyRUk5dHad9p27n8RunlrhaRAX12S1C/NLxYQMMdDDFbie6eseJK+ZgHvDFYu7Su9lIQIwvARnkEJYABLD39ZjVNGaUcyopk9Cx8YpMhR1uv1/5x02T9KWyBeXowBBu8c7kPpdQ0WXfse56S9q97/MloGxT4xU1xs+jCosZ0AGW0wC/pHAQF2UvWijS7an9x4nOfG3nAQUOSSGggCIcqZujsKorpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJX3nlevw6ZwDmBvHc7qhWe1X38wjYVlM6XsBOW4TyQ=;
 b=Jj4uztFbgbZSMCkp0EOn5LKiI2I5DXx8gGQ8D1TXLFxYxAgsUzrtC6WWf+UNB3+cndJd2D9obYMlfcx4tYe8qYKsFppuUsjVcq5+7ykrXlIo7Twz0e2N4IImSZ2EtR5HMdu6IYD0zqPV+sXErPl5k66N1ntiKhh7flNKufnm0xhMx56V+O7kebCwEaLCeCga6Mjpp2Hxq4aUG6zGPP+S9RiEZ88SS1iaAX0pv+GK9eGLrJj094XioslNim2ZiCYMLhMeFNjrUt7tR5B+/QEuflKA5CrJZN6afcK6S3qm5jkz9q4ELFEftQxP3Wvm6t78xg6K0KSA5AHr6bVSxLpzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJX3nlevw6ZwDmBvHc7qhWe1X38wjYVlM6XsBOW4TyQ=;
 b=AtsJod9r1BmK9bGRe27gFGqlyiJUQsnKjllelNrBY8orDbN60hzRNpiZ/qXG/vLIPVikRhAnenHNGYy937MzxrRREZ+MDqcFovrJdwDHNu6pIWjJArG2OsFOZLS3fn4KysPxtGeYhNY3jlkYrwzAqHKiet/Sm2Xlf1uPw4E9PPrzXuX9Ph/0Gs7vaZRKpE++v/uxXHRDxZ8EUOzMDInL4XQUCS/VU2V2OVkfRLycwF/bJ2i0KzbDq4UYt105A42uGxH0F2y8BCvF7loSRigClR5D68hYdIVd8KDhPAB9sddNVc2bDhV5J90WqTRLddSOuTyaEpoogxoAn+Ipf6ukSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:38 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:37 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 19/30] mptcp: add userspace pm addr entry refcount
Date: Tue, 19 Sep 2023 12:02:20 +0800
Message-Id: <ab4c1e384c5244b8e8c3465b8ce9f35edef3306e.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0278.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::19) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 822cf576-f960-4782-1151-08dbb8c58a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dy5OYNsLtIkTZXG8fujdfXXiMTPVAtqr6Axtty9LjxJlybZ+cvfJ+55LVyU7YK9SOg2t0FJbTy5poAPwBnDqvnbG2tR+pqJeIovaAmAZquL8jfZgZ+Sty9FS+aEvCQFRF4M6OPnRmUehguDXGGuGQh5wiPusRkAv4Cvy4rnCxcaGCIBnmTEL4Opfiniz06lI2mjq9jHelY7l0RSUNALShOETDTrzOSYhe/eTjHIQoNeBi0ZzylgW2J2hpwdWBg0Zdk9omnZBAX5KpoT4g7diEmH6fYV2uLf8F04WXxVHRbOxfD3zyS0crZOlv0JPuCDlj/VOnjDGe+aKlOUyV4uVb+PmSlBGKryiLZvjIclbSw/sA4T9l3Io6AbGaBNZsc3LGbu8DmBbKOuAe8kZgLKVwXo8BMRUB1KjTku3aB2ZjAGtp3NZ2x0gnWEHVz3mcTh3qSXaWHk2+zDcqV3p5Gc/ffuiPf30WbgIjmBOMQjkKLeEDgHqdgju0Mwq3clNtDW1zvamHcqAoT4zyyblxMdyUK6ombcwYpX3GjAI4qZiS+p17KDZIfWM5+j8OmsrBzDYgXP+QITOnWhKMFayvQeyV7EbRvypyk9xCx8JQvfB/mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMaFN5XqH0EhMf8hBGVovPbStfoNimqUv2eObmE6wZf+h74tWThfT6kC0i90?=
 =?us-ascii?Q?g1X9g8VYajlmVXGrXzLFRjHTrMwmyyU+NRbvBFMD0ou36fViDg0wM8CHO4Oc?=
 =?us-ascii?Q?AuB5y0howsF348o/WmWS2Z66vOXqRDYUHW2T4ajp0gkAdFC9hEklYn+ykGzl?=
 =?us-ascii?Q?NfBjtx8DwJ16BKSPwRF1Puk2kz2BSfAmjeUX8xVrO/i7xZfvix5Puepb9R+n?=
 =?us-ascii?Q?m6+MqatojCiqSbiZHuGH2J/kChimQHR8lCvGT4ocASzM2JEPrpKY1OcoolbC?=
 =?us-ascii?Q?u+KHViQnCOHSm2rYcM5++LkWcQg+ShJeauxBQaadcZ142TNYjnk854RhRKmc?=
 =?us-ascii?Q?rWIsQTn/SXDWwbgZpMREZLtRPk/v4DLYzkXCEDfvfR3iBuN8W+EpRM7NQbpV?=
 =?us-ascii?Q?Sl5DUeSfLJO9Io8nCmuMPTWsJFjYYi6UiuiG+T9kHmgjss3VG4Oh8s3hh+hL?=
 =?us-ascii?Q?6ejc0t1KoAQcItL/5G4hbkAexPj2zgj1LvO0GoU7EnMl4MQqDVFOYXig7RLO?=
 =?us-ascii?Q?JEjqrTuNfYDfC7/O91kkyY2JTzoY1V/ZHBZ63xktIDVZebkJEdIeOaNknE4K?=
 =?us-ascii?Q?K8nBdaHKq4/W7fZ2Cwb3XJForNhQgG159M9hQeHCWkmpQsBJ1cvp+RoetiTJ?=
 =?us-ascii?Q?zce/vP+XK1tIAvR8tLHx5+Z/cXe8UhRI/EpeBfTXLn66nLHzeLCAA0oO53b2?=
 =?us-ascii?Q?JfTFlP5O4nB8XUahR5CZOzk9U5A3hjbiK2xN6rzlPXBKOpZsVo36xju52Q5X?=
 =?us-ascii?Q?GfbVxGWBsIkbCjuBMeNrKQVaOXAFiDtu4jAyGvKPHMMhKweFuKsDzJylPW+0?=
 =?us-ascii?Q?GpkzEXjdvQbuPg2GH+IAaBSLZ1+8LRMg/WDjxMMt4f6PcBsRXpNDZ9S3mDw2?=
 =?us-ascii?Q?3+HbPvL8Pmo0AOkKpqKTs9fH/r6wOR5XhTEyUdhSSoVPqR2mPfW7Ivlif6Kn?=
 =?us-ascii?Q?+pYa+1xmtlw95vSL9qvKZcy7NuNd2lZ3dbwYCHmXYwqJLgEUQtwEKjLC++4t?=
 =?us-ascii?Q?LbLAFzhst/JWeJiZzKOCKiKXJrHYrxPGuIW59kE5XwJK9O3IoiMJe1ib89VT?=
 =?us-ascii?Q?RqJMDKWoRx4fluUkprTV/vs7/BWzGqJ+JSdIR/pJmYX2YwX6xsChk7RpiWmc?=
 =?us-ascii?Q?+biuH+BG6WkXbrRUsliPhytzUilF9qziqwib+x8A0C8ia+tYLj3oTje3VEL6?=
 =?us-ascii?Q?puiZe26UcaMPWcCwUXXZ7zPKEwXwe1ymfyanf/JBb3kEOcP2mVGOK3+Kd8p7?=
 =?us-ascii?Q?La8HSQYhUoVIyYT5S9kqhmV7s2S0arWjVejCq0lo0osmABEbeL6bgPHeaPum?=
 =?us-ascii?Q?JQT5UDnKzfcX8ukyk99Hg7dc2CA9d7yBmKowc2446LTLohrU/mdmRBW+uR6c?=
 =?us-ascii?Q?iUvOH+iE9vJz9U2QLFuSnlT65LYfdGFRFh61XJd2eTyeDB6SDQfelLBtRrov?=
 =?us-ascii?Q?8NfjAnGrLaTSM8PGx1caYfY124ADSqOU6Q+yldMi9VyYB9+Km9YGQCbvUtpx?=
 =?us-ascii?Q?lCrMFylfKicQqC6ezP34ItVsxtywoG4uHUj3cUs+NyBHYzu9tQnM5wMUzXuD?=
 =?us-ascii?Q?l02uQWguf3JbA1mfUjWhXWZSMh5YDqC0mtYdserf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822cf576-f960-4782-1151-08dbb8c58a84
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:37.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iIHQmTIvyvhIFSfOutkxFNznRnJzySW/vGnmwIALAca7/PwyJ0FryTctW3s0IdzQu9zSro77tqNEWuuTjFxklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds userspace PM address entry refcount. Add a new filed
'refcont' in struct mptcp_pm_addr_entry, inited to 1.

Increase this counter in mptcp_nl_cmd_sf_create(), and decrease it in
mptcp_userspace_pm_delete_local_addr() according the subflows value.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 21 +++++++++++++++------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 75c08375f6f4..d3846f2e8339 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -70,6 +70,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 							1);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 	} else if (match) {
 		ret = entry->addr.id;
@@ -107,9 +108,12 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	if (!entry)
 		return -EINVAL;
 
-	/* TODO: a refcount is needed because the entry can
-	 * be used multiple times (e.g. fullmesh mode).
-	 */
+	if (!refcount_dec_not_one(&entry->refcnt)) {
+		pr_debug("userspace refcount error: refcnt=%d",
+			 refcount_read(&entry->refcnt));
+		return -EINVAL;
+	}
+
 	list_del_rcu(&entry->list);
 	kfree(entry);
 	msk->pm.local_addr_used--;
@@ -387,10 +391,15 @@ int mptcp_nl_cmd_sf_create(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
-		msk->pm.subflows++;
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry && refcount_inc_not_zero(&entry->refcnt))
+			msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6ec1d967f22c..7adad41b5c1d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -241,6 +242,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

