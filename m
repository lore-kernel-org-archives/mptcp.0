Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE14A45
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 06:04:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYG76z/2XZB1V0EdK5zZ9bJ/9cKgR9cBCyTrXD5y8QAblVNxnCr3mq9+ZprGn0zMcS2/Ggi3oqyeBek8ZAywOqcJvZWSG1dhV6tQXHMo7cz5QketpzVkkqDeo3My/gimdSdf7k0BCfayc26sUVGYgr5Bukjm6RLZS/1sjv7OlrlelUGhQzbxaN9Qrs9lUW6GOC4Z1adBf7ChFx1yTU+lgxWwOp7qf7EhLTLWbJFJHaHVi/SftU7bkGTixg7r+jD8PzTh2AKyeEYoYOiso/82aezYiLb9BpEwNgTkfT59c6HRo0IrVZZW53yDPlvs/6SZMAC8bOQTWiJZJRXoF7nfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tH4Ww9wDS7AcXZZm5Zb3yL96z9SWVx8olHfgCMTvTs4=;
 b=OUVFFm4NFLM3j4TLTjDVe/XRM6YktsVksy4aSucHfae6UMxJk9DjqsHuzg8+jYnlERK+7UIOcqChN3n0hrAWdmzmGNOmw6ThxbQgUUegOGPYuWgKw/k1V/dvS4KXluuntD5noWAGXBvF4ZaPC2ruH4rblPeaqrdHSGfkNkG7Ao4b1Et7RShNOSUY7qHmDo/5KTotcgZx9YQcB2QyI7MzD+J0sGTBQhNx5YCcRDqIS9DiaSYR5hI2AZ4gJT81cJOSxVkdfuKs4kFJtU8zoIQGVpSc6NDOjYHEKhzXy9kw9baY1Ssg/4qf4sttOuevMb2hDWGtVAPsWRjr+GSAYctuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tH4Ww9wDS7AcXZZm5Zb3yL96z9SWVx8olHfgCMTvTs4=;
 b=oM9sNA2pI/wQmB2oZgMS2OTicWfOiE+6kIjD1cIcet+pk4HHqj1kek6B6YlH1JZQ0pBHzauIYAShfjwl9HLmpFiMfHgRlMXT1lXLoUkEN/W/SkNT383zsUJfx3RPxrnVShRLJODwJJXUmWPzkI7OyJ1THG8eHFZFCK2TdTut4mci2dpwUM7BuvQ9QFopheEqRR0Gj95gYy+Ox3dqe+uIQF4czdNdwE+0c7bxua3GGcu6/zQmYtk91avL6cGIN4oFRaATY099jxyYZ5j3jqKbLAMzmbWr3bNRz3G0+3VnfjegkcynLpXGey0UUvxddz3Zueko2uo+sQOYCJKm8PbNRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Wed, 13 Sep
 2023 06:04:26 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 06:04:26 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next 01/13] mptcp: add userspace_pm_get_entry helper
Date: Wed, 13 Sep 2023 14:04:49 +0800
Message-Id: <622c534c891cbd723de77f7936ab001dee7dc098.1694584681.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1694584681.git.geliang.tang@suse.com>
References: <cover.1694584681.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0116.apcprd02.prod.outlook.com
 (2603:1096:4:92::32) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 53832f1c-f23c-449a-1af3-08dbb41f483a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U8jUJggyLxZWBH3YqecqcLmhMd4OAfGk7ytnALK47mYO7/G2egb5JYhArNo52IsuYr7gLv9xxesF9WQ4Yi2uGi7Eip3kNQWqjOFjMf+ye+eJutOYUGkEsse7FpV5UNrjT4qm46XJnNIlzWvlNN68ZguqyGx4QpoBQjMuW/O7+jooLHjCBZjhseYrXRc8MMdGC5HiyEjTpmU3/zga/eyrA7gYa5FkGyuY6OrdIn2xC27+iMOnEeC0zB3m3qix61ZQ8lfOADQAdF/6jGBM8mH35chMaKwxgD2WcrMKbrZ6ej+l0ie72zI9MpAWA+U4vtMsDJz5zODjSSFBw7A3NZT/Ct7nPopJ9yno1KNA5KtnUmTVb6AIs8vqwIHbcKbJE1irlhnGJ6ZFBDd4XDekDKtgCN0hDqL/3jo/4/UWKYc0cbXF3HCGZ/IXH1sOYBVY+ingTUD5fy1p1n+tUC2z5gkUhXfOCmKoKBPTbKBn0BknWiAofFh7lo+MPUNqFX523KwfRG4z0ji9h6suZ4aU74GJ1zHZk6vZ5c9azBAJpHlEfq7srDEI3gnOjg0RMnqoQks/vMieuJhA9Eq4IifLao4JttaA/E6QcLsBv7OwZAjuee8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(186009)(451199024)(316002)(6486002)(6506007)(6666004)(38100700002)(86362001)(36756003)(2906002)(26005)(6512007)(107886003)(478600001)(2616005)(41300700001)(5660300002)(83380400001)(4326008)(8936002)(8676002)(6916009)(66946007)(44832011)(66476007)(66556008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YoHN3S+3iaUYkIQ4qD7eIUipuScABag5o3ayRZLoZ4WFHtjLlbJ/nGsIx3h?=
 =?us-ascii?Q?8V0ItdX9n4fv/15cYwv7RN5uVeuIIbDTGOiVAh91hLpK4kuKIt0WBys+0pVE?=
 =?us-ascii?Q?XAIDx2LvdN9n5HixB7bpaPe6pqRKjiweEXXRjbMHV/8bgjC6fGuiBGvTSvQM?=
 =?us-ascii?Q?Nk6BFCZjsvHwWz9KTtZ4uHoc5Csmo4l3akKAxSSLipAUopLMTJ+85BtNXiz+?=
 =?us-ascii?Q?pj7pLvk+wKlKhQdbnXjc7d3L3AmBmrX+KNirYlGqcvDvcdwuTWlkT4/mUYsO?=
 =?us-ascii?Q?wS6V1UXNIWKMnbCc5Rzs9I/RdU3gKXMAXk+TVAKBZJiDG9vcqfEFSQXftlWx?=
 =?us-ascii?Q?wxoB+WxAxnJ7N7UIhBCoCSwc3pbUU7Ji8qJtg1LqZo4VqNWfkjBDLKircKBh?=
 =?us-ascii?Q?KbHuWuhA3wixEbEXwJGM717LPI1jgGoZd+TThVF2LvLGcEIK8GB77SJaKAde?=
 =?us-ascii?Q?UcdybviTY8wHlMIkAnbUGUtZ4ODhDOxefNjaEzdJfAThU2klr9ZTA/FUJURb?=
 =?us-ascii?Q?KVpam919AkilV0LzFuHybmLTugo+UYwsctgX7d2vEVFG/u2eADiubsvn7vie?=
 =?us-ascii?Q?TeSTaAk//Bwghx85e4YeQyrVfwLoeZRsAoGv9JpiEytD+yoFVxybLW5ot1bC?=
 =?us-ascii?Q?6/5+PnpwevEKoWuUBFdGHjpOLDO0BHE89TRYY46a5Ny7Cpg3OOqu3tmhL0nw?=
 =?us-ascii?Q?eeoytZlNAR+M9XpC6VDmHote4Vmh0bt2kd/mLTqr7mdHH6GDWIyx2YG5VJqI?=
 =?us-ascii?Q?H37I7gl8T0ENIvug1m83aFhdJ7LnRptwcz3ZoTz85lYC93KwblQQzKVoVA2z?=
 =?us-ascii?Q?4ehqT9xU0PXpWQSbzGxlejKdUV5MibznYXEgkThPMeXLHQ5gG58dsYBtYxB8?=
 =?us-ascii?Q?R5Lf70/FhjpX160KGhd1uCovC2sh6RItZelXtaNPAkVe6JNlzPSQ7TukclTO?=
 =?us-ascii?Q?sdrmjiacsbKTxtfZa6esHx1fQg3YiymWIy4MDMqZLdGafL+siNi+wnQYTxK9?=
 =?us-ascii?Q?Cin9Y3J87E9PUZjyTT8jR5eGtVKHaHRivYDz+sEmlf/OR5mARqR7t7uAHkIF?=
 =?us-ascii?Q?KRXxv1otE9FFTxey9W/li0Ffq5Q7AgzvrN9UGEL3j+5TlBiMUZdqotvlEEtK?=
 =?us-ascii?Q?Uh+VCsAbxHP3JsLuSELD5zrfp6GUjPpijfpr2H9SToZrHhch5vskFRR1l5di?=
 =?us-ascii?Q?pqwjwNlXQEjtTO2XlZZn4qhnBKGK6UjKnBHnZD5qAtbMaGwSrm1AuoKjkUTE?=
 =?us-ascii?Q?8UFEZr0UIsYlWD/yR+BYrg4c1GpsSnen3VI6wrYvW3EmPtc9X7/Y6mn/iukn?=
 =?us-ascii?Q?4H1H4a+s6+a5+TSfktgtkPGrs+aHjkNheKU2CLHLZZ9/A3c96nmtlxIYvBl8?=
 =?us-ascii?Q?0GPIKw19jp9sSnbKM4Ja8d3nYxX0EU3lg3jgag1JhMV0vZ8u2+GnXFOT74oT?=
 =?us-ascii?Q?0e03k/zlCwBayB+Q0Bk79P8hmCjZo2vIvRabnL9G5NDoWMuZ1jnbbUI4KAbf?=
 =?us-ascii?Q?2JbnpK+rsW4sUIVPF085CEVsQ6PGBddLRSLoB0VVrIUhs5nt0FxS4YT6J1Vm?=
 =?us-ascii?Q?4/CgrYihzON6vfald+zPnKQJBcri4yvkJ5DhoWPV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53832f1c-f23c-449a-1af3-08dbb41f483a
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 06:04:26.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cuy7RXcnC1kNQewt6UrcJ46KPK6MH/C1xR0fEUc8mWG7v8Mazu2tMbSlsHS6G4usHQm0XDcI9GKowjSPB+UL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 41d2d57b570c..359ecc65fc73 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -80,6 +80,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	return ret;
 }
 
+static struct mptcp_pm_addr_entry *mptcp_userspace_pm_get_entry(struct mptcp_sock *msk,
+								struct mptcp_addr_info *addr)
+{
+	struct mptcp_pm_addr_entry *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, addr, false))
+			return entry;
+	}
+
+	return NULL;
+}
+
 /* If the subflow is closed from the other peer (not via a
  * subflow destroy command then), we want to keep the entry
  * not to assign the same ID to another address and to be
@@ -88,21 +101,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
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
-	}
+	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr);
+	if (!entry)
+		return -EINVAL;
 
-	return -EINVAL;
+	/* TODO: a refcount is needed because the entry can
+	 * be used multiple times (e.g. fullmesh mode).
+	 */
+	list_del_rcu(&entry->list);
+	kfree(entry);
+	msk->pm.local_addr_used--;
+	return 0;
 }
 
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
@@ -487,10 +498,12 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
 	ssk = mptcp_nl_find_ssk(msk, &addr_l, &addr_r);
 	if (ssk) {
 		struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
-		struct mptcp_pm_addr_entry entry = { .addr = addr_l };
+		struct mptcp_pm_addr_entry *entry;
 
 		spin_lock_bh(&msk->pm.lock);
-		mptcp_userspace_pm_delete_local_addr(msk, &entry);
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l);
+		if (entry)
+			mptcp_userspace_pm_delete_local_addr(msk, entry);
 		spin_unlock_bh(&msk->pm.lock);
 		mptcp_subflow_shutdown(sk, ssk, RCV_SHUTDOWN | SEND_SHUTDOWN);
 		mptcp_close_ssk(sk, ssk, subflow);
-- 
2.35.3

