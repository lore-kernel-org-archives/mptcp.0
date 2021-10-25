Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9EE2C8B
	for <mptcp@lists.linux.dev>; Mon, 25 Oct 2021 21:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635195702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=2GO6xheU21esJu6DY6RrdtjAs3t0Hw2eK3xrXM+6ODw=;
	b=NvbAXQMkI3Rn+93mYcZ/pE/cjcdwiLLG4XdGx0l2T6geHyLEGZhORx2m1DDzP6qdg2mDAE
	FQYYN/YDgS2DS1AzONYTQ0HP1dmzh41DWkRTROL8mmoCNOt/BB5e3OC+y02/41Zao6C1Wz
	bDnGl+XSs3d40Opbz64NHY0vNgPoiy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-Hd5NXc9VMD2C5Zgajt3wng-1; Mon, 25 Oct 2021 17:01:38 -0400
X-MC-Unique: Hd5NXc9VMD2C5Zgajt3wng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51C008066F6;
	Mon, 25 Oct 2021 21:01:37 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D0B75F4EC;
	Mon, 25 Oct 2021 21:01:36 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp net-next] Support for SOL_IP for MPTCP setsockopt
Date: Mon, 25 Oct 2021 21:01:12 +0000
Message-Id: <51fa50ca9158e5b72a8f41ba9fcd1e449638dbc5.1635194315.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=psonparo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
https://github.com/multipath-tcp/mptcp_net-next/issues/220

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220

Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
---

Notes:
    - This patch addresses previous suggestions.
    - The TOS value is now being set successfully for subflows
      created after setsockopt().

 include/net/ip.h       |  3 +--
 net/ipv4/ip_sockglue.c |  2 +-
 net/mptcp/sockopt.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index cf229a531194..a40501fe89de 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -762,7 +762,6 @@ void ip_icmp_error(struct sock *sk, struct sk_buff *skb, int err, __be16 port,
 		   u32 info, u8 *payload);
 void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 dport,
 		    u32 info);
-
 static inline void ip_cmsg_recv(struct msghdr *msg, struct sk_buff *skb)
 {
 	ip_cmsg_recv_offset(msg, skb->sk, skb, 0, 0);
@@ -789,5 +788,5 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
-
+void  __ip_sock_set_tos(struct sock *sk, int val);
 #endif	/* _IP_H */
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index b297bb28556e..7fd83f14daae 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -576,7 +576,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	return err;
 }
 
-static void __ip_sock_set_tos(struct sock *sk, int val)
+void __ip_sock_set_tos(struct sock *sk, int val)
 {
 	if (sk->sk_type == SOCK_STREAM) {
 		val &= ~INET_ECN_MASK;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8137cc3a4296..3967e1b8455c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,6 +598,43 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_sol_ip_set_tos(struct mptcp_sock *msk, int optname,
+					   sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret, val = 0;
+	int err;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+	val = inet_sk(sk)->tos;
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		__ip_sock_set_tos(ssk, val);
+	}
+	release_sock(sk);
+
+	return ret;
+}
+
+static int mptcp_setsockopt_sol_ip(struct mptcp_sock *msk, int optname,
+				   sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_TOS:
+		return  mptcp_setsockopt_sol_ip_set_tos(msk, optname, optval, optlen);
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -637,6 +674,9 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
 	if (ssk)
 		return tcp_setsockopt(ssk, level, optname, optval, optlen);
 
+	if (level == SOL_IP)
+		return mptcp_setsockopt_sol_ip(msk, optname, optval, optlen);
+
 	if (level == SOL_IPV6)
 		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
 
@@ -1000,6 +1040,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	ssk->sk_priority = sk->sk_priority;
 	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;
 	ssk->sk_incoming_cpu = sk->sk_incoming_cpu;
+	__ip_sock_set_tos(ssk, inet_sk(sk)->tos);
 
 	if (sk->sk_userlocks & tx_rx_locks) {
 		ssk->sk_userlocks |= sk->sk_userlocks & tx_rx_locks;
-- 
2.18.2

