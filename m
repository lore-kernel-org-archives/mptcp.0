Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB2178372
	for <mptcp@lists.linux.dev>; Thu, 10 Oct 2024 05:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728539312; cv=none; b=JG+OSiD6x5KXtu8IAhejdq2bTKci/HDnjFvDBmRkWX/4Y9lfvbvsXjIxB5avNDUooG+hqh65hiXk7tPz18bWTaJsDq8EXR6l3dYDI7h0hnGOlvHNFvYeNhZFSHDIA4vR7akWXxhXGrMUrBySKlcq6YI60x7NfNU21rvfCVdCeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728539312; c=relaxed/simple;
	bh=BeacQk9SNJKDALTc97IELSpe5HWfKDrbBtJDX/4EDjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYeNyE0sU3KJVT2jCPy9vvwj2wfsjZvBnOs9lEr29Tkd2ah9ohFk/C3yN4sQ72Tdsc0r+tedyH8A083MGUn/VyGbd+TJQvzUIR/fXIUgHdSfAm2Ng4dsxAca7q78rrtx9Ygzz9ZHOSvsfUzf0P7nS7E0WKsQPDFRRROjfMp9b38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGD2/5hx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGD2/5hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAA4C4CEC5;
	Thu, 10 Oct 2024 05:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728539312;
	bh=BeacQk9SNJKDALTc97IELSpe5HWfKDrbBtJDX/4EDjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGD2/5hxKvlywJCwC6CTma0kaO+XZU0lh2lwA8Mps5wHOan67XMPuTvil5nVLWu85
	 yfamLS+zJPRp3ZH/UjvOYK81l9IHcjmieQdl91cinKJOtprwZuaTnijByY0yz6sKAB
	 ZfZTfdOZvrb7B4XJ+WvztgxktnHIfVzocJ5qrbUymuZRUbe41OIC+lOrzuTVPKpwkb
	 cF5QveZ0GZwHSYmvkOZ7MVXvbOITSSlXd5Eee9JhS8HrwOljUctEFqTy3ZDs0/obQI
	 ZKa60A1DexKF7b4FIZPaGarToB+CdlFsUsJtmjNubZ88M37fIM1MCXxq+MCQ9ocByu
	 heYcweWwkNwIw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 14/15] mptcp: drop struct mptcp_pm_local
Date: Thu, 10 Oct 2024 13:47:59 +0800
Message-ID: <13e159c0bc49c99a692c71d3ed83634119b8a3bf.1728538976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1728538975.git.tanggeliang@kylinos.cn>
References: <cover.1728538975.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The following code in mptcp_pm_nl_subflow_create_doit() that assigns struct
mptcp_pm_addr_entry "entry" to the local struct mptcp_pm_local variable
"local" is not allowed in BPF if we use the same code to implement the
subflow_create() interface of a BFP path manager:

	struct mptcp_pm_local local;

	local.addr = entry.addr;
	local.flags = entry.flags;
	local.ifindex = entry.ifindex;

We should avoid this type of assignment from struct mptcp_pm_addr_entry to
struct mptcp_pm_local.

In fact, there is no need to add a dedicated address entry type for local
address entry. All its fields are the same as struct mptcp_pm_addr_entry,
except that it lacks a "lsk" for the listening socket. So we can use struct
mptcp_pm_addr_entry directly. This makes the path manager code simpler.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c   | 22 ++++++++--------------
 net/mptcp/pm_userspace.c |  7 +------
 net/mptcp/protocol.h     |  8 +-------
 net/mptcp/subflow.c      |  2 +-
 4 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 47dda03e4ee2..03f3b02d4542 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -149,7 +149,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
+		     struct mptcp_pm_addr_entry *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -164,9 +164,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap.map))
 			continue;
 
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
+		*new_local = *entry;
 		found = true;
 		break;
 	}
@@ -177,7 +175,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 
 static bool
 select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
-		     struct mptcp_pm_local *new_local)
+		     struct mptcp_pm_addr_entry *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -195,9 +193,7 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		new_local->addr = entry->addr;
-		new_local->flags = entry->flags;
-		new_local->ifindex = entry->ifindex;
+		*new_local = *entry;
 		found = true;
 		break;
 	}
@@ -534,11 +530,11 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
-	struct mptcp_pm_local local;
 	unsigned int subflows_max;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
@@ -660,7 +656,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_pm_local *locals)
+					     struct mptcp_pm_addr_entry *locals)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
@@ -683,9 +679,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			locals[i].addr = entry->addr;
-			locals[i].flags = entry->flags;
-			locals[i].ifindex = entry->ifindex;
+			locals[i] = *entry;
 
 			/* Special case for ID0: set the correct ID */
 			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
@@ -721,7 +715,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_addr_entry locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 4b2c3d0f685e..fc2f2bf6a69d 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -338,7 +338,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
 	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
-	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -385,12 +384,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = entry.addr;
-	local.flags = entry.flags;
-	local.ifindex = entry.ifindex;
-
 	lock_sock(sk);
-	err = __mptcp_subflow_connect(sk, &local, &addr_r);
+	err = __mptcp_subflow_connect(sk, &entry, &addr_r);
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 168f144b86a4..c4842fe5d3ff 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -240,12 +240,6 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
-struct mptcp_pm_local {
-	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-};
-
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -738,7 +732,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 				struct socket **new_sock);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 860903e06422..b54324d106f1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1582,7 +1582,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 #endif
 }
 
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-- 
2.43.0

