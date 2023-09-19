Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CC31A74
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSOBYChnBFAYvvNtYUD3OSirhkNb1zDRoRpAOJ9aT9N1GoIzF8RbvTC3X8Nqj1lA1WE8AtFQ2SeE93U1PCi2kupKrkVCkyzZmJ0+JbOS0OAdLEqXatkjcng5ToW41bzHiFUWvBZBBzgRThjLyQ73aCG18iuT0p9PwDUDV9KL/mXSYiYCozQ5CnOPj80QJm8OSWXjHGy6i5jLp0S9ITLoJsY75HIhBJK2bKYy9zxrI5gMp1BvaP2VZo4Mlm0qhbICF1293MpK/YmsdDQr11ZyrOVMcRXq2etZMRmOOnBpXyjHvnjRTsjdL0cXAqdgEduvdeTQis2thS/SbG+UaJM+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpT8z1BWMsArBuSFlqbf5Uc+F+tKd/u4sAAz5PWo8fs=;
 b=dTE75ApeoCyjQHCbfX4mjK5duTdGbBkN5IWlTzTtRAe00TcyOyb51W1vSTajsSc/SlRyv+AkrBD5TD9Gp3HSbcTVhb4j8BiCio+bt9ONLAE4WXNTrxx6U7fYaOH87dAuy4hMMd1sdIOilYnrzvjR7BMa0kaCeOa55sFTuZMHRtmU8NIHg8YIM/718KTb+Bz0lW7UTBkpSutrASPWkqDJEU4xhdmOljQbOhU2XXQref7IIz4AUPjjZJyAMPcvCuKC+9sXkhcaWBnLVE0j8vLDY6OALTs2YBD1PumOAkcgBXLAl0JbkFZQ2wU3g1pPUsmTRKSZydxll85RziCrSzGeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpT8z1BWMsArBuSFlqbf5Uc+F+tKd/u4sAAz5PWo8fs=;
 b=xaaBVhpOQ6mt8hykAH2W55THCVjK0EiQ2vKZ9tfA8rFFGc/E8EyjM9AXR221gavza1cD4+kg30j7P6ERysyppQCJJ+nHr+wErk/wtlpexEPz5dwcHpFWng+K0H6NnsYHdQ0N1OjXYZnZgPC0vNfuG8UZ6f4+wkWkEu6VfUaqS364VQKjOmNNxH8bBcGjsdQIccZyqljtmL0gjZONLyG3OLuJt4QHnZ9845ULX15IlXQ8PGMJ2/qZe6HAQ9jreNIcVxlYXExxAb4lW1RYby8dryPoFHxikH7qQmXYiIIYRxIUyg0IOpartmYIV43zmBZtArxzLEVs1duu4kPwgPAzhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:04:27 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:04:27 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 18/30] mptcp: add userspace_pm_get_entry helper
Date: Tue, 19 Sep 2023 12:02:19 +0800
Message-Id: <27e62f435ddc40524e7e1b6d7aebca4e10376cae.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0272.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::18) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6006e56b-a3b4-463f-3046-08dbb8c5840b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IGirubExA14mYK66wrD0kZjuiDfhcHe+4uzZPpv3adv6eybu4k40JFCDA7Y1Lm90V5pY12klhQfrpwvYpjQM3SVYLhKqjMw21wx3ZXyIIb6JZWEC4FPUvKiqH1jP7//mLpwENESdODlNupUnKA4+0vOadI2tB1I3ODj6fWpeRGnOQ7OQbkpW6ky1beFrG0fNuYB5vcxSpiLHgQ29LYqEytdQ7gtkCc5g2CWxZOoGPukk28RXsrC/zJtS550sqHt8jU0qaxtGbaa6eNuy3b2EJ+JxT4a21XUMTwMUMZ4T9+w2OyANhNj2EUQ1TMiu0+0Rz30PdIlpO0AOHnkxOIn66hevGE/4gi2r9en3yDhbgQWpqe6qYywRlymjqXcwaB8trmhiu5PV8B5xLLhtWU4trQb6yibKqy39P0err48ZfyN35eI7IJJHP6qsMS/CsuNtE2q0f4AVkqIgswaqEFSeJ2hclNE+NTZT3YaorBuzlAxRwyi97MUKtXXMYZQDhx/vcs8n5AmBASbuYi+RwL2T8SJwD33cH3Yqt7oy0yIswXQ7wlnHGbeQkc+t3XCdozrWH0vT61+7nVB8gI5Pxh2dAUWmcQt1LXjPnHYVD9XG/Lt3wRrqWp5oHWxhiemXw4NfqdBQGsE7o/AXoph1HeDNJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009)(334744004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0hGUqbSjajtIwuVG0nVuIN+jo15Y+nPjD+i3HjYyT9Mq8VkAD+JKQaTniy9A?=
 =?us-ascii?Q?Ol/tGO8Md9mbKV69j6NF3TlXc95je53C2gjOD6+tgrpGGBE/aWOmI/ukRdMr?=
 =?us-ascii?Q?VM6150NuX02v6V+/FW0kIxymiQuGxBPyvYT1FuctvSHJ4cdS0QmnSdb6UGfY?=
 =?us-ascii?Q?7LxnyqOfQxKMpXjYZYX4HNKHeNwx7cgf+HWwmQTFQgR4iczofV12EvoqfDSm?=
 =?us-ascii?Q?xDuLhy176+yuLiVtBawZ7Ui08oIv3FbWiSlEpwWh1Dmtwwhds/PJ9d0UKfYZ?=
 =?us-ascii?Q?3yGQrkSJ5UDh+ktLsKW+B5azwjfUR/cKqr0RO1kPEMkNOPlQ2HW49F2AWSix?=
 =?us-ascii?Q?0xRq9BCDQYe3SYsQ9vGOOSEyxGeNK/x4yN73vVwYO26z4mIbU3b7wk4YSb4O?=
 =?us-ascii?Q?MpMlqdvhIslLuiMnlGHlArUyNpIhSxHjyDqmhohZgZ5YL7wjyyqKWSlsgRAj?=
 =?us-ascii?Q?VATBhH6WcRqjz8hLnuLIVw0lGk/m2H9UdA5dKjQaeLR6bgzqEx7AEpBP8qm9?=
 =?us-ascii?Q?hG680i3ePzSG+diO1C7UUhq69kh/pNed1NKWktnLanEghVAKff+zZ8yX912O?=
 =?us-ascii?Q?1jCsLkLZNS50DfsShQV58QwWS7bGjlMijJhIdM733L8YEaTxkY+b+si+L8RP?=
 =?us-ascii?Q?cfDjlqW+PwYOTtwugtu9JpqXdxbVylHgAwJqA35NZVCdIWp3Lg1b+35YZ7OU?=
 =?us-ascii?Q?IQ2zs8ewrnJOACuZXK/kM1HTaynW9V9RL80gwYQ+OxyS1UuBCF8aIP/25r4L?=
 =?us-ascii?Q?yqwYEeLphSOI48rXT16fn7Ef5GcXzd5VPGFDI6URTqqANHNFOwqjxBBesEkT?=
 =?us-ascii?Q?B73Lk+vqfJE3WoR1o8xBuaWMGvIj6EoEnewwyChf9r7DJE3yUKA72oEqQDJz?=
 =?us-ascii?Q?FQ5S/mKin7KjXWA+0N8/nLBkBciSAOQjED/st0yuFjq4bXWIjT7qvxbHi8ol?=
 =?us-ascii?Q?jT3pMiaYl42+FLIruOXOdfIJJsZl92opka/Ro1y/yDferO5eE3p9F8TxyICx?=
 =?us-ascii?Q?3QoqpquZ/sORttPK4pRwdQn/3f1zR7gwe7rGh3qdgOzWFRCjZWkmv19sC4YP?=
 =?us-ascii?Q?w7VnjVEw5iZmkKF6ui73I0gzzxHs1AcX3PdG4GNfyrpse+FHs+fj5IsqJ4i5?=
 =?us-ascii?Q?rtDVpq3Y1RBK29aX1p1lXQXZUqynuHVyEQJuzJkl2T2OdWkiaRavGOwdpauO?=
 =?us-ascii?Q?qeB7uBKVMZhahcf+87oJjLDppRdEEC0gJz/KRyoFQvf0LsST8j4kjMS5qXlt?=
 =?us-ascii?Q?syHN+QM+fN/1AKny5Ba8p2+rlT5YGm3U5LnXdHBuV/7M+5tIt6UlzEVba0Ev?=
 =?us-ascii?Q?OVSRwziKbZbx6r9mpXiAxVbNZeSSaMwsl/owGP6hYmz5f+MVK84Rfqab7EGL?=
 =?us-ascii?Q?TzQZ4gO9xjicFLxoQpazDgwf0WnGArRmXlXkXOH6kEby+N9VHJHB2U+TZ91f?=
 =?us-ascii?Q?UE1CGQB+Szlzjwtj8cFuoxXJ8wczanoOR8Zg3AHr6Li+kTafxAnlfGjOT1AZ?=
 =?us-ascii?Q?npxLsOBi2OS3N6bYagpBSDtNxRLKaglPyUkzCpJNjO1nVCIL2t/q6HsafrPF?=
 =?us-ascii?Q?IW9PpOgrChsbVo3nwI7CkLnaBm+n0C6BE0vgHlbt?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6006e56b-a3b4-463f-3046-08dbb8c5840b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:04:26.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Adkr/64WslU/ezeFEfbn6kuVzlP3R7PfPnlzJIdbBWM7qC7NYBGOhQvIJBpQqs2/S6ucPa6kioU7/JER4FSLJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

This patch adds a new helper mptcp_userspace_pm_get_entry() to find out
the address entry on the userspace_pm_local_addr_list through the given
address. Use this helper in mptcp_userspace_pm_delete_local_addr() and
mptcp_nl_cmd_sf_destroy().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 43 ++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index c1dac6d0a28e..75c08375f6f4 100644
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
@@ -495,10 +506,12 @@ int mptcp_nl_cmd_sf_destroy(struct sk_buff *skb, struct genl_info *info)
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

