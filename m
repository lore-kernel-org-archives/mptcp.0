Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557665;
	b=unIDZtjEfzY8//CjEKDOfF4iiyi4w7NqF8X2W3kKXisuSA7lbFLA3AMBRp4XmaeoUbSN
	 L/2sqSbu1m0xzVrqs21PiCrgxj/CkGI0e5YNepgBaF8lebzDI2IHShHloznQw8so27JK6
	 00Ts8WCNjp5UaDSTJk7Is8RsPoafoFALaTpF591lZ+UOlnMumWM9mDOSVEqSeyb+gKYR6
	 KplMgU/l5GmIh/AqJZ2D5O6xBhIeGP72Kk8RLfizNUxU3WWDflfM9b9RJRU55IhwQSxzn
	 AVBUxAT7lGSfNperEZn8K/gg/VuLk4FYwWepwBcALMm9gS/ahreyYGV4VLermCdaNTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557665;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NQ6O6I9lgWJkoD59oZb2bESSWFObxrQ4jdNicUxSFHg=;
	b=XvkTkXPvDs84qyiOg+a01T8+GVVV29k3nyeJojZ3MrAzMHsCBD7rM/iC9p5ESN6UGZd9
	 /SB6aMNtOAqAA973axpVGk4oCeahvc6XAmCfJecjAIqaOniZ08QxtZWdprMmsrLgROmVR
	 UuK9zEB8bLex+l6cyYeNtRhktQ3A04cOnXKHkUxtCLWlB7mi1EdkuYSDTW6AeR5PAEhQx
	 aTblEPTwfixFxmrHhFNLS6fRf4tOVYdXmLbnUTnF76/Vt3aL1mB35xMHm+INR9bZKjXph
	 W2+YxiNsZzSh0VjXFws9ShDCa0d57fjn0fR4y+zGI8vdG9CTzXZisK4LeP6IgsBC5Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVOOiuxO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF8606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVOOiuxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FA01F000C0;
	Tue, 24 Nov 2026 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557664;
	bh=NQ6O6I9lgWJkoD59oZb2bESSWFObxrQ4jdNicUxSFHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nVOOiuxOMbm0tIYBFEWkEvlC/g3vS23N3rfr01ailwJJxqVT2+TYTLZXsyEWmV8pY
	 AwLjmYJZB1hQAlnaKb1Qi3DOijJIj0ZZZ4T8RI/AVXyc2Yx3miMLMfsbcanaDz8aGn
	 T+twlRpyU26dTU/0PNqlv/5R3qr+9OgENegNE6z4g4AnCcKSNiaxZjGZoswQF6Jm4w
	 lWp2DPsyLGYMnIxPOWIG8RqE5fPd7I5Pqksi0xek84M2r7bbWOuFSTPKxR8S/AGImn
	 Wti68SNRPE201o9lQygc4lgC7wPuK4U5xFeyhzJRzWkHadjAesS7v+HT+mjs4eGEBm
	 ohIeLuIiZ9KSg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:23 +0100
Subject: [PATCH mptcp-net v3 06/50] mptcp: reset the subflow on abort after
 fallback
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-6-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3572; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=v1bW90uvKg98FPN9It079PjRN2cAgOXqW1SJbeBurgg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOH6JayntX7aL54Jae1yyb4vGFI5HtV/qG/m2dt7UU
 2Z/xXSio5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIunxn+F8efmjTVJNeg7+7z
 xIVSpVYHD1n7PF90f/Gxz3WB7xZ/OcXwh6N0b93BuzuCJE9fdjPyWd4u9fSz+VsXry8/S5OC1tq
 KcgIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a fallback to TCP, closing an MPTCP socket with unread data, or
with SO_LINGER and a zero timeout, did not reset the connection as TCP
does: the data still in the MPTCP send queue was dropped, and the
subflow was closed with a FIN. The peer then got a truncated stream,
followed by EOF, without error.

mptcp_do_fastclose() sends a reset on each subflow, except after a
fallback: send it in this case too. No MPTCP option is added after a
fallback: this is a plain TCP reset. Its other callers, on disconnect()
and when the close timeout of an orphan expires, were already resetting
the subflow after a fallback, via tcp_disconnect(), in most states: the
reset is now sent as without a fallback.

When a listener is closed, its MPTCP sockets not accepted yet then got a
second reset from tcp_disconnect(), as already without fallback since
the commit below: move their subflow to TCP_CLOSE after the first reset
too, as done for the other subflows. This has been found by an AI code
review agent (Clashiko), and confirmed with Packetdrill, by counting the
resets: two in both cases, one with TCP.

This issue has been found by an AI code review agent, while reviewing
another fix, and confirmed with a new Packetdrill test: an MPTCP client
falls back to TCP, receives data, and closes the socket without reading
it. Without this patch, a FIN was sent instead of a reset:

  v1_connect_tcpfallback_close_unread_data.pkt:19: error handling packet: live packet field tcp_fin: expected: 0 (0x0) vs actual: 1 (0x1)

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: no second reset for the children of a closed listener, also without
    fallback (Clashiko)

Note (Clashiko on v2): with SO_LINGER set to 0, a subflow in LAST_ACK or
CLOSING gets a reset, while TCP would only drop the unacked data.
---
 net/mptcp/protocol.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f28262f07282..bbb28f778d81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2738,6 +2738,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		subflow->lent_mem_frag = 0;
 	}
 
+	/* also before accept(), not to reset again in inet_child_forget() */
+	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
+		tcp_set_state(ssk, TCP_CLOSE);
+
 	/* If the first subflow moved to a close state before accept, e.g. due
 	 * to an incoming reset or listener shutdown, the subflow socket is
 	 * already deleted by inet_child_forget() and the mptcp socket can't
@@ -2756,9 +2760,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	if (dispose_it)
 		list_del(&subflow->node);
 
-	if (subflow->send_fastclose && ssk->sk_state != TCP_CLOSE)
-		tcp_set_state(ssk, TCP_CLOSE);
-
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
 		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
@@ -3268,10 +3269,7 @@ static void mptcp_do_fastclose(struct sock *sk)
 	mptcp_backlog_purge(sk);
 	msk->fastclosing = 1;
 
-	/* Explicitly send the fastclose reset as need */
-	if (__mptcp_check_fallback(msk))
-		return;
-
+	/* Explicitly send the fastclose reset, a plain one after a fallback */
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 

-- 
2.55.0

