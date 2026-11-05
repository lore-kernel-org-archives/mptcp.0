Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860699;
	b=XzpGmWLv4dUviI2rZTclGd7iV5QZ/OMA+jMDu9GNSbOONwAAOoygCJSs/uCEHALX1z7S
	 1pi2d7hfKKiFrPYjQ6Ne1t5MNqXMsRCO5W0JH/KFGpjkS83KJ2u8+yDHDRs27Zjc7hvZ7
	 TZgZ9Jt5B9H+om/O+k9pDRdkVfNkg5m/w3o33jBDJ0JqVbX7czIRk1p8EhDOFwVgcBYna
	 lpKqFOZsfoYd4acXDrpgE7GUepUZiTACaZvwEapg34bbzQG2mRLGbu2ynLxCPiL4DEjMx
	 1d/ELJ4js+Or6wEQbiPahl95yVKX3CIbJFWUUGUijWuFM6EZWnt340e/81wDEk/nkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860699;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1BOj9IwBetuH6wQfgMlaFk13qYefPRDVrU8bFhlZjog=;
	b=PBpkD9KHe+bQXCcnkv/Axt7wsIESRL1QNcrzXD0Sye5zfDPycnTv9ITlok8yaLul0l8Z
	 YvjdkeeAGDrba31jwtvc+kgHOfBC+YTdXqz+Pfiway2vlNwOJITk/tl3UCPRngEsFM96E
	 ucCFlHuZ4iiJ3deID66yFSjHuBDe8aZJPaoO1sUDlWMGsQafYslvK1No7DH3W/TBC7nI6
	 cgMvWJ1VPUO6aMbynbRa4amIpc5xI+OYbXgQIA7jlF2Q3mtvSj0OHfvpZq4CUbm/bXuqP
	 aDQE1qABI3CBtKqF9JlGH/mzDOlbUaMcXaijMRP3g+U2EB1ZpYzpt+sBGoMkcm4Pn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sg19iG18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79F606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sg19iG18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3179A1F00919;
	Thu,  5 Nov 2026 06:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860699;
	bh=1BOj9IwBetuH6wQfgMlaFk13qYefPRDVrU8bFhlZjog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sg19iG18C1Cp9wkoWJHk0FGXEFoVA8YjXfoTnXOp2M1WNXmRMAmFRyzcpCPtkWq+d
	 aw3ZkYASaVwlzf7zAo1llCDDT3NOs5nvCpDSe3SXraFtCBzZ3klrNVOp4V3ouF4ZbN
	 yfczdm+DLZG6H6H+AVXSQ4Y0bBGBJrzaTwQrxMFrj/3N6S/T1MkKUbrOwxFZGiuC7P
	 0sIka7G5s8NFW+mKGd5DJUZOOs7uQOT7e2vJa2D7CxWEhPY6am3EaMHlQXtnAMuvof
	 hC+JUeMc1fOOXiBGLI9oZt7KxoJosYwg5XXEVre5qYpx1nfgQp/+Eh0ewJdPmY/hzW
	 y/MGFYaItKUyg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v6 4/7] mptcp: implement peek_len for proto_ops
Date: Thu,  5 Nov 2026 14:38:00 +0800
Message-ID: <0033cad94cccd9808f0f7eae563bf6d27f414205.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
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
mptcp_data_avail() (bytes_received - bytes_consumed). This aligns with
TCP's design where tcp_inq() is used by peek_len and tcp_inq_hint() is
used by SIOCINQ.

Like tcp_inq(), mptcp_inq() returns 0 during handshake (TCPF_SYN_SENT/
TCPF_SYN_RECV), INT_MAX when avail >= INT_MAX, otherwise the actual byte
count. Unlike mptcp_inq_hint() (which mirrors tcp_inq_hint()), this helper
does not include the EOF hint (returning 1 when socket is closed with no
data) because peek_len is used by upper layers like strp that only need
the data length, not connection state information. It also does not drain
the backlog before reading counters, as peek_len provides a heuristic
value for rate limiting rather than an exact count for userspace queries.

Wire into mptcp_peek_len() and assign .peek_len in both mptcp_stream_ops
and mptcp_v6_stream_ops.

This prepares for upcoming kTLS and sockmap support.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1704e689bc93..aed25c901e4b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4791,6 +4791,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
@@ -4813,6 +4833,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4925,6 +4946,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

