Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904B42C9F
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 16:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635266654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type;
	bh=fs82X/nOg98vFL3nz1DFmvPrimcsND96b+NBF+KEOto=;
	b=goy23KoWmvC7gFK/7oLvsaJWaLVlVItSsHX6rGyB4cNFwB5/UzvXnxJB6iQa5uhEID0tyR
	TWIG9y3zmEolruNqB+42PGmhgiuu2BwAb6Y0s7JjMjWA2clOVs6iwGBwtK9kyEYDcrNphR
	5WI7/c2sIS6/e5nQXhx/ZuX3TSsD2pY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-1zETSOpgMKar2XFjO8cmUg-1; Tue, 26 Oct 2021 12:44:11 -0400
X-MC-Unique: 1zETSOpgMKar2XFjO8cmUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93247801FCE;
	Tue, 26 Oct 2021 16:44:10 +0000 (UTC)
Received: from nst.lab.eng.brq.redhat.com (nst.lab.eng.brq.redhat.com [10.37.153.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9933060BF1;
	Tue, 26 Oct 2021 16:44:09 +0000 (UTC)
From: Poorva Sonparote <psonparo@redhat.com>
To: mptcp@lists.linux.dev
Cc: matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp net-next v2] Support for IP_TOS for MPTCP setsockopt()
Date: Tue, 26 Oct 2021 16:35:40 +0000
Message-Id: <31da6aa5b0a0df7c10c5ad55312b5372c9f7ec6f.1635266103.git.psonparo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

SOL_IP provides a way to configure network layer attributes in a
socket. This patch adds support for IP_TOS for setsockopt(.. ,SOL_IP, ..)
https://github.com/multipath-tcp/mptcp_net-next/issues/220

Support for SOL_IP is added in mptcp_setsockopt() and IP_TOS is handled in
a private function. The idea here is to take in the value passed for IP_TOS
and set it to the current subflow, open subflows as well new subflows that
might be created after the initial call to setsockopt(). This sync is done
using sync_socket_options(.., ssk) and setting the value of tos using
 __ip_sock_set_tos(ssk,..).
To set the value for all subflows associated, __ip_sock_set_tos(ssk,..) is
exposed in ip.h

The patch has been tested using the packetdrill script here -
https://github.com/multipath-tcp/mptcp_net-next/issues/220#issuecomment-947863717
It has not been selftested because there's no support for IP_TOS in
getsockopt() yet.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/220
Signed-off-by: Poorva Sonparote <psonparo@redhat.com>
---
Thanks Mat and Matthieu for the feedback! Kindly let me know if any changes
are required.

Notes:
    - Fixed formatting errors in ip.h and sockopt.c
    - Edited the commit message to add in more details.
    - The patch cannot be seltested because there's no
      support for IP_TOS in getsockopt() yet.
    - Changed the function name mptcp_setsockopt_sol_ip(..)
     to mptcp_setsockopt_v4(..).
    - Similarly, changed the function name mptcp_setsockopt_sol_ip_set_tos(..)
     to mptcp_setsockopt_v4_set_tos(..) for uniformity.

 include/net/ip.h       |  2 +-
 net/ipv4/ip_sockglue.c |  2 +-
 net/mptcp/sockopt.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index cf229a531194..e9e050f5af99 100644
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
@@ -789,5 +788,6 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val);
 void ip_sock_set_pktinfo(struct sock *sk);
 void ip_sock_set_recverr(struct sock *sk);
 void ip_sock_set_tos(struct sock *sk, int val);
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
index 8137cc3a4296..ded47f0483ed 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -598,6 +598,43 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
+				       sockptr_t optval, unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int ret, val;
+	int err;
+
+	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
+
+	if (err != 0)
+		return err;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	val = inet_sk(sk)->tos;
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
+static int mptcp_setsockopt_v4(struct mptcp_sock *msk, int optname,
+			       sockptr_t optval, unsigned int optlen)
+{
+	switch (optname) {
+	case IP_TOS:
+		return mptcp_setsockopt_v4_set_tos(msk, optname, optval, optlen);
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
+		return mptcp_setsockopt_v4(msk, optname, optval, optlen);
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

