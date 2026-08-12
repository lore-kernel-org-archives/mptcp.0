Received: from mta0.migadu.com (out-204.mta0.migadu.com [91.218.175.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFA3939A9
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529195; cv=none; b=D8gjkCL+ujMLCs1nNVMjJzRBwGY01GjBKvJDGvo//esseZIUQhmBSg0m9mieaKCwf4/WFmYXhfp4ktmxCGyQwRcz3B/wgVgOJrcV7oV4qItY6ot3sltmDEkDA8H6cuUyNlNtBEOhYaf7uhEfSNoJFZW67/HBCQXb8mzU+pO0HJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529195; c=relaxed/simple;
	bh=6NTkhoQBUivGYDUENf6SectqtTze71990xlbTKqOl1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uqdcEIcxA2jPDkf2K7iaTM0q5F9cpuHbpl60ZD4eJbayfdbjiOnEwmrV+vml1FaOn3iN9zs0GBxouBAHJFfRcbNuMdTDYcqVtZX5R1ewolkYd9A+gse/66Bfm66itHbVEaG0lw1+5HZ6TjH1igrtag4as5w+B2hz2QtPkLMS6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AwhppazS; arc=none smtp.client-ip=91.218.175.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AwhppazS"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=6NTkhoQBUivGYDUENf6SectqtTze71990xlbTKqOl1c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786529191; v=1; x=1787133991;
 b=AwhppazSl3fY1ddX99Naof5RKMRdjNgXlsLMHSgjFnuSfgtTdt1r5aE6fvOwzndHVO4W//7n
 lsP+6XD41TaMRVxnPOaiB4P38vL1A7tDWh6zC6/m8X+5xjtoTX9glin4G9ZIcz5L4sBqWtZqZ3l
 8Mb/P8zmRgJXQIQLRq4bqlLE=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (120.244.49.214)
	by smtp.migadu.com with ESMTPS id ffa7ce9c9f2a2c7f;
	Wed, 12 Aug 2026 10:06:31 +0000
X-Migadu-Scanner: mta10.migadu.com
Authentication-Results: mta10.migadu.com;
	none
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: pass net namespace to options parser
Date: Wed, 12 Aug 2026 18:05:49 +0800
Message-ID: <20260812100550.148670-2-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812100550.148670-1-gang.yan@linux.dev>
References: <20260812100550.148670-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

The MPTCP options parser will need access to the per-netns MIB counters
to track received invalid options. To prepare for this, pass the net
namespace down to mptcp_get_options() and mptcp_parse_option().

This is a pure refactor with no functional change.

Assisted-by: Claude:GLM-5.2
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/options.c  |  9 +++++----
 net/mptcp/protocol.h |  2 +-
 net/mptcp/subflow.c  | 10 +++++-----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 97da22668dbe..dfdcc888efe3 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -20,7 +20,8 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) == MPTCP_CAP_HMAC_SHA256;
 }
 
-static void mptcp_parse_option(const struct sk_buff *skb,
+static void mptcp_parse_option(struct net *net,
+			       const struct sk_buff *skb,
 			       const unsigned char *ptr, int opsize,
 			       struct mptcp_options_received *mp_opt)
 {
@@ -419,7 +420,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 	}
 }
 
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(struct net *net, const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
@@ -454,7 +455,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode == TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, mp_opt);
+				mptcp_parse_option(net, skb, ptr, opsize, mp_opt);
 			ptr += opsize - 2;
 			length -= opsize;
 		}
@@ -1247,7 +1248,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 		return !mptcp_over_limit(subflow->conn, sk, skb);
 	}
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sock_net(sk), skb, &mp_opt);
 
 	/* The subflow can be in close state only if check_fully_established()
 	 * just sent a reset. If so, tell the caller to ignore the current packet.
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7e168e450fb0..333fb5c89c59 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -927,7 +927,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
 				 struct request_sock *req);
-void mptcp_get_options(const struct sk_buff *skb,
+void mptcp_get_options(struct net *net, const struct sk_buff *skb,
 		       struct mptcp_options_received *mp_opt);
 
 void mptcp_finish_connect(struct sock *sk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5e699d..9a8a39b23fcb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -167,7 +167,7 @@ static int subflow_check_req(struct request_sock *req,
 	}
 #endif
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sock_net(sk_listener), skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYN);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
@@ -273,7 +273,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	int err;
 
 	subflow_init_req(req, sk_listener);
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sock_net(sk_listener), skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
@@ -539,7 +539,7 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	subflow->ssn_offset = TCP_SKB_CB(skb)->seq;
 	pr_debug("subflow=%p synack seq=%x\n", subflow, subflow->ssn_offset);
 
-	mptcp_get_options(skb, &mp_opt);
+	mptcp_get_options(sock_net(sk), skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
 			if (!mptcp_try_fallback(sk,
@@ -842,13 +842,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		 * reordered MPC will cause fallback, but we don't have other
 		 * options.
 		 */
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sock_net(sk), skb, &mp_opt);
 		if (!(mp_opt.suboptions &
 		      (OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_ACK)))
 			fallback = true;
 
 	} else if (subflow_req->mp_join) {
-		mptcp_get_options(skb, &mp_opt);
+		mptcp_get_options(sock_net(sk), skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
 	}
-- 
2.43.0

