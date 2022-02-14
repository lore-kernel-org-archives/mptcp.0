Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318BA25
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644853173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mXMsmFaXta3oWg5nuPCSVx577rlLT3nAIbkBlsoqENk=;
	b=JW1R/ZUIxVZcYEEoacLKoqer9ydUtE8YT6qRGGDXnJ0dB/QPGeUVrbPRqO7Omcvu01RPaF
	AEDBUP6qZCz251Jc++4hdpeI3HxhKcIoUQ8mEDl+84PoUGJcz3meKmL/E81nSco8uEuf7S
	GcsNm3e40Ql3CUuvGS0adrxx1BE2X2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-qpNBEFFdN7O4BnFBEixRNQ-1; Mon, 14 Feb 2022 10:39:26 -0500
X-MC-Unique: qpNBEFFdN7O4BnFBEixRNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D846B189DF41
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.152])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4C2E42B598
	for <mptcp@lists.linux.dev>; Mon, 14 Feb 2022 15:39:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 3/3] mptcp: strict local address ID selection.
Date: Mon, 14 Feb 2022 16:38:57 +0100
Message-Id: <f1aa3b81c1085855726c7b7b007dc29105bc5252.1644852970.git.pabeni@redhat.com>
In-Reply-To: <cover.1644852970.git.pabeni@redhat.com>
References: <cover.1644852970.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The address ID selection for MPJ subflows created in response
to incoming ADD_ADDR option is currently unreliable: it happens
at MPJ socket creation time, when the local address could be
unknown.

Additionally, if the no local endpoint is available for the local
address, a new dummy endpoint is created, confusing the user-land.

This change refactor the code to move the address ID seleciton inside
the rebuild_header() helper, when the local address eventually
selected by the route lookup is finally known. If the address used
is not mapped by any endpoint - and thus can't be advertised/removed
pick the id 0 instead of allocate a new endpoint.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 v3 -> v4:
- really create endpoints in mptcp_pm_get_local_id() - Mat

 v2 -> v3:
- keep creating dummy endpoint

 v1 -> v2:
- hopefully fix build issue with ipv6 disabled
- avoid looking-up multiple times the local_id for req sockets
- factor-out an helper for local_id initialization

RFC -> v1:
- don't bail if ID lookup fails, use 0 instead
---
 net/mptcp/pm_netlink.c | 13 --------
 net/mptcp/protocol.c   |  3 ++
 net/mptcp/protocol.h   |  3 +-
 net/mptcp/subflow.c    | 67 ++++++++++++++++++++++++++++++++++++------
 4 files changed, 63 insertions(+), 23 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 66cda3a425c4..3686d4c803b6 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -83,16 +83,6 @@ static bool addresses_equal(const struct mptcp_addr_info *a,
 	return a->port == b->port;
 }
 
-static bool address_zero(const struct mptcp_addr_info *addr)
-{
-	struct mptcp_addr_info zero;
-
-	memset(&zero, 0, sizeof(zero));
-	zero.family = addr->family;
-
-	return addresses_equal(addr, &zero, true);
-}
-
 static void local_address(const struct sock_common *skc,
 			  struct mptcp_addr_info *addr)
 {
@@ -1022,9 +1012,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
-	if (address_zero(&skc_local))
-		return 0;
-
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
 	rcu_read_lock();
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3324e1c61576..57caf470e500 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -117,6 +117,9 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+
+	/* This is the first subflow, always with id 0 */
+	subflow->local_id_valid = 1;
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a1ce1fd005ab..663b8d83154e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -453,7 +453,8 @@ struct mptcp_subflow_context {
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
-		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
+		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
+		local_id_valid : 1; /* local_id is correctly initialized */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b53b392dd280..283e5d57e003 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -481,6 +481,51 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_subflow_reset(sk);
 }
 
+static void subflow_set_local_id(struct mptcp_subflow_context *subflow, int local_id)
+{
+	subflow->local_id = local_id;
+	subflow->local_id_valid = 1;
+}
+
+static int subflow_chk_local_id(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	int err;
+
+	if (likely(subflow->local_id_valid))
+		return 0;
+
+	err = mptcp_pm_get_local_id(msk, (struct sock_common *)sk);
+	if (err < 0)
+		return err;
+
+	subflow_set_local_id(subflow, err);
+	return 0;
+}
+
+static int subflow_rebuild_header(struct sock *sk)
+{
+	int err = subflow_chk_local_id(sk);
+
+	if (unlikely(err < 0))
+		return err;
+
+	return inet_sk_rebuild_header(sk);
+}
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static int subflow_v6_rebuild_header(struct sock *sk)
+{
+	int err = subflow_chk_local_id(sk);
+
+	if (unlikely(err < 0))
+		return err;
+
+	return inet6_sk_rebuild_header(sk);
+}
+#endif
+
 struct request_sock_ops mptcp_subflow_request_sock_ops;
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops __ro_after_init;
 
@@ -1403,13 +1448,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
 	} while (!subflow->local_nonce);
 
-	if (!local_id) {
-		err = mptcp_pm_get_local_id(msk, (struct sock_common *)ssk);
-		if (err < 0)
-			goto failed;
-
-		local_id = err;
-	}
+	if (local_id)
+		subflow_set_local_id(subflow, local_id);
 
 	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
 					     &flags, &ifindex);
@@ -1434,7 +1474,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->local_id = local_id;
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
@@ -1734,15 +1773,22 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->token = subflow_req->token;
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->idsn = subflow_req->idsn;
+
+		/* this is the first subflow, id is always 0 */
+		new_ctx->local_id_valid = 1;
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
-		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
 		new_ctx->thmac = subflow_req->thmac;
+
+		/* the subflow req id is valid, fetched via subflow_check_req()
+		 * and subflow_token_join_request()
+		 */
+		subflow_set_local_id(new_ctx, subflow_req->local_id);
 	}
 }
 
@@ -1795,6 +1841,7 @@ void __init mptcp_subflow_init(void)
 	subflow_specific.conn_request = subflow_v4_conn_request;
 	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_specific.rebuild_header = subflow_rebuild_header;
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
@@ -1807,6 +1854,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request = subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_v6_specific.rebuild_header = subflow_v6_rebuild_header;
 
 	subflow_v6m_specific = subflow_v6_specific;
 	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
@@ -1814,6 +1862,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
 	subflow_v6m_specific.net_frag_header_len = 0;
+	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
-- 
2.34.1

