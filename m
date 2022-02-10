Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505962C9C
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 15:30:00 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nIBOQ-0003FA-NR; Thu, 10 Feb 2022 16:29:58 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next 1/4] mptcp: prefer ip address in syn skb instead of listen sk bound address
Date: Thu, 10 Feb 2022 16:29:46 +0100
Message-Id: <20220210152949.19572-2-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210152949.19572-1-fw@strlen.de>
References: <20220210152949.19572-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once we change mptcp to use tproxy-like scheme to steer mptcp join
requests to a special pernet socket, the 'sk bound address' becomes
meaningless because it will never be identical to the tcp dport/ip daddr
of the on-wire packet.

Prepare for this: pass the skbuff and use the packet data instead of
the address the listener socket is bound to.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/pm_netlink.c | 17 +++++++++++++++--
 net/mptcp/protocol.h   |  2 +-
 net/mptcp/subflow.c    |  5 +++--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98b485406afa..1696f6fb9baa 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -279,13 +279,26 @@ mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+static void skb_address(const struct sk_buff *skb,
+			struct mptcp_addr_info *addr)
+{
+	addr->port = tcp_hdr(skb)->dest;
+	if (addr->family == AF_INET)
+		addr->addr.s_addr = ip_hdr(skb)->daddr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+	else if (addr->family == AF_INET6)
+		addr->addr6 = ipv6_hdr(skb)->daddr;
+#endif
+}
+
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, int af, const struct sk_buff *skb)
 {
 	struct mptcp_pm_add_entry *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	saddr.family = af;
+	skb_address(skb, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3937ea3f6759..03e3880d274d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -760,7 +760,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, int af, const struct sk_buff *skb);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr, bool check_id);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e727d838da0e..d50cf555ea40 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -216,7 +216,8 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk,
+							 sk_listener->sk_family, skb)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
@@ -748,7 +749,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_sport_in_anno_list(owner, sk->sk_family, skb)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					goto dispose_child;
 				}
-- 
2.34.1

