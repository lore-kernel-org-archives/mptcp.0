Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3976ADB
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 23:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645744950; x=1677280950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ueI6AXKUpu13rwh4tTo1/sxA24G7VVoqab0DpiBrETk=;
  b=XE83anwOAkJjbHouI+aNJBclGeR/v+kQAapd3YJcfg4HORMqOQhTJDJv
   I9NfogvD39fFirjCWaUtUWnZMiXts9B6RjP4oJ2yq9D1R1w3WzPBXZ8zx
   HgjsftIgUZM0XS3DXJhfBnI74A9tUhExY9V/RamWNlVJXTbzVAnvswHJq
   CvhtQUDgYr9V67kX8GH7IzBymXn7+R/feC5+2Qi1oB9l0UWujD8owZ12b
   cj/80WRWPmU9ONgSG+GVzw5DKz558llEn3FSDglfavAiAEQkAAAxcOqVe
   btKDjszxnNfBGaNZ3eEUVifMDY1dj3Fyio1zd7Nw9Wqi0duYAfv7ng3as
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="232998397"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="232998397"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="491784931"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.28.67])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 15:22:28 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	fw@strlen.de
Subject: [RFC PATCH mptcp-next 2/4] tcp: Allow tcp_check_req() to return more status values
Date: Thu, 24 Feb 2022 15:22:24 -0800
Message-Id: <20220224232226.259304-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
References: <20220224232226.259304-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_check_req() can already use an output parameter to set req_status,
indicating whether the current thread has lost a race to process the req.

Convert this bool pointer to instead use an enum, so tcp_check_req() can
look for and set status values indicating other situations. This is used
in a subsequent commit to check for a MPTCP MP_JOIN header. There is no
functional change intended in this patch.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 include/net/tcp.h        | 10 +++++++++-
 net/ipv4/tcp_input.c     |  4 ++--
 net/ipv4/tcp_ipv4.c      |  6 +++---
 net/ipv4/tcp_minisocks.c |  6 +++---
 net/ipv6/tcp_ipv6.c      |  6 +++---
 5 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 04f4650e0ff0..0215acaec29f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -382,9 +382,17 @@ enum tcp_tw_status {
 enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait_sock *tw,
 					      struct sk_buff *skb,
 					      const struct tcphdr *th);
+
+enum tcp_req_status {
+	TCP_REQ_OK = 0,
+	TCP_REQ_LOST_RACE = 1,
+	TCP_REQ_MP_JOIN = 2
+};
+
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req, bool fastopen,
-			   bool *lost_race);
+			   enum tcp_req_status *req_status);
+
 int tcp_child_process(struct sock *parent, struct sock *child,
 		      struct sk_buff *skb);
 void tcp_enter_loss(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2088f93fa37b..7eb02f9da3c9 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6457,12 +6457,12 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	req = rcu_dereference_protected(tp->fastopen_rsk,
 					lockdep_sock_is_held(sk));
 	if (req) {
-		bool req_stolen;
+		enum tcp_req_status req_status;
 
 		WARN_ON_ONCE(sk->sk_state != TCP_SYN_RECV &&
 		    sk->sk_state != TCP_FIN_WAIT1);
 
-		if (!tcp_check_req(sk, skb, req, true, &req_stolen))
+		if (!tcp_check_req(sk, skb, req, true, &req_status))
 			goto discard;
 	}
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index feb779d1fd21..73e5726af8d0 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2030,8 +2030,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		goto do_time_wait;
 
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		enum tcp_req_status req_status = TCP_REQ_OK;
 		struct request_sock *req = inet_reqsk(sk);
-		bool req_stolen = false;
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
@@ -2067,13 +2067,13 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			iph = ip_hdr(skb);
 			tcp_v4_fill_cb(skb, iph, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_status);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
 		if (!nsk) {
 			reqsk_put(req);
-			if (req_stolen) {
+			if (req_status == TCP_REQ_LOST_RACE) {
 				/* Another cpu got exclusive access to req
 				 * and created a full blown socket.
 				 * Try to feed this packet to this socket
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6366df7aaf2a..3d989f8676a5 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -562,7 +562,7 @@ EXPORT_SYMBOL(tcp_create_openreq_child);
 
 struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 			   struct request_sock *req,
-			   bool fastopen, bool *req_stolen)
+			   bool fastopen, enum tcp_req_status *req_status)
 {
 	struct tcp_options_received tmp_opt;
 	struct sock *child;
@@ -774,7 +774,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 	sock_rps_save_rxhash(child, skb);
 	tcp_synack_rtt_meas(child, req);
-	*req_stolen = !own_req;
+	*req_status = own_req ? TCP_REQ_OK : TCP_REQ_LOST_RACE;
 	return inet_csk_complete_hashdance(sk, child, req, own_req);
 
 listen_overflow:
@@ -803,7 +803,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 
 		if (unlinked)
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_EMBRYONICRSTS);
-		*req_stolen = !unlinked;
+		*req_status = unlinked ? TCP_REQ_OK : TCP_REQ_LOST_RACE;
 	}
 	return NULL;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b414e2f77fa3..4706aad6dd8f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1682,8 +1682,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		goto do_time_wait;
 
 	if (sk->sk_state == TCP_NEW_SYN_RECV) {
+		enum tcp_req_status req_status = TCP_REQ_OK;
 		struct request_sock *req = inet_reqsk(sk);
-		bool req_stolen = false;
 		struct sock *nsk;
 
 		sk = req->rsk_listener;
@@ -1716,13 +1716,13 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			th = (const struct tcphdr *)skb->data;
 			hdr = ipv6_hdr(skb);
 			tcp_v6_fill_cb(skb, hdr, th);
-			nsk = tcp_check_req(sk, skb, req, false, &req_stolen);
+			nsk = tcp_check_req(sk, skb, req, false, &req_status);
 		} else {
 			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 		}
 		if (!nsk) {
 			reqsk_put(req);
-			if (req_stolen) {
+			if (req_status == TCP_REQ_LOST_RACE) {
 				/* Another cpu got exclusive access to req
 				 * and created a full blown socket.
 				 * Try to feed this packet to this socket
-- 
2.35.1

