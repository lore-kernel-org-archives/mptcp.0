Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567F2C0303
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245361; cv=none; b=dxpmPctN/a78Fpsi1J4AgQ3969Cent/ufbbOUlqDMRuZtsz3ICrWhkri08HL7btcJHBaCNaGz9HHhnamotZ7X5d1XOKUhMg5bE+Y+kfAPUZR4EaS/59prO2R8Gg4Y9/WtEpKEZ/Vf7xv6+kUqv5qTxkl89SZcq/j6eAUfiwy0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245361; c=relaxed/simple;
	bh=wSOM4H+mIT+d4Hl8rHlDo8LVKIUVL3FZtwIaoXCkDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m87FhRwsZqzvj6vsot2QHyoeqTkr7wpS9uRAKuTfu8JdV0Fj3zLZ32NzKJ2uE5IxCQKFOcp/M/UDnp6vFwy1Rc4H5/aX64asdxQ2mlS4qbPUFA6Gmhe5fsbnGUNifLn/LHpBoH7mrKhoJLWOW/TpwM0YOBygslTJ1ly8N6FamVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZ7mxkHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZ7mxkHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA14D1F000E9;
	Tue,  1 Sep 2026 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788245360;
	bh=lX9HCP3IvGlxXBluWcBrN7LEtNqKQJ4kwMx9MttjhfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZ7mxkHxQmnwgPXi1IKyb/GVhABV957oiHTYXCY50rRa5tfPHIOoFeT31N8qfWUWp
	 9iK74QOo8LVRJQjJCT0p+ru2E3/0sJZpjaS/QqN7IjcqOdCoua8Sy1cJHxncINIu4Z
	 KFnFlTzfj6aXPevlb+l/jLXSmuzmtRangZE7sIm3UBQ8T3zFIR9rzeTcaLihX077I+
	 bNsW8f5QD66DKUl1XphoQ4xsmc/EknkhuBfu2r8eryvs/fOuWY1a9CQ0K5niR8mz6V
	 FPzkFRs9nqbdteslVJYTCxSAtjrqVhHF+kDN2bSO6NYy3Nkx0aLBYsXOiRC+Efns/k
	 DiPrJ5t98Zvog==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v13 06/10] mptcp: align FIN handling with TCP via SOCK_DONE
Date: Tue,  1 Sep 2026 14:48:59 +0800
Message-ID: <837b36993bdfdeb79518c1b5bc1a919a2f37504c.1788245079.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788245079.git.tanggeliang@kylinos.cn>
References: <cover.1788245079.git.tanggeliang@kylinos.cn>
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
index 794d01afb031..f627270042c5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -735,7 +735,8 @@ static void mptcp_check_data_fin(struct sock *sk)
 		WRITE_ONCE(msk->rcv_data_fin, 0);
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
-		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		smp_mb(); /* Order SHUTDOWN, ack_seq before SOCK_DONE. */
+		sock_set_flag(sk, SOCK_DONE);
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
@@ -2406,8 +2407,12 @@ static bool mptcp_move_skbs(struct sock *sk)
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

