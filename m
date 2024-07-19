Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854C1E871
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721399213; cv=none; b=USii/q/sRkTZARM5RGSZc2MvNGz/mjkpdKZgyV9Mk0Vo8tgEi8xKs6EVXx42oJLlE/6g7ZoEDzMYP+dsWkAxTmgYZYhx2HlXFEEyK9fFiXWppyzvoTtNgSmR7RgNNQnqvfjmqUbZazI3brkN1K+mqf/Rd7LpWb/j/DFCCFxCs14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721399213; c=relaxed/simple;
	bh=aJtTpoQwnYg9jlPE1xh0YSgaYOTxe1rgYadfQT1eDB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JCvOlxBrneqShC+F1Wh2k9Ir8KKLAaDaNkpYaKuxIoicK/Fr+SKBCgdWOcrBhEmd+zSullzIkKscX2HglUUDPq1Dbl5Qesov0bSBDqydvYJT1UFAVBWwa0H8vaaCAuiuDAqc0qVJxuE9NT3nBnOGSLNqkG+x1t4sylgqEfLDP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzHf6xBI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzHf6xBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC65C32782;
	Fri, 19 Jul 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721399212;
	bh=aJtTpoQwnYg9jlPE1xh0YSgaYOTxe1rgYadfQT1eDB4=;
	h=From:Date:Subject:To:Cc:From;
	b=hzHf6xBIHF42AHeG7wgDW7AeULknhPnNyM1wKEV3gqTirlUI+sfT6wti0LHdm0xSV
	 lalmkqD53Mxy61hYn1e1xS30RJiUw6/Cv2DBYWcnLcZ/W4QJ3mDOzWIM9fJozHAUZn
	 flCG+RLGrJRrEDvbjPVKrAMbwRUbcg4+USgreuSobTuMbtAaHpkZOKHWKNaAwUhe21
	 zrDJOfOjku8+aKEl+wsapeHFfoMAdOz/qAs/46TFNnU4fqmYexI35ampgm4u6FQNAi
	 p9TEIIByJtkUirXSxWEQf9kQqZly4ko98kc0o3gssw1B1p3zPnCnPvMfRzll1IaU3I
	 zzaD1ubC5OtIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Jul 2024 16:26:45 +0200
Subject: [PATCH mptcp-next] mptcp: pm: reduce entries iterations on connect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-mptcp-pm-refact-connect-v1-1-1027d648a65f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKR3mmYC/0WNWwqDMBREtyL3u4Gb+MJspfgR47UN1JgmMQji3
 hu0tF/DMI+zQyBvKIAsdvCUTDCLzYbfCtBPZR/EzJg9CBQVtrxjs4vaMTczT5PSkenFWsoqEGt
 sOhzGQUNeu5yb7Xy+wzWytEXor8zTe82w+C38WLI4SY3AP0klZV5sqqns6nagquIyldAfxwfSE
 MzXvgAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12911; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aJtTpoQwnYg9jlPE1xh0YSgaYOTxe1rgYadfQT1eDB4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmmnerpaZUcmmkXIJyyTOsp16SPm9OKPKWyr+OH
 NwL3zLJlGWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpp3qwAKCRD2t4JPQmmg
 c1RND/sE+qZ95Kt3t+YJWEHV4/3ahhkWGcgH7tGfj576lQ0WCvDZZgGLC8D2kEIBGBaU7d2rGny
 uJXSIGV/oRQKnGI2lOJrh9roijysHbY6anIcA8ignu22om1IVF+h5fuohVQ/LRSHDdlASrcNXKO
 cVG7hjlCNoRBiTjYVX002TxZjWJK9HovQ1ip6FQYORNSPM5WwHH7JZwIYUKmR/0SpkdfpV/7aEV
 K5s6lhwSQ9R6eDHXdA82uLTvj4EhW0pPQ7k9uPS3Ps/jqamQzb110Sv4PEHRUg4l11fKbaDJGbf
 aFux0vv/EnrSS/m5XRwnaL++TRJA86PowjIm6SVx5Ej5EUZQpgbW3Sy7vNXx3m0u4z+7nut1c+q
 cMAR/BZbeX4OYtHICZkkWMfUckAYHDy1gJGS+RdfIrJ+NPfU2RwaRFryse2WLJo6Ue+hArCaIXC
 FzKFofTJOZVNppdH79sYutzhw1tonoD9/AHAC+++h6FI5dbcnjr9/RsmRQowfOaOHfoav+WshDL
 g2aH/9XIqVVy2AFaJSBq+dJa/Zy+XaHYPH7Ut4q12Om2AAnUHBYY9wSK0koQKoMDyUs0t4vGyP9
 8wiQy6N2ZadSfad3VYvMz9+wxoRKc756UpdDb8TOQ+XOi5DxQOeRQaLbnw51EUR9ESjfgg+lQqA
 uJBrxw0PjQnJ6gg==
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
Based-on: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
---
 net/mptcp/pm.c           | 11 -----------
 net/mptcp/pm_netlink.c   | 51 +++++++++++++-----------------------------------
 net/mptcp/pm_userspace.c | 19 +-----------------
 net/mptcp/protocol.h     | 10 +---------
 net/mptcp/subflow.c      | 29 ++++++++++++++++-----------
 5 files changed, 34 insertions(+), 86 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index ddad51210971..54fabd386b04 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -416,17 +416,6 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, &skc_local);
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
index 1b0e1617e90a..9fed7c92e52b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -612,7 +612,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -633,8 +633,9 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_addr_info *addrs)
+					     struct mptcp_pm_addr_entry *entries)
 {
+	struct mptcp_pm_addr_entry new_entry;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info mpc_addr;
@@ -655,14 +656,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			msk->pm.subflows++;
-			addrs[i] = entry->addr;
+			memcpy(&new_entry, entry, sizeof(new_entry));
 
 			/* Special case for ID0: set the correct endpoint */
 			if (mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
-				addrs[i].id = 0;
+				new_entry.addr.id = 0;
 
-			i++;
+			msk->pm.subflows++;
+			entries[i++] = new_entry;
 		}
 	}
 	rcu_read_unlock();
@@ -671,21 +672,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
-		struct mptcp_addr_info local;
-
-		memset(&local, 0, sizeof(local));
-		local.family =
+		memset(&new_entry.addr, 0, sizeof(new_entry.addr));
+		new_entry.addr.family =
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			       remote->family == AF_INET6 &&
 			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
 #endif
 			       remote->family;
 
-		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+		if (!mptcp_pm_addr_families_match(sk, &new_entry.addr, remote))
 			return 0;
 
 		msk->pm.subflows++;
-		addrs[i++] = local;
+		entries[i++] = new_entry;
 	}
 
 	return i;
@@ -693,7 +692,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
@@ -722,13 +721,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	/* connect to the specified remote address, using whatever
 	 * local address the routing configuration will pick.
 	 */
-	nr = fill_local_addresses_vec(msk, &remote, addrs);
+	nr = fill_local_addresses_vec(msk, &remote, entries);
 	if (nr == 0)
 		return;
 
 	spin_unlock_bh(&msk->pm.lock);
 	for (i = 0; i < nr; i++)
-		if (__mptcp_subflow_connect(sk, &addrs[i], &remote) == 0)
+		if (__mptcp_subflow_connect(sk, &entries[i], &remote) == 0)
 			sf_created = true;
 	spin_lock_bh(&msk->pm.lock);
 
@@ -1379,28 +1378,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
index f0a4590506c6..97b09dffff6d 100644
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
@@ -394,7 +377,7 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	err = __mptcp_subflow_connect(sk, &local.addr, &addr_r);
+	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 
 	release_sock(sk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f2eb5273d752..259e247b0862 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -722,7 +722,7 @@ bool mptcp_addresses_equal(const struct mptcp_addr_info *a,
 void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
 			    const struct mptcp_addr_info *remote);
 int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 				struct socket **new_sock);
@@ -1015,14 +1015,6 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
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
index 39e2cbdf3801..0835e71118b9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1544,26 +1544,24 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 #endif
 }
 
-int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
+int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_addr_entry *local,
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
 
@@ -1573,23 +1571,32 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
 	} while (!subflow->local_nonce);
 
-	if (local_id)
+	/* if 'IPADDRANY', the ID will be set later, after the routing */
+	if (local->addr.family == AF_INET) {
+		if (!local->addr.addr.s_addr)
+			local_id = -1;
+#if IS_ENABLED(CONFIG_IPV6)
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
@@ -1600,7 +1607,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	subflow->remote_token = remote_token;
 	WRITE_ONCE(subflow->remote_id, remote_id);
 	subflow->request_join = 1;
-	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+	subflow->request_bkup = !!(local->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
 	subflow->subflow_id = msk->subflow_id++;
 	mptcp_info2sockaddr(remote, &addr, ssk->sk_family);
 

---
base-commit: 52d9822897dc3649af506ed28135dedf9cf8ba3f
change-id: 20240719-mptcp-pm-refact-connect-20050690bdbc
prerequisite-change-id: 20240620-mptcp-pm-avail-f5e3957be441:v3
prerequisite-patch-id: a804d4bf78954addfee863b9ae1b19ea01a7103f
prerequisite-patch-id: 1cbde162f714bd28430c4985fb701762e536021c
prerequisite-patch-id: 1cef710d16564a7f101184bbe9aaf1bb09d82743
prerequisite-patch-id: d05eb1ef921bac68264c994daced70f46e707868
prerequisite-patch-id: b7f76b3d50c14f862433d170fd48c30076da649b
prerequisite-patch-id: f1e8aab49982c3de4092b9940d5dca1586dabf7f
prerequisite-patch-id: 8ba292b3b2b681ba08dbfe22470ca01b9100c0f1
prerequisite-patch-id: 6b45b393a5341c38a1ebbdeb212989c7e53de3bb
prerequisite-patch-id: e5a410260d84101e6d099487545da0c9f19ff9d7
prerequisite-patch-id: 593236babe3ceb10d682f8a8e8acc8b095e98b58
prerequisite-patch-id: 7b94591f5d92cd183b3713f360eb29ca72d3c129
prerequisite-patch-id: 07ddff8eebd1cfc9db306546307eae5157451ded
prerequisite-patch-id: 55cc1b1f59a365757e4f0d23292479d4d12f1534
prerequisite-patch-id: c6ba8859f84b0b726cdf57fa5ebcbf83d82f949b
prerequisite-patch-id: a40ab15bd28a982b57f7bbc66564086a79e77070
prerequisite-patch-id: 2988a4bcdb5a53ef659c15924a3cbfc6888b55ac
prerequisite-patch-id: a5ea2de5eeaf719483e2fa7977afd94ba5fe507d
prerequisite-patch-id: 9b37053038fcb0e952f21cb39389e7446e11b02a
prerequisite-patch-id: 36b922942e9510b19c0c45646307c433049c756a
prerequisite-patch-id: a565fd838caf63e4474de807b04b7fcde2acdb62

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

