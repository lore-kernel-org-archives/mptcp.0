Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EAAA57
	for <mptcp@lists.linux.dev>; Wed, 23 Feb 2022 11:08:50 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nMpVi-0005hk-Tj; Wed, 23 Feb 2022 12:08:42 +0100
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH 1/4] mptcp: prefer ip address in syn skb instead of listen sk bound address
Date: Wed, 23 Feb 2022 12:08:29 +0100
Message-Id: <20220223110832.29357-2-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220223110832.29357-1-fw@strlen.de>
References: <20220223110832.29357-1-fw@strlen.de>
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
index a0e7d5b7e22f..ed923b573c1c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -269,13 +269,26 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+static void skb_fetch_src_address(const struct sk_buff *skb,
+				  struct mptcp_addr_info *addr)
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
+	skb_fetch_src_address(skb, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c8bada4537e2..6b2d7f60c8ad 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -761,7 +761,7 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq);
 void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
+bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, int af, const struct sk_buff *skb);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c05c19f92532..1fa096086f82 100644
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
@@ -793,7 +794,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
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

