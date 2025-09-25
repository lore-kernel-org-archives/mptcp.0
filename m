Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02E8488
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790493; cv=none; b=lKiWdOxF8kaOl/jgGr0g3z2H0mzhujJjITSzFoeHYvfIFmG/QzUfRtqAlu1IZSfglcd+3ljATlbjCaM8xRA7XAYyMH/YAx0SxMfwTMhdw5iOjq/bs9eUar1KLrQd5ptTQoNmsWOfWI2ajwpiXH1o4uzXDpNDhjnFBgnXgCdUEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790493; c=relaxed/simple;
	bh=OG9cGHp+r6+ZKuJnHxW7/GVZjSKS1Agaf2/cx2sOUf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJsP6TQ3eT912H21JKdytAq/NzeJMRLiPBHfUe6WD0RyPDGjlayZozlENouuom0uDdnuPXAF4CiOeDO94XkyiTWphRnRIoJDiOVSlV9UhAdj9hSwswgE/BwxkntuPUrmW6vFupyMW7mTJpp75o6Dxq+kb6TJjvtJzHIYo5FTJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC3f3G/B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC3f3G/B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C07FC4CEF0;
	Thu, 25 Sep 2025 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758790493;
	bh=OG9cGHp+r6+ZKuJnHxW7/GVZjSKS1Agaf2/cx2sOUf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XC3f3G/Be7WK2vrA7GyTE12iVmUn2y0jDnc2Foamd3uxmhTllvGNyibAZryZ9yRgf
	 Mf1QcpFqGnF9Y5+YfceBuSUt8MumwgnLTT4Kob61dO/RPkwhE8lINGenaBvrkQPMpU
	 NoAjZwU/rR14Re0wf5UXhWWnCldUbY/QmKKjXWgH4mbJAVcREAkiDpT2uB/k9MZ3OQ
	 yza89BJuCnaWEmEXNS4qMjUESo0wf/L+gVXCBg1qgnJixWg40UyN0SNwucz/Sd7jK7
	 1Mp7c1ts59dFVOrVRmViS0CwcOVlLTiJaNcjEBPvT50/kiFdOiqx5EA3bI5mh2jm5u
	 93t7wUBLDRPtA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 10:54:21 +0200
Subject: [PATCH mptcp-next v3 5/6] mptcp: pm: in-kernel: add laminar
 endpoints
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-pm-kern-endp-add_addr-new-v3-5-1697a14ffa7d@kernel.org>
References: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
In-Reply-To: <20250925-pm-kern-endp-add_addr-new-v3-0-1697a14ffa7d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9447; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OG9cGHp+r6+ZKuJnHxW7/GVZjSKS1Agaf2/cx2sOUf0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuMofufLh9b8nyareZzDlvry2LeXj0ydWItNlF79pNY
 +ebXe5z7ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhIxldGhoV9yx/7qf3kqAzk
 MPD4Iqpjp/t73fyL74r8E2IdLl9J+sLI8I/nKZ/2tRWRP5KW51Q5TJs0XfRC6MNZTzsuvdmYoCA
 5jQkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, upon the reception of an ADD_ADDR (and when the fullmesh flag
is not used), the in-kernel PM will create new subflows using the local
address the routing configuration will pick.

It would be easier to pick local addresses from a selected list of
endpoints, and use it only once, than relying on routing rules.

Use case: both the client (C) and the server (S) have two addresses (a
and b). The client establishes the connection between C(a) and S(a).
Once established, the server announces its additional address S(b). Once
received, the client connects to it using its second address C(b).
Compared to a situation without the 'laminar' endpoint for C(b), the
client didn't use this address C(b) to establish a subflow to the
server's primary address S(a). So at the end, we have:

   C        S
  C(a) --- S(a)
  C(b) --- S(b)

In case of a 3rd address on each side (C(c) and S(c)), upon the
reception of an ADD_ADDR with S(c), the client should not pick C(b)
because it has already been used. C(c) should then be used.

Note that this situation is currently possible if C doesn't add any
endpoint, but configure the routing in order to pick C(b) for the route
to S(b), and pick C(c) for the route to S(c). That doesn't sound very
practical because it means knowing in advance the IP addresses that
will be used and announced by the server.

'laminar', like the idea of laminar flows: the different subflows don't
mix with each other on an endpoint, unlike the "turbulent" way traffic
is mixed by 'fullmesh'.

In the code, the new endpoint type is added. Similar to the other
subflow types, an MPTCP_INFO counter is added. While at it, hole are now
commented in struct mptcp_info, to remember next time that these holes
can no longer be used.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/503
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
 - rename var and function names to state 1 address will be filled (Mat)
v3:
 - rename 'address' -> 'laminar' (Mat)
 - use subflow_get_local_id() to be on the safe side.
---
 include/uapi/linux/mptcp.h |  6 +++-
 net/mptcp/pm_kernel.c      | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h       |  1 +
 net/mptcp/sockopt.c        |  2 ++
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 5ec996977b3fa2351222e6d01b814770b34348e9..87cfab874e2415d88c98f17e5562b0440feafaab 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -39,6 +39,7 @@
 #define MPTCP_PM_ADDR_FLAG_BACKUP		_BITUL(2)
 #define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
 #define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
+#define MPTCP_PM_ADDR_FLAG_LAMINAR		_BITUL(5)
 
 struct mptcp_info {
 	__u8	mptcpi_subflows;
@@ -51,6 +52,7 @@ struct mptcp_info {
 	#define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
 	__u8	mptcpi_add_addr_accepted_max;
 	#define mptcpi_limit_add_addr_accepted mptcpi_add_addr_accepted_max
+	/* 16-bit hole that can no longer be filled */
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
 	__u64	mptcpi_write_seq;
@@ -60,13 +62,15 @@ struct mptcp_info {
 	__u8	mptcpi_local_addr_max;
 	#define mptcpi_endp_subflow_max mptcpi_local_addr_max
 	__u8	mptcpi_csum_enabled;
+	/* 8-bit hole that can no longer be filled */
 	__u32	mptcpi_retransmits;
 	__u64	mptcpi_bytes_retrans;
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
 	__u8	mptcpi_subflows_total;
-	__u8	reserved[3];
+	__u8	mptcpi_endp_laminar_max;
+	__u8	reserved[2];
 	__u32	mptcpi_last_data_sent;
 	__u32	mptcpi_last_data_recv;
 	__u32	mptcpi_last_ack_recv;
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 116d62ed86f78b0242a33a67f77ff875ba00ae30..fde88e3e134151bf57e26a1924b4843e44b8bfb5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -21,6 +21,7 @@ struct pm_nl_pernet {
 	u8			endpoints;
 	u8			endp_signal_max;
 	u8			endp_subflow_max;
+	u8			endp_laminar_max;
 	u8			limit_add_addr_accepted;
 	u8			limit_extra_subflows;
 	u8			next_id;
@@ -61,6 +62,14 @@ u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk)
 }
 EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_subflow_max);
 
+u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+
+	return READ_ONCE(pernet->endp_laminar_max);
+}
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_laminar_max);
+
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk)
 {
 	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
@@ -453,6 +462,66 @@ fill_local_addresses_vec_fullmesh(struct mptcp_sock *msk,
 	return i;
 }
 
+static unsigned int
+fill_local_laminar_endp(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
+			struct mptcp_pm_local *locals)
+{
+	struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
+	DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry *entry;
+	struct mptcp_pm_local *local;
+	int found = 0;
+
+	/* Forbid creation of new subflows matching existing ones, possibly
+	 * already created by 'subflow' endpoints
+	 */
+	bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if ((1 << inet_sk_state_load(ssk)) &
+		    (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING |
+		     TCPF_CLOSE))
+			continue;
+
+		__set_bit(subflow_get_local_id(subflow), unavail_id);
+	}
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->endp_list, list) {
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_LAMINAR))
+			continue;
+
+		if (!mptcp_pm_addr_families_match(sk, &entry->addr, remote))
+			continue;
+
+		if (test_bit(mptcp_endp_get_local_id(msk, &entry->addr),
+			     unavail_id))
+			continue;
+
+		local = &locals[0];
+		local->addr = entry->addr;
+		local->flags = entry->flags;
+		local->ifindex = entry->ifindex;
+
+		if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
+			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+
+			if (local->addr.id != msk->mpc_endpoint_id)
+				msk->pm.local_addr_used++;
+		}
+
+		msk->pm.extra_subflows++;
+		found = 1;
+		break;
+	}
+	rcu_read_unlock();
+
+	return found;
+}
+
 static unsigned int
 fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
 				struct mptcp_addr_info *remote,
@@ -527,6 +596,10 @@ fill_local_addresses_vec(struct mptcp_sock *msk, struct mptcp_addr_info *remote,
 	if (i)
 		return i;
 
+	/* If there is at least one MPTCP endpoint with a laminar flag */
+	if (mptcp_pm_get_endp_laminar_max(msk))
+		return fill_local_laminar_endp(msk, remote, locals);
+
 	/* Special case: peer sets the C flag, accept one ADD_ADDR if default
 	 * limits are used -- accepting no ADD_ADDR -- and use subflow endpoints
 	 */
@@ -702,6 +775,10 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		addr_max = pernet->endp_subflow_max;
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max + 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_LAMINAR) {
+		addr_max = pernet->endp_laminar_max;
+		WRITE_ONCE(pernet->endp_laminar_max, addr_max + 1);
+	}
 
 	pernet->endpoints++;
 	if (!entry->addr.port)
@@ -1096,6 +1173,10 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		addr_max = pernet->endp_subflow_max;
 		WRITE_ONCE(pernet->endp_subflow_max, addr_max - 1);
 	}
+	if (entry->flags & MPTCP_PM_ADDR_FLAG_LAMINAR) {
+		addr_max = pernet->endp_laminar_max;
+		WRITE_ONCE(pernet->endp_laminar_max, addr_max - 1);
+	}
 
 	pernet->endpoints--;
 	list_del_rcu(&entry->list);
@@ -1178,6 +1259,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
+	WRITE_ONCE(pernet->endp_laminar_max, 0);
 	pernet->endpoints = 0;
 }
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 027d717ef7cffe150f8de7b3b404916a1899537a..a574d112ce371fa72847cfab626d623e1f21608b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1179,6 +1179,7 @@ void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_endp_subflow_max(const struct mptcp_sock *msk);
+u8 mptcp_pm_get_endp_laminar_max(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_add_addr_accepted(const struct mptcp_sock *msk);
 u8 mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 92a2a274262732a345b9ab185efd7da1f0a5773a..a28a483858852b49966b904a2f0dd44d8d118b5e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -980,6 +980,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 		info->mptcpi_endp_subflow_max =
 			mptcp_pm_get_endp_subflow_max(msk);
+		info->mptcpi_endp_laminar_max =
+			mptcp_pm_get_endp_laminar_max(msk);
 	}
 
 	if (__mptcp_check_fallback(msk))

-- 
2.51.0

