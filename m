Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B882168C7
	for <mptcp@lists.linux.dev>; Fri, 26 Jul 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722004144; cv=none; b=OGC6hsFXH3mc564yjel40yqWzGGe3AVksNo5cwWoxLfQC44iCjIes+iez1LK6x7iQ9lM1l6WjyWIeDSUp6wb2LYNEuYP+wYpT/J1fGQNwwC8LZETgIqy+0sz3+OS3C1u0jEio9xAz+4w6JnLDOXy5TOEro18rn8KVzQ9JUWK/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722004144; c=relaxed/simple;
	bh=ltDEPQl3Bb0mzx0mjYjXKhmDBtTJKwwcvGJxQ9wy/QA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClJXLQ6YGEzNdnjqoe+eqJAgyG94qE/rw0P0CiM0nv+icotsnyOjk1uHD2RVWp174PAsVvgsUJajEAHmnC3Z8Fh7t8BbD51kwcwgdHwJzmEtpkAxBIACV5S2U040ifv8b7TzgmK6JZhXIZjXkcFMmH8ngnMQvBB3ZBpVO5rBmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W81zLvgJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W81zLvgJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B944BC32786;
	Fri, 26 Jul 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722004143;
	bh=ltDEPQl3Bb0mzx0mjYjXKhmDBtTJKwwcvGJxQ9wy/QA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W81zLvgJNbU9zSilqzqSXR6/IFghI3K/AAyWMEfzKORY2hGTrjFV02S8oC9FVhM5a
	 DllPhQ1mptRMI49C9YGUEyBXCnj6eabgeQ0UK48A13IHZ3daLU8hqP8WXNZ9gSuoNP
	 O8xTvhtAGVmCkMKzJUEqbfxodGZPK9C7TVsG61CVP0PRX1YLArXPsfknZsWy00Vbmq
	 1JsqLch2s4QEkqL9d/RoTOMhjGwMlxwJGK3BZ/iFk/riIJhT7O+F5FQ2Lkh6u0U5MM
	 LgzmRF6Jkzg+DDAfXkF7wYCbaknZABy8NBDGH0gFdOxZBD4jdfWZCwpVYumIfvTmlU
	 LmqTMID3XIr/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Jul 2024 16:28:39 +0200
Subject: [PATCH mptcp-net v5 13/13] mptcp: pm: reduce entries iterations on
 connect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-mptcp-pm-avail-v5-13-fb1117ddeef6@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
In-Reply-To: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=16209; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ltDEPQl3Bb0mzx0mjYjXKhmDBtTJKwwcvGJxQ9wy/QA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmo7KcE7hmX9kQJQoY5K2IiN86WVTR+P4rmSdK5
 8Ht04vCnMWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqOynAAKCRD2t4JPQmmg
 cx95EACl2WeRtido4r0vhv/CvrRm+n/+eP1GG9qz1tS3VFZaCvvKZOF93NNerWRw92WrRyKXIfB
 Uem81ffsG8pjo/ArFHau2sW1ZpMk732GzZ+6IgumaOqCeXr00QHAy7bNfG0f+qKk+KKjMmnoQuM
 zdBEqwR2K8rh8zjUIO2GSuU3jIdZ0IRSlxy7BllkS3HBsaNOIuBflXuQrSHmBFyFBUmZ+ElTMGu
 JkO+L0/Qf6qjqRplyA0mLvDC9KRTsXslDhDwU8odmRK2BQ0O0pasHCbnDPyVV/bw0W/7sqZKSU7
 RRYWZAEO/H7MzhK9U/W9X6VwO0xwNJbK8Ri16x2WHPB2qmPNbVeD+f9ErpZz8TybhpNtjmqq5Xr
 ntKyajWx30XEf3sTj4rrdiiUsvjChN5XBr6L7Rkf9rm5CS8Sfj8lha9zIkFGTTHlCJcVFfI+fFu
 YhrHWPG77oHeveiI4SOHwbecuyNDP4U+h1aXvTRZMV/kGJTG8KDKAXFiIZhlOnn5Oct0wWeBUv/
 m2Umamhd2+aoCxeYwWQ3eoRH+tB1HMtO68EIxGtG380svOXK93ypqH3L8EKAKxIQsvVJsql5liN
 JPfHB4q1f6/vzxssqJjbhoJ4JopYaxe8nKep5bGloYRnoD7guvCKSVztOjbuh+GIj4vQ92mlI2B
 xmz+ao+K5t8oY7A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

__mptcp_subflow_connect() is currently called from the path-managers,
which have all the required information to create subflows. No need to
call the PM again to re-iterate over the list of entries with RCU lock
to get more info.

Instead, it is possible to pass a mptcp_pm_addr_entry structure, instead
of a mptcp_addr_info one. The former contains the ifindex and the flags
that are required when creating the new subflow.

This is a partial revert of commit ee285257a9c1 ("mptcp: drop flags and
ifindex arguments").

While at it, the local ID can also be set if it is known and 0, to avoid
having to set it in the 'rebuild_header' hook, which will cause a new
iteration of the endpoint entries.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - This patch is for net-next
 - v4:
   - Avoid multiple copies of an addr entry in
     fill_local_addresses_vec().
   - Rebased on top of "mptcp: fix endpoints with 'signal' and 'subflow'
     flags", v4.
 - v5:
   - Use CONFIG_MPTCP_IPV6 instead of CONFIG_IPV6 (Intel's Kernel robot)
   - Use new mptcp_pm_local struct, not to use mptcp_pm_addr_entry with
     only half of the info we need to reduce the memory reserved on the
     stack needed for the fill_*_addresses_vec() helpers to handle the
     fullmesh case. (Paolo)
     Note that we could also embed 'struct mptcp_pm_local' in 'struct
     mptcp_pm_addr_entry', but that means adapting that in quite a few
     places (171).
---
 net/mptcp/pm.c           | 11 --------
 net/mptcp/pm_netlink.c   | 66 ++++++++++++++++++------------------------------
 net/mptcp/pm_userspace.c | 40 ++++++++++-------------------
 net/mptcp/protocol.h     | 16 +++++-------
 net/mptcp/subflow.c      | 29 +++++++++++++--------
 5 files changed, 62 insertions(+), 100 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3e6e0f5510bb..56c0a318e5df 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -428,17 +428,6 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					 u8 *flags, int *ifindex)
-{
-	*flags = 0;
-	*ifindex = 0;
-
-	if (mptcp_pm_is_userspace(msk))
-		return mptcp_userspace_pm_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
-	return mptcp_pm_nl_get_flags_and_ifindex_by_id(msk, id, flags, ifindex);
-}
-
 int mptcp_pm_get_addr(struct sk_buff *skb, struct genl_info *info)
 {
 	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 53355f629846..469a16326b3f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -146,7 +146,7 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 static bool
 select_local_address(const struct pm_nl_pernet *pernet,
 		     const struct mptcp_sock *msk,
-		     struct mptcp_pm_addr_entry *new_entry)
+		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -161,7 +161,9 @@ select_local_address(const struct pm_nl_pernet *pernet,
 		if (!test_bit(entry->addr.id, msk->pm.id_avail_bitmap))
 			continue;
 
-		*new_entry = *entry;
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
 		found = true;
 		break;
 	}
@@ -172,7 +174,7 @@ select_local_address(const struct pm_nl_pernet *pernet,
 
 static bool
 select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
-		      struct mptcp_pm_addr_entry *new_entry)
+		     struct mptcp_pm_local *new_local)
 {
 	struct mptcp_pm_addr_entry *entry;
 	bool found = false;
@@ -190,7 +192,9 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		*new_entry = *entry;
+		new_local->addr = entry->addr;
+		new_local->flags = entry->flags;
+		new_local->ifindex = entry->ifindex;
 		found = true;
 		break;
 	}
@@ -521,11 +525,11 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
-	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
+	struct mptcp_pm_local local;
 	unsigned int subflows_max;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
@@ -624,7 +628,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -645,7 +649,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_addr_info *addrs)
+					     struct mptcp_pm_local *locals)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
@@ -669,14 +673,16 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			msk->pm.subflows++;
-			addrs[i] = entry->addr;
+			locals[i].addr = entry->addr;
+			locals[i].flags = entry->flags;
+			locals[i].ifindex = entry->ifindex;
 
 			/* Special case for ID0: set the correct ID */
 			if (msk->first &&
-			    mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
-				addrs[i].id = 0;
+			    mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
+				locals[i].addr.id = 0;
 
+			msk->pm.subflows++;
 			i++;
 		}
 	}
@@ -686,21 +692,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
-		struct mptcp_addr_info local;
-
-		memset(&local, 0, sizeof(local));
-		local.family =
+		memset(&locals[i], 0, sizeof(locals[i]));
+		locals[i].addr.family =
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			       remote->family == AF_INET6 &&
 			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
 #endif
 			       remote->family;
 
-		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
 			return 0;
 
 		msk->pm.subflows++;
-		addrs[i++] = local;
+		i++;
 	}
 
 	return i;
@@ -708,7 +712,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_local locals[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
@@ -737,13 +741,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, &remote, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, locals);
 	if (nr == 0)
 		return;
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+		if (__mptcp_subflow_connect(sk, &locals[i], &remote) == 0)
 			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
 
@@ -1412,28 +1416,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					    u8 *flags, int *ifindex)
-{
-	struct mptcp_pm_addr_entry *entry;
-	struct sock *sk = (struct sock *)msk;
-	struct net *net = sock_net(sk);
-
-	/* No entries with ID 0 */
-	if (id == 0)
-		return 0;
-
-	rcu_read_lock();
-	entry = __lookup_addr_by_id(pm_nl_get_pernet(net), id);
-	if (entry) {
-		*flags = entry->flags;
-		*ifindex = entry->ifindex;
-	}
-	rcu_read_unlock();
-
-	return 0;
-}
-
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8eaa9fbe3e34..2cceded3a83a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -119,23 +119,6 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
 	return NULL;
 }
 
-int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-						   unsigned int id,
-						   u8 *flags, int *ifindex)
-{
-	struct mptcp_pm_addr_entry *match;
-
-	spin_lock_bh(&msk->pm.lock);
-	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
-	spin_unlock_bh(&msk->pm.lock);
-	if (match) {
-		*flags = match->flags;
-		*ifindex = match->ifindex;
-	}
-
-	return 0;
-}
-
 int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 				    struct mptcp_addr_info *skc)
 {
@@ -352,8 +335,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *raddr = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *laddr = info->attrs[MPTCP_PM_ATTR_ADDR];
-	struct mptcp_pm_addr_entry local = { 0 };
+	struct mptcp_pm_addr_entry entry = { 0 };
 	struct mptcp_addr_info addr_r;
+	struct mptcp_pm_local local;
 	struct mptcp_sock *msk;
 	int err = -EINVAL;
 	struct sock *sk;
@@ -379,18 +363,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_entry(laddr, info, true, &local);
+	err = mptcp_pm_parse_entry(laddr, info, true, &entry);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
 
-	if (local.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
+	if (entry.flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
 		GENL_SET_ERR_MSG(info, "invalid addr flags");
 		err = -EINVAL;
 		goto create_err;
 	}
-	local.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
+	entry.flags |= MPTCP_PM_ADDR_FLAG_SUBFLOW;
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -398,27 +382,29 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	if (!mptcp_pm_addr_families_match(sk, &local.addr, &addr_r)) {
+	if (!mptcp_pm_addr_families_match(sk, &entry.addr, &addr_r)) {
 		GENL_SET_ERR_MSG(info, "families mismatch");
 		err = -EINVAL;
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &local, false);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
 	if (err < 0) {
 		GENL_SET_ERR_MSG(info, "did not match address and id");
 		goto create_err;
 	}
 
+	local.addr = entry.addr;
+	local.flags = entry.flags;
+	local.ifindex = entry.ifindex;
+
 	lock_sock(sk);
-
-	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
-
+	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
-		mptcp_userspace_pm_delete_local_addr(msk, &local);
+		mptcp_userspace_pm_delete_local_addr(msk, &entry);
 	else
 		msk->pm.subflows++;
 	spin_unlock_bh(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index fcf6983ca555..22b7eff311f5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -236,6 +236,12 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
+struct mptcp_pm_local {
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+};
+
 struct mptcp_pm_addr_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
@@ -723,7 +729,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 				struct socket **new_sock);
@@ -1016,14 +1022,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 struct mptcp_pm_add_entry *
 mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 				const struct mptcp_addr_info *addr);
-int mptcp_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-					 unsigned int id,
-					 u8 *flags, int *ifindex);
-int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int id,
-					    u8 *flags, int *ifindex);
-int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
-						   unsigned int id,
-						   u8 *flags, int *ifindex);
 int mptcp_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a21c712350c3..a7fb4d46e024 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1561,26 +1561,24 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 #endif
 }
 
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 			    const struct mptcp_addr_info *remote)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
+	int local_id = local->addr.id;
 	struct sockaddr_storage addr;
 	int remote_id = remote->id;
-	int local_id = loc->id;
 	int err = -ENOTCONN;
 	struct socket *sf;
 	struct sock *ssk;
 	u32 remote_token;
 	int addrlen;
-	int ifindex;
-	u8 flags;
 
 	if (!mptcp_is_fully_established(sk))
 		goto err_out;
 
-	err = mptcp_subflow_create_socket(sk, loc->family, &sf);
+	err = mptcp_subflow_create_socket(sk, local->addr.family, &sf);
 	if (err)
 		goto err_out;
 
@@ -1590,23 +1588,32 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
 	} while (!subflow->local_nonce);
 
-	if (local_id)
+	/* if 'IPADDRANY', the ID will be set later, after the routing */
+	if (local->addr.family == AF_INET) {
+		if (!local->addr.addr.s_addr)
+			local_id = -1;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	} else if (sk->sk_family == AF_INET6) {
+		if (ipv6_addr_any(&local->addr.addr6))
+			local_id = -1;
+#endif
+	}
+
+	if (local_id >= 0)
 		subflow_set_local_id(subflow, local_id);
 
-	mptcp_pm_get_flags_and_ifindex_by_id(msk, local_id,
-					     &flags, &ifindex);
 	subflow->remote_key_valid = 1;
 	subflow->remote_key = READ_ONCE(msk->remote_key);
 	subflow->local_key = READ_ONCE(msk->local_key);
 	subflow->token = msk->token;
-	mptcp_info2sockaddr(loc, &addr, ssk->sk_family);
+	mptcp_info2sockaddr(&local->addr, &addr, ssk->sk_family);
 
 	addrlen = sizeof(struct sockaddr_in);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	if (addr.ss_family == AF_INET6)
 		addrlen = sizeof(struct sockaddr_in6);
 #endif
-	ssk->sk_bound_dev_if = ifindex;
+	ssk->sk_bound_dev_if = local->ifindex;
 	err = kernel_bind(sf, (struct sockaddr *)&addr, addrlen);
 	if (err)
 		goto failed;
@@ -1617,7 +1624,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
-	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	subflow->subflow_id = msk->subflow_id++;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 

-- 
2.45.2

