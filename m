Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AA1CEACB
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272916; cv=none; b=bKbz5X+mvn2/3u6e0qjqE+buxBdNuoR6mZLIIG1EMy82x87HCNnrIwEDk6F3opGmI2UuWCuxCpnwGCGDF8MkIfSuy//zd+crsw97KVmkhJNcyekhbbSAxVLUVHpgJvASBX6KSzO6GhKtS9RvcQ2Q5RBfpVfvIX8uMJinVsFF3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272916; c=relaxed/simple;
	bh=GwIM/t1uRb2/iMd8ktrH9AiIj9tBrjuKDg2W46t/1gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRvR/IkJyfyHQokXB6IDFKSAJRDkYy7VuVxIEUP24MEjKjBj18xcbzi2sZN8X4afSmfWqU/FGHwlqUS7A5MephMHMtQloc2U836WcCQTesckox9zFqGo+eNBp1pYELFpj1ruTT9di6j5IRL8O6bzU/FyNQWNae8QREwvqtLFX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfwCCxRz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfwCCxRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E72C4CEF0;
	Fri, 19 Sep 2025 09:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272915;
	bh=GwIM/t1uRb2/iMd8ktrH9AiIj9tBrjuKDg2W46t/1gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EfwCCxRzRZTGcwJMRBlx0tf7JWuhbs6z3Gop9olRMQZHvLaAItmPeBY3awqqX269Y
	 aW2A8bYVLU4KovU3RCr9TaCfp37btcQZmZpn7D5V+vSEaAjt0BesH7zYyr/sWFagN7
	 1ovbHTR+xtZm1qTExwWwjCqz4EH/yblNsN9SO0FaJ2OKNp7wLEKnHmOVqFMNVQ7d2G
	 xhOUROdgQeKPe7VvG39jWAMdb12RtMWubVb5YgblGWnT58u+S0z8IvWv5xIKoOVssb
	 r5+nP7+cD+wETE1BobJg9NYd9mGQ1qpInsy4H+HRPSUvcyOlKopsaI/XpWZeEPJEG1
	 uwJRvwatolF9g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 19 Sep 2025 11:08:08 +0200
Subject: [PATCH mptcp-next v2 02/10] mptcp: pm: in-kernel: refactor
 fill_local_addresses_vec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-pm-kern-endp-add_addr-v2-2-1f8f04f01914@kernel.org>
References: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
In-Reply-To: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6901; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GwIM/t1uRb2/iMd8ktrH9AiIj9tBrjuKDg2W46t/1gs=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGjNHYSgqeaU5UIxCEuC7MYI7I1dA/+wN79iIyVHe7vo/RbzN
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmjNHYQACgkQfCLwwvNHCpcJ3AEA1cfx
 hSAR6Q8/WPzx4m1RCw6B+f2OXaBVFeYCM6TCDe0A/0xs57CleYj0Y+E0Wfk8BL02CJZSAMvcJ4z
 gG4WjXSgE
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this modification, this function was quite long with many levels
of indentations.

Each case can be split in a dedicated function: fullmesh, C flag, any.

No functional changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: move modif in protocol.h to the parent commit (Geliang)
---
 net/mptcp/pm_kernel.c | 182 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 108 insertions(+), 74 deletions(-)

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

-- 
2.51.0

