Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809744;
	b=bG3+K2hvRDx2waT1b9ybAgDsAgqBhw5tC850U5GihM6NErnTYo4Wk61kc5J6FAclKMug
	 nbcreR/YWOnTc77k5f76e1+WSRknXQbZIliPkaYQ1d6nWgirL3PjeOIb+vlNUNMxQF33E
	 D6TPQHkd2tU0isA5wN8WR/pyLolnXnpp1xeDVY478enWYkLOaZsRqGgUdK/sxU9DAqHM+
	 X77adwI0ntMurxz+tzosggZUiwh+YZLzTfboZrHwJB28SqYkm9TVQD8AZlDl/XLq/of+f
	 9Rb2SM4oL+tg+Gy+w/Ohh/SyIORfA7yV2ATekN6i0xeoAJMXPmTKadcRoXYRl1Dovog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809744;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UYBzWb0I+e1ApFMjcrMcGWNIS1qPFLC+9Zlbjn80NzI=;
	b=4xwJnsIprkLnfn7AaWpyBzXxW/c0iPpfe74XLN2TiYHWf0DEHpNnaM46M8n4mHlhAWc/
	 r3uKeKnNnL74WIJecyDogqh5yVlD0V9W9kDAxR8d01pkz9Voexe7VvWYr/erN8B0uYIuM
	 FqR2xDIPT7rxlSlYTHhST9aVSfgWesGCBDO8M5sWCitKl8zChUeEdIaeS0t2S6Geldua2
	 N+MVapSEyal+EHXH02VehVXB8e35P1dPWBaFh+HFVunpG0RHaZU5XmcatQj4biuejO6+m
	 Vyn+XswbetdZOcHWBOCO8JfPbP9cfwDL0fxLZTiqnRlc65bVGaInQDLYohFFuM1JG7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXiWlrQP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F0606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXiWlrQP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7861F00893;
	Fri, 27 Nov 2026 20:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809744;
	bh=UYBzWb0I+e1ApFMjcrMcGWNIS1qPFLC+9Zlbjn80NzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AXiWlrQPbrLrkTLGOD5jWJeeZImpbaz/RpwoLjtBHrFmsSPK+0zc/ZQhYQb2UPeIG
	 yGAzbMvvcVmmmzF1Q1WG7OWlBj/CrYqiJbsMfcNjpE/aqRE6+d59WFNdSPJnBfzDU1
	 nQmP9Msb6RhMzGoAR5twooxCyQf4WJF/BlJN0jzU2FOEV+9IBtaumigR2UaFELzsDk
	 ojlQgJNIiCQtxxzs2YPXsgIvWNUK1+eRLpiZaHgbUT26ZZ6VzgEw8re5+EkuboCs0W
	 Ihznmv6jgMRb3jeNVLN/LqstLZ0zn3vbtiW+vhhBW87rhHNKPMPzde530d7yTRcoJt
	 KK3N4ixKULBiA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:43 +0100
Subject: [PATCH mptcp-next mptcp-net v4 19/20] mptcp: set ECONNRESET on
 disconnect, as TCP does
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-19-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3402; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=PPYPzqGnldB2iMBjJNL//pkXwGJjliitTXvRUUNNsEM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H+4wMzvcYLH+v5/njIJG01MLmOSCehpnLj9170FUm
 c+8vyryHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABN5vpfhv8cf7fV3Uz1mxP3R
 Y1T3Ua/O2LT93akVWX7eHE9M787edInhn8l54QNHbfaVvfWa+08pf5ai+te9Jpz8V+LO8tnY7bT
 lZgEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a disconnect aborts a connection, e.g. connect(AF_UNSPEC) on an
established socket, or shutdown() in SYN_SENT, TCP sets ECONNRESET. It
is then reported once, e.g. by SO_ERROR or the next send(), or returned
by a connect() blocked in another thread, when interrupted by
shutdown(). MPTCP set no error.

Set it in the same cases as tcp_disconnect(), at the MPTCP level: in
SYN_SENT, ESTABLISHED, CLOSE_WAIT, FIN_WAIT1 and FIN_WAIT2, and in
CLOSING or LAST_ACK only if data or the DATA_FIN is still to be sent. As
with TCP, the next connect() clears it.

This changes the errors seen by the applications: e.g. after a
disconnect following a deferred connect with TCP_FASTOPEN_CONNECT, the
next write() now reports ECONNRESET once, then EPIPE, as with TCP. The
test checking it in the MPTCP Packetdrill repository has to be adapted.

This difference with TCP has been found by an AI code review agent,
while reviewing "mptcp: clear sk_err on connect(), as TCP does", and
confirmed with new Packetdrill tests, also checking that no error is
reported in LAST_ACK once everything has been sent, as with TCP. Without
this patch, SO_ERROR reported no error, e.g. after a disconnect in
ESTABLISHED:

  disconnect_established.pkt:18: runtime error in getsockopt call: Bad getsockopt optval: expected: 104 actual: 0

And a connect() blocked in another thread, interrupted by shutdown(),
returned ECONNABORTED, instead of ECONNRESET as with TCP.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v4: new, for mptcp-next, for a difference with TCP found by a review
    agent

Note: it depends on "mptcp: clear sk_err on connect(), as TCP does",
applied in the MPTCP tree: without it, the next connection would report
this error too.

Note: only the MPTCP-level state and data are checked, not the subflows:
e.g. data given to a subflow but not sent yet, or after a fallback, a
subflow still in LAST_ACK with the MPTCP socket closed. To keep it
simple, these rare cases still report no error, as before.
---
 net/mptcp/protocol.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8661fba643a..fd6a72d375aa 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3957,6 +3957,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct mptcp_sock *msk = mptcp_sk(sk);
+	bool aborted;
 
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
@@ -3965,6 +3966,13 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	if (msk->fastopening)
 		return -EBUSY;
 
+	/* as tcp_disconnect() */
+	aborted = ((1 << sk->sk_state) &
+		   (TCPF_SYN_SENT | TCPF_ESTABLISHED | TCPF_CLOSE_WAIT |
+		    TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2)) ||
+		  (((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) &&
+		   msk->snd_nxt != msk->write_seq);
+
 	mptcp_check_listen_stop(sk);
 	mptcp_set_state(sk, TCP_CLOSE);
 	inet_clear_bit(DEFER_CONNECT, sk);
@@ -4020,6 +4028,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sock_reset_flag(sk, SOCK_DONE);
+	if (aborted)
+		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	sk_error_report(sk);
 	return 0;
 }

-- 
2.55.0

