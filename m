Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B46D18
	for <mptcp@lists.linux.dev>; Tue,  6 Apr 2021 10:03:54 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so9392866pjb.0
        for <mptcp@lists.linux.dev>; Tue, 06 Apr 2021 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oRQ3Qqux2kbEl6Xr/ST0T4ymNaxYIhTN7QqYcw2bnS8=;
        b=C5RkbDX8GIAW4cOlHviq8XFoUnOX1Bg/ZlxjJh/KyPtQi2heu2uNSgnCfmJBKZMPNS
         GUMx62du0h7gBE4c4rfjk5KdYxesgqkrlrdiEhCqX+ysq8sYBjIcUOHrsU6JHrLcr+qf
         vZoBiCgDHmLdQz0+M8fo5eThyfihzkNt/uaETXejVCHjdVY5UvpOyQhxdiz2NyTflRJV
         Oj+TXpZm8ieKVGdNChSVi2Ka7zFXrRC0gng7BNiMJoafZDq1ggfR28R3SFRXd8KNBbLh
         gqp+UGEvT58zYrsagXWLb2N8EEMs8M/0B8201FFI++4B/9NCc2Aqj/wKjhDJ1VCXv+Y2
         vxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oRQ3Qqux2kbEl6Xr/ST0T4ymNaxYIhTN7QqYcw2bnS8=;
        b=YJK45E0Y2ZAHKwQ794oPuQNmWkuMEm45rmLfuPW5iCmk25N0z2XNX3Vmnvt+17efiq
         lkgMgFpFxOdlG+s0jfQ49lLlot58XJAv2tybZEWP8KySvvQqdchwH1LiJl6vapAMv5es
         2mjB3FFdlVs2SgNq51HfF+OEvC+51F0HZGEs79nFo68A29nfui51IZqMcxGCV+L4Zi0J
         3O1ua73Cqkh5ZqEmhdmXZ7YxTrW2PqrFWitXf+zj+qkwxQN4DGdf1e2oPJsgCmgJFH/R
         DWzLh/5pc2dLbNboaI2YsHCPJl3SLIqKkd45LPHYmzCVNaE6eZk+ryXrya2G/vU70mhm
         5SLg==
X-Gm-Message-State: AOAM5324LUCYmzZdkpMoGIALSgPtaED++Cas0+HKaNIDGWDP2QQ+YdbO
	h2oT/j5NNyrWuXFnBa4u90/mFs8tcf460g==
X-Google-Smtp-Source: ABdhPJxMZZ6d0TNI2o+FfhFTCZvlJDqEKxm32/z3fGRJnxr5yyWG+Abx+NkQOVzlXeuxuwlUbcmVYA==
X-Received: by 2002:a17:902:a5c6:b029:e5:df57:e156 with SMTP id t6-20020a170902a5c6b02900e5df57e156mr28027092plq.71.1617703433528;
        Tue, 06 Apr 2021 03:03:53 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id u17sm1970669pjx.10.2021.04.06.03.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:03:53 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next 1/2] mptcp: add mptcp_for_each_msk helper
Date: Tue,  6 Apr 2021 18:03:43 +0800
Message-Id: <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617703144.git.geliangtang@gmail.com>
References: <cover.1617703144.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new macro helper mptcp_for_each_msk to traverse each
existing msk socket in the net namespace.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ba040897738..b9044defd89b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -58,6 +58,10 @@ struct pm_nl_pernet {
 #define MPTCP_PM_ADDR_MAX	8
 #define ADD_ADDR_RETRANS_MAX	3
 
+#define mptcp_for_each_msk(__net, __msk)				\
+	long __slot = 0, __num = 0;					\
+	while ((__msk = mptcp_token_iter_next(__net, &(__slot), &(__num))) != NULL)
+
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
 {
@@ -985,9 +989,8 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 static int mptcp_nl_add_subflow_or_signal_addr(struct net *net)
 {
 	struct mptcp_sock *msk;
-	long s_slot = 0, s_num = 0;
 
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+	mptcp_for_each_msk(net, msk) {
 		struct sock *sk = (struct sock *)msk;
 
 		if (!READ_ONCE(msk->fully_established))
@@ -1096,14 +1099,9 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 						   struct mptcp_addr_info *addr)
 {
 	struct mptcp_sock *msk;
-	long s_slot = 0, s_num = 0;
-	struct mptcp_rm_list list = { .nr = 0 };
-
-	pr_debug("remove_id=%d", addr->id);
 
-	list.ids[list.nr++] = addr->id;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+	mptcp_for_each_msk(net, msk) {
+		struct mptcp_rm_list list = { .nr = 0 };
 		struct sock *sk = (struct sock *)msk;
 		bool remove_subflow;
 
@@ -1112,6 +1110,8 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 			goto next;
 		}
 
+		list.ids[list.nr++] = addr->id;
+
 		lock_sock(sk);
 		remove_subflow = lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow);
@@ -1162,13 +1162,10 @@ static void mptcp_pm_free_addr_entry(struct mptcp_pm_addr_entry *entry)
 static int mptcp_nl_remove_id_zero_address(struct net *net,
 					   struct mptcp_addr_info *addr)
 {
-	struct mptcp_rm_list list = { .nr = 0 };
-	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
-	list.ids[list.nr++] = 0;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+	mptcp_for_each_msk(net, msk) {
+		struct mptcp_rm_list list = { .nr = 0 };
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info msk_local;
 
@@ -1179,6 +1176,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (!addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
+		list.ids[list.nr++] = 0;
+
 		lock_sock(sk);
 		spin_lock_bh(&msk->pm.lock);
 		mptcp_pm_remove_addr(msk, &list);
@@ -1271,13 +1270,9 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 static void mptcp_nl_remove_addrs_list(struct net *net,
 				       struct list_head *rm_list)
 {
-	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 
-	if (list_empty(rm_list))
-		return;
-
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+	mptcp_for_each_msk(net, msk) {
 		struct sock *sk = (struct sock *)msk;
 
 		lock_sock(sk);
@@ -1320,7 +1315,8 @@ static int mptcp_nl_cmd_flush_addrs(struct sk_buff *skb, struct genl_info *info)
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_unlock_bh(&pernet->lock);
-	mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
+	if (!list_empty(&free_list))
+		mptcp_nl_remove_addrs_list(sock_net(skb->sk), &free_list);
 	__flush_addrs(&free_list);
 	return 0;
 }
@@ -1535,11 +1531,10 @@ static int mptcp_nl_addr_backup(struct net *net,
 				struct mptcp_addr_info *addr,
 				u8 bkup)
 {
-	long s_slot = 0, s_num = 0;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 
-	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
+	mptcp_for_each_msk(net, msk) {
 		struct sock *sk = (struct sock *)msk;
 
 		if (list_empty(&msk->conn_list))
-- 
2.30.2

