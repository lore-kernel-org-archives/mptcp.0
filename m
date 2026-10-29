Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259513;
	b=GE57N2m1arAYDY8k/JITa0x+r4jokG8SfyDaBkrogU3SniQLvOiz1D+sB9ezKpxRLH9s
	 8aYgJjhC6CTrwPtrMyjC2d5vqI6/mW7cSqTSy2XHK38H3DrEesj+uYYBzl8i4gaAxS1yL
	 E5a24AaeoJZvA24d6JIxxl1spqFibnGN36YFU18nUKW+EbvMf8Pc2OyDrjSoBerX7U2aK
	 JQKMCV0nWzffRsRo9nv6Cp7TVh3DEKj+CFqixtyGg9cxrPNNiXcYcrUC/u7tPJI70NXms
	 rws2QMt2UmC1dtdNLCQ5zBa81/SJKqxzZDX89Vkz9tqiIlRrj3278B/Dr7pOASpflrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6mjr4Wn4qKAhBaXcTjNn4QG4/380rbEBnUhSohCKRBY=;
	b=lZVbYhkvGo0NK2UA+SCB/Tyn0yBohgGCM3IGBiFLwJBSbQFJcM4Q8nP7i2kMajG1yuzS
	 XfQYTb0vN3LtO19v00IF5oOvNoejovjWfHdHjxdW8jMAfHFvIg7B7k0yGX/Wjtyofi858
	 M7iIjiA7ratXz+IIR5jv+17kWGFzsF7U6BqNAiJIE5mzr5HD19VaI4o+wf1MxXuxH9K2P
	 FDH+b1ujVOgHs66RparYVWHmAP3iy0LRecjokeZ0+zstrFfdQ9D5T+JSHekfJvJ4UKQjq
	 W4PYNhaCxVeozh9NOl78zLLi4GvKN2TbTMyHql0E4JhB0mLbpS6LEkIt385NPF4LJJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8FQ3jgS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9F606A31F
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8FQ3jgS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803311F031E5;
	Thu, 29 Oct 2026 07:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259512;
	bh=6mjr4Wn4qKAhBaXcTjNn4QG4/380rbEBnUhSohCKRBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8FQ3jgSLatdTXcZNjSpHCCH2VWZCVU+aDLAxu4J8C92mVpqv8P8AcTXNWfk/5qNT
	 pXclS98KFDma7ul2zNSOpiZwJSu+NqNcMFGqDbDm9WsDlI01aF1ix/1Gip+cjx4/nr
	 e5Si2lrayuYSMBCSkAJS8XZjQV6IkctWJS2eoKU1QB8qW1CpAqig0t0GX/OZe0FpmW
	 l8iNJ2dorRiWtFmsUK9rG628iPkO3V94Z3ODslyjg8rc4lDz3fF4Df7mZ1coyA8G2L
	 PDLDBOsXF6KO2p2+TR6n+KgRM9ak/t0/I57d3GrBp7qutOWEzmoWmkiQTqSXaWgrtb
	 aixqreUD9FrgA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v2 2/5] mptcp: implement peek_len for proto_ops
Date: Thu, 29 Oct 2026 15:38:14 +0800
Message-ID: <5a0397c9d6a1bdbb1ddeb7b2c900a8c1184dee59.1793258749.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute readable bytes at the MPTCP level using
mptcp_data_avail() (bytes_received - bytes_consumed) to avoid TFO
overflow issues. Returns 0 during handshake or when avail >= INT_MAX
(likely torn read on 32-bit), and subtracts 1 when DATA_FIN is received
(msk->rcv_data_fin), mirroring tcp_inq().

READ_ONCE() is used instead of mptcp_data_lock() because mptcp_inq()
will be called from TLS contexts with socket lock held - taking the
spinlock would deadlock.

Wire into mptcp_peek_len() and assign .peek_len in both mptcp_stream_ops
and mptcp_v6_stream_ops.

Note: mptcp_inq() differs from mptcp_inq_hint() by returning 0 (not 1)
when value is 0, and using mptcp_data_avail() with rcv_data_fin check
instead of ack_seq - copied_seq with TCP_CLOSE/RCV_SHUTDOWN check, to
correctly handle TFO scenarios.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0caa31525b90..6f34e3459e8a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4797,6 +4797,33 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 avail;
+	int answ;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	avail = mptcp_data_avail(msk);
+	if (avail >= INT_MAX)
+		return 0;
+
+	answ = (unsigned int)avail;
+
+	/* Subtract 1, if DATA_FIN was received. Mirror tcp_inq() */
+	if (answ && READ_ONCE(msk->rcv_data_fin))
+		answ--;
+
+	return answ;
+}
+
+static int mptcp_peek_len(struct socket *sock)
+{
+	return mptcp_inq(sock->sk);
+}
+
 static const struct proto_ops mptcp_stream_ops = {
 	.family		   = PF_INET,
 	.owner		   = THIS_MODULE,
@@ -4819,6 +4846,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4931,6 +4959,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

