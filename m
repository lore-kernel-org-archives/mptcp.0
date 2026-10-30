Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324665;
	b=WEE29Zu7YEcXiHQluaV+gz1vW2g5P930zhpfr9y1C7ayaJfm4R9CrCPMGWiR5QQjP3hM
	 RK/PLfcZYCo3GgkpvS9IBDGHw0CKrhTn4tdpxT4wme0mSQCQOfxzwl3AI0ijyyam6XmJY
	 hmRKXoFPmJ13+Qe3vWqq41GVxhXX0e0qMyC39C6RoSbFIMtM2swFzff2DGIMGrh6I6XIs
	 ybS3Xb6/rUAbgRKBwrdK1aDN9C8zoBVKyluT+jW/qneA4ojZW5F3WEO1iJJOocTAOqyym
	 6cNiS+y/fkH32gt2uq0qKzHRe8n3RqdWMavtPUOnPeuLv5P9ZHY/odc/8leJ4/Epppg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=D26+i4vNU6/8l3Lxiv/bOsH67gQLcneTBNlJ3SmL1D4=;
	b=PGvvhK8CF4grHO3keTp0H/C+3y/BkHj1jsD4pPaVI/vm5P4EkXSUy0Nyt8yYZ8rpe11X
	 uTfF0HtZn2RbVbngUfj8LPdtcrpEQ0jYI8G25iC9Cer1iZJA2ei9j4hcTExtPNTx61v5T
	 s5ttVLnmCJGlylUjsoYyq638nLPmM16rVh3e4zj6O/+0v+mbndWKMr81wXt8XHteEpxTv
	 hFCJdKkpgTMxA5gGkoSoVu1eH+TrVXcA94L/J30Iau0tGsUEmFWoSnSLZM+YYtNCL+mmK
	 lxCZDCUF3GoBW7VtF/hH/CxsRBibu2g4uQ4kZUfKQGPAUy++ft/DyNWpmUAgCH5e1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSVMM6yp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA6606A31C
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSVMM6yp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5D1F00A02;
	Fri, 30 Oct 2026 01:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793324665;
	bh=D26+i4vNU6/8l3Lxiv/bOsH67gQLcneTBNlJ3SmL1D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSVMM6yp/WM2eI1a+g1x9u1tEZJJKUCzmHqGXHU+SxzaiYWuoBAM7ZMf3j277lMxU
	 I4bZYx26hExaf4cu/aq3Lv15JSBS1Ig/xlNSXGBkfEGFdP4JiCNPNvj5WWTOnC+xcn
	 DhjrLD39w3ciIcuIAtGVA/Kl9qjcG4q/VDUdpmGwSvEizGcY9Ah64G1SasL66y9mGb
	 1SV+gjBOQDSNkNaoilGUE0FlLY0619cDnnjCiM4Aichh1gdbt9SoGoj3hfWNSKRqRq
	 Y5ozsltBVqBHlCZL8syA22CZ7MF/zzmarNLECmPGR4mxrxy9bTv0puCGCg3LCKpEbY
	 2907fJUmrDYFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v3 2/5] mptcp: implement peek_len for proto_ops
Date: Fri, 30 Oct 2026 09:44:14 +0800
Message-ID: <792219afffb4d3cc71ba3286b648b90ea50b1c86.1793324316.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793324316.git.tanggeliang@kylinos.cn>
References: <cover.1793324316.git.tanggeliang@kylinos.cn>
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
(likely torn read on 32-bit).

READ_ONCE() is used instead of mptcp_data_lock() because mptcp_inq()
will be called from TLS contexts with socket lock held - taking the
spinlock would deadlock.

Wire into mptcp_peek_len() and assign .peek_len in both mptcp_stream_ops
and mptcp_v6_stream_ops.

Note: mptcp_inq() differs from mptcp_inq_hint() by returning 0 (not 1)
when value is 0, and using mptcp_data_avail() instead of ack_seq -
copied_seq with TCP_CLOSE/RCV_SHUTDOWN check, to correctly handle TFO
scenarios.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0caa31525b90..dbd6275963b8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4797,6 +4797,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
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
+		return 0;
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
@@ -4819,6 +4839,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4931,6 +4952,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.55.0

