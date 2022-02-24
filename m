Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB177A
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 15:50:29 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nNGNv-0005JI-SN; Thu, 24 Feb 2022 16:50:27 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet listen socket
Date: Thu, 24 Feb 2022 16:50:09 +0100
Message-Id: <20220224155010.23676-4-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155010.23676-1-fw@strlen.de>
References: <20220224155010.23676-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently mptcp adds kernel-based listener socket for all
netlink-configured mptcp address endpoints.

This has caveats because kernel may interfere with unrelated programs
that use same address/port pairs.

RFC 8684 says:
 Demultiplexing subflow SYNs MUST be done using the token; this is
 unlike traditional TCP, where the destination port is used for
 demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
 packets is done using the 5-tuple, as in traditional TCP.

This patch deviates from this in that it retains the existing checks of
verifying the incoming requests destination vs. the list of announced
addresses.  If the request is to an address that was not assigned, its
treated like an invalid token, i.e. we send a tcp reset with mptcp
error specific code is returned.

The checks that do this are moved from subflow specific code to the new
hook, this allows us to perform the check at an earlier stage.

Furthermore, TCP-only listeners take precedence: An MPTCP peer MUST NOT
announce addr:port pairs that are already in use by a non-mptcp listener.

This could be changed, but it requires move of mptcp_handle_join() hook
*before* the tcp port demux, i.e. an additional conditional in hotpath.

As-is, the additional conditional (syn && !rst && ...) is placed in the
'no socket found' path.

The pernet "listening" socket is hidden from userspace, its not part of
any hashes and not bound to any address/port.

TPROXY-like semantics apply: If tcp demux cannot find a port for a given
packet, check if the packet is a syn packet with a valid join token.

If so, the pernet listener is returned and tcp processing resumes.
Otherwise, handling is identical.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/mptcp.h  |  19 +++-
 net/ipv6/tcp_ipv6.c  |  19 ++--
 net/mptcp/ctrl.c     | 229 ++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.c |   2 +-
 net/mptcp/protocol.h |   2 +-
 net/mptcp/subflow.c  |   8 +-
 6 files changed, 258 insertions(+), 21 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b914e63afc13..b8939d7ea12e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -189,6 +189,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 				  struct sk_buff *skb);
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb);
+struct sock *__mptcp_handle_join(int af, struct sk_buff *skb);
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 {
@@ -198,10 +199,20 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 	return htonl(0u);
 }
 
-static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
+static inline struct sock *mptcp_handle_join(struct sk_buff *skb, int af)
 {
+	const struct tcphdr *th = tcp_hdr(skb);
+
+	if (th->syn && !th->ack && !th->rst && !th->fin)
+		return __mptcp_handle_join(af, skb);
+
 	return NULL;
 }
+
+static inline struct sock *mptcp_handle_join4(struct sk_buff *skb)
+{
+	return mptcp_handle_join(skb, AF_INET);
+}
 #else
 
 static inline void mptcp_init(void)
@@ -284,14 +295,18 @@ static inline struct sock *mptcp_handle_join4(struct sk_buff *skb) { return NULL
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int mptcpv6_init(void);
+int mptcpv6_init_net(struct net *net);
+void mptcpv6_exit_net(struct net *net);
 void mptcpv6_handle_mapped(struct sock *sk, bool mapped);
 
 static inline struct sock *mptcp_handle_join6(struct sk_buff *skb)
 {
-	return NULL;
+	return mptcp_handle_join(skb, AF_INET6);
 }
 #elif IS_ENABLED(CONFIG_IPV6)
 static inline int mptcpv6_init(void) { return 0; }
+static inline int mptcpv6_init_net(struct net *net) { return 0; }
+static inline void mptcpv6_exit_net(struct net *net) { }
 static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
 static inline struct sock *mptcp_handle_join6(struct sk_buff *skb) { return NULL; }
 #endif
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 2f7a621aa24d..b414e2f77fa3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2256,13 +2256,22 @@ static struct inet_protosw tcpv6_protosw = {
 
 static int __net_init tcpv6_net_init(struct net *net)
 {
-	return inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
-				    SOCK_RAW, IPPROTO_TCP, net);
+	int err = inet_ctl_sock_create(&net->ipv6.tcp_sk, PF_INET6,
+				       SOCK_RAW, IPPROTO_TCP, net);
+	if (err)
+		return err;
+
+	err = mptcpv6_init_net(net);
+	if (err)
+		inet_ctl_sock_destroy(net->ipv6.tcp_sk);
+
+	return err;
 }
 
 static void __net_exit tcpv6_net_exit(struct net *net)
 {
 	inet_ctl_sock_destroy(net->ipv6.tcp_sk);
+	mptcpv6_exit_net(net);
 }
 
 static struct pernet_operations tcpv6_net_ops = {
@@ -2287,15 +2296,9 @@ int __init tcpv6_init(void)
 	if (ret)
 		goto out_tcpv6_protosw;
 
-	ret = mptcpv6_init();
-	if (ret)
-		goto out_tcpv6_pernet_subsys;
-
 out:
 	return ret;
 
-out_tcpv6_pernet_subsys:
-	unregister_pernet_subsys(&tcpv6_net_ops);
 out_tcpv6_protosw:
 	inet6_unregister_protosw(&tcpv6_protosw);
 out_tcpv6_protocol:
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..c7370c5147df 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -12,6 +12,7 @@
 #include <net/netns/generic.h>
 
 #include "protocol.h"
+#include "mib.h"
 
 #define MPTCP_SYSCTL_PATH "net/mptcp"
 
@@ -21,6 +22,12 @@ static int mptcp_pernet_id;
 static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
 #endif
 
+struct mptcp_join_sk {
+	struct sock *sk;
+	struct inet_bind_bucket *tb;
+	struct inet_bind_hashbucket head;
+};
+
 struct mptcp_pernet {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *ctl_table_hdr;
@@ -32,6 +39,18 @@ struct mptcp_pernet {
 	u8 checksum_enabled;
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
+
+	/* pernet listener to handle mptcp join requests
+	 * based on the mptcp token.
+	 *
+	 * Has to be pernet because tcp uses
+	 * sock_net(sk_listener) to obtain the net namespace for
+	 * the syn/ack route lookup.
+	 */
+	struct mptcp_join_sk join4;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	struct mptcp_join_sk join6;
+#endif
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -185,13 +204,190 @@ static void mptcp_pernet_del_table(struct mptcp_pernet *pernet) {}
 
 #endif /* CONFIG_SYSCTL */
 
+static void add_mptcp_rst(struct sk_buff *skb)
+{
+	struct mptcp_ext *ext = skb_ext_add(skb, SKB_EXT_MPTCP);
+
+	if (ext) {
+		memset(ext, 0, sizeof(*ext));
+		ext->reset_reason = MPTCP_RST_EMPTCP;
+	}
+}
+
+struct sock *__mptcp_handle_join(int af, struct sk_buff *skb)
+{
+	struct mptcp_options_received mp_opt;
+	struct mptcp_pernet *pernet;
+	struct mptcp_sock *msk;
+	struct socket *ssock;
+	struct sock *lsk;
+	struct net *net;
+
+	/* paranoia check: don't allow 0 destination port,
+	 * else __inet_inherit_port will insert the child socket
+	 * into the phony hash slot of the pernet listener.
+	 */
+	if (tcp_hdr(skb)->dest == 0)
+		return NULL;
+
+	mptcp_get_options(skb, &mp_opt);
+
+	if (!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ))
+		return NULL;
+
+	net = dev_net(skb_dst(skb)->dev);
+	if (!mptcp_is_enabled(net))
+		return NULL;
+
+	/* RFC8684: If the token is unknown [..], the receiver will send
+	 * back a reset (RST) signal, analogous to an unknown port in TCP,
+	 * containing an MP_TCPRST option (Section 3.6) [..]
+	 */
+	msk = mptcp_token_get_sock(net, mp_opt.token);
+	if (!msk) {
+		add_mptcp_rst(skb);
+		return NULL;
+	}
+
+	if (!mptcp_pm_sport_in_anno_list(msk, af, skb)) {
+		sock_put((struct sock *)msk);
+		MPTCP_INC_STATS(net, MPTCP_MIB_MISMATCHPORTSYNRX);
+		add_mptcp_rst(skb);
+		return NULL;
+	}
+
+	sock_put((struct sock *)msk);
+	pernet = mptcp_get_pernet(net);
+
+	switch (af) {
+	case AF_INET:
+		lsk = pernet->join4.sk;
+		break;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	case AF_INET6:
+		lsk = pernet->join6.sk;
+		break;
+#endif
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	ssock = __mptcp_nmpc_socket(mptcp_sk(lsk));
+	if (WARN_ON(!ssock))
+		return NULL;
+
+	return ssock->sk;
+}
+
+static struct socket *mptcp_create_join_listen_socket(struct net *net, int af)
+{
+	struct socket *s, *ssock;
+	int err;
+
+	err = sock_create_kern(net, af, SOCK_STREAM, IPPROTO_MPTCP, &s);
+	if (err)
+		return ERR_PTR(err);
+
+	ssock = __mptcp_nmpc_socket(mptcp_sk(s->sk));
+	if (!ssock) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	ssock->sk->sk_max_ack_backlog = SOMAXCONN;
+	inet_sk_state_store(ssock->sk, TCP_LISTEN);
+
+	s->sk->sk_max_ack_backlog = SOMAXCONN;
+	inet_sk_state_store(s->sk, TCP_LISTEN);
+
+	s->sk->sk_net_refcnt = 1;
+	get_net_track(net, &s->sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+
+	return s;
+out:
+	sock_release(s);
+	return ERR_PTR(err);
+}
+
+static int mptcp_init_join_sk(struct net *net, struct sock *sk, struct mptcp_join_sk *join_sk)
+{
+	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(sk));
+	struct inet_hashinfo *table = ssock->sk->sk_prot->h.hashinfo;
+	struct inet_bind_bucket *tb;
+
+	spin_lock_init(&join_sk->head.lock);
+	INIT_HLIST_HEAD(&join_sk->head.chain);
+
+	/* Our "listen socket" isn't bound to any address or port.
+	 * Conceptually, SYN packet with mptcp join request are steered to
+	 * this pernet socket just like TPROXY steals arbitrary connection
+	 * requests to assign them to listening socket with different
+	 * address or port.
+	 *
+	 * The bind_bucket is needed for sake of __inet_inherit_port(),
+	 * so it can place the new child socket in the correct
+	 * bind_bucket slot.
+	 *
+	 * A phony head is used to hide this socket from normal sk loookup.
+	 */
+	tb = inet_bind_bucket_create(table->bind_bucket_cachep,
+				     net, &join_sk->head, 0, 0);
+	if (!tb)
+		return -ENOMEM;
+
+	inet_csk(ssock->sk)->icsk_bind_hash = tb;
+	return 0;
+}
+
 static int __net_init mptcp_net_init(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct socket *sock;
+	int err;
 
 	mptcp_pernet_set_defaults(pernet);
 
-	return mptcp_pernet_new_table(net, pernet);
+	err = mptcp_pernet_new_table(net, pernet);
+	if (err)
+		return err;
+
+	sock = mptcp_create_join_listen_socket(net, AF_INET);
+	if (IS_ERR(sock)) {
+		err = PTR_ERR(sock);
+		goto out_table;
+	}
+
+	err = mptcp_init_join_sk(net, sock->sk, &pernet->join4);
+	if (err) {
+		sock_release(sock);
+		goto out_table;
+	}
+
+	/* struct sock is still reachable via sock->sk_socket backpointer */
+	pernet->join4.sk = sock->sk;
+	return err;
+
+out_table:
+	if (!net_eq(net, &init_net))
+		mptcp_pernet_del_table(pernet);
+	return err;
+}
+
+static void __net_exit mptcp_exit_join_sk(struct mptcp_join_sk *jsk)
+{
+	struct socket *ssock = __mptcp_nmpc_socket(mptcp_sk(jsk->sk));
+	struct inet_bind_bucket *tb;
+	struct inet_hashinfo *table;
+
+	table = ssock->sk->sk_prot->h.hashinfo;
+
+	tb = inet_csk(ssock->sk)->icsk_bind_hash;
+	inet_bind_bucket_destroy(table->bind_bucket_cachep, tb);
+
+	ssock = jsk->sk->sk_socket;
+	sock_release(ssock);
 }
 
 /* Note: the callback will only be called per extra netns */
@@ -200,6 +396,7 @@ static void __net_exit mptcp_net_exit(struct net *net)
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
 
 	mptcp_pernet_del_table(pernet);
+	mptcp_exit_join_sk(&pernet->join4);
 }
 
 static struct pernet_operations mptcp_pernet_ops = {
@@ -219,12 +416,36 @@ void __init mptcp_init(void)
 }
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int __init mptcpv6_init(void)
+int __net_init mptcpv6_init_net(struct net *net)
 {
+	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct socket *sock;
 	int err;
 
-	err = mptcp_proto_v6_init();
+	if (net_eq(net, &init_net)) {
+		err = mptcp_proto_v6_init();
+		if (err)
+			return err;
+	}
+
+	sock = mptcp_create_join_listen_socket(net, AF_INET6);
+	if (IS_ERR(sock))
+		return PTR_ERR(sock);
 
-	return err;
+	err = mptcp_init_join_sk(net, sock->sk, &pernet->join6);
+	if (err) {
+		sock_release(sock);
+		return err;
+	}
+
+	pernet->join6.sk = sock->sk;
+	return 0;
+}
+
+void __net_exit mptcpv6_exit_net(struct net *net)
+{
+	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+
+	mptcp_exit_join_sk(&pernet->join6);
 }
 #endif
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb975227d12..bc7108ed453c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3794,7 +3794,7 @@ static struct inet_protosw mptcp_v6_protosw = {
 	.flags		= INET_PROTOSW_ICSK,
 };
 
-int __init mptcp_proto_v6_init(void)
+int __net_init mptcp_proto_v6_init(void)
 {
 	int err;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 6b2d7f60c8ad..7ec2513e1c2f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -648,7 +648,7 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
 
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-int __init mptcp_proto_v6_init(void);
+int __net_init mptcp_proto_v6_init(void);
 #endif
 
 struct sock *mptcp_sk_clone(const struct sock *sk,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 77da5f744a17..67a4c698602d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -116,6 +116,9 @@ static void subflow_init_req(struct request_sock *req, const struct sock *sk_lis
 
 static bool subflow_use_different_sport(struct mptcp_sock *msk, const struct sock *sk)
 {
+	if (inet_sk(sk)->inet_sport == 0)
+		return true;
+
 	return inet_sk(sk)->inet_sport != inet_sk((struct sock *)msk)->inet_sport;
 }
 
@@ -216,11 +219,6 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk,
-							 sk_listener->sk_family, skb)) {
-				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
-				return -EPERM;
-			}
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
 		}
 
-- 
2.34.1

