Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557678;
	b=wA36g/+ekcWEewc6ikqR2a8nymZO0Ke6RE9b6hQhZYKz1elM4m4vszgp+7N9nDBUFfyl
	 bA1MbCs/dPp19pGijJ9AbnL+oBLZyMPOptvBN8bGNkSE5U9xsQjC/ESKCNdaefmf6zHjN
	 mtGySMT4Nxn9pbQLf9bSnGhxvzeYSfDZp6aJXtg3t59NwarERCn64TG6T/bcVO8Qr3kvl
	 0LKZX83g5ZToYY4ca8aAZEZw3MmPn568/FNdB5N+543N2wu36I6PCq9dNFO/UyK895iL6
	 MSGwGmORimSJ8ettdMwp0ogygytmGZWgI+MlOkqEeb76xKm35WhDXb8Bms6KMpSBQ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557678;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IUgGOpysbTOEziieM2X3tGQbL6K6Uw7HbwzTMwuc+Xs=;
	b=QWCGIASiZ81xCJ4/ejNqST3716rHgzqcHBAErX2hbzjSCD99ZYCa4pQFafHG9KUa1ZVw
	 iaOydEaGrTqOfIvz1jjZ9UvSxZURDEuF3i4fsacGy9aWpDnBWRhqymkCTZdZV7CIGdTwf
	 RTIA01ChRST/SPrzhiGMFx+UX65XjLy913vB48jxy/yORRfXGOpoeWWUdR52bXRRKM8z0
	 z7bojXbHe8Kr7k9PiEzRiReNOX3hIN3aw6m8G7ElxtkqRSvwbEjIs+Ww1CanV+hBVz96v
	 5P3BYlE7Gt5slFAdLXkV1J3CjYWjIL2n8fRSK9fxuRPcNUDhne4/eRP7ocfiLTl6CIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ92sUnA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EB606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJ92sUnA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3954F1F000E1;
	Tue, 24 Nov 2026 22:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557678;
	bh=IUgGOpysbTOEziieM2X3tGQbL6K6Uw7HbwzTMwuc+Xs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jJ92sUnAO/ISDNvj5AB3H7Pc7Toso9LS02+QIngG3ZZf2vUBUsKmVy+9+AUrP3VQq
	 3cb/OTk3b+hJtMtqGx3Ugr2aQ1MZnDn5JWCNcBs9iUMUegaiQ17EOZW1SG5LNRqYCe
	 NomkpQt2iCEBCgm8Z/j2Dn8XCKYSlFxBMqlDcPlrLye1XZykQ78jr8hlDTbFwDNXg6
	 XLW5ZWAdatE+JwR33OxDsfKxdGKvmvSQ24OH8zzbmdLZZZGWaDkrP0SZitVgY14MU6
	 tjvejsAxvn/jE4pEy4btpiXFgcgpHcsd5HiiPeUCwUrUUt0je6IjGxv8PC/pB2Kduf
	 hzPQlC0V6BP8g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:34 +0100
Subject: [PATCH mptcp-net v3 17/50] mptcp: report sf aborts during deferred
 connect
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-17-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bhtVu3TjvWCT3TuBvU5Xhp7ILbUH9r7lfcLejtyHhg0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOBkvl1QKHH3ecDPlqcXi0zvczBtUjqg8eHXQTXt7A
 We6xWeOjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIksnsnwz6rge2pC9P753bd/
 ek90z+AWEs7vUn0qfq6eYc48gz7r44wM32Yv0+GTe3Qms7VF+uzmV/x6nfzmq+bXq0X4Td3GeeA
 kDwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With TCP_FASTOPEN_CONNECT, connect() on an MPTCP socket only sets
DEFER_CONNECT on the first subflow and on the msk, and the first write()
sends the SYN with data via mptcp_sendmsg_fastopen().

If the first subflow is aborted by tcp_abort(), e.g. via a sock_diag
destroy request or the bpf_sock_destroy() kfunc, while mptcp_sendmsg()
already owns the msk socket and is waiting for the subflow lock:

- tcp_abort() clears DEFER_CONNECT on the subflow, and moves it to
  TCP_CLOSE;
- subflow_error_report() can only set MPTCP_ERROR_REPORT, because the
  msk is owned by the user: the msk stays in SYN_SENT, with
  DEFER_CONNECT still set.

tcp_sendmsg_fastopen() then skips tcp_connect(), and calls
__inet_stream_connect() with the msk socket, the first subflow being
grafted to it. Because DEFER_CONNECT is set on the msk, -EISCONN is
returned to userspace, on a connection that has just been aborted.

Detect this case once the subflow lock is held: if DEFER_CONNECT is set
on the msk, but no longer on the subflow, the subflow has been aborted,
or disconnected. Propagate the subflow error to the msk directly,
instead of waiting for the msk release callback. mptcp_sendmsg() will
then report this error via sk_stream_wait_connect(), like plain TCP
after tcp_abort(), e.g. -ECONNABORTED. The deferred error report is then
a no-op, so the error is not reported twice.

Without the race, the msk is already in TCP_CLOSE with the error set:
the same check also avoids going through tcp_sendmsg_fastopen() and
__inet_stream_connect() in this case, except with MSG_FASTOPEN. As TCP
does, write() then reports the error without disconnecting the socket.
With MSG_FASTOPEN, the socket has to be disconnected, as with TCP, for
the next sendto() to connect again, and the race cannot happen:
__mptcp_nmpc_sk() requires an msk in TCP_CLOSE.

Clearing DEFER_CONNECT on the msk from tcp_abort_override() instead
would not be enough: tcp_abort() is called on the subflow without the
msk lock, and mptcp_sendmsg() checks the msk bit before taking the
subflow lock. The abort can then happen in between, and write() would
return -EALREADY, followed by a disconnect of the msk dropping the
deferred error. In this path, only mptcp_sendmsg_fastopen() holds both
the msk and the subflow locks, and sees a consistent state.

This issue has been reported by Sashiko, while reviewing the commit
below. It has not been reproduced: the abort has to happen while write()
owns the msk socket, and waits for the subflow lock.

Fixes: 93723db43e51 ("tcp: Clear DEFER_CONNECT before tcp_connect() and in tcp_abort().")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue spotted by Sashiko
v3: comment and msg: also after a disconnect, and what write() does
    without the race (Clashiko)
---
 net/mptcp/protocol.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 257c851c8a76..87f6da0f6cab 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1960,8 +1960,6 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	/* on flags based fastopen the mptcp is supposed to create the
 	 * first subflow right now. Otherwise we are in the defer_connect
 	 * path, and the first subflow must be already present.
-	 * Since the defer_connect flag is cleared after the first succsful
-	 * fastopen attempt, no need to check for additional subflow status.
 	 */
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		ssk = __mptcp_nmpc_sk(msk);
@@ -1974,6 +1972,19 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 	ssk = msk->first;
 
 	lock_sock(ssk);
+
+	/* subflow aborted or disconnected: its error report may be deferred.
+	 * With MSG_FASTOPEN, the socket is disconnected below, as with TCP.
+	 */
+	if (unlikely(!(msg->msg_flags & MSG_FASTOPEN) &&
+		     inet_test_bit(DEFER_CONNECT, sk) &&
+		     !inet_test_bit(DEFER_CONNECT, ssk))) {
+		inet_clear_bit(DEFER_CONNECT, sk);
+		__mptcp_subflow_error_report(sk, ssk);
+		release_sock(ssk);
+		return 0;
+	}
+
 	msg->msg_flags |= MSG_DONTWAIT;
 	msk->fastopening = 1;
 	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);

-- 
2.55.0

