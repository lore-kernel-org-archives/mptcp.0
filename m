Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557681;
	b=rane3VVRLCQplBeJ0sgIRPh8/PJr7hvoy9KTUjoIDf/H6mVi/ocFX2lYc7BVRx8TeiJX
	 abeakSC2GVDmW5EmCta3AELIm4Yp0asRf3XDKJgoluNcLUGWvXdarpWwQ9BXyyDB15y1R
	 qK1w9u85h/5Y40ZQYrw0liAppMNI2h46vvILW2E3n24+xdVZwF2QUGnomb9dL3eE0JeNF
	 3UmegOaD3+aix8wMz5GqjLbu8WJctN8LJ/LD+VUt9uwkC+PJAqNuwttrV373WsEnukp3N
	 HY9aTJ7uuRptkHt1wOLIyv3iJNwNABKtWaYfO6tTVNG8HbtdkogmvrSCJo0kAc0Ig/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557681;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=b83vJJ70vpcs6EzZe6QVugxjvk8LHtBIsLrG0HUDeo8=;
	b=P0vHIzmOeYE5BWWSGalDJBLZyMOiN4/UGjAmfmQBdvAq36/Ql79qE9UUDSAJKzLFlbnd
	 dWaHp2rkN6VQNioBRcozMpdRQOYSJTp0zcBHo1+c6TxQpb6dvx/wjriFdX6gLRVmnzBId
	 6bPD9LnjORaQ1xhShC30ZCIvfBY47bWe8wYu6ronfUI+RRVshEDzmawezA5PhfPFlLqHT
	 OYjQCEXYZR2OWJTCitibx35CbxnRAR9v0CdYtPAmdG94YDS0BvJ7JWUVoGXU2Sbxhoemr
	 hxZ07NBOUfeSVqBagWgdImZSF7LsI7SNXgf8fZTFcMgPYJf3ibxwAw8mhxW+6VBA6Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjR3o6l9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1A606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XjR3o6l9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB801F000C6;
	Tue, 24 Nov 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557680;
	bh=b83vJJ70vpcs6EzZe6QVugxjvk8LHtBIsLrG0HUDeo8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XjR3o6l9JGgwwnrPcIqH15dihtH1o1bBU5w0Kjv0hteUOpnm9cbBofDdQnu0a7vfm
	 IOB/tLRhNLAgYIIfp/hnEPpz0Uws+0A142u/H9IWsxD0LlkQaeH/Ql7P40bTuT6bUs
	 Iy3IwUrNWuvIwKl7Z/d7AYSPFKCysneZE9K+1p6QUd/9MQi6moHuu8SVrStNPbTSVc
	 a99QBHIYur1p/cn5o1QXn9kqv7SW8ebPRRWhQ2iev8dB8I9UU4ROxHzZ9TLkEccpbp
	 cWlE/97YkbaYB7Rpw7Qc6tEbcCbNwmz0hPiwMYcTos0KLj/tBe4gzSC4i+y6wdfZxU
	 NFkQwq8Pq1I7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:36 +0100
Subject: [PATCH mptcp-net v3 19/50] mptcp: fastopen: keep listeners and
 connections
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-19-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Q7TK+NFZ5u1s2IPhVTeYesNtcJHHUxaR/O0EwSY38Og=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOJmOby+O/XAtV7toepGU9O/r03ur23v+Bwl76T1iP
 ctwUeRZRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwES0mRgZJhsy8fEzv02bG2ru
 JB4g6ORfFBfg6MPErdmzrU629WQQw19hl+qC3fUsfqadj9XnNjHOPiNwKF+lp2bK245dQr4Ht3E
 AAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A sendmsg() with MSG_FASTOPEN on an MPTCP listener fails, e.g. with
EISCONN, as with TCP, but it also closes the listener: after any error,
mptcp_sendmsg_fastopen() retries the disconnect that could have failed
in __inet_stream_connect(), while there is nothing to retry for a
listener. On a connection closed by both sides, with data still to be
read, the same retry also drops this data and the end of the stream.

Skip this disconnect for a listener and for a connected socket:
__inet_stream_connect() returned without trying to disconnect them. They
are then kept as they are, as with TCP.

This issue has been found by an AI code review agent, while reviewing
"mptcp: report sf aborts during deferred connect", and confirmed with a
new Packetdrill test: sendto() with MSG_FASTOPEN on a listener, then a
SYN. Without this patch, the SYN got a reset instead of a SYN-ACK:

  listen_sendto_fastopen.pkt:14: error handling packet: live packet field ipv4_total_length: expected: 60 (0x3c) vs actual: 40 (0x28)

The case of the closed connection has been found by an AI code review
agent (Clashiko), while reviewing a previous version of this patch, and
confirmed with another Packetdrill test: after a shutdown(), data and a
DATA_FIN are received, then sendto() with MSG_FASTOPEN fails with
EISCONN. Without this patch, the data could no longer be read:

  closed_sendto_fastopen.pkt:30: runtime error in read call: Expected result 1000 but got -1 with errno 107 (Transport endpoint is not connected)

Fixes: 7d803344fdc3 ("mptcp: fix deadlock in fastopen error path")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: also skip it for a connected socket, not to drop unread data
    (Clashiko)

Note (Clashiko on v2): only retrying a disconnect that failed, with
SS_DISCONNECTING, would leave a deferred socket stuck after an early
error from tcp_sendmsg_fastopen(), DEFER_CONNECT being cleared on the
msk: then, the disconnect is still retried, as before.
---
 net/mptcp/protocol.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6c712f677220..d529cfb582a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2004,11 +2004,14 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		 */
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
-	} else if (ret && ret != -EINPROGRESS) {
+	} else if (ret && ret != -EINPROGRESS && sk->sk_state != TCP_LISTEN &&
+		   sk->sk_socket->state != SS_CONNECTED) {
 		/* The disconnect() op called by tcp_sendmsg_fastopen()/
 		 * __inet_stream_connect() can fail, due to looking check,
 		 * see mptcp_disconnect().
 		 * Attempt it again outside the problematic scope.
+		 * A listener or a connected socket is not disconnected there,
+		 * as with TCP.
 		 */
 		if (!mptcp_disconnect(sk, 0)) {
 			sk->sk_disconnects++;

-- 
2.55.0

