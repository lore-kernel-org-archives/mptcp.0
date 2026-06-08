Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70538888F
	for <mptcp@lists.linux.dev>; Mon,  8 Jun 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910136; cv=none; b=TSBez4yTXH7i3UyCpgy8z4a1pats99Ca/g9yWCKsQhM7jUttkw50et1+x59H0RwdbK37MLgqcwvjDnfEWBvA/5uwK0nbhpIOj4EX5Bkn27Qadn3kkOJl/8r2LDMg4KwD1Kbubc2hZEmmh0VSa4i7U+OqwSOazierhr0PMYeyqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910136; c=relaxed/simple;
	bh=Ss5WEyIX+gWlbd0J8PRmFD8cn2BY/BsxoHhoBkugjfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlvgiRLJZ1pn93iFnDPc6jZTVYw4dR0aUXBZZAv0W/GFax2ieN+HW29GrPLzq2LX0hha5ClZ5/suXDVYYu1yDpBojBB1l+tPSW2YD1HfM2CETwkfruLGEgZPlQRzHRriDCEgs4q9aSAz8EwPs1mjdMh9OiqQHMpg/t2TxBKVLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4q6JMcj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4q6JMcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7111F00898;
	Mon,  8 Jun 2026 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910134;
	bh=1voRG8WD5lox6GM1tbOl/cPMucl7hOuNmnzuLZIfwm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4q6JMcj5QEd2GBmK5xuH9uQ4koXJUcUs8kkomuF2xfy2+ryn+mzMtKAlke5PoKZc
	 ExhKpHtMUXCfRs1iajCjUJ9/bncQ7y5dT/PoW/jrcfWRnrMZ6p57W+toF4RvY1AWy9
	 /PhvngWPrlpVu1AIrh2udWNL7r6iDKv1PnSIwSptCxZOzFlqlWpKSvNrYqealyqrvK
	 uvr2S/ywwF4yZ9Fh99XyGqTnwgxz4Au/zinT9zIYP4wpltnqYffnNeaispbDPS1z7e
	 QvYN6RjjUNrbkWC+sbXUooOBSCskM5j4U2vNbxVNep68Asb9D98KhDEAC9WE9jINf1
	 bPjjcWFWIJk+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 1/2] mptcp: implement .splice_eof
Date: Mon,  8 Jun 2026 17:15:20 +0800
Message-ID: <b97a556294736129e643e350fef5407b02a2abb0.1780909894.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780909894.git.tanggeliang@kylinos.cn>
References: <cover.1780909894.git.tanggeliang@kylinos.cn>
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

