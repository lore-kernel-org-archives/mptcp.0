Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775C343D7F
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735315; cv=none; b=sn+6Z7YA31uQyBEnSopQiSelvJBA+4Pa5f3ISeFNrWF327haaMYR2k0362uHnIkUTUqrF5NL5W7lodTsvfimAnIQzKzbZ/iU5Cnv+de7t4gB1/71yxEGvUD9YNLU4+x+kJMa5/BojQyMb5CmOK36/tiq5hUgJRQEGWf2rso5QCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735315; c=relaxed/simple;
	bh=xt5y35oxjJE8bXnEKsX/Dh09GaIMlNmHfrgDoDWzIpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNt5mIXq+gFCvZ7ZhYRnDMqIRod8q69G5LPb/bik18axt0PF35b5sqyqvtRVBCM52F0SheuPS9x22R92xLAVHQLU8+MUV+4Z19X6HC5iK6Cs+6OCYyzMdyVoJTPpTaN+FpyjeqDcx7MG3OEHorj0iiC2BnzDrEmx+l/qUaWLGqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2SYMoGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2SYMoGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF72E1F000FF;
	Wed, 30 Sep 2026 02:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735313;
	bh=HMsW6BZnvR7mMmYjFN5gwgWGxqCh8xqVHU5rI8islsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2SYMoGkg7Q0m3INAC898ZDsr4H1LbbPJHbSys8AOPmCgEZjVWE+OrFDt7PKldbo3
	 a9Ejj91+EvsVSx56ZpcZ5YcOOdx3iQY2X1+uGXtLL5yu10EAWEqqySHqrgrXNiMKZi
	 CP5OxWzxPhcH+nbvE+rszuebbv2urUNtka558KA0ZU5l6gAY1zZbwYXYzdoObQ38UM
	 tQpGrA4X0mtybvk5G92h36hkpNLNwzYYAryNjIJC8k5mciGXAGwsqODkPtwsCY1caW
	 LqUDIvOr2JrkRGl1lpc9Cs2q4QR8w6RMtNLvgB7I6Zmpc16gYszxKRvfOrS5wmtwTe
	 wv2xC8npRTp9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v14 06/11] mptcp: align FIN handling with TCP via SOCK_DONE
Date: Wed, 30 Sep 2026 10:23:40 +0800
Message-ID: <64ec5f3d886de8362ffea9c0cc173dd89487ef1d.1790734083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790734083.git.tanggeliang@kylinos.cn>
References: <cover.1790734083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

TCP uses SOCK_DONE to mark FIN reception because RCV_SHUTDOWN alone is
ambiguous: it is also set by RST (via SHUTDOWN_MASK) without an ack_seq
increment. mptcp_inq_hint() used the latter as a proxy for "FIN pending",
causing over-count and potentially returning 0 to peek_len() on a
RST-while-data-queued socket, hanging TLS/BPF strparser consumers.

Mirror tcp_fin()/tcp_disconnect() in MPTCP:

- Set SOCK_DONE in mptcp_check_data_fin() next to RCV_SHUTDOWN, strictly
tied to the ack_seq +=1 that counts the FIN byte.
- Test SOCK_DONE in mptcp_inq_hint() and mptcp_recvmsg() so the FIONREAD/
recvmsg FIN-handling only fires on a real DATA_FIN.
- Reset SOCK_DONE in mptcp_disconnect() to mirror tcp_disconnect().

Memory ordering: use smp_mb() in mptcp_check_data_fin() to order the
SHUTDOWN, rcv_data_fin, and ack_seq writes before the non-atomic
sock_set_flag(SOCK_DONE) and the subsequent atomic operations in
mptcp_set_state()/mptcp_close_wake_up(). Pair it with smp_rmb() in
mptcp_inq_hint() so a reader never sees SOCK_DONE=1 without the matching
ack_seq +=1. smp_mb() is required (rather than reusing the existing
smp_mb__before_atomic()) because sock_set_flag() uses __set_bit() which
is non-atomic: on LoongArch smp_mb__before_atomic() is just a compiler
fence and a CPU could reorder the SOCK_DONE store past it.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 58b48a8962cc..7eafe904dbc6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -741,7 +741,8 @@ static void mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
-		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		smp_mb(); /* Order SHUTDOWN, ack_seq before SOCK_DONE. */
+		sock_set_flag(sk, SOCK_DONE);
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
@@ -2405,8 +2406,12 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
+	bool sock_done = sock_flag(sk, SOCK_DONE);
 	u64 hint_val;
 
+	/* Pair with smp_mb() in mptcp_check_data_fin(). */
+	smp_rmb();
+
 	/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
 	mptcp_data_lock(sk);
 	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
@@ -2419,8 +2424,7 @@ static unsigned int mptcp_inq_hint(struct sock *sk)
 	if (hint_val >= INT_MAX)
 		return INT_MAX;
 
-	if (!hint_val &&
-	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+	if (!hint_val && sock_done)
 		return 1;
 
 	return (unsigned int)hint_val;
@@ -2492,6 +2496,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+
 			if (sk->sk_err) {
 				copied = sock_error(sk);
 				break;
@@ -3735,6 +3742,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
+	sock_reset_flag(sk, SOCK_DONE);
 	sk_error_report(sk);
 	return 0;
 }
-- 
2.53.0

