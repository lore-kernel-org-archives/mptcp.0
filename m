Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CC3DE450
	for <mptcp@lists.linux.dev>; Mon, 31 Aug 2026 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172095; cv=none; b=OZNtLE++mSxKJ+kDDEnQpUgCpLsl4lPjdYzgRhD0Sut03hTBbYB0ZIfGfrcsLjCyuBS6NY/Am3/DUEFpCz3sR2sjv/Ko+YqzgWUF4kg7hW9/H8aSvjSm/cXj2GP4Lybt+xkoEzNP+YbCitbmlDlBgtY9FZS+SkH9HHrhy6LcQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172095; c=relaxed/simple;
	bh=iRZSL/ILq/QZSyqv2M8CMKz4kDH5kEAKLWUdJDWnp7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZIXXCvPE08G46MR60usQTU5AU3VbrwS5pZAdJNzU60lRL43dQGCtT9bL0iavJI7k6MgOx0ZnIJWkfHbcqBNUsa7fLs0YdFBwFtZufHaSnmhnApZA17a6GcxHd2hC0n6gbMoGKWXQOt5Qsa5c6AntccCH5iCmvOw3I1dduxiFCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjS0wCs9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjS0wCs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933351F000E9;
	Mon, 31 Aug 2026 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788172093;
	bh=5h9ESTqDFdDheMgU2RG5IXMUi8AN4BImaz+Yp6sgE7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjS0wCs97/nrrn+k9BgTbJ6GgXQU4vPaW952j615OTy2PfTqWp/GdJkx75XjcnbID
	 ytQv9SXZOkmZyeYmlmGB7C0RWqRgZaEAkblct5TCm0HHymdSIOXeTERAyYsRof8GNd
	 UpXZhrejYBMBqcQ/Zky6/GYWOW+XCPDD8JnglyLfpZZP/YBAB8kB7CovQIAWlH/75m
	 7dOSIHkcYaxgffPZJ/BC/asskPmVYcniNCiAALV+hO82rCx4pHj4BraN0fs7RX6I4c
	 wy2C37GBn7/BLi+J+3a7DTkaqmIJwav4bKmEW9dtvKvgDh6NHO4FAdxzw7GM5jTowB
	 Bz5ySMaiPbldQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [PATCH mptcp-next v12 06/10] mptcp: align FIN handling with TCP via SOCK_DONE
Date: Mon, 31 Aug 2026 18:27:14 +0800
Message-ID: <916f17d4a2b1e948fd89634e57552243564a0d59.1788171508.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788171508.git.tanggeliang@kylinos.cn>
References: <cover.1788171508.git.tanggeliang@kylinos.cn>
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

The existing smp_mb__before_atomic() in mptcp_check_data_fin() already
orders the SHUTDOWN and SOCK_DONE writes before the subsequent atomic
operations. Pair it with an smp_rmb() in mptcp_inq_hint() (after sampling
SOCK_DONE) so a reader never sees SOCK_DONE=1 without the matching ack_seq
+=1, even on weakly-ordered archs where SOCK_DONE is read locklessly.

Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9bcca31501e7..f970b9242972 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -736,6 +736,7 @@ static void mptcp_check_data_fin(struct sock *sk)
 
 		WRITE_ONCE(sk->sk_shutdown, sk->sk_shutdown | RCV_SHUTDOWN);
 		smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
+		sock_set_flag(sk, SOCK_DONE);
 
 		switch (sk->sk_state) {
 		case TCP_ESTABLISHED:
@@ -2399,8 +2400,12 @@ static bool mptcp_move_skbs(struct sock *sk)
 static unsigned int mptcp_inq_hint(struct sock *sk)
 {
 	const struct mptcp_sock *msk = mptcp_sk(sk);
+	bool sock_done = sock_flag(sk, SOCK_DONE);
 	u64 hint_val;
 
+	/* Pair with smp_mb in mptcp_check_data_fin(). */
+	smp_rmb();
+
 	/* Avoid races vs ack_seq updates and MPTCP_SYNC_SEQ flag. */
 	mptcp_data_lock(sk);
 	if (test_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
@@ -2412,8 +2417,7 @@ static unsigned int mptcp_inq_hint(struct sock *sk)
 	if (hint_val >= INT_MAX)
 		return INT_MAX;
 
-	if (!hint_val &&
-	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
+	if (!hint_val && sock_done)
 		return 1;
 
 	return (unsigned int)hint_val;
@@ -2485,6 +2489,9 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			    !timeo)
 				break;
 		} else {
+			if (sock_flag(sk, SOCK_DONE))
+				break;
+
 			if (sk->sk_err) {
 				copied = sock_error(sk);
 				break;
@@ -3729,6 +3736,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	msk->copied_seq = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
+	sock_reset_flag(sk, SOCK_DONE);
 	sk_error_report(sk);
 	return 0;
 }
-- 
2.53.0

