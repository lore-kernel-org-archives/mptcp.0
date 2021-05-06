Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33171
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 17:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620321887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V4mQ/sn0jEf4HeMaNBbxdNGwsG610g0p5fldJ5tErDg=;
	b=eQUEW3rg7YduS58hNs3pD4JkiEyfyokYx0YPy5JXlcBZsv5K2YCYnpQAsyvUZ2T1D2lj6z
	PKju0k9xw8HIGgeX7JwejxH8jZAJ4vnCVfO6SNExMUtaq1jZ/VuTRXGILaFku5nwBOPbJ7
	xoQpDEO2Zqp6ePhJxz4ATAZOKYwQCJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-sy4DlUw9PDqSAaye_UsHtw-1; Thu, 06 May 2021 13:24:40 -0400
X-MC-Unique: sy4DlUw9PDqSAaye_UsHtw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7300F8030CF;
	Thu,  6 May 2021 17:24:39 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-113-238.ams2.redhat.com [10.36.113.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4700319C46;
	Thu,  6 May 2021 17:24:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-net] mptcp: avoid OOB access in setsockopt()
Date: Thu,  6 May 2021 19:24:29 +0200
Message-Id: <79b377c2cb932a86f0fd1a17f814064dd1ad7015.1620321074.git.pabeni@redhat.com>
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

We can't use tcp_set_congestion_control() on an mptcp socket, as
such function can end-up accessing a tcp-specific field -
prior_ssthresh - causing an OOB access.

To allow propagating the correct ca algo on subflow, cache the ca
name at initialization time.

Additionally avoid overriding the user-selected CA (if any) at
clone time.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/182
Fixes: aa1fbd94e5c7 ("mptcp: sockopt: add TCP_CONGESTION and TCP_INFO")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
@Christoph: could u please give this a spin?
---
 net/mptcp/protocol.c | 14 +++++++++++---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sockopt.c  |  4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 32a39774075b..627352c59416 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2437,8 +2437,6 @@ static int __mptcp_init_sock(struct sock *sk)
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
 	timer_setup(&sk->sk_timer, mptcp_timeout_timer, 0);
 
-	tcp_assign_congestion_control(sk);
-
 #if IS_ENABLED(CONFIG_KASAN)
 	sock_set_flag(sk, SOCK_RCU_FREE);
 #endif
@@ -2448,6 +2446,7 @@ static int __mptcp_init_sock(struct sock *sk)
 
 static int mptcp_init_sock(struct sock *sk)
 {
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct net *net = sock_net(sk);
 	int ret;
 
@@ -2465,6 +2464,16 @@ static int mptcp_init_sock(struct sock *sk)
 	if (ret)
 		return ret;
 
+	/* fetch the ca name; do it outside __mptcp_init_sock(), so that clone will
+	 * propagate the correct value
+	 */
+	tcp_assign_congestion_control(sk);
+	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
+
+	/* no need to keep a reference to the oops, the name will suffice */
+	tcp_cleanup_congestion_control(sk);
+	icsk->icsk_ca_ops = NULL;
+
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf = sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
 	sk->sk_sndbuf = sock_net(sk)->ipv4.sysctl_tcp_wmem[1];
@@ -2639,7 +2648,6 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
 
-	tcp_cleanup_congestion_control(sk);
 	sk_refcnt_debug_release(sk);
 	mptcp_dispose_initial_subflow(msk);
 	sock_put(sk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 98c735f237b4..868e878af526 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -263,6 +263,7 @@ struct mptcp_sock {
 	} rcvq_space;
 
 	u32 setsockopt_seq;
+	char		ca_name[TCP_CA_NAME_MAX];
 };
 
 #define mptcp_lock_sock(___sk, cb) do {					\
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 00d941b66c1e..a79798189599 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -547,7 +547,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	}
 
 	if (ret == 0)
-		tcp_set_congestion_control(sk, name, false, cap_net_admin);
+		strcpy(msk->ca_name, name);
 
 	release_sock(sk);
 	return ret;
@@ -705,7 +705,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	sock_valbool_flag(ssk, SOCK_DBG, sock_flag(sk, SOCK_DBG));
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
-		tcp_set_congestion_control(ssk, inet_csk(sk)->icsk_ca_ops->name, false, true);
+		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
-- 
2.26.2

