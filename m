Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826674;
	b=wJ+yHxjb8h1y1s16O3sDbiowcoRSzbqQsGuJnJByWIGjb2255Kgj0gQA+6sR4skTpNeG
	 aJP/UqDL0y96F2gdKNxYn2fDQlajMi8blW8UlTIU/Dwh08PWiVoo1GfAJ923G5EYOW/lS
	 xA820w2gtbwiqzq2hIW/dXzuDNXtJvOYgG7Y6+53Y97B88Ypa3IoeCqIyGwCQyPOBmqZI
	 v3FGfmCNXr/gDt4SMQ8xf1uN7nyyu5k1YttxMa29sVqngtfgOBKWQ5YKAWg22XnhXqPhn
	 IcyK5IHxV942FaiyaV8kTzsKaWHX0w/WBXzlbjBXDCPsIki93p6ZkWz21bk8rnih0TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826674;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zz56YeJo0eT+g8zyMVT5viYhBOo6zETWRl7OF8oNXJ4=;
	b=iuSzY0ZxoLRXei6o3Iq64UmtEy2kyzlchBtFLI6z7XnqWny3zJc3Gv5Z/x/vLC1DWWrn
	 2ZWbX2OT9JUskYyRcXlkNMgqJ2G7j6Y2SnNtElwyHje/7AVsThmdCTBS0SzxNwriEHxcv
	 Q6ro0I61G88hTDLDRDXrRsF1OQi5SL+HUWePgc2p9z5lmhf/qJmBNx9iDNbg9n6iSkhYp
	 gCqtybFzUAqaBql5ZxzUtBxooUhbHfcj6+Xi+xUZkIQum31zAODDdw8HN4mrUOAXXPR0a
	 /8Br2B+A/lktGVy4FrfUWdEYLSOaqmQQX+BJNflaOTzEjb1lQzS1K9KeyLOvEkghygA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrromFB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74366606A332
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RrromFB4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B41F000C4
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794826674;
	bh=zz56YeJo0eT+g8zyMVT5viYhBOo6zETWRl7OF8oNXJ4=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=RrromFB4hqfZhveEWQ7MKJzqsEmi6nVcXI8H6oNrGHiQzhu1yxWh5XIsiTfNEYYF/
	 q0q3/DjGa4V/ezxxqKrjSKMwn8Xt15w84fa5+PxLezLUBMlg5k54JdmleEyUCyy00K
	 SAbtFWOsy/c3n0rPOKLVxYC2TgCy+uSNU+2vtjza2YYgO4+8qW9me/HsP7D58E7vbG
	 Qo3JKr6LMa2RsocRuWUp83NFGG4h2vgq++at1hJXmJmGqva9Fdtqf5HfD4hc94mKkH
	 WrJ9kMmtB6j2HXsJAQFO3gNTzT5t5AWQqaoeKkfqevSBK6LMVakp0+pk4MUzIMbmqZ
	 zBahchbWPyO+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v8 3/7] mptcp: implement peek_len for proto_ops
Date: Mon, 16 Nov 2026 18:57:41 +0800
Message-ID: <0ecc320bbed2cf5713fd0e23c71bbb7127370a70.1794826541.git.geliang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794826541.git.geliang@kernel.org>
References: <cover.1794826541.git.geliang@kernel.org>
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
mptcp_data_avail() (bytes_received - bytes_consumed). It returns 0 during
handshake (TCPF_SYN_SENT/TCPF_SYN_RECV), INT_MAX when avail >= INT_MAX,
otherwise the actual byte count.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops.

Unlike mptcp_inq_hint() (used by SIOCINQ), mptcp_inq() does not include
the EOF hint (returning 1 when socket is closed with no data) because
peek_len is used by strparser to check whether the whole message is
already queued, not to report connection state to userspace. It also does
not drain the backlog before reading counters; the caller mptcp_ioctl()
handles that for SIOCINQ, while strparser only needs a heuristic value.

This prepares for upcoming kTLS and sockmap support.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 574eba9989a8..a0ad28f5a385 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4789,6 +4789,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	u64 avail;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return 0;
+
+	avail = mptcp_data_avail(msk);
+	if (avail >= INT_MAX)
+		return INT_MAX;
+
+	return (unsigned int)avail;
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
@@ -4811,6 +4831,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4923,6 +4944,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

