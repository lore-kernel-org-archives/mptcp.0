Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566363B8939
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788100398; cv=none; b=p5iUT/0vD9FOSXcPMUyY+TtA8kEeGy0/Coxcr7nxSuw0YsKkNf0i13CbpnbRCTeJjxYctudRF2gMTDZF5KOkPC65XMnlt5g6jn1Ps0vN2RA5eRTzCL7mymwgnMuf0Tc2qF4lIT8sbw8KNjQzB7hUn3iaMfqa7uFL6IKIA4NgZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788100398; c=relaxed/simple;
	bh=+PyYjJq8ft/mztzNmFe5Y2ll/YMfeQmwbkfn/MVu/Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2H46lYKjy+6un5pm8qIsn3GCF5I6EcQIAO76U348I+/o5twp4cY3HE87ENyarvvvraEaMlQw6hxYZbBRmFghKmuGZo/FPFGCgrRdGOWciqtUWPAXDl+G0wqm5cJD68daOdPqC6VD7UpgxmwH6ZWsF1YYwEdMGJBDFX/9nsa8FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPqvQhQH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPqvQhQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A51F000E9;
	Sun, 30 Aug 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788100394;
	bh=Nx6j1+/iY9HL/SbKw1oiIX1xw7soTQt1y/PMYGI4cOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPqvQhQHUeEnah6Mo/9Ry+rRX8whHHu76Iethzxses2snNgPv6v2mejjirL7KAyp5
	 ozseIxgJtF8YQ2+i1haN3cYkHfHC4RsTWcrOwy6PF6TQGJfThNzkbUMBYT3v2qW5xG
	 xzz7VtRe2eEXOKNieLJ+zWUJXHJbuTaznDDhyOPPDJjUiFoEnEc+KZaws9eXgxk8/T
	 YC4y3pbXY5x9BrKNzkI7CX3HDfgucXM1ZR3MMbLraQOzqLIQLNyOB4pR8DCG52q1Rk
	 NY0vhl64NCvheYZsbQ0auENb0jAslAX4qBqqahfa87gxyrgSiy9QO7npZygDADvgf/
	 qz2qso+MMYN1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 07/10] mptcp: implement peek_len for proto_ops
Date: Sun, 30 Aug 2026 22:32:50 +0800
Message-ID: <5333db5976d6a9fbfd18fb33eb017d7ab30d0f45.1788099847.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788099847.git.tanggeliang@kylinos.cn>
References: <cover.1788099847.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add mptcp_inq() to compute the number of readable bytes at the MPTCP
level. It derives the count from ack_seq - copied_seq, returns 0 while
the connection is still handshaking (TCP_SYN_SENT/TCP_SYN_RECV), and
subtracts 1 once a FIN has been received, mirroring tcp_inq().

The subtraction is needed because MPTCP's ack_seq is incremented by 1
in mptcp_check_data_fin() when the DATA_FIN is processed, consuming a
sequence number without carrying any payload data. Without subtracting 1,
peek_len would over-report by one byte, causing upper layers to wait for
data that will never arrive.

READ_ONCE() is used instead of mptcp_data_lock() for the u64 reads of
ack_seq and copied_seq because mptcp_inq() will be called from TLS
contexts with the socket lock held - taking the spinlock would deadlock.
On 32-bit systems a torn read can produce a wrapped subtraction (close to
2^64), which is caught by the INT_MAX clamp. TLS callers use mptcp_inq()
conservatively: over-reporting defers work to the next iteration, where
recvmsg() provides the actual byte count.

Wire mptcp_inq() into mptcp_peek_len() and assign .peek_len in both
mptcp_stream_ops and mptcp_v6_stream_ops, so upper layers get the
correct in-queue byte count for MPTCP connections.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c0822ef4ae3..81452a2b6fd0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4809,6 +4809,37 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
 	return ret;
 }
 
+static int mptcp_inq(struct sock *sk)
+{
+	const struct mptcp_sock *msk = mptcp_sk(sk);
+	int answ;
+
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
+		answ = 0;
+	} else if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
+		answ = 0;
+	} else {
+		u64 hint_val;
+
+		hint_val = READ_ONCE(msk->ack_seq) - READ_ONCE(msk->copied_seq);
+		if (hint_val >= INT_MAX)
+			hint_val = INT_MAX;
+
+		answ = (unsigned int)hint_val;
+
+		/* Subtract 1, if FIN was received. Mirror tcp_inq() */
+		if (answ && sock_flag(sk, SOCK_DONE))
+			answ--;
+	}
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
@@ -4831,6 +4862,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct inet_protosw mptcp_protosw = {
@@ -4955,6 +4987,7 @@ static const struct proto_ops mptcp_v6_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.peek_len	   = mptcp_peek_len,
 };
 
 static struct proto mptcp_v6_prot;
-- 
2.53.0

