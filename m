Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6621341B8
	for <mptcp@lists.linux.dev>; Tue, 19 Sep 2023 04:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naqg0Mx3VkH/Qf/9kPMwCp/SeRGDem5BtGxp9GXOHSp2DYYe7ofW67RlsSj8lz+xKArhTUU3mj/FOsCFoRaqG1DUgPxtAFCD+Bw1SyE6KsSKQXjEX5COe9tQOn86N1nei2ZBGA0BMmPNaat82YMvv2FgFZyzWjj2kcqgXbo2GDzthwgSpihRrlBVdVU6wNdc82y81YThviL1QvLqlzAZlwJzqO/yAkERwgtGBxO57W++olYle5q0/lQw2EERqQ8GuL4ITfElmdJ/OPPjf4CfuAP8mB+eg/IRn7GA9d+jDCpa/2+hv0zWnoS9fgCW296cIPiL1mTuifboBtJebFzltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZWnKfmbeJi30V+/EU50X13bO4wOjIfw0jiMcfX/c4U=;
 b=aAV08qW6ObTpdDXHlazmUQSFc90FZih3TqbEfpmd3CwuzBl+vSIKpGYsA28567XMwmh5sB2sdScGXzzvCr70wg8GqyfOYtlbLJIer/k4AEXvsr0ZMyfHFR6YFbeGUUMf4/oaO96C2h50a4Y+OMU872j0Jn/vXLs3XUV967BCMN59wiVfgt8qGVKU0j4l799NCEEDixXyapSy9nKtAjU7dbyFiWR3YMQdyXF/YUXdysk2Qe93xgutyUbbR9QrOTDbqHrGdNIBngkGJF0rrXdw+13yDVAR6npqefjR/4JTHhbl7nM5FAzGJ+fpRd6DkhBtKc/NRXdqyJlxcKJqGvZPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZWnKfmbeJi30V+/EU50X13bO4wOjIfw0jiMcfX/c4U=;
 b=U3+pt+WlKnN3yqqi1WvUa42SnowUcgeVjJeuW3o19cphqJVesCTKxx6p9cmn3oxGiq4dOLHGlhwIH/zG3Zkp5Ds5Ugyl/P220Sngp8BTi5Uye9Hf2nRJ6cx02KgpYeE43sheiYyUurt+/SyUJLrbyzVJaP2Ud+QUuFhEqxdF4/PonZ0sloZZZl33Dsktleo1lyWcXLJ7mmZMbvRqThudK2abK1W7jxrdsbzXQ1bxtb+VBHRNgap1rkzpGcjv8eqgUKAEEUPU4R2rAToWB1ornqxI+d/WHfKHRXuJ8EPTOqgr1HxMZ2FzVdajeU7lPNGDBbcVRkiU6Dg2ObLXXETSiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 04:02:42 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::2867:7a72:20ac:5f71%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 04:02:42 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v2 06/30] mptcp: define more local variables sk
Date: Tue, 19 Sep 2023 12:02:07 +0800
Message-Id: <90e3adcc0291d04a31264a3359576190fafeb64f.1695095289.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1695095289.git.geliang.tang@suse.com>
References: <cover.1695095289.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8058c6-0c9c-44a2-9acf-08dbb8c545fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZVMqRgh1qdvs0iQQ83KC2pwFRMzzrK5AHLgOpMvI5QaGHFTENghhiG3G568AR2N+Oo3MTDuHpatsQuGQaI34XPpqo9IvRnvOiUmyeuAA5hrBj/2W48xn4bFuu10/QgF6SoLsHOzlAkhAItB14xvC7LBfg43AZy5PhA4EPL9sJlb49UrMxvawIQSoLSSpLl67FdZE8EzsRVykNp3z0GmIyPizAHKtNYAnkAXly7/6inh3wBEdek84hyO0WUVyT/2cxrrA0BainJGSn2/bpoM6zQNQFpLSjiyhlkoAz2SOXqhdqgKrKfglec0SXYS5vo4mpo3w/cnQb45WSe3b+yNDDfNpMzdLXwu1dGNtWqJaBXeaTNz75HOnFWH0kABXcfD3JfKAC6QR7+T+qroilVNtO6Yv6rCexY3MdNzfJZgLjOQ8lj892VoditnUMdw6Ew3BA3xjH1U376OgeiZi6o47Rki9vcUaBgcT1HUlfxQFlbq3q/BRhZUjZHd6UUmFz0ZfkoDT/BvnSw59w/G0F/pVpfp1mMQxFkF3uzyuTT2wezZsBzxEUK23QAO6P0x9S0kLCGyGD1EEin3fvwqFuppBBEQlbsUOOpy6unoTpUkfQNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(1800799009)(186009)(451199024)(83380400001)(36756003)(2906002)(38100700002)(6506007)(41300700001)(6486002)(2616005)(66476007)(66556008)(6916009)(316002)(66946007)(6512007)(86362001)(26005)(478600001)(44832011)(6666004)(5660300002)(107886003)(8676002)(8936002)(4326008)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MuR8SrB3OtTYNpBvLzfz7ldhtLowLtLN5PNBEpVUwC+SZ0hKUExhwauLIZ1u?=
 =?us-ascii?Q?rrW/YgCGsC3PVC42pP8ssA8/q1TQxTBPiLGTK+wczGHSPhhk86WqpwsYonL6?=
 =?us-ascii?Q?somDYxB0zCRAckvzBJXNboXjhGCRZtISnJPPvbkirNArKxcQGpGS01+nulDQ?=
 =?us-ascii?Q?39ToLNPKHd6kqs0KTB53h1WU1K8QMTwFdNNzIezRXfCxE0XkPKzRDNfAJt2p?=
 =?us-ascii?Q?8wixHYsK0nbZQxkG+DxKnLRACbi69c3ecl+ZA/3vL10hWw0Vy5VIQgl+ESnJ?=
 =?us-ascii?Q?vdqnsfGZFCOyl9aD30tPfQOg4GFN1vwauydhqr9QHiwmQYX0I06aJnTlJvw7?=
 =?us-ascii?Q?0e8gpydIUF/83BGjS+qCKEZAIUWjUlnsEdW6bL33Tw86EytEnQ+ajUIRBgMl?=
 =?us-ascii?Q?gdVYGyYCryLz9fx44fhAyejZs9Gzb7Yiv/fEC3fKxgIKHSLRirPJc6Fmk4oQ?=
 =?us-ascii?Q?6Ez60yhCvi4+9T7MZ8gsRXBOHAM3tB5B/j0tbRoDC6+SrvzUvLcEvzi/ztlJ?=
 =?us-ascii?Q?DC+sylPLXfXy3641A3nq9vXrEYTsSb3NW/lPa0rC4W7whn68wmlsZElDWl6N?=
 =?us-ascii?Q?43AWNg0Qca0Ayf4QIVT8YYTqtQRmXCx178wtwFfmqpS3LOgcJ4XBOS9q9RBm?=
 =?us-ascii?Q?5Y50Zu9jmiXkpZQ2av9fthzprUuVzHdhHg3A8KpY9cN+iuvQ3KtDc+DlmT6T?=
 =?us-ascii?Q?E5mdaEj21EL9W6JORXo54FhyO32Ll0ib1Ms3bwmxC2626hIORYQZYqIXSZeP?=
 =?us-ascii?Q?7/PDfRBunKc60+Ay+z6OMyVnIBPxbOLHwsLCmJrybdEi1IUHCBigKefvL8YT?=
 =?us-ascii?Q?fNlusbtasBkU0toKX5CRqVxhIIkkusLDdHd48jXHzP9a7ywi6CsACFS77dPb?=
 =?us-ascii?Q?5w6PDamonFShBqlekvNklTBpdLKHtBUao/11AgFDlSaqo14Bxs27pw2I4rAG?=
 =?us-ascii?Q?TxbJR4z+ZxZb6r4ZLdpy/ZtbKocF7fDK8Pvb5AZxDLRkgOV/lM99NsaeRa1G?=
 =?us-ascii?Q?Cp7wu4yOKFlrNn+XbupDF41MDOR94F3A7OHhr3f35Bv6aDkFsUpaKNbMA9Tm?=
 =?us-ascii?Q?wC1ZPEgiIJ0j9pR9q6WGZ/xoJM+YtNS0uzIy0qH1Vg0I7Lods5HDBcvLq+Eu?=
 =?us-ascii?Q?lmslFlatEkSKrjPkqPt8hCrHXnnsnWjFcSkIV7v+ElL0jkSNm2ucm+7yZQBT?=
 =?us-ascii?Q?w45OY8BhKKNVTemiryYGEGkmOQk74CYU5PkyjMeL7Xz3jHnZPcJymGkQjsJu?=
 =?us-ascii?Q?y+So88x6wzY0eVUXIk8XD2y07vNKG593m/UxKYTVLYTZ9Qsbk7ZnEwYz91pC?=
 =?us-ascii?Q?v+jcA+fdkXJ3h0YEjmVQERO/8nen63HF4qbFzSmHYhn7YzMmcCGmDimKqJAj?=
 =?us-ascii?Q?t8B6wLzMRxrW/WmTo0PaKJoxw/JUPmNhLV1pwdx7t4jcCngtvQfntWtQ82cm?=
 =?us-ascii?Q?+AogphTOqFQbtEWGySTLRGL26MhdWbU3PBsXqS5zO4PM3/wNkH3eX8ceE1Wz?=
 =?us-ascii?Q?6fTGYVGZ7aoedrz5sRGyfUUY+SBM6oB2FT2YWJQKQ8OoY/uN/yU/mQjAYWcn?=
 =?us-ascii?Q?AD1L317sDFmvQ86bqqAUyIVKUrOMUVQphc9PKt8E?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8058c6-0c9c-44a2-9acf-08dbb8c545fe
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 04:02:42.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPbG5TXYsLt1Jh9DRQrEmfAn+kgUhILsxUCPmJtiNbpbkFBYTItlacFpX8p/8LHUHnDObhIQPXURFWqq5nRJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297

'(struct sock *)msk' is used several times in mptcp_nl_cmd_announce(),
mptcp_nl_cmd_remove() or mptcp_userspace_pm_set_flags() in pm_userspace.c,
it's worth adding a local variable sk to point it.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 78b935ab7d3b..9429cf91a9e9 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -152,6 +152,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_pm_addr_entry addr_val;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	if (!addr || !token) {
@@ -167,6 +168,8 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto announce_err;
@@ -190,7 +193,7 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 		goto announce_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
 	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
@@ -200,11 +203,11 @@ int mptcp_nl_cmd_announce(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	spin_unlock_bh(&msk->pm.lock);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	err = 0;
  announce_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -217,6 +220,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
 	int err = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 	u8 id_val;
 
@@ -234,12 +238,14 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 		return err;
 	}
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk)) {
 		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
 		goto remove_err;
 	}
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 
 	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
 		if (entry->addr.id == id_val) {
@@ -250,7 +256,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
-		release_sock((struct sock *)msk);
+		release_sock(sk);
 		goto remove_err;
 	}
 
@@ -258,15 +264,15 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 	list_for_each_entry_safe(match, entry, &free_list, list) {
-		sock_kfree_s((struct sock *)msk, match, sizeof(*match));
+		sock_kfree_s(sk, match, sizeof(*match));
 	}
 
 	err = 0;
  remove_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return err;
 }
 
@@ -485,6 +491,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 {
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
+	struct sock *sk;
 	u32 token_val;
 
 	token_val = nla_get_u32(token);
@@ -493,6 +500,8 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	if (!msk)
 		return ret;
 
+	sk = (struct sock *)msk;
+
 	if (!mptcp_pm_is_userspace(msk))
 		goto set_flags_err;
 
@@ -500,11 +509,11 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
-	lock_sock((struct sock *)msk);
+	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
-	release_sock((struct sock *)msk);
+	release_sock(sk);
 
 set_flags_err:
-	sock_put((struct sock *)msk);
+	sock_put(sk);
 	return ret;
 }
-- 
2.35.3

