Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0293403EF
	for <mptcp@lists.linux.dev>; Tue,  9 Jun 2026 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969058; cv=none; b=nIfT4HT260o2nZyvPu0vzXfW3AeA0fb7sxmGhAmqbYzwHKoIm7dkoxVAwp5N+OJfKxOGwOdXz0wP8fYpGxVle7su3/kwc9Lwm6LqgwR55Dd64Gcl8nNr4fJ2lwLL+YZcirc99+vxQ9unUbYY2e5uF7O9l5Q3S6YRJh4lSSYYdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969058; c=relaxed/simple;
	bh=Ss5WEyIX+gWlbd0J8PRmFD8cn2BY/BsxoHhoBkugjfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzOvGiFfo3z4waYE840qeRMAL2LykLSNjBxLXqu4rOX4Bjp4+k/791v+RGSdoWGNKqdbdjWNJCL3X53+j3NJpll50gg0e8ji/EBBTQ3PDjPR0xfd/aG3joX8pdyuwD6gIdCIJ2A4ZEnBlOFCZRQ6oLDWSaiaRXCIt4776fq9Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7jW6X0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7jW6X0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FB11F00898;
	Tue,  9 Jun 2026 01:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969057;
	bh=1voRG8WD5lox6GM1tbOl/cPMucl7hOuNmnzuLZIfwm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A7jW6X0pp8OKMKGMe0EAie+3skefVu+ogHuiPic0NiPsyVurS2Dr7fErWS2znbQxW
	 iwJh1YjI0paeLdt+98/kUzeerOrgGkRmhImFeECpCZ2xOym24Orqearbk94zRhdq6X
	 iLLYZXkftGAqDurG1frY+S1FT29yRsSJcHV4rU0EXOtUFM3e80HSlWOnuNdsIEpOAh
	 Fik3re7EYNgOROT9P61Kop3eeRYTlhuRmkrO/kOKRRI/KlH22UFwfGOANlt6dGyjDI
	 5+OWv9wGRtL/z0Bob/uxP0MrqSzyBtfgasQkaJF9tgPIVPO38J/wdvCFQFosaRaAui
	 AZCHgxiqtIgEQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 1/2] mptcp: implement .splice_eof
Date: Tue,  9 Jun 2026 09:37:22 +0800
Message-ID: <4c67eaabfff55b92566507ce66800111e8661846.1780968872.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780968872.git.tanggeliang@kylinos.cn>
References: <cover.1780968872.git.tanggeliang@kylinos.cn>
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
index a4f7e99b30db..09c02d6e6024 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4180,6 +4180,34 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
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
@@ -4211,6 +4239,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.splice_eof	= mptcp_splice_eof,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
@@ -4703,6 +4732,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4815,6 +4845,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.43.0

