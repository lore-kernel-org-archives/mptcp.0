Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602B3B38B8
	for <mptcp@lists.linux.dev>; Mon, 24 Aug 2026 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787555392; cv=none; b=stB4iqjr5RofhT6o3NsxV1EQfqf0e7Jal8nfzM/Rk4+ejIt92yBCBL9qgiMQZZyRNtf6Awd3sLf6+yA0atWMUlUh8vmR++VwN4lp6PLoZ90greCGLT7pVSX7eSgB05mOK6P/oZ2LAqKb2/fpYHNLhkXQbp11XAZKPQk/pLneSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787555392; c=relaxed/simple;
	bh=WNinlTC6l5aJkklnVvmXzVfYe39Y3p+v11qQ5jvFHwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVv/GP2oI4h4IygOlUG3vXpIKa1MA8sMUld0OEuM2lEyCEb5d2hPE7smfCrTVfJb6QIJOz5ASP2ds40MelZKDhZUdva7E8cYwr70MRKy7V/XMxAbagRmxPrb5AUPBLkAiooZiDtByTrVCK47u1q4YE6Jhcab6GM4WIh0xDmYGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5bRtyEm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5bRtyEm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29411F00A3A;
	Mon, 24 Aug 2026 07:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787555391;
	bh=f6RhVjLJ14gSo6WNMgM09WSZMaFCjDVBirOC4KjoxLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a5bRtyEm4S0+yq/5fChByvxojoFtUwMQSVm/OKVS21uuFcSXgzv4X2EjHfYhmTxNB
	 tiu4lPgMjb+TQ28Py6Wr4ZVjjf7RrJDs6rPsNSIfh/hoKJ+Yh07tMSQB+8zgWLYRsk
	 fnJoHhbQArigDU+n7SZ7KrUEWg4e8DHbdUhCFHA2bhX/Ib4SkPyyTfHn6gnkW3M9ao
	 tcan4X65s9XHXzkpzXjwzDigLv8QpggMVtVBSvROJvvaS1waVr2VUZ/tRJkgDScGo0
	 3A329yA4OwFd7qAZeA/D89uOCrnaX/JGyjO/8EA26lVQcI4/G/xm7nr3Xt5HfbDc1A
	 8YW2Y+8lnzDBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 1/5] mptcp: implement .splice_eof
Date: Mon, 24 Aug 2026 15:09:35 +0800
Message-ID: <d733858fe63e5b641314776b72ea978c959003f4.1787554581.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787554581.git.tanggeliang@kylinos.cn>
References: <cover.1787554581.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the .splice_eof interface for MPTCP, namely
mptcp_splice_eof(), to flush any pending data when a sendfile()
operation reaches end-of-file.

The implementation first calls __mptcp_push_pending() to push all
unsent data from the MPTCP layer's write queue to the TCP subflows.
Then, for each active subflow that still has data in its send queue,
it acquires the subflow socket lock with lock_sock_nested(,
SINGLE_DEPTH_NESTING) to avoid lockdep false positives (the MPTCP
socket lock is already held). After that, it calls tcp_send_mss()
and tcp_push() to flush the subflow's send buffer.

Without this .splice_eof support, MPTCP did not flush its pending
data immediately when sendfile() reached EOF. While the data would
eventually be sent after a short delay, this patch makes the
behavior consistent with TCP.

Note: the .splice_eof field of mptcp_stream_ops is set to
inet_splice_eof, which redirects to the protocol-specific .splice_eof
(here, mptcp_splice_eof).

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53..265a07e73a52 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4249,6 +4249,34 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+static void mptcp_splice_eof(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = sock->sk, *ssk;
+	struct mptcp_sock *msk;
+	int mss_now, size_goal;
+	struct tcp_sock *tp;
+
+	msk = mptcp_sk(sk);
+
+	lock_sock(sk);
+	__mptcp_push_pending(sk, 0);
+	mptcp_rps_record_subflows(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk->sk_state == TCP_CLOSE ||
+		    !tcp_write_queue_tail(ssk))
+			continue;
+
+		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+		tp = tcp_sk(ssk);
+		mss_now = tcp_send_mss(ssk, &size_goal, 0);
+		tcp_push(ssk, 0, mss_now, tp->nonagle, size_goal);
+		release_sock(ssk);
+	}
+	release_sock(sk);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4280,6 +4308,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.splice_eof	= mptcp_splice_eof,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
@@ -4773,6 +4802,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4885,6 +4915,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

