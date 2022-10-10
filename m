Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5E5C84
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 19:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665431769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qjg7faDUMCPmzL02FZ9pnPTjRD25oc41ift8y2p3gDA=;
	b=VXjWtWa/GJAs5Nnpc7ZJl7LV/9vpv5U+hMVgo+ShDPOxnVaIoE5K4wGPmY3IkmKziRh1cZ
	dWkGLqXr0V2kpvND8pU+b06g2L62k6hwFgoWR9nslAlfL5nDjYSHyVJ3fmIryZMSsV6oib
	mzS16I1hWr4h3bBqRqZS17QqkK4qojc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-h0XAACyTORKAMC1zxtzgXg-1; Mon, 10 Oct 2022 15:56:08 -0400
X-MC-Unique: h0XAACyTORKAMC1zxtzgXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 895F21012460
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 19:56:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9A8112D164
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 19:56:07 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: set msk local address earlier
Date: Mon, 10 Oct 2022 21:56:02 +0200
Message-Id: <f5e8bfe9878d3948df9328870fc35daec6388e2b.1665431162.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp_pm_nl_get_local_id() code assumes that the msk local address
is available at that point. For passive sockets, we initialize such
address at accept() time.

Depending on the running configuration and the user-space timing, a
passive MPJ subflow can join the msk socket before accept() completes.

In such case, the PM assigns a wrong local id to the MPJ subflow
and later PM netlink operations will end-up touching the wrong/unexpected
subflow.

All the above causes sporadic self-tests failures, especially when
the host is heavy loaded.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/308
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Fixes: d045b9eb95a9 ("mptcp: introduce implicit endpoints")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 3 +--
 net/mptcp/protocol.h | 1 +
 net/mptcp/subflow.c  | 7 +++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1aa940928b4f..d34765db0700 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2951,7 +2951,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 	sock_put(sk);
 }
 
-static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
+void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	const struct ipv6_pinfo *ssk6 = inet6_sk(ssk);
@@ -3702,7 +3702,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		if (mptcp_is_fully_established(newsk))
 			mptcp_pm_fully_established(msk, msk->first, GFP_KERNEL);
 
-		mptcp_copy_inaddrs(newsk, msk->first);
 		mptcp_rcv_space_init(msk, msk->first);
 		mptcp_propagate_sndbuf(newsk, msk->first);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 18f866b1afda..2358a4083eb3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -604,6 +604,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 int mptcp_get_pm_type(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
+void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk);
 void mptcp_subflow_fully_established(struct mptcp_subflow_context *subflow,
 				     struct mptcp_options_received *mp_opt);
 bool __mptcp_retransmit_pending_data(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 07dd23d0fe04..05a2b054287a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -723,6 +723,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (new_msk)
+				mptcp_copy_inaddrs(new_msk, child);
 			subflow_drop_ctx(child);
 			goto out;
 		}
@@ -750,6 +752,11 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			ctx->conn = new_msk;
 			new_msk = NULL;
 
+			/* set msk addresse early to ensure mptcp_pm_get_local_id()
+			 * uses the correct data
+			 */
+			mptcp_copy_inaddrs(ctx->conn, child);
+
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
 			 */
-- 
2.37.3

