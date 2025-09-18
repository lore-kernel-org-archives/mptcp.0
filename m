Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D221FF3F
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217365; cv=none; b=rxHzu+011nEntulvmvcRoKe9KUIhOcuNFYLH4hPH0mL+0agE1uyALZ3P3p5xv8kFCXWGO9JYbzYxyKM8EtN98RCYbj0onAe+U4N/Fg+mLxHsFK6iiW18Qq6drpAQFGtpKLfJcBLSC4InOrNWVSWxRGGifvbFhdSI3kZHy7O7JHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217365; c=relaxed/simple;
	bh=O6JCHoODZlgZU+9IqAqR2XDdhlzpoBQ4m+mgbv+5kG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNjsJ9apOfAWEnsolXpm5oj39IIh7jS3tNovOg05zVH77GLn9XUHPBFcIA32SuTiG0zwrrpOxmhJMPEgXQuXAnxGN0r9h+htlqtZMCQbxQiJGIqHW6QbHjOUapkIUfb+edPyyvsAhF/IjnfRKuRaBmJGr6PHt4CD68zFarcHwE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHWA/jXd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHWA/jXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8BEC4CEE7;
	Thu, 18 Sep 2025 17:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217364;
	bh=O6JCHoODZlgZU+9IqAqR2XDdhlzpoBQ4m+mgbv+5kG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UHWA/jXdrAWrkr2kjQrQ27R7xGpjx4GMepXxPcX49TKtk3T4JY7bAg2A6Hoa8V/sh
	 gRn5UWMskpsKLDEAS1p4j/IbRbaYl9mo9gHp+s9c82lYwLJfEdDQQtTSfjdS4Q6nqY
	 9kBwNow76nENMRAquW9j10lz4TOVEw4lioa5j8pgE+a4+olhwHWf89uXwiBKwHvqvA
	 0hlzzLaIJa4BH/ZwW1itq104wVKhsskDjbYT5PpB3emtpadv2GCGSY185skwlhdIo7
	 t3aVRGJkEcMGfhx/tdjAr6P+YnO0JISl/yoXT6PoGP+dawBjeZX91j5J8fL2WL2EuT
	 6McU/n7xbdHTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 18 Sep 2025 19:42:18 +0200
Subject: [PATCH mptcp-next 02/10] mptcp: pm: in-kernel: refactor
 fill_local_addresses_vec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pm-kern-endp-add_addr-v1-2-e12e58770a11@kernel.org>
References: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
In-Reply-To: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7626; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O6JCHoODZlgZU+9IqAqR2XDdhlzpoBQ4m+mgbv+5kG8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuLQfFZ0zs7+La7o01+XCjPY183qt/N7t+bqw+9wnP
 a0gs7SlHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZt4CR4UTF4XoHUa05faFm
 K7vlut9XM+iKZz+9MylrveUTJo1jUYwMu82SLDbEXzlnEupWL7cjdvOba4vWT5ibf3br1TNvt9y
 8xA4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, C flag, any.

To remove one level of indentation, msk->pm.subflows >= subflows_max is
now checked upfront.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 182 ++++++++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h  |   3 +-
 2 files changed, 110 insertions(+), 75 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 277f81f38134d07918143331746a50bc316d81ca..5bdcfcc26308841c49375ce35205097f30592279 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -377,25 +377,20 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
 	mptcp_pm_create_subflow_or_signal_addr(msk);
 }
 
-/* Fill all the local addresses into the array addrs[],
- * and return the array size.
- */
-static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
-					     struct mptcp_addr_info *remote,
-					     struct mptcp_pm_local *locals)
+static unsigned int
+fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
+				  struct mptcp_addr_info *remote,
+				  struct mptcp_pm_local *locals,
+				  bool c_flag_case)
 {
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_addr_info mpc_addr;
-	struct pm_nl_pernet *pernet;
-	unsigned int subflows_max;
-	bool c_flag_case;
+	struct mptcp_pm_local *local;
 	int i = 0;
 
-	pernet = pm_nl_get_pernet_from_msk(msk);
-	subflows_max = mptcp_pm_get_subflows_max(msk);
-	c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
-
 	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
 
 	rcu_read_lock();
@@ -406,77 +401,116 @@ static unsigned int fill_local_addresses_vec(struct mptcp_sock *msk,
 		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
 			continue;
 
-		if (msk->pm.subflows < subflows_max) {
-			locals[i].addr = entry->addr;
-			locals[i].flags = entry->flags;
-			locals[i].ifindex = entry->ifindex;
+		local = &locals[i];
+		local->addr = entry->addr;
+		local->flags = entry->flags;
+		local->ifindex = entry->ifindex;
 
-			if (c_flag_case &&
-			    (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
-				__clear_bit(locals[i].addr.id,
-					    msk->pm.id_avail_bitmap);
+		if (c_flag_case && (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 
-			/* Special case for ID0: set the correct ID */
-			if (mptcp_addresses_equal(&locals[i].addr, &mpc_addr, locals[i].addr.port))
-				locals[i].addr.id = 0;
+		/* Special case for ID0: set the correct ID */
+		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+					  local->addr.port))
+			local->addr.id = 0;
 
-			msk->pm.subflows++;
-			i++;
-		}
+		msk->pm.subflows++;
+		i++;
+
+		if (msk->pm.subflows >= subflows_max)
+			break;
 	}
 	rcu_read_unlock();
 
+	return i;
+}
+
+static unsigned int
+fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
+				struct mptcp_addr_info *remote,
+				struct mptcp_pm_local *locals)
+{
+	unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	unsigned int subflows_max = mptcp_pm_get_subflows_max(msk);
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_addr_info mpc_addr;
+	struct mptcp_pm_local *local;
+	int i = 0;
+
+	mptcp_local_address((struct sock_common *)msk, &mpc_addr);
+
+	while (msk->pm.local_addr_used < local_addr_max) {
+		local = &locals[i];
+
+		if (!select_local_address(pernet, msk, local))
+			break;
+
+		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+			continue;
+
+		if (mptcp_addresses_equal(&local->addr, &mpc_addr,
+					  local->addr.port))
+			continue;
+
+		msk->pm.local_addr_used++;
+		msk->pm.subflows++;
+		i++;
+
+		if (msk->pm.subflows >= subflows_max)
+			break;
+	}
+
+	return i;
+}
+
+static unsigned int
+fill_local_address_any(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
+		       struct mptcp_pm_local *local)
+{
+	struct sock *sk = (struct sock *)msk;
+
+	memset(local, 0, sizeof(*local));
+	local->addr.family =
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+			remote->family == AF_INET6 &&
+			ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
+#endif
+			remote->family;
+
+	if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
+		return 0;
+
+	msk->pm.subflows++;
+
+	return 1;
+}
+
+/* Fill all the local addresses into the array addrs[],
+ * and return the array size.
+ */
+static unsigned int
+fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
+			 struct mptcp_pm_local *locals)
+{
+	bool c_flag_case = remote->id && mptcp_pm_add_addr_c_flag_case(msk);
+	int i;
+
+	/* If there is at least one MPTCP endpoint with a fullmesh flag */
+	i = fill_local_addresses_vec_fullmesh(msk, remote, locals, c_flag_case);
+	if (i)
+		return i;
+
 	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
 	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
 	 */
-	if (!i && c_flag_case) {
-		unsigned int local_addr_max = mptcp_pm_get_local_addr_max(msk);
+	if (c_flag_case)
+		return fill_local_addresses_vec_c_flag(msk, remote, locals);
 
-		while (msk->pm.local_addr_used < local_addr_max &&
-		       msk->pm.subflows < subflows_max) {
-			struct mptcp_pm_local *local = &locals[i];
-
-			if (!select_local_address(pernet, msk, local))
-				break;
-
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
-
-			if (!mptcp_pm_addr_families_match(sk, &local->addr,
-							  remote))
-				continue;
-
-			if (mptcp_addresses_equal(&local->addr, &mpc_addr,
-						  local->addr.port))
-				continue;
-
-			msk->pm.local_addr_used++;
-			msk->pm.subflows++;
-			i++;
-		}
-
-		return i;
-	}
-
-	/* If the array is empty, fill in the single
-	 * 'IPADDRANY' local address
-	 */
-	if (!i) {
-		memset(&locals[i], 0, sizeof(locals[i]));
-		locals[i].addr.family =
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-			       remote->family == AF_INET6 &&
-			       ipv6_addr_v4mapped(&remote->addr6) ? AF_INET :
-#endif
-			       remote->family;
-
-		if (!mptcp_pm_addr_families_match(sk, &locals[i].addr, remote))
-			return 0;
-
-		msk->pm.subflows++;
-		i++;
-	}
-
-	return i;
+	/* No special case: fill in the single 'IPADDRANY' local address */
+	return fill_local_address_any(msk, remote, &locals[0]);
 }
 
 static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dd0662defd41c84474e44c559c571e3594b85d9e..0d6dae37c9daf4ec8990b9a87036aa393add585c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1200,7 +1200,8 @@ static inline bool mptcp_pm_add_addr_c_flag_case(struct mptcp_sock *msk)
 {
 	return READ_ONCE(msk->pm.remote_deny_join_id0) &&
 	       msk->pm.local_addr_used == 0 &&
-	       mptcp_pm_get_add_addr_accept_max(msk) == 0;
+	       mptcp_pm_get_add_addr_accept_max(msk) == 0 &&
+	       msk->pm.subflows < mptcp_pm_get_subflows_max(msk);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);

-- 
2.51.0

