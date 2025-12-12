Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19D274B2E
	for <mptcp@lists.linux.dev>; Fri, 12 Dec 2025 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506451; cv=none; b=mDIqCN8jsbnAyyj39FdpN5i7ajAnsSKgIkJ2xJeTCw/OIzZtPr1RTfkMKErU66/btk5SSSuMqJKQEqux2jrNZ3j065fd6cyDvdZ2BktVzTVSfJxcQwE8FUO08QL8nxpMfqeFqI7Z+dHm7BQ1VSyN6as4L2BpZtCCLpricC4wjhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506451; c=relaxed/simple;
	bh=hmLpiN3dL0NAGpnfcAdxNKyTMuE/QkP93XjVbSIynAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dC5o6xW5JIdtPg2MDTuGuzoRl1dNwAaaAKXgBVL0BlhNzZ4HV7cFMdcJ7Yip8rtkNDcj4UKvrceEltW1G5tIU45RHUoYwKnaV0/Q/oc8wzZqBNLOa7NgdY4RsAjAGXoJnAIsx9D6dSX9AjV9uVWyP1+Iijl7vvtyXlh/2Puw6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCf5fM2n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCf5fM2n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EE2C4CEF7;
	Fri, 12 Dec 2025 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765506451;
	bh=hmLpiN3dL0NAGpnfcAdxNKyTMuE/QkP93XjVbSIynAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCf5fM2n2o6itCD5csh2pbu3sHa/QD/xGQPxe4NHGYtXFaO9lcMUgxHySJ/ABHY5Y
	 O2bpnnnT2yPkjBIEQwuZs2Jas6zyYNU6AaJpOqq0upiCUfiNzecZiX3QSl/iNUGhSG
	 HSND88rGIaM4U7Qdlj+ZU7+I8SQJ77oVnqPBBdSy5vl1B5yUVIpXxZjb/KJyEt0Upn
	 VxIaqJqX3uIEJZTXYUD5WxLHXjq8cd+J1D6gF+a7wlYKnu7suBmUc+hLPy4Prd87dR
	 dq3oS+DIXkuZ9bzuDt6ufn21KkQ7o5ZlYcHC2yqtLfZLC7PngUTiUMhvcitvHEL5TR
	 aVi4fwFwlmOog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 03/10] tls: switch to mptcp_inq
Date: Fri, 12 Dec 2025 10:27:13 +0800
Message-ID: <32d096b7bd6aa7992f33d65e0dd5b1073d03fd80.1765505775.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1765505775.git.tanggeliang@kylinos.cn>
References: <cover.1765505775.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To extend MPTCP support based on TCP TLS, corresponding MPTCP-specific
helper mptcp_inq() has been exported into net/mptcp.h.

Note that there is a slight difference between mptcp_inq() and
mptcp_inq_hint(), it does not return 1 when the socket is closed or shut
down; instead, it returns 0. Otherwise, it would break the condition
"inq < 1" in tls_strp_read_sock().

TLS implementation switches between the respective TCP and MPTCP helpers
based on the detected protocol.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  7 +++++++
 net/mptcp/protocol.c | 12 +++++++++++-
 net/tls/tls_strp.c   |  8 ++++++--
 net/tls/tls_sw.c     |  4 +++-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 050c2e820fc4..4c8e483fcc4b 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -254,6 +254,8 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+unsigned int mptcp_inq(const struct sock *sk);
 #else
 
 static inline void mptcp_init(void)
@@ -345,6 +347,11 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline unsigned int mptcp_inq(const struct sock *sk)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 334fdb10fdf3..82a3b3c70ad1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2242,7 +2242,7 @@ static bool mptcp_move_skbs(struct sock *sk)
 	return enqueued;
 }
 
-static unsigned int mptcp_inq_hint(const struct sock *sk)
+unsigned int mptcp_inq(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
 	const struct sk_buff *skb;
@@ -2257,6 +2257,16 @@ static unsigned int mptcp_inq_hint(const struct sock *sk)
 		return (unsigned int)hint_val;
 	}
 
+	return 0;
+}
+
+static unsigned int mptcp_inq_hint(const struct sock *sk)
+{
+	unsigned int inq = mptcp_inq(sk);
+
+	if (inq)
+		return inq;
+
 	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
 		return 1;
 
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index cdbcb07a52f8..0639130b8d5e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -494,7 +494,9 @@ bool tls_strp_msg_load(struct tls_strparser *strp, bool force_refresh)
 	DEBUG_NET_WARN_ON_ONCE(!strp->stm.full_len);
 
 	if (!strp->copy_mode && force_refresh) {
-		if (unlikely(tcp_inq(strp->sk) < strp->stm.full_len)) {
+		if (unlikely((sk_is_msk(strp->sk) ?
+			      mptcp_inq(strp->sk) :
+			      tcp_inq(strp->sk)) < strp->stm.full_len)) {
 			WRITE_ONCE(strp->msg_ready, 0);
 			memset(&strp->stm, 0, sizeof(strp->stm));
 			return false;
@@ -517,7 +519,9 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 {
 	int sz, inq;
 
-	inq = tcp_inq(strp->sk);
+	inq = sk_is_msk(strp->sk) ?
+	      mptcp_inq(strp->sk) :
+	      tcp_inq(strp->sk);
 	if (inq < 1)
 		return 0;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index c35c25abc40c..30ca332afe41 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1958,7 +1958,9 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
 		return false;
 
 	max_rec = prot->overhead_size - prot->tail_size + TLS_MAX_PAYLOAD_SIZE;
-	if (done - *flushed_at < SZ_128K && tcp_inq(sk) > max_rec)
+	if (done - *flushed_at < SZ_128K && (sk_is_msk(sk) ?
+					     mptcp_inq(sk) :
+					     tcp_inq(sk)) > max_rec)
 		return false;
 
 	*flushed_at = done;
-- 
2.51.0

