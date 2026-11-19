Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795065045;
	b=pSkJO9J93YJpkqMexRWpGH7e4qpvTiCVgZNtGYBkjqJ9mf6vYpZKaA7p4+1IuqFZvR4I
	 793WnSjQ3UVNSPMHEFciTWRzEoR6GzB7wgc7vvzp0sPr6PIM6fesn/IUEqHawak21W66y
	 Zpu8gqXTdrN8tdFZ2lMliNsHmDwHbU1sKcxYpb6vNccSjSrVwJyL+zFbWYu+6HBi0Y4Le
	 mYs0z3cLb2N0ewlcz1V7z/xWLIy5WPkifsq+b6rX9PteYbFxId8Dv0zoggCS/Pfdc5/ap
	 46TlY9sUKw1U0fwG12tYdMShi0s+6FEiQnvyXq3esW21c4cpG9yw8DIz0Wd7FvIV/tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065045;
	h=Received:DKIM-Signature:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DTUEqA+vdZlqvwd8oIXdC/d9bcnUyl/tEZIXKGe2cI8=;
	b=2udO0h6KuGYdK87eofQgll9ib6yhbMTcI/OEe/p6X32a07ztyJlbLtHK7m4ThP+v43P+
	 qmjG6yqDRJYClEUVfpoGabxouFeZ/Splc32jJhJSaADF23SFCyvI7/9uoVKmusdHFzS76
	 Y8Ok8iDud6TNwVHKUti4JtaSP7Wf1HFKW/Aa1d4w8dGxBHafMxOo/Atl2IdOGUuGupj2V
	 6rpgueiASr1LVgVTt6DgTUFesvpN2lDlHjt/gucE2B4alxYjZZXjyLU1TnNGxhnCJn3qc
	 Mex86JnQ2SNSjs1Pc2Cp3r4CKa8XrWyP7felE0upU/P3OuJ7tLG3cfs8ZDI8sZ3TnfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADLAOkNp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AB2606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ADLAOkNp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA321F000C5
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795065044;
	bh=DTUEqA+vdZlqvwd8oIXdC/d9bcnUyl/tEZIXKGe2cI8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=ADLAOkNpHGE8BrG16JPdoj7hKXWqWM3uGat5bSP+bO/B9hZkGzTHKqNabtO/3jWKC
	 rlzrqU90niHeMI6SPyKEVUnqTV1WxFo1MgVTWQSx1DUx5gmlbMHG8DsGLW+IYhOzUk
	 R8n3qDX23FxoVDhp8kGiSZ2AQmCAD/nqZ9n3SaXSh0IwY0+PGzU3DCX0GAHLUQ5dvf
	 03yoQtrejtcfuJOhKSgKBptb2BxZ5zkQOh99PSxQWMFrDnp1T94g8xsemG1uLXrF2v
	 IrrUiNKMSM9I0JF127LNJ7foTEH9DX5Tet7xZSo4l/Nvlr0IA0qRJ/YZA3/8h+M8La
	 Nnfg1vfqdnrMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v29 2/8] mptcp: fix TFO SIOCINQ overflow in mptcp_inq_hint
Date: Thu, 19 Nov 2026 13:10:28 +0800
Message-ID: <f9a5a16a7164ad9e1a09b0f58e99f0e4ab3cdb99.1795063943.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795063943.git.tanggeliang@kylinos.cn>
References: <cover.1795063943.git.tanggeliang@kylinos.cn>
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

Fix mptcp_inq_hint() to compute available bytes using mptcp_data_avail()
(bytes_received - bytes_consumed) instead of ack_seq minus the head skb's
map_seq.

On passive TFO connections, the TFO skb has map_seq set to -skb->len.
Without the removed __mptcp_fastopen_gen_msk_ackseq() to adjust the TFO
skb's map_seq, mptcp_inq_hint() computes "ack_seq - map_seq = iasn + len",
almost always >= INT_MAX, causing SIOCINQ/FIONREAD and TCP_CM_INQ to
report INT_MAX. This also breaks receive buffer autotuning, as
mptcp_rcv_space_adjust() uses mptcp_inq_hint() to measure consumed data.
The bogus hint prevents mptcp_rcvbuf_grow() from being called until the
entire TFO skb has been read.

Using mptcp_data_avail() avoids this by tracking bytes directly. The FIN
byte (+1) is now guarded by rcv_data_fin_seq != 0, so the hint only
counts a FIN when a DATA_FIN was actually received. Without this guard,
local shutdown(SHUT_RD) and MP_FASTCLOSE (which set RCV_SHUTDOWN or
TCP_CLOSE without a DATA_FIN) would incorrectly inflate the hint by 1.
This means with N bytes unread after DATA_FIN, both SIOCINQ and TCP_CM_INQ
report N+1 when rcv_data_fin_seq is set, or N otherwise. This differs
from TCP, which always reports N+1 after FIN because the FIN consumes a
sequence number.

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 382da2532037..072725c6ab5d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2404,22 +2404,15 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(const struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
-	const struct sk_buff *skb;
+	u64 hint_val = mptcp_data_avail(msk);
 
-	skb = skb_peek(&sk->sk_receive_queue);
-	if (skb) {
-		u64 hint_val = READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq;
+	if (hint_val >= INT_MAX)
+		return INT_MAX;
 
-		if (hint_val >= INT_MAX)
-			return INT_MAX;
+	if (READ_ONCE(msk->rcv_data_fin_seq))
+		hint_val += 1;
 
-		return (unsigned int)hint_val;
-	}
-
-	if (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN))
-		return 1;
-
-	return 0;
+	return (unsigned int)hint_val;
 }
 
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
-- 
2.55.0

