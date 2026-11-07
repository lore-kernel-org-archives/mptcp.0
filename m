Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053874;
	b=gPKrRAE1rrw4u2/UMWzskckD1qE7+ZQ4bC4n2VSHaeJbcZjdyEHEiY1RVQTlpO0z8LbS
	 +hZDog1CnvwhLxu9RVxM/wxUwb+w/3ZTmT8Xo1pjhgzbuSPOiP/9/6Not0J8nZ8+JmYEi
	 g5YmskZmrcSdNB7tEegdyMgYiTlwweNVBUPZVQkckqERZRsmqgkdB9xDCdKnhrkqUd6+A
	 NNU9g103+mLO79JTnqSoSVFyLb1tecbaOUDDXkY49RjBN3bSOD8gLuMMw/TiEgThrP7lD
	 MObnYE0QxyTl4QkYfsBQ+aQntsfQBkHXEquIjOdGQnoHMjYSVbULHovHqYvCtWpPctA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ty//qhtvMw1aXkRpUg8h/vI+QAJB2abkJB+w2knaCYw=;
	b=ShHr5FRxj8NxEG2Lbke4oPdb1WCryS9N+fA3HEVDx3Hy+P6Eq6nNmlLdJjwj0QB28GWu
	 bjR27noaLS0Po3bpfTLvSx98x4SfVKv0vBT45GCKoYZig4HYrvmOAF7eAWL0Q41YSrmIZ
	 ZtzZCBKTJOuzVDvAicYQkHrKjOhy44jTFOWD8c+r/Igeb2hGPoH81pbtDsWjXvnmIylK4
	 CHGzIN9jr3nMBXSRUxLMNykKC2KNEexgY5XxuO04dPo+5a56GBlcvppuxvbWdEkdoOKId
	 3Akl7c9Zy6uIDYLmBHnBMWR3rkWmh5te6gq3C0xYQRBCEdUSIDieE3QCdwV5yuBhOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e78RjAO6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547B4606A32D
	for <mptcp@lists.linux.dev>; Sat,  7 Nov 2026 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e78RjAO6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B6E1F008A4;
	Sat,  7 Nov 2026 12:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053874;
	bh=ty//qhtvMw1aXkRpUg8h/vI+QAJB2abkJB+w2knaCYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e78RjAO6inQokzADiBbSwNbY9BIGIHvF2PD6EbUP5GMXU1NIyev+E9u8rSfXnKAEt
	 52jd4JQM6SRWl9ZiHiX0Ct43EhIztqWdfkp3S4cUOJytaJxTNFa1SwsOIzifbXFt9I
	 4+4y1Mlfe8rZvnkVumLPnKBGBOd5oTZwklPaf+rq/kzf0SfC2CIyJpL7joF+37zKEF
	 HQv9tRCWGyfU0VwxkIxu5KWH4UOiWMLaPR4vj5qIBf8YYPX3wEhcn2cILZQKylH2MC
	 lhZUAAwwl/oqxuGAfdYV+6H3nL3rzbnL0phxSGeawgzDU3s8qsGxBBxsiofEm/pKLA
	 KLEKO8tpF7kcA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v7 3/7] mptcp: implement peek_len for proto_ops
Date: Sat,  7 Nov 2026 20:17:16 +0800
Message-ID: <a4a85af8c1f0b471d613b0a50ffb0d6df8bf4817.1794053683.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794053683.git.tanggeliang@kylinos.cn>
References: <cover.1794053683.git.tanggeliang@kylinos.cn>
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
index 421df3af1ef9..585730c30da1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4790,6 +4790,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -4812,6 +4832,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4924,6 +4945,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

