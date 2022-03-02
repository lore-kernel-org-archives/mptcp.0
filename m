Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6077F28E2
	for <mptcp@lists.linux.dev>; Wed,  2 Mar 2022 09:45:42 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nPLY6-0001VU-1O; Wed, 02 Mar 2022 10:45:34 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp 5/4] mptcp: handle join requests early
Date: Wed,  2 Mar 2022 10:45:27 +0100
Message-Id: <20220302094527.12212-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155010.23676-5-fw@strlen.de>
References: <20220224155010.23676-5-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relative patch to better explain whats happening, if we go this route
then this would be squashed/replace patch #3.

Main problem: bypasses TW infrastructure, i.e. SYN+JOIN with existing
subflow quadruple won't work.

This could be resolved by duplicating considerable code from
tcp_ipv4(6).c to mptcp_handle_join, but I don't like that either.

IOW, I would prefer to keep the sequence as-is, first do the standard
port-based demux and then, if no result was found, do the join handling.

This means subflow to TCP-only listener will fail to establish, but that
could be resolved by having a 'reserve the port' approach (mptcpd?) in
the tooling that adds the required netlink commands.

I would prefer to minimize kernel work.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h | 17 +++++++-------
 net/ipv4/tcp_ipv4.c | 12 ++++------
 net/ipv6/tcp_ipv6.c |  9 ++------
 net/mptcp/ctrl.c    | 54 ++++++++++++++++++++++++++++++++++++---------
 4 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b8939d7ea12e..cc95c279a196 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -189,7 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  struct sk_buff *skb);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
-struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
+bool __mptcp_handle_join(int af, struct sk_buff *skb);
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 {
@@ -199,17 +199,17 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 	return htonl(0u);
 }
 
-static inline struct sock *mptcp_handle_join(struct sk_buff *skb, int af)
+static inline bool mptcp_handle_join(struct sk_buff *skb, int af)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 
-	if (th->syn && !th->ack && !th->rst && !th->fin)
+	if (unlikely(th->syn && !th->ack && !th->rst && !th->fin))
 		return __mptcp_handle_join(af, skb);
 
-	return NULL;
+	return true;
 }
 
-static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
+static inline bool mptcp_handle_join4(struct sk_buff *skb)
 {
 	return mptcp_handle_join(skb, AF_INET);
 }
@@ -290,7 +290,8 @@ static inline int mptcp_subflow_init_cookie_req(struct request_sock *req,
 }
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
-static inline struct sock *mptcp_handle_join4(struct sk_buff *skb) { return NULL; }
+static inline bool mptcp_handle_join4(int af, struct sk_buff *skb) { return true; }
+
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
@@ -299,7 +300,7 @@ int mptcpv6_init_net(struct net *net);
 void mptcpv6_exit_net(struct net *net);
 void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
 
-static inline struct sock *mptcp_handle_join6(struct sk_buff *skb)
+static inline bool mptcp_handle_join6(struct sk_buff *skb)
 {
 	return mptcp_handle_join(skb, AF_INET6);
 }
@@ -308,7 +309,7 @@ static inline int mptcpv6_init(void) { return 0; }
 static inline int mptcpv6_init_net(struct net *net) { return 0; }
 static inline void mptcpv6_exit_net(struct net *net) { }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
-static inline struct sock *mptcp_handle_join6(struct sk_buff *skb) { return NULL; }
+static inline bool mptcp_handle_join6(struct sk_buff *skb) { return true; }
 #endif
 
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index da9ed7b0b7f5..ba685f18a767 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1949,12 +1949,15 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 	th = (const struct tcphdr *)skb->data;
 	iph = ip_hdr(skb);
+
+	if (!mptcp_handle_join4(skb))
+		goto no_tcp_socket;
+
 lookup:
 	sk = __inet_lookup_skb(&tcp_hashinfo, skb, __tcp_hdrlen(th), th->source,
 			       th->dest, sdif, &refcounted);
 	if (!sk)
 		goto no_tcp_socket;
-
 process:
 	if (sk->sk_state == TCP_TIME_WAIT)
 		goto do_time_wait;
@@ -2087,10 +2090,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 	if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
-	sk = mptcp_handle_join4(skb);
-	if (sk)
-		goto process;
-
 	tcp_v4_fill_cb(skb, iph, th);
 
 	if (tcp_checksum_complete(skb)) {
@@ -2137,9 +2136,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 							iph->daddr, th->dest,
 							inet_iif(skb),
 							sdif);
-		if (!sk2)
-			sk2 = mptcp_handle_join4(skb);
-
 		if (sk2) {
 			inet_twsk_deschedule_put(inet_twsk(sk));
 			sk = sk2;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index a8aebfbb531e..39184d7654b1 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1615,6 +1615,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	th = (const struct tcphdr *)skb->data;
 	hdr = ipv6_hdr(skb);
 
+	if (!mptcp_handle_join6(skb))
+		goto no_tcp_socket;
 lookup:
 	sk = __inet6_lookup_skb(&tcp_hashinfo, skb, __tcp_hdrlen(th),
 				th->source, th->dest, inet6_iif(skb), sdif,
@@ -1746,10 +1748,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
 		goto discard_it;
 
-	sk = mptcp_handle_join6(skb);
-	if (sk)
-		goto process;
-
 	tcp_v6_fill_cb(skb, hdr, th);
 
 	if (tcp_checksum_complete(skb)) {
@@ -1799,9 +1797,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 					    ntohs(th->dest),
 					    tcp_v6_iif_l3_slave(skb),
 					    sdif);
-		if (!sk2)
-			sk2 = mptcp_handle_join6(skb);
-
 		if (sk2) {
 			struct inet_timewait_sock *tw = inet_twsk(sk);
 			inet_twsk_deschedule_put(tw);
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index c7370c5147df..bf079bb50177 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -10,6 +10,8 @@
 
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
+#include <net/inet_hashtables.h>
+#include <net/inet6_hashtables.h>
 
 #include "protocol.h"
 #include "mib.h"
@@ -214,30 +216,54 @@ static void add_mptcp_rst(struct sk_buff *skb)
 	}
 }
 
-struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
+/* return false if tcp must pretend no socket was found. */
+bool __mptcp_handle_join(int af, struct sk_buff *skb)
 {
 	struct mptcp_options_received mp_opt;
+	const struct ipv6hdr *ip6h;
+	const struct iphdr *iph;
+	struct sock *lsk = NULL;
+	const struct tcphdr *th;
 	struct mptcp_pernet *pernet;
 	struct mptcp_sock *msk;
 	struct socket *ssock;
-	struct sock *lsk;
 	struct net *net;
 
 	/* paranoia check: don't allow 0 destination port,
 	 * else __inet_inherit_port will insert the child socket
 	 * into the phony hash slot of the pernet listener.
 	 */
-	if (tcp_hdr(skb)->dest == 0)
-		return NULL;
+	if (tcp_hdr(skb)->dest == 0 || skb->sk)
+		return true;
 
 	mptcp_get_options(skb, &mp_opt);
 
 	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
-		return NULL;
+		return true;
 
 	net = dev_net(skb_dst(skb)->dev);
 	if (!mptcp_is_enabled(net))
-		return NULL;
+		return true;
+
+	lsk = NULL;
+	th = tcp_hdr(skb);
+	switch (af) {
+	case AF_INET:
+		iph = ip_hdr(skb);
+		lsk = inet_lookup_listener(net, &tcp_hashinfo, skb, __tcp_hdrlen(th), iph->saddr,
+					   th->source, iph->daddr, th->dest, inet_iif(skb), inet_sdif(skb));
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		ip6h = ipv6_hdr(skb);
+		lsk = inet6_lookup_listener(net, &tcp_hashinfo, skb, __tcp_hdrlen(th), &ip6h->saddr,
+					    th->source, &ip6h->daddr, th->dest, inet6_iif(skb), inet6_sdif(skb));
+		break;
+#endif
+	}
+
+	if (lsk && sk_is_mptcp(lsk))
+		goto assign_sk;
 
 	/* RFC8684: If the token is unknown [..], the receiver will send
 	 * back a reset (RST) signal, analogous to an unknown port in TCP,
@@ -246,14 +272,14 @@ struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
 	msk = mptcp_token_get_sock(net, mp_opt.token);
 	if (!msk) {
 		add_mptcp_rst(skb);
-		return NULL;
+		return false; /* suppress 4-tuple based lookups */
 	}
 
 	if (!mptcp_pm_sport_in_anno_list(msk, af, skb)) {
 		sock_put((struct sock *)msk);
 		MPTCP_INC_STATS(net, MPTCP_MIB_MISMATCHPORTSYNRX);
 		add_mptcp_rst(skb);
-		return NULL;
+		return false;
 	}
 
 	sock_put((struct sock *)msk);
@@ -270,14 +296,21 @@ struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
 #endif
 	default:
 		WARN_ON_ONCE(1);
-		return NULL;
+		return true;
 	}
 
 	ssock = __mptcp_nmpc_socket(mptcp_sk(lsk));
 	if (WARN_ON(!ssock))
 		return NULL;
 
-	return ssock->sk;
+	lsk = ssock->sk;
+
+assign_sk:
+	WARN_ON_ONCE(sk_is_refcounted(lsk));
+
+	skb->sk = lsk;
+	skb->destructor = sock_pfree;
+	return true;
 }
 
 static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
@@ -297,6 +330,7 @@ static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
 
 	ssock->sk->sk_max_ack_backlog = SOMAXCONN;
 	inet_sk_state_store(ssock->sk, TCP_LISTEN);
+	sock_set_flag(ssock->sk, SOCK_RCU_FREE);
 
 	s->sk->sk_max_ack_backlog = SOMAXCONN;
 	inet_sk_state_store(s->sk, TCP_LISTEN);
-- 
2.34.1

