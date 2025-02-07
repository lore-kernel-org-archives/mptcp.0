Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4C236A90
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920587; cv=none; b=ibPQheF5FT7z4apvGwwA2HqtS60eqm0klyjZafXmIuUyuiR9eE69iyT4lbSEQ4dunDTctwwtxYZJH1luAk4OkNIU2eFlx9TeBELrxBZLVkaTWKWkWyAHQb5MGD7UcP8x93Czq9owPTDsSuACfB/pY6f6T5GsyAJw+i/qV137vBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920587; c=relaxed/simple;
	bh=/vjF+xOhxiZEDpE/Kt393D5jfpxh3o4DgiaTEoJRafg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUrc1VBmvI9bCmxiY8A3qh//51ddOobQLYFIhu7GNW2qX9k7Sv2atmuydneumkpbaVU+rkFZxRqGIeJ8VjZMnGvNKO727je3MRAmfaLgltm0yOC0v89KPjKXmuoPlPNpBwcyOp/r9JnL3evJmCguo06rFa6dTXC00F8hhGohwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7/GSauW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7/GSauW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D19AC4CED6;
	Fri,  7 Feb 2025 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738920587;
	bh=/vjF+xOhxiZEDpE/Kt393D5jfpxh3o4DgiaTEoJRafg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h7/GSauWABj7vyQi1V8ZuyYT65ilxnq+/xvgDHEaGsBzAM43RMskvPuazJSD5Qltg
	 E8OQYAmxxK/A9CDEhLQ3OoAIzoUlQlVjmg+/W8XFx4zA/17sltfYZisuDUfAV1InwK
	 h9s18Myl/+JHEkE8vo80fm73N5EsLxCoGVjiUsruHswKWgFgsZqozXoZN0vVGfgy0L
	 IBEZIx4IV8fBXk5wBgiEeF/CUmKV6+pujP0dq1+M51MRKvDN9p/9RoDdT0B9884xVS
	 KhTWYI+HEmU+tYzVhUjq69UyW302HuCffBRcd6utgkHh947wRtU1N0UOxdgQybWJsQ
	 e19O35kkV9h6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/4] mptcp: initialize and release mptcp_pm_ops
Date: Fri,  7 Feb 2025 17:29:34 +0800
Message-ID: <1a5446abf3d1d4d16074f5bb801f93e720228d32.1738919954.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738919954.git.tanggeliang@kylinos.cn>
References: <cover.1738919954.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add a struct mptcp_pm_ops pointer "ops" in struct mptcp_pm_data, and two
functions mptcp_pm_initialize() and mptcp_pm_release(), to set and release
this pointer. mptcp_pm_initialize() is invoked in mptcp_pm_data_reset(),
while mptcp_pm_release() is invoked in __mptcp_destroy_sock().

In this way, different userspace path managers can be initialized through
the pm_type sysctl, and then called into their respective interfaces
through "ops" of "msk->pm".

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c           | 49 ++++++++++++++++++++++++++++++++++++++--
 net/mptcp/pm_netlink.c   | 11 ++++++++-
 net/mptcp/pm_userspace.c | 28 +++++++++++++++++------
 net/mptcp/protocol.c     | 10 +++++++-
 net/mptcp/protocol.h     |  3 +++
 5 files changed, 90 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 1304a0c99e12..91c815856d14 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -76,6 +76,9 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, const struct sock *ssk, int
 
 	WRITE_ONCE(pm->server_side, server_side);
 	mptcp_event(MPTCP_EVENT_CREATED, msk, ssk, GFP_ATOMIC);
+
+	if (pm->ops && pm->ops->created)
+		pm->ops->created(msk);
 }
 
 bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk)
@@ -153,16 +156,24 @@ void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock *ssk)
 	msk->pm.status |= BIT(MPTCP_PM_ALREADY_ESTABLISHED);
 	spin_unlock_bh(&pm->lock);
 
-	if (announce)
+	if (announce) {
 		mptcp_event(MPTCP_EVENT_ESTABLISHED, msk, ssk, GFP_ATOMIC);
+
+		if (pm->ops && pm->ops->established)
+			pm->ops->established(msk);
+	}
 }
 
 void mptcp_pm_connection_closed(struct mptcp_sock *msk)
 {
 	pr_debug("msk=%p\n", msk);
 
-	if (msk->token)
+	if (msk->token) {
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
+
+		if (msk->pm.ops && msk->pm.ops->closed)
+			msk->pm.ops->closed(msk);
+	}
 }
 
 void mptcp_pm_subflow_established(struct mptcp_sock *msk)
@@ -629,6 +640,10 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->work_pending, 0);
 		WRITE_ONCE(pm->accept_addr, 0);
 		WRITE_ONCE(pm->accept_subflow, 0);
+
+		rcu_read_lock();
+		mptcp_pm_initialize(msk, mptcp_pm_find(pm_type));
+		rcu_read_unlock();
 	}
 
 	WRITE_ONCE(pm->addr_signal, 0);
@@ -704,3 +719,33 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm)
 	list_del_rcu(&pm->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm)
+{
+	if (!pm)
+		return -EINVAL;
+
+	if (!bpf_try_module_get(pm, pm->owner))
+		return -EBUSY;
+
+	msk->pm.ops = pm;
+	if (msk->pm.ops->init)
+		msk->pm.ops->init(msk);
+
+	pr_debug("userspace_pm type %u initialized\n", msk->pm.ops->type);
+	return 0;
+}
+
+void mptcp_pm_release(struct mptcp_sock *msk)
+{
+	struct mptcp_pm_ops *pm = msk->pm.ops;
+
+	if (!pm)
+		return;
+
+	msk->pm.ops = NULL;
+	if (pm->release)
+		pm->release(msk);
+
+	bpf_module_put(pm, pm->owner);
+}
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ef85a60151ad..91f01f895e18 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1080,6 +1080,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
+	struct mptcp_sock *msk;
 	int backlog = 1024;
 	int err;
 
@@ -1104,8 +1105,9 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
 				      &mptcp_keys[is_ipv6]);
 
+	msk = mptcp_sk(newsk);
 	lock_sock(newsk);
-	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
+	ssk = __mptcp_nmpc_sk(msk);
 	release_sock(newsk);
 	if (IS_ERR(ssk))
 		return PTR_ERR(ssk);
@@ -1136,6 +1138,13 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (!err)
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
 	release_sock(ssk);
+
+	if (!err) {
+		lock_sock(newsk);
+		if (msk->pm.ops && msk->pm.ops->listener_created)
+			msk->pm.ops->listener_created(msk);
+		release_sock(newsk);
+	}
 	return err;
 }
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 3d324aaec550..74406f8cc4cf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -159,7 +159,9 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	if (new_entry.addr.port == msk_sport)
 		new_entry.addr.port = 0;
 
-	return userspace_pm_get_local_id(msk, &new_entry);
+	return msk->pm.ops && msk->pm.ops->get_local_id ?
+	       msk->pm.ops->get_local_id(msk, &new_entry) :
+	       userspace_pm_get_local_id(msk, &new_entry);
 }
 
 static bool userspace_pm_get_priority(struct mptcp_sock *msk,
@@ -179,7 +181,9 @@ static bool userspace_pm_get_priority(struct mptcp_sock *msk,
 bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 				  struct mptcp_addr_info *skc)
 {
-	return userspace_pm_get_priority(msk, skc);
+	return msk->pm.ops && msk->pm.ops->get_priority ?
+	       msk->pm.ops->get_priority(msk, skc) :
+	       userspace_pm_get_priority(msk, skc);
 }
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
@@ -264,7 +268,9 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_address_announced(msk, &addr_val);
+	err = msk->pm.ops && msk->pm.ops->address_announced ?
+	      msk->pm.ops->address_announced(msk, &addr_val) :
+	      userspace_pm_address_announced(msk, &addr_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR(info->extack, addr,
@@ -364,7 +370,9 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 	sk = (struct sock *)msk;
 
 	lock_sock(sk);
-	err = userspace_pm_address_removed(msk, id_val);
+	err = msk->pm.ops && msk->pm.ops->address_removed ?
+	      msk->pm.ops->address_removed(msk, id_val) :
+	      userspace_pm_address_removed(msk, id_val);
 	release_sock(sk);
 	if (err)
 		NL_SET_ERR_MSG_ATTR_FMT(info->extack, id,
@@ -445,7 +453,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_established(msk, &entry, &addr_r);
+	err = msk->pm.ops && msk->pm.ops->subflow_established ?
+	      msk->pm.ops->subflow_established(msk, &entry, &addr_r) :
+	      userspace_pm_subflow_established(msk, &entry, &addr_r);
 	release_sock(sk);
 
 	if (err)
@@ -580,7 +590,9 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	}
 
 	lock_sock(sk);
-	err = userspace_pm_subflow_closed(msk, &addr_l, &addr_r);
+	err = msk->pm.ops && msk->pm.ops->subflow_closed ?
+	      msk->pm.ops->subflow_closed(msk, &addr_l, &addr_r) :
+	      userspace_pm_subflow_closed(msk, &addr_l, &addr_r);
 	release_sock(sk);
 	if (err)
 		GENL_SET_ERR_MSG(info, "subflow not found");
@@ -652,7 +664,9 @@ int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
 	}
 
 	lock_sock(sk);
-	ret = userspace_pm_set_priority(msk, local, &rem);
+	ret = msk->pm.ops && msk->pm.ops->set_priority ?
+	      msk->pm.ops->set_priority(msk, local, &rem) :
+	      userspace_pm_set_priority(msk, local, &rem);
 	release_sock(sk);
 
 	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2b48cf648346..3bfb4c786289 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2944,6 +2944,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stop_timer(sk, &sk->sk_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
+	mptcp_pm_release(msk);
 
 	sk->sk_prot->destroy(sk);
 
@@ -2967,13 +2968,14 @@ static __poll_t mptcp_check_readable(struct sock *sk)
 
 static void mptcp_check_listen_stop(struct sock *sk)
 {
+	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sock *ssk;
 
 	if (inet_sk_state_load(sk) != TCP_LISTEN)
 		return;
 
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-	ssk = mptcp_sk(sk)->first;
+	ssk = msk->first;
 	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
 		return;
 
@@ -2983,6 +2985,9 @@ static void mptcp_check_listen_stop(struct sock *sk)
 	inet_csk_listen_stop(ssk);
 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
 	release_sock(ssk);
+
+	if (msk->pm.ops && msk->pm.ops->listener_closed)
+		msk->pm.ops->listener_closed(msk);
 }
 
 bool __mptcp_close(struct sock *sk, long timeout)
@@ -3802,6 +3807,9 @@ static int mptcp_listen(struct socket *sock, int backlog)
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 		mptcp_copy_inaddrs(sk, ssk);
 		mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CREATED);
+
+		if (msk->pm.ops && msk->pm.ops->listener_created)
+			msk->pm.ops->listener_created(msk);
 	}
 
 unlock:
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 79cd10447b7b..ba5f0abb6d8b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -221,6 +221,7 @@ struct mptcp_pm_data {
 	struct mptcp_addr_info remote;
 	struct list_head anno_list;
 	struct list_head userspace_pm_local_addr_list;
+	struct mptcp_pm_ops *ops;
 
 	spinlock_t	lock;		/*protects the whole PM data */
 
@@ -1052,6 +1053,8 @@ struct mptcp_pm_ops *mptcp_pm_find(enum mptcp_pm_type type);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm);
 int mptcp_pm_register(struct mptcp_pm_ops *pm);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm);
+int mptcp_pm_initialize(struct mptcp_sock *msk, struct mptcp_pm_ops *pm);
+void mptcp_pm_release(struct mptcp_sock *msk);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

