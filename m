Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82A2C9E
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639407902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b80mynt3/qTiueNqRfqZZb7JGPtFWSSp3p16Mqnhv0I=;
	b=LOLQaKryh6722oYLP7urTwHM67sTGWtHhKkifHwDaIB1VNl6YREv2AotLMSxBCPlagC+dP
	TV+w8M1xAFixfM2Fn97HzwAAf3R5zz3mZOIGFJ3gg2j0/A0YAOMCQEV6zqAVDK2ZF3ycHP
	7VmUcXsy/3OrgugFshz+o3AjvVDilBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-QbQOkx6zMZmxwmM-5Xnl-A-1; Mon, 13 Dec 2021 10:04:59 -0500
X-MC-Unique: QbQOkx6zMZmxwmM-5Xnl-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 982B88015CD
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 15:04:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.194])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9528277BF7
	for <mptcp@lists.linux.dev>; Mon, 13 Dec 2021 15:04:57 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH] mptcp: strict local address ID selection.
Date: Mon, 13 Dec 2021 16:04:46 +0100
Message-Id: <3818d10f0103e74bec3f9159df3746dc224f839d.1639407864.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
selected by the route lookup is finally known.

Additionally, let the ID selection explicitly fail if no endpoint
is available for the local address, avoiding dummy subflows creation.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
notes:
- This is a follow-up to last week mtg, outlining the current issue
and a possible solution. It also demonstrates how the change impacts
on the existing setup - basically for each 'signal' endpoint on the
server end, we need an addtional endpoint with no flag on the client
side.

- The change impacting the self-tests is the allocation removal
---
 net/mptcp/pm_netlink.c                        |  33 +-----
 net/mptcp/protocol.c                          |   1 +
 net/mptcp/protocol.h                          |   3 +-
 net/mptcp/subflow.c                           |  53 +++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 101 +++++++++++++++---
 5 files changed, 135 insertions(+), 56 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 675c51214b05..b7693d16d4e3 100644
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
@@ -953,7 +943,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	struct mptcp_addr_info skc_local;
 	struct mptcp_addr_info msk_local;
 	struct pm_nl_pernet *pernet;
-	int ret = -1;
+	int ret = -EINVAL;
 
 	if (WARN_ON_ONCE(!msk))
 		return -1;
@@ -966,9 +956,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
-	if (address_zero(&skc_local))
-		return 0;
-
 	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
 
 	rcu_read_lock();
@@ -979,24 +966,6 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
-
 	return ret;
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 334abea4be9c..0331f216679f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -117,6 +117,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
 	subflow->request_mptcp = 1;
+	subflow->local_id_valid = 1;
 	mptcp_sock_graft(msk->first, sk->sk_socket);
 
 	return 0;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 95c8481ff71d..9ba649e08c46 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -443,7 +443,8 @@ struct mptcp_subflow_context {
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
-		stale : 1;	    /* unable to snd/rcv data, do not use for xmit */
+		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
+		local_id_valid : 1;
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u32	start_stamp;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 09225b57c7f6..91254d2b622f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -483,6 +483,44 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_subflow_reset(sk);
 }
 
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
+	subflow->local_id = err;
+	subflow->local_id_valid = 1;
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
+static int subflow_v6_rebuild_header(struct sock *sk)
+{
+	int err = subflow_chk_local_id(sk);
+
+	if (unlikely(err < 0))
+		return err;
+
+	return inet6_sk_rebuild_header(sk);
+}
+
 struct request_sock_ops mptcp_subflow_request_sock_ops;
 EXPORT_SYMBOL_GPL(mptcp_subflow_request_sock_ops);
 static struct tcp_request_sock_ops subflow_request_sock_ipv4_ops;
@@ -1410,12 +1448,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 		get_random_bytes(&subflow->local_nonce, sizeof(u32));
 	} while (!subflow->local_nonce);
 
-	if (!local_id) {
-		err = mptcp_pm_get_local_id(msk, (struct sock_common *)ssk);
-		if (err < 0)
-			goto failed;
-
-		local_id = err;
+	if (local_id) {
+		subflow->local_id = local_id;
+		subflow->local_id_valid = 1;
 	}
 
 	mptcp_pm_get_flags_and_ifindex_by_id(sock_net(sk), local_id,
@@ -1441,7 +1476,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
 		 remote_token, local_id, remote_id);
 	subflow->remote_token = remote_token;
-	subflow->local_id = local_id;
 	subflow->remote_id = remote_id;
 	subflow->request_join = 1;
 	subflow->request_bkup = !!(flags & MPTCP_PM_ADDR_FLAG_BACKUP);
@@ -1743,11 +1777,13 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->token = subflow_req->token;
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->idsn = subflow_req->idsn;
+		new_ctx->local_id_valid = 1;
 	} else if (subflow_req->mp_join) {
 		new_ctx->ssn_offset = subflow_req->ssn_offset;
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->local_id_valid = 1;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
@@ -1804,6 +1840,7 @@ void __init mptcp_subflow_init(void)
 	subflow_specific.conn_request = subflow_v4_conn_request;
 	subflow_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_specific.rebuild_header = subflow_rebuild_header;
 
 	tcp_prot_override = tcp_prot;
 	tcp_prot_override.release_cb = tcp_release_cb_override;
@@ -1816,6 +1853,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6_specific.conn_request = subflow_v6_conn_request;
 	subflow_v6_specific.syn_recv_sock = subflow_syn_recv_sock;
 	subflow_v6_specific.sk_rx_dst_set = subflow_finish_connect;
+	subflow_v6_specific.rebuild_header = subflow_v6_rebuild_header;
 
 	subflow_v6m_specific = subflow_v6_specific;
 	subflow_v6m_specific.queue_xmit = ipv4_specific.queue_xmit;
@@ -1823,6 +1861,7 @@ void __init mptcp_subflow_init(void)
 	subflow_v6m_specific.net_header_len = ipv4_specific.net_header_len;
 	subflow_v6m_specific.mtu_reduced = ipv4_specific.mtu_reduced;
 	subflow_v6m_specific.net_frag_header_len = 0;
+	subflow_v6m_specific.rebuild_header = subflow_rebuild_header;
 
 	tcpv6_prot_override = tcpv6_prot;
 	tcpv6_prot_override.release_cb = tcp_release_cb_override;
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8f49bbd4a201..55b0d03f485c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1110,9 +1110,10 @@ signal_address_tests()
 
 	# accept and use add_addr
 	reset
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1125,6 +1126,7 @@ signal_address_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal" 2 2 2
@@ -1135,6 +1137,7 @@ signal_address_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1148,6 +1151,9 @@ signal_address_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1159,6 +1165,8 @@ signal_address_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.12.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1197,6 +1205,7 @@ link_failure_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1211,6 +1220,7 @@ link_failure_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 dev ns2eth4 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 2
@@ -1226,6 +1236,7 @@ link_failure_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 	export FAILING_LINKS="1"
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 1
 	chk_join_nr "backup subflow unused, link failure" 2 2 2
@@ -1239,6 +1250,7 @@ link_failure_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	export FAILING_LINKS="1 2"
 	run_tests $ns1 $ns2 10.0.1.1 1
@@ -1254,6 +1266,7 @@ link_failure_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 dev ns2eth2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 dev ns2eth3 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 2
 	chk_join_nr "backup flow used, bidi, link failure" 2 2 2
@@ -1267,8 +1280,9 @@ add_addr_timeout_tests()
 	# add_addr timeout
 	reset_with_add_addr_timeout
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1276,8 +1290,9 @@ add_addr_timeout_tests()
 	# add_addr timeout IPv6
 	reset_with_add_addr_timeout 6
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "signal address, ADD_ADDR6 timeout" 1 1 1
 	chk_add_nr 4 0
@@ -1288,6 +1303,8 @@ add_addr_timeout_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
 	chk_add_nr 8 0
@@ -1298,6 +1315,8 @@ add_addr_timeout_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.12.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.12.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
 	chk_add_nr 8 0
@@ -1329,6 +1348,7 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address" 1 1 1
 	chk_add_nr 1 1
@@ -1339,7 +1359,11 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+
+	# note that the endpoint creation order matters, as
+	# the test will delete the first endpoint
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal" 2 2 2
 	chk_add_nr 1 1
@@ -1352,6 +1376,7 @@ remove_tests()
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -2 slow
 	chk_join_nr "remove subflows and signal" 3 3 3
 	chk_add_nr 1 1
@@ -1364,6 +1389,9 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1376,6 +1404,9 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.12.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.14.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -3 0 slow
 	chk_join_nr "remove invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1386,6 +1417,7 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
@@ -1411,6 +1443,9 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.4.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 	chk_join_nr "flush addresses" 3 3 3
 	chk_add_nr 3 3
@@ -1423,6 +1458,9 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.14.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 3 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.12.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.14.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 0 slow
 	chk_join_nr "flush invalid addresses" 1 1 1
 	chk_add_nr 3 3
@@ -1442,6 +1480,7 @@ remove_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -9 0 slow
 	chk_join_nr "remove id 0 address" 1 1 1
 	chk_add_nr 1 1
@@ -1461,6 +1500,7 @@ add_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 1 0 slow
 	chk_join_nr "add signal address" 1 1 1
 	chk_add_nr 1 1
@@ -1483,6 +1523,8 @@ add_tests()
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 2 0 slow
 	chk_join_nr "add multiple addresses IPv6" 2 2 2
 	chk_add_nr 2 2
@@ -1501,6 +1543,7 @@ ipv6_tests()
 	# add_address, unused IPv6
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "unused signal address IPv6" 0 0 0
 	chk_add_nr 1 1
@@ -1510,6 +1553,7 @@ ipv6_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
 	chk_join_nr "single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1519,6 +1563,7 @@ ipv6_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 0 slow
 	chk_join_nr "remove single address IPv6" 1 1 1
 	chk_add_nr 1 1
@@ -1530,6 +1575,7 @@ ipv6_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add dead:beef:2::2
 	run_tests $ns1 $ns2 dead:beef:1::1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal IPv6" 2 2 2
 	chk_add_nr 1 1
@@ -1549,8 +1595,9 @@ v4mapped_tests()
 	# signal address IPv4-mapped with IPv4-mapped sk
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.2.2"
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address IPv4-mapped" 1 1 1
 	chk_add_nr 1 1
@@ -1566,8 +1613,9 @@ v4mapped_tests()
 	# signal address v4-map-v6
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.2.2"
 	run_tests $ns1 $ns2 "::ffff:10.0.1.1"
 	chk_join_nr "signal address v4-map-v6" 1 1 1
 	chk_add_nr 1 1
@@ -1583,8 +1631,9 @@ v4mapped_tests()
 	# signal address v6-map-v4
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add "::ffff:10.0.2.1" flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add "::ffff:10.0.2.2"
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address v6-map-v4" 1 1 1
 	chk_add_nr 1 1
@@ -1630,10 +1679,11 @@ backup_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 	chk_join_nr "single address, backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 1
 }
 
 add_addr_ports_tests()
@@ -1641,8 +1691,9 @@ add_addr_ports_tests()
 	# signal address with port
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1652,6 +1703,7 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal with port" 2 2 2
@@ -1662,6 +1714,7 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
 	chk_join_nr "remove single address with port" 1 1 1
 	chk_add_nr 1 1 1
@@ -1673,6 +1726,7 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 -1 -1 slow
 	chk_join_nr "remove subflow and signal with port" 2 2 2
 	chk_add_nr 1 1 1
@@ -1683,6 +1737,7 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
@@ -1696,6 +1751,8 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10100
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with port" 2 2 2
 	chk_add_nr 2 2 2
@@ -1706,6 +1763,8 @@ add_addr_ports_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal port 10100
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.3.1 flags signal port 10101
 	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "multiple addresses with ports" 2 2 2
 	chk_add_nr 2 2 2
@@ -1742,8 +1801,9 @@ syncookies_tests()
 	# test signal address with cookies
 	reset_with_cookies
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address with syn cookies" 1 1 1
 	chk_add_nr 1 1
@@ -1753,6 +1813,7 @@ syncookies_tests()
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 2
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and signal w cookies" 2 2 2
@@ -1763,6 +1824,7 @@ syncookies_tests()
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.4.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
@@ -1823,8 +1885,9 @@ deny_join_id0_tests()
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 1 0
 	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns1" 1 1 1
 	chk_add_nr 1 1
@@ -1833,8 +1896,9 @@ deny_join_id0_tests()
 	# ADD_ADDRs are not affected by allow_join_id0 value.
 	reset_with_allow_join_id0 0 1
 	ip netns exec $ns1 ./pm_nl_ctl limits 1 1
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "signal address allow join id0 ns2" 1 1 1
 	chk_add_nr 1 1
@@ -1842,8 +1906,9 @@ deny_join_id0_tests()
 	# subflow and address allow join id0 ns1
 	reset_with_allow_join_id0 1 0
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 1" 2 2 2
@@ -1851,8 +1916,9 @@ deny_join_id0_tests()
 	# subflow and address allow join id0 ns2
 	reset_with_allow_join_id0 0 1
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 2
-	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 2 2
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
@@ -1877,8 +1943,9 @@ fullmesh_tests()
 	# 1 fullmesh addr in ns2, added during the connection.
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 1 3
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 3
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 	chk_join_nr "fullmesh test 1x1" 3 3 3
 	chk_add_nr 1 1
@@ -1888,8 +1955,9 @@ fullmesh_tests()
 	# 2 fullmesh addrs in ns2, added during the connection.
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 5
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 5
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2" 5 5 5
 	chk_add_nr 1 1
@@ -1900,8 +1968,9 @@ fullmesh_tests()
 	# limit max_subflows to 4.
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 2 4
-	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 4
+	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2
 	run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_2 slow
 	chk_join_nr "fullmesh test 1x2, limited" 4 4 4
 	chk_add_nr 1 1
-- 
2.33.1

