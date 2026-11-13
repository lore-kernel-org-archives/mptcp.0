Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599671;
	b=oeM7tbC0XeyVDVPZSeIqNpMmarVMrCrpq8ViR118zZiE1mK3Eph6uuAk06fnhpWCqDcG
	 z0xLN3g/qC3O7ZSBGm+kJniiCppMZt/dLF6vzk9C1iOAceYBdA6/xLxGQuH4kWQwTA9AR
	 wwU6DlP6x0brCUmf5Tjks/rPugOKOeeJ/EOgZlDjjxxLuaw79QDq2neOyEmB6uxrfmApA
	 f7++FfgJgf2BvrhBeHuMxuX+DitoA3dfO4u01lwAuTEx7/paYC5z4rrK6mBk06nIdFijn
	 y6YELtAkWPNZGeBzO1M4ZzE9zkiMRJhc+cvbpEYyu1+oLZ9ch/xwB8cKrG5+9x39I7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599671;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j4HmeUuNQnA4qL5jaOPeeDkBW1vR58287ymOw7+6L0U=;
	b=Efgh0x58nbuy2Ik0tw27XFMcOLa3aZ/CYNrUJzidYETNkeJ4/aFGTrPuJC117CqUyVyL
	 PWq+EFC6TPmuxK1oFu57TMhK5z+exhdrHTsYC7N31us9IaosLGad202nlePMpLM8QGYdn
	 qkbYAqc9Hk0cu7EABzgEw8tHDPDHhZYGTvHsNvVERxkbqxKVTzSJqosrKvVwIen4VDsC3
	 CsagZSF9UiIpkdy0L69SkEYjqxRSLBKRbotpqId5U2ubdWZmqCUR5+jr8wLwuOQAfJ46Z
	 oiNvYwFpZl7CLA4YQdfMhxkxSp9YeAL2Hsd0Sik5F5zRQ1h0P8f3Ae1Fvzt8lvQt0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB53D8bh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30852606F34A
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TB53D8bh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1511F000C9;
	Fri, 13 Nov 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599671;
	bh=j4HmeUuNQnA4qL5jaOPeeDkBW1vR58287ymOw7+6L0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TB53D8bhB/Q51lNPU8H2Jn5LsiZWX5oxZwqueUzUNmx/pD7aTP9dhOh076gwokuJ0
	 +5R5LXR9am+NPHY9oqecToDYgB+4t0ek1Hbcg/h/iX6jQg2HcwmUVewbGE74CVp+RW
	 zirkB3p+3knfRp9KJRpcOZyVOknsXk8g4SlETxncWm+wIDhUB4Ij6EuF5bQrmn6g5E
	 VJgkeiWI+DyOoj/7Kr+vXCSatzehh0R/Cc87GDNYXAMT1jNv6HTWPGxbrCvaX27zT+
	 lIF9KWDLxTYyKL/MR8Ef6gqJpELUvI36XMGM1hZOs5WqGEMB/4wktNjVJhezgQqoHs
	 vulJvZ5ET0/QQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:45 +0100
Subject: [PATCH mptcp-net 07/34] mptcp: arm the rtx timer if a push leaves
 data behind
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-7-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3705; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4oOMglXua13HpL5PPzR7A1yA1MdsNmkJBBBLtc6om/I=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z117NT1f52lR+7tnPO0KAXcizRaX9Jw7HC7efaDk0
 G6B3+7POkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbi28bI0HL7ySPX9TE3Lev1
 TpYsFc3jZQ0stjFat9ot98eTkidpFxn+6cied+mRfXRU6/3C1/sX8f6fZ/xVn0HzmuHVvED+7T2
 KHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

In a memory shortage, send() on an idle MPTCP socket can succeed but
leave its data unsent, and the connection stays stalled after the
shortage has ended.

send() puts its data in the write queue of the MPTCP socket, and the
push to a subflow leaves the data there if the memory charge to the
subflow is refused or no skb can be allocated. A push that leaves data
in the write queue has to be tried again, on the acknowledgment of data
in flight or from the handler of the MPTCP retransmission (rtx) timer.
But __mptcp_push_pending() and __mptcp_subflow_push_pending() arm that
timer only if they have pushed data, so with no data in flight and no
timer pending, the data waits for another event, such as the next
send().

The fix used here is to also arm the timer, in both functions, if unsent
data is left in the write queue.

This does not help a socket that has fallen back to TCP, as its rtx
timer is disabled since commit e2ab913f68c7 ("mptcp: do not reschedule
the RTX timer for fallback sockets"). "mptcp: force the charge for the
first skb of a subflow" avoids a refused charge in this case, but not a
failed skb allocation.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
with fault injection: one skb allocation made to fail during a send().
Without this patch, the data accepted by this send() was only sent with
the next one, 60 seconds later here:

  3.007 s: CLIENT send() of 1,000 bytes returned 1000. Allocations that were made to fail in it: 1
  [...]
  63.008 s: CLIENT the second send(), of 100 bytes, returned 100
  63.008 s: SERVER has 1200 bytes
  RESULT-FAILSLAB [...] the_1000_bytes_at_the_server_at=never [...]
  [...] arrived_before_the_second_send=no [...]

Fixes: 2ea6190f42d0 ("mptcp: schedule rtx timer only after pushing data")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: sockets that fell back to TCP are not
  covered + how the issue was found, and its symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e484f7edad49..dc8cdda31a98 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1850,14 +1850,11 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
-	 * will be updated on positive acks by __mptcp_cleanup_una().
-	 */
-	if (copied) {
-		if (!mptcp_rtx_timer_pending(sk))
-			mptcp_reset_rtx_timer(sk);
+	/* also retry later if unsent data is left: no ack may trigger it */
+	if ((copied || mptcp_send_head(sk)) && !mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
+	if (copied)
 		mptcp_check_send_data_fin(sk);
-	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
@@ -1919,13 +1916,15 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	if (copied) {
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
-		if (!mptcp_rtx_timer_pending(sk))
-			mptcp_reset_rtx_timer(sk);
 
 		if (msk->snd_data_fin_enable &&
 		    msk->snd_nxt + 1 == msk->write_seq)
 			mptcp_schedule_work(sk);
 	}
+
+	/* see __mptcp_push_pending() */
+	if ((copied || mptcp_send_head(sk)) && !mptcp_rtx_timer_pending(sk))
+		mptcp_reset_rtx_timer(sk);
 }
 
 static int mptcp_disconnect(struct sock *sk, int flags);

-- 
2.55.0

