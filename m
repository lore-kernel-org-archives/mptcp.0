Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2048.outbound.protection.outlook.com [40.107.15.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B411CB9
	for <mptcp@lists.linux.dev>; Thu,  2 Nov 2023 09:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M8IGBQdR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjalOnf5tkltLQPEVmETlgFZShT98abRzJb8atI0qLcIh8lDQlFhLJ8iMc4pS0/KGtvmg5HsCl+MdmhyPbsja8t0ZtrbI/MsHVg1r63JwvPRQdrelUYMT+RLrGL3s/aI5AvAK4HbBquObzan83JRQZzcooXcxJZ41YyJVJMW2efyPJakKRPCh706tudZQb9oO80q0ik/0C8NStYr5JH5dTwzJy2g0lQd8ecHPJymRDFiXIpyr9DuXQwf92qKLpmOR5F87xBSFCgbJc0FwdRGsxm2JUj4UrEPE1gWgcOLWfiIFg7jfmiWXZYA102GGfz8wJ+p4atJ/FuHz1hvbuqiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvyPMA/bySFPFIqW2JDW9tr13OIXOzQbjy0djyw9/h8=;
 b=RfJojbsv+wk5eJLY3kRXk9RLnFecWna0ddZ2+TEJWl9bBxWcgLP/kTKLxOAxtaBADlHABALSveXDuhYRA936oCBOuXzVAY8o15uH6+WgPepVW3KEAUhCf2i+UZ8NZ1lmbICRD6XOaIH9mKMez6q5b2BKTr6UCZvroLbfuBNaYLX1YP6q9XWQ/mTHnUHTR2xHfzQVPlg+/9XwBUOZlh6ij92+IIwmsY0lk1Ckn/dmi8wF21YmX2BhmQu4+KLpnNwwOqbYK3ppkqEuWR8XWFZ20NLFPH+M0uyc+L2TNorKmS2FLlfbYoeHSmUj4OFN7YBqutzqmUpOc3cAp9ullxFa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvyPMA/bySFPFIqW2JDW9tr13OIXOzQbjy0djyw9/h8=;
 b=M8IGBQdRU2e2Q3LrQJK15lh1HYW7y/nqO/WB0rEvHspxB/x35HkbhQ7GHDY8DA9Yitn+muR5QLYuLtnK/j7ICmLFHTFZ4mQSY4OvzHeujXJqPRh3yWMnZANlbhScdhQwr709zyKRzyk/q1IpmPueJIiLi/kD0rmOOMfzOCBWsJxy6p9F4sno3xT7B4z3STIi7+zAfGHrFRRnb5SBV6U9YdKM5SQk6fHVSLO318irZBLE6e7djpQh57ObOpy1Tn6GYmtB1xYkJ2yiOSJbakrIAJIazIeLtu6kK/Eff+3zCOkZOXIxbxwqiBPIQ0UQJQaL+4omkVAKrJgxSlE0NFEevg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 09:50:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::1c4a:15f4:3b93:e235%6]) with mapi id 15.20.6933.011; Thu, 2 Nov 2023
 09:50:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/10] mptcp: add userspace_pm_get_entry helper
Date: Thu,  2 Nov 2023 17:50:44 +0800
Message-Id: <fd8e605424c3c43087f5436baa909b76ac1a7206.1698918546.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1698918546.git.geliang.tang@suse.com>
References: <cover.1698918546.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0192.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::10) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DU0PR04MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d2a9e9-9f42-467b-601a-08dbdb893603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hVoNolJzms1ppSu+XhZHX5+eK/30jvbYW9sSEPykUpco5l9UJcIpkBYRcAaQVn1w/2MhPue36Wvp2HzEABDXUpInf0r/AfA44RQR52dFWSfrLrr9nHc27mzlvRVS3bsSA6gKxasORb5IX7mKvSN1LgqUgV0ReLYoyvQqu+Y/dX8eL03Ik+Lft0omPiS//PJvcn9UUMAZ5mw4w3pEaQLzijwCN5i+KwwJit0tvJihZEIsI4tbdUV53CNyjlwi3qYtUHbkIHkkukxz97MlAS6C1+4HjR0YgmFjypvaVY5beXH+TykahLq4tc/6QX4nfUyQ5p9ggZQswoqfOv6jRxGbfPuEtUUYwTUhCBgnR9sim6xRUzJGQfo2W5sV1MRb8Jc6FFIEBVWDymI4f6aLd3yHxvQpN94oOQn4LsJpdlPomMKwhhrgWgY+CdpuPrCZQkTjLv13ABXAeUP0LZiLgH0b7Vzg4di6RWaUUhtY/wLKDlMNrztM3+pSJ1Qk8a2ruVYCvaxLrYCdhTr7dlwtSKDPThXOBwVsSl7ri624egDExQtFf1NKovleJUU5ul2mCGng4UPc2kFvCm1XhqdonTMR3965reJvuGTwDwVe10cOFQw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(36756003)(83380400001)(6512007)(26005)(6506007)(478600001)(2616005)(44832011)(6486002)(107886003)(6666004)(41300700001)(66556008)(4326008)(316002)(2906002)(5660300002)(38100700002)(86362001)(6916009)(66476007)(8936002)(66946007)(8676002)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbGufU5c57s7u+ChCdeG+dopi6HXR5vHX6b5KA4RtojMa4+qgDS9g2ydJgvq?=
 =?us-ascii?Q?hA0/OM1q1BjTcfrP5oQo0GWcjtlWzu9fdUuFM7WvZWlQaQRR+U+lANd/TL/a?=
 =?us-ascii?Q?O08K/zQEUxgYCgFpdP2nE7OHfL7iqbJSQWCOyplQVX1MvGlrotXTvQEmNFU/?=
 =?us-ascii?Q?U8at9tqGE/y+IkMBt5tcDxgQyddi0JDD1EZv7E1FkxSpa1chBgKCsqVPr3uZ?=
 =?us-ascii?Q?t5KbuNQp02nuRSMncXdhezpmEKRdqhkDIROwBNmt4W84yMfyvxF3KFi24HtH?=
 =?us-ascii?Q?bcaXOsdyme/sVh52iB3pX/xKJcsXyiaCaSiVnZQ4V1jqDCT3XE+YTbdiTb94?=
 =?us-ascii?Q?HngcMq7ZU3vQ5lbVHFe2tei5FLbnC6JPkm4oikvBIkAMEiR8zX9n4churbk2?=
 =?us-ascii?Q?uBg8/XAaa0buOTnj4xIfI8E+BTA52cYVXKN0x+3yKFyc0jm0bvCsiRYiLWxe?=
 =?us-ascii?Q?9ZJobqb1ZVAPU389El49SZ42vCS2S17ph9cBJBW7U8erxMVCEe6KlR+myihs?=
 =?us-ascii?Q?Se96NM83NtKMKYl1jVIUGKm1NUcL3PD3WRNSQAnHVsERbRM8senU8avNCSJb?=
 =?us-ascii?Q?mGRaok6zbjbxd/aBJZUeZGq+6Q3uNC5dNMdcu8/2onERYUeUru+ZhzMDLYwn?=
 =?us-ascii?Q?GaUr8Ir3hVVEAe11YNAYyEDd/+sYa73yu7ro0kcb2j1cHnp+evorq8/PTEo6?=
 =?us-ascii?Q?zWOATBWLXDR0ZXvxMByMn/o/sv/lZOYel1qlVlN8NOT/ntr7nU0xMHTgFHX1?=
 =?us-ascii?Q?TreT+yCRA97Dz4yGjvCIWVnwexktnG1N7slUkzCs4HjISQIC9i8z+jPYmPZZ?=
 =?us-ascii?Q?ENGqjFOklx895QCiaG+igAgU8MAnpoNDp2py5WDtPu/djLu7z2P8WpPbyFBE?=
 =?us-ascii?Q?DbSJvlSsDFf4NYFPz8WXNLPX3qGs8E0Lz3VL6gP5CPOofNPKObXKWmeH2Usz?=
 =?us-ascii?Q?SzqD1TVAhuThnF37/X8KMzmhagC0ZMXGwPOnY0B1FxBc27y4W6IfSObHlYPX?=
 =?us-ascii?Q?i28zryqthvI6i5BbsBSiwVwaILNF6eXJz5MWQ6A2U76f/k4fBYqfTMOl3XFP?=
 =?us-ascii?Q?4N1CtKBef+5CwgqVjbm6N7VhfFfzQnVERD9QLNNf/YXHi/OrZU2yognjTYZO?=
 =?us-ascii?Q?FLnfPY/33dZSBgOIBrpFFpWXEzyvbbKHXReJLyT99Hj8kol8VFVUhhwB3752?=
 =?us-ascii?Q?qfHEpQ7AoJtbHvFlhbL44z2fRZvLfBWYNitnwi73RvQMpe6P5U/+Txp8IPtP?=
 =?us-ascii?Q?mYdLEFPOLD1ItMGHdglLfiil271eS9++IhC/r3A3L+gyB2HX2KLtibuC2ECL?=
 =?us-ascii?Q?DiN2WjUclQG8YCacnALYHxglK5WOax2LC8UupV0NK62xeYORWRafTv539ioY?=
 =?us-ascii?Q?RnYcZ+I18t0ooeH+6lApyHu0H6j9GueRuJBwzVRYip3F5nwRuGjTs7L3og2g?=
 =?us-ascii?Q?wKAUmT0IG31GDMYEfWa09wp4921shzYnNB+XE6JUVGBXlFQnkB4xBsKY4eRe?=
 =?us-ascii?Q?uQfziBM1sv4rf8OQuiWpmn9vnUdKBoBGTuuDbTE6ho+2GNe0fAy9EcTwzDAn?=
 =?us-ascii?Q?aBZaqLxzPuMKQ8UqMBqhSMQDjJ8coUOrmAw/NpNg?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d2a9e9-9f42-467b-601a-08dbdb893603
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 09:50:56.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJIEIO/m6oAJXEnlk0fNYbORa4h+2rdV5EKEZosgTeOSXANma9wibIg0pTk3ICPKtKdOD1bBqYSh+Grn2p5j7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index efecbe3cf415..69733a1a5663 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -25,6 +25,20 @@ void mptcp_free_local_addr_list(struct mptcp_sock *msk)
 	}
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr,
+								bool use_port)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, use_port))
+			return entry;
+	}
+
+	return NULL;
+}
+
 static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    struct mptcp_pm_addr_entry *entry)
 {
@@ -88,18 +102,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 						struct mptcp_pm_addr_entry *addr)
 {
-	struct mptcp_pm_addr_entry *entry, *tmp;
+	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
-			/* TODO: a refcount is needed because the entry can
-			 * be used multiple times (e.g. fullmesh mode).
-			 */
-			list_del_rcu(&entry->list);
-			kfree(entry);
-			msk->pm.local_addr_used--;
-			return 0;
-		}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false);
+	if (entry) {
+		/* TODO: a refcount is needed because the entry can
+		 * be used multiple times (e.g. fullmesh mode).
+		 */
+		list_del_rcu(&entry->list);
+		kfree(entry);
+		msk->pm.local_addr_used--;
+		return 0;
 	}
 
 	return -EINVAL;
-- 
2.35.3

