Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9AE171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676979; cv=none; b=L2TK05FF69seShjyN+ReiBBThwdhKL58V3V1Sc5d5sTMGfDbdle1wWVOb2MI9js4QHdWxYzr19dvur+grxCBBnF43BVme2ZCcEDH6/XXJy6P6uEf+iXDYWOOZNAWh880hYCV5rpjp9AVfpdebJQk9RyPIeUD6yNIjbI5HO9LGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676979; c=relaxed/simple;
	bh=D8/2W8TEqTlnYbeJtESGqmOUdofeKNTwfGYnPnZXBdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYidNbg3VRuwtJNtPBxzSWov/wUoxWCy/0plcccGM8FectcpW4ZKBS88jJkti1YYEdWQ5KAonvUYRhLQ6F99xX86aJ3NW95XO0ehf+RDjYHcxblyQ/qEWijkbPtIE/BKrvjal6eXUlIPjx6F9B1DY7uxitDH+XOsos0xUcgWD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/AxSRaF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/AxSRaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC7AC116B1;
	Mon, 22 Jul 2024 19:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676979;
	bh=D8/2W8TEqTlnYbeJtESGqmOUdofeKNTwfGYnPnZXBdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s/AxSRaFdullc+MSy30grmPIREofNN+XDxS0MLV298ZBvksEJ5QebIEh6sC6c0M9+
	 rNl1yJ09etE8Nfadc2Eq1KAXBHIQVG+P08J4UxLX3s7CZakj69dTV3XexfgDHUD9iz
	 brQwcJZDiXKkad6AwUDvw8U783KPMrcKTd9fePPBWp1F5E1TIFyEsyKIdG4JglkzZy
	 SsAUc/Gyb8vDIjip5lKRrID8U2xAUMu/6HgkEOYo9zYXB4D1uALnxnxdjQBDe1yJhX
	 iokQ9/5TFVjhakINxWbhFxGcJAVhbCLetY/e8l+XmPiw7zyI/areYIkV1RNLQqVqkS
	 6AOhR6uCV1N2A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:36:01 +0200
Subject: [PATCH mptcp-net v4 23/23] mptcp: pm: reduce entries iterations on
 connect
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-23-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11395; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=D8/2W8TEqTlnYbeJtESGqmOUdofeKNTwfGYnPnZXBdY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXpXQxWM2lGju0DdDSZWNh38m80MRUa6fev
 +fVkLgKg/WJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c1hHEACgA7xDP3PyM4Kio4LTEzUE00OAS4UE7ljsDykyqWmE79iP6VgsAsH3xeXNgX4Gfj/fc4f
 ygqaGnkwrbzpaN4Ug/Ee0v0brCzmTWzt41h0UoFvzBl6KlHGZ2DWPUARVriCokvbjBsWGruC4Iz
 UdhcRCNNgVpqnvXDB0Pg5mcxuj3OI0CKQ4eRJHKE4S7V+LrXjCRKICZDHAvID4Mt/aPffKi+M/e
 hrjWGaFIN4XRKJzPWw9T+7lPhCl33tZgUPnubv+4nNsikonRc1ER2EG6eZRIbvuOndyowpEpZo5
 n5fgaHuX+0pRtTtEvoqiY7pNZxv5RCTokVwnzMS+o5Ecx6bwy5DJZhvuHg0+vyI38iPoT3V/HrE
 j5TTSXu7yTwCRqpY5pfXQf4HBdr5KgeL81xp+gHTC/yZk4r1NiIWTCgXXGPZBQYzK0B/HaFN8NO
 XqLfz2PHXbfsNlgGHBcx+phx8qNQ+fsCcnhvucCiELb0QXRpxwFqhuOtTvl7qQJTp+i7Vy3F4ci
 n2niT9RiCgVBlfzoEGOLGnxePQD86T/NhS6QN319mXnmGTLOZ5M2GSJvS7u5RMsnjLSOti1tM8y
 +VUi9rvHd7R4wVFy9DSQ8ySFpPgxGOpwaDBynxyvektNo13zigg+l5zbK/iQWZJh29NRMbFzEQD
 C9t8r5EN+swx79A==
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
---
 net/mptcp/pm.c           | 11 -----------
 net/mptcp/pm_netlink.c   | 48 ++++++++++++------------------------------------
 net/mptcp/pm_userspace.c | 19 +------------------
 net/mptcp/protocol.h     | 10 +---------
 net/mptcp/subflow.c      | 29 ++++++++++++++++++-----------
 5 files changed, 32 insertions(+), 85 deletions(-)

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
index 45a1aa0a40bf..a316951f8762 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -625,7 +625,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
@@ -646,7 +646,7 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
  */
 static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 					     struct mptcp_addr_info *remote,
-					     struct mptcp_addr_info *addrs)
+					     struct mptcp_pm_addr_entry *entries)
 {
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
@@ -670,14 +670,14 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 			continue;
 
 		if (msk->pm.subflows < subflows_max) {
-			msk->pm.subflows++;
-			addrs[i] = entry->addr;
+			memcpy(&entries[i], entry, sizeof(entries[i]));
 
 			/* Special case for ID0: set the correct ID */
 			if (msk->first &&
 			    mptcp_addresses_equal(&entry->addr, &mpc_addr, entry->addr.port))
-				addrs[i].id = 0;
+				entries[i].addr.id = 0;
 
+			msk->pm.subflows++;
 			i++;
 		}
 	}
@@ -687,21 +687,19 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 	 * 'IPADDRANY' local address
 	 */
 	if (!i) {
-		struct mptcp_addr_info local;
-
-		memset(&local, 0, sizeof(local));
-		local.family =
+		memset(&entries[i], 0, sizeof(entries[i]));
+		entries[i].addr.family =
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 			       remote->family == AF_INET6 &&
 			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
 #endif
 			       remote->family;
 
-		if (!mptcp_pm_addr_families_match(sk, &local, remote))
+		if (!mptcp_pm_addr_families_match(sk, &entries[i].addr, remote))
 			return 0;
 
 		msk->pm.subflows++;
-		addrs[i++] = local;
+		i++;
 	}
 
 	return i;
@@ -709,7 +707,7 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 {
-	struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
+	struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
 	struct sock *sk = (struct sock *)msk;
 	unsigned int add_addr_accept_max;
 	struct mptcp_addr_info remote;
@@ -738,13 +736,13 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
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
 
@@ -1395,28 +1393,6 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
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
 

-- 
2.45.2

