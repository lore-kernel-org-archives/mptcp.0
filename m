Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D376F847E
	for <mptcp@lists.linux.dev>; Mon, 13 Nov 2023 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XUV/xb/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTq0vDwlyEw0tKFSX2EPo8fOREvG5vHybUaG/Z6D4nD3Pp9zSi3IT4/1BfXcaq4oGhcKRiWEOC40Am5Fo2KFI/rXC1vpHREEUdw/71TYH4Cn2EDcgBgx+1K57dwIWUKavY17UNOzqa9WghG5UdZvLksZjnxQomZ/95CqeOQtbCYtK0oJFcpz3ZsRl6zimnwvDINedwCqsgLQRadvk5IZkgJ8hy3FJbEhofxUDfVCpgw6MWLkPQauxs+WrSJm5KwALgSia1kuHK3EwO8VoUBeAFXHYfJxys4Ygu5osRWYV8bHDJNVPMJdPJ7xdzQvsuFbgS6etH9NB2KyZCMTi1vp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys86Q/WLn1d3k+vcoaUlNkQYJxkT6CO+Wwtkdxfnz9U=;
 b=hiGCfFHslIhn8NWBnSuKpF9hZO9g2ycc4+bORCA2VnzEsEOjsCPJmBlJ4YmKgxPUOLj78HZ5fMfLsmdM41VHGyxO9A4mJDN2CuWj9yJbeDFkJeiJ2AvgI1xuupsfxYaTJyGbPZwEuU2VgkwEjT7KUVaki14WWVjwHq86vI+jZ+7dYmL5nVVJO6b229Hxqnzb8roZBhH7/IsGKDIya8OJ93ZTDbvk4wXXRvulZCQqKQdEOiY+teAccrppSpORJJu/cYLfNGjwArNJZFTwhSBiH8XCnpNEPHmDSnT40ZsnQGfb0/YpchRAmq6TUYnB5qQ8XQJ/xc9XFa59fxJiMcAtvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys86Q/WLn1d3k+vcoaUlNkQYJxkT6CO+Wwtkdxfnz9U=;
 b=XUV/xb/BxNfG0tH21HllzE3jQOmlkBbzQihG1CtLZlzLbC4znMoTCv1xVMxJ81uVy3I5eIhzWhmbBW+NPH1Wj533Plt7xktChDMzmSQUu2UWT8UE43q4QhUPZRwCCgkxVUkLY1+Y/vyryZ3evxqJ/67fJEdYT1/6uX5TN3+3+lwcWJbvgkMFPEfDRaM2kTA8o2cBh3DmIu339bamxMDNY7aja5fC3BAbVrXy70/0mCryxCYWbNjs6kG9W6VLWQDoTe3pSLsUk3ku6AnkojrGk1sH5qW0HAiktj37gjXqbTsvc9xl5zn/UFDWtENsajd45/qa4nxxCsDE4/0OlYaK7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by PAXPR04MB8895.eurprd04.prod.outlook.com (2603:10a6:102:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 02:50:57 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::7102:259:f268:5321%7]) with mapi id 15.20.7002.014; Mon, 13 Nov 2023
 02:50:57 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v8 21/22] mptcp: add userspace pm addr entry refcount
Date: Mon, 13 Nov 2023 10:49:05 +0800
Message-Id: <670ece039c7c63d09e69a23a61da2e276f521c41.1699843617.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1699843617.git.geliang.tang@suse.com>
References: <cover.1699843617.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|PAXPR04MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 075aa60d-332d-412b-1fbc-08dbe3f35cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qf2WZw/2ba6SJ2b7O7uQwy7VW7BQTrp/aJL6TWwnuFfGqGtfakS9wNVjEgnnCF3q18YdKKzyHt2PlzpDax4zq7ALbE1AlKIPSHf8enOL9WlsqmJWmGytkj99WkDrhAeWa2I5c8YrE3iOknvEmZ/noobAhz0M/16LqXKhs/CfXHTFYKCOe37/uKYM/tLaLpPvQmVF09DHGL2Z12IiHSmFxc2ToAVPDHC7oFCHIEyFKnNNnbY8ojcozeiFjcubWPFDNXRTutIcP9be28rkQXdIzbxnxsjl5qgIPy2m6g7EXUZdwVvl5ZZOjOUy3aC1dFdXMrH0+qfEQ3lAJy0LP7CsxoRVNXpDT9GJWwvm92h3kkyYS9B0cbXbPDw+fFUBKnpP5Sey/M4IJxjFqR4aEcuj0QkWhwbS3ETWxmS/qExRCp9wrVhAtLqo56VtrtOUZ0jPJJQ02FFc8u/p++G5ziR3aafcBNIh/+mUpQ7BUu/N5B+DH0BuoO/2BGWylr7CnKY/h7ohsc9B4dmji7mozyhl69SW2zOijwyIfYN6+pfvUmY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(8676002)(44832011)(38100700002)(66946007)(6506007)(6666004)(66556008)(66476007)(478600001)(966005)(6486002)(26005)(83380400001)(6512007)(6916009)(316002)(107886003)(2616005)(36756003)(41300700001)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mVIHxOuTwBKz+e0/u+dR4FRujwZm8LOXRGtnBYjvU9b4sDGZEAiP/TwMfQXf?=
 =?us-ascii?Q?WE8vwZMQYwzmgeY4DOuhhwO9rr4tdvLBe7A6BWc8iZCzFg1IrLCadI2Am5qe?=
 =?us-ascii?Q?WhdZpOswvC7eDcsr7cj8RXLWtQvm9NKYyOYLi95W0h8ZifMjkCHTo9RHBXoa?=
 =?us-ascii?Q?GXYr8AgekNgHze04m92MmxJYFze/i8iWlrRPQ6v9lGnlI+bqCJg+ZCnhHbWE?=
 =?us-ascii?Q?wygxCW0g45oKUdpzupw0AzXe1u1d6vviBXX18M6OreIKQpe1DLZu7h67erxY?=
 =?us-ascii?Q?e14ilKdikADcMRpxqFcJBt69Yq0qWAU7fpqai34iW9uGVDLkkWgAqWbIAIbm?=
 =?us-ascii?Q?EskqlUtJ7L7kER3AVfWSEIs+0GBRRbCctNCOgzzeZD3w+VvDnBAuMnmUTjzg?=
 =?us-ascii?Q?zcJqBBtwmCME9qhrFcm5WvZ6+FlLuIlGQWr5F2907QiNqBwHOJw3Xis8WMoq?=
 =?us-ascii?Q?KuRCxIG0eR7nvuQDIMgmjYCTSYrnpGeO/xgXPRygutV6bkH3pXxE5/1mcpfG?=
 =?us-ascii?Q?pXeqmbvRHwEs8ZgrlU75mK/bGnH1kD5pJGcLjupHiaA/7UXEE3ZrxLKOjH3Q?=
 =?us-ascii?Q?UB+Yi1UxiJedD88SuKd2PCxswskAoQdlw10Zgy+HWQb2IzDQjwerrcU8pELi?=
 =?us-ascii?Q?X/Cu3I2oZk/UNOY5EY3pKyiyZ+LyeGHiBfBSt/ijQN0D5dr4l1hcN8c9m8Nu?=
 =?us-ascii?Q?YYv5U2J6uyVB8paGNzh/NAUkVoktQnZVpEh3zkrTLdJdfKWY8HOAAtb2XDQd?=
 =?us-ascii?Q?sY+8FZ37tsfzaXtFzJyeBNiad1y+vM4IVJmp6nYUQ0/N0cbJL63QLSHAwqKI?=
 =?us-ascii?Q?3HtiWbsin9+OUE0m4E3+FNXQQ2SbAt2JLq5/UaQ4wzLbA2kgtnPSsyWUqfPz?=
 =?us-ascii?Q?A+CRuWglUy7H1GqDVTD9jbD6ZrCTgVGs+ejoGqKRb/EhdV7zRzp5LOEV/fRY?=
 =?us-ascii?Q?AKBbdsBOZCOVk1ZneqZEaqT0DUOIID0z57ZsPAPjxy71VlrrHfvouNx2j3L1?=
 =?us-ascii?Q?QOOjYoWbeO0mzP25YqCDdbNZM7vyFYSB8qaiIPQ1hUjICOpEhVPF0nmYGTpf?=
 =?us-ascii?Q?crn7pXtwg7EyfFLsZ0KPJHAzy1/DN+SD+ZLz+NVCegRHtqDyQF12u9OckaGZ?=
 =?us-ascii?Q?FaVS3/3bmv/wLtN61px7i5OUOwlht7vmXSurw4CyXVG4KQRFOoSD0iCPbdwy?=
 =?us-ascii?Q?8MR+7x5w23fK2wlJz6DU+PIEWPj4z6rstUrNldSoq5ZMxCPTvKmRH9EGoP6m?=
 =?us-ascii?Q?iXkGzm8kRlfkDDyMv2MF8tWvw6ppWOfQYW4QMymWar+YIzOR54lyXSkc7smo?=
 =?us-ascii?Q?UeS+jK4sO+QC2+QP4NQHP+AzV1c6/N8X/mB8Pd36I9KkMPAbpQLVE31D8l6i?=
 =?us-ascii?Q?d9Dmb8n9sulIv9P96k6PYFhkoVwKImp0P5vNk/Q4JAFagTdCwYxJpUVB4EQv?=
 =?us-ascii?Q?o2BjSX2vyvDp+YIm8XIJVEIu3qodedkY+2NZBk+7hOeRuK4G694GDP6jzWkz?=
 =?us-ascii?Q?mr0yMdnQbLZa7YtKv8cdMOaZcdp5GAvVzYC14ckARfhSQJRZVtyjImjLJcI0?=
 =?us-ascii?Q?mTt7BUOTQobSUTk9SvcDxhbR5Q7wOtPOeoCkl8Q9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075aa60d-332d-412b-1fbc-08dbe3f35cbb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 02:50:57.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sygSuYhNQysJPmfH9WknkzcJh/ooUtSprGrx7jLS2UKDUgIIGbmGraVIaiag9cZYsFv8NOBGhHyxcF+DNHi1Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8895

This patch adds the refcount of addree entry in userspace PM. Add a new
counter 'refcnt' in struct mptcp_pm_addr_entry, initiated to 1.

Increase this counter when an address is announced or a subflow is created
in mptcp_pm_nl_announce_doit() and mptcp_pm_nl_subflow_create_doit(). And
decrease it when an address is removed or a subflow is closed in
mptcp_pm_nl_remove_doit() and mptcp_userspace_pm_delete_local_addr(). If
the counter reaches to 1, free this entry.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/403
Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 33 +++++++++++++++++++++++----------
 net/mptcp/protocol.h     |  2 ++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e2f11e821214..f93eaf1b2338 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -83,6 +83,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		__set_bit(e->addr.id, pernet->id_bitmap);
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
+		refcount_set(&e->refcnt, 1);
 		ret = e->addr.id;
 		goto append_err;
 	}
@@ -108,12 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 
 	entry = mptcp_userspace_pm_get_entry(msk, &addr->addr, false, false);
 	if (entry) {
-		/* TODO: a refcount is needed because the entry can
-		 * be used multiple times (e.g. fullmesh mode).
-		 */
-		list_del_rcu(&entry->list);
-		kfree(entry);
-		msk->pm.local_addr_used--;
+		if (!refcount_dec_not_one(&entry->refcnt)) {
+			list_del_rcu(&entry->list);
+			kfree(entry);
+			msk->pm.local_addr_used--;
+		}
 		return 0;
 	}
 
@@ -207,6 +207,11 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_val.addr, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace uninitalized entry");
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
@@ -312,8 +317,10 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	list_del_rcu(&match->list);
-	kfree(match);
+	if (!refcount_dec_not_one(&match->refcnt)) {
+		list_del_rcu(&match->list);
+		kfree(match);
+	}
 
 	release_sock(sk);
 
@@ -398,10 +405,16 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
-	if (err)
+	if (err) {
 		mptcp_userspace_pm_delete_local_addr(msk, &local);
-	else
+	} else {
+		struct mptcp_pm_addr_entry *entry;
+
+		entry = mptcp_userspace_pm_get_entry(msk, &addr_l, false, false);
+		if (entry && !refcount_inc_not_zero(&entry->refcnt))
+			pr_debug("userspace uninitalized entry");
 		msk->pm.subflows++;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
  create_err:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0eb7b84a262..3093766dd224 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -8,6 +8,7 @@
 #define __MPTCP_PROTOCOL_H
 
 #include <linux/random.h>
+#include <linux/refcount.h>
 #include <net/tcp.h>
 #include <net/inet_connection_sock.h>
 #include <uapi/linux/mptcp.h>
@@ -244,6 +245,7 @@ struct mptcp_pm_addr_entry {
 	u8			flags;
 	int			ifindex;
 	struct socket		*lsk;
+	refcount_t		refcnt;
 };
 
 struct mptcp_data_frag {
-- 
2.35.3

