Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236E2F28
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644487645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=19lzRj//pDv3I8Zo7XLJ//ZF0sCqPdpAneo7+BHFQdw=;
	b=YkmiE8AzmiYZzB/y1VV9grL3jUosQwZc2H6/rg/SkWuxA/9BQMV+UY3gnIJA0Heqnm1eX/
	pxtUjtcWodTksK7VuTy8rhqmuccooQY+jibeNK/Y3dhPl63LgV+GVjhYgjxyWVV+i645p/
	Tkl029o7FFvZIE1Nekhg1MYdL3hBKWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-UY58xcTPM_WQk2VHJrvelw-1; Thu, 10 Feb 2022 05:07:23 -0500
X-MC-Unique: UY58xcTPM_WQk2VHJrvelw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD1D5193F561
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:07:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.220])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4D16F94E
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 10:07:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next] mptcp: strict local address ID selection.
Date: Thu, 10 Feb 2022 11:07:17 +0100
Message-Id: <75e02d63aa8b03b873ad94f5b4d901776f9a81ea.1644487551.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Note: send v2 to address the build issue, to help the discussion

 v1 -> v2:
- hopefully fix build issue with ipv6 disabled
- avoid looking-up multiple times the local_id for req sockets
- factor-out an helper for local_id initialization

RFC -> v1:
- don't bail if ID lookup fails, use 0 instead
---
 net/mptcp/pm_netlink.c | 39 +++++-------------------
 net/mptcp/protocol.c   |  3 ++
 net/mptcp/protocol.h   |  3 +-
 net/mptcp/subflow.c    | 69 ++++++++++++++++++++++++++++++++++++------
 4 files changed, 72 insertions(+), 42 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 46346f009485..5f6395b10fdc 100644
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
@@ -998,7 +988,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret = 0;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
@@ -1011,9 +1001,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
-	if (address_zero(&skc_local))
-		return 0;
-
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
 	rcu_read_lock();
@@ -1024,24 +1011,14 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 		}
 	}
 	rcu_read_unlock();
-	if (ret >= 0)
-		return ret;
-
-	/* address not found, add to local list */
-	entry = kmalloc(sizeof(*entry), GFP_ATOMIC);
-	if (!entry)
-		return -ENOMEM;
-
-	entry->addr = skc_local;
-	entry->addr.id = 0;
-	entry->addr.port = 0;
-	entry->ifindex = 0;
-	entry->flags = 0;
-	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
-	if (ret < 0)
-		kfree(entry);
 
+	/* if src address is not mapped by any endpoint, we can't reliably pick an
+	 * ID without creating "dummy" endpoint which would unexpectly pollute the
+	 * netns.
+	 * In such case arbitrary pick the 0 id. This is an RFC violation, as the
+	 * mapping for ID 0 is not unique, but an unconsequential one: lacking the
+	 * endpoint the peer can't generate RM_ADDR for this address
+	 */
 	return ret;
 }
 
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
index 485f00dcaf84..8e5e3c375ba1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -481,7 +481,52 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_subflow_reset(sk);
 }
 
-struct request_sock_ops mptcp_subflow_request_sock_ops;
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
+ struct request_sock_ops mptcp_subflow_request_sock_ops;
 EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
 
@@ -1404,13 +1449,8 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
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
@@ -1435,7 +1475,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->local_id = local_id;
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
@@ -1735,15 +1774,22 @@ static void subflow_ulp_clone(const struct request_sock *req,
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
 
@@ -1796,6 +1842,7 @@ void __init mptcp_subflow_init(void)
 	subflow_specific.conn_request = subflow_v4_conn_request;
 	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_specific.rebuild_header = subflow_rebuild_header;
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
@@ -1808,6 +1855,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request = subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_v6_specific.rebuild_header = subflow_v6_rebuild_header;
 
 	subflow_v6m_specific = subflow_v6_specific;
 	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
@@ -1815,6 +1863,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
 	subflow_v6m_specific.net_frag_header_len = 0;
+	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
-- 
2.34.1

