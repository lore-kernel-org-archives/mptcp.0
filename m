Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254147;
	b=ymztv0/hIfG37qXx8PFznPObLGoTi0/2H5xxF0HTySiiguhGOao74OXjzHtUiIEAsJ71
	 KKddMn9IXwXSq4H18izeX/5ShS7cRFfKxNE62FjnI41ulrZ2N62Dghy9vPcHDrgbOnIz+
	 rMXws2uFF1R49EEG6To5mNrJvAKbYpV1OOXe/nkPCoOptVBwdpx98qjhDOPxbnpC0wZQI
	 Y3vh53ojsVw1B3SUeb+Y3pxc2ZwQEFh1LvsyGy2RMwmh06Tqm0yO6uiUWBhz9HTWYH+FG
	 xAxcWHU7daEmfKPATt/RINdGsJxu8XTkOrU2yCMvhimGGGSL2WCZMuRBtKYNYgbKFXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254147;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7n1AQslQEPAAxUCmuc1O+7WfE8WOJXjYr5/K+PVKf+o=;
	b=SnLzbAdCIk+Gl4fiVAOz5s1HbSWdJnRl+Xa9XXrW8NCk1KgL2JBK1gVJ4rHhgZL5OQg7
	 MP6lp2rh1Pv35GUkSsjM/A7ggYQ1J4eP4dAUp21Pe7se4LbUbYRxpTuRtHslNor2NxfJI
	 xd/4/Qb7zN0jlcBN9eIap/oWBAs9ebo2A+olIC3VeErBvjtMeWRw39waaHlzstMDVkt0o
	 3CE31bpR/0PapAdlyR66E8KvvJY2Rdd9zSqXjsFYLRHDidjXNzHrY+iNrRu6fICxLlKu8
	 oTyLZa4aTgKyZlg/EZT1H8jeKZCz1qyxZVpBC8pd0dVJftFR2i6X9ADVn5DRNUmOwpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtfrFD0I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA8606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FtfrFD0I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8671F000C4;
	Sat, 21 Nov 2026 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254146;
	bh=7n1AQslQEPAAxUCmuc1O+7WfE8WOJXjYr5/K+PVKf+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FtfrFD0IvYd3HXyRu90hterXIWNLyqKUICIo1Y2IpPQeq53cYHfCc6G4oiopemf2w
	 wajPZAIAIVirJ9CUCKNgvg8duZ5twXWOZrQoTEhFBcDjz9Y3ziTO6RUqF7LanAfCdc
	 1InX/FnarOLubTq9cNpl+HVN2Xa/1Ea/O39putJTz2aOqkcbQ8RiRJbJ/Y5S2T4ydX
	 b5TuyxHaB7mQjAXpkDXwXVcOCZ9niNhTtDfhDqInPjpbImUMf0HonpHxo13pqm0kt+
	 wu1eQl5F7A0fZezfZBakHsYQO2zJktExn4K8nrXFeuqHWD0/hOQkansbWdcmOI2gn4
	 EIi+zxNHFpMAg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:06 +0100
Subject: [PATCH mptcp-net v2 08/62] mptcp: arm the rtx timer if a push
 leaves data behind
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-8-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3919; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CqKE6HROO2t3zj/guspHPxEgWY1ZJTzXQyiTQEgjGD4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ0/1cNV91R5+0qBJaIvapOqJ8/7mopVv6ROe/K3iaq
 tVufOFRRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETCBRj+8EQzNM1gZrC/zSC+
 s7VrQcrFvUWK7TfPvL1wZvnlqSxc5xkZfupbSVcp2v/3n1/iU+7zedryrQafrrlf/zG3dMWzm3X
 JfAA=
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
Note (Clashiko on v1): timer_ival cannot be 0 here in net: the in-kernel
scheduler sets it before it can fail, and the timer is disabled after a
fallback. Only the BPF schedulers, not in net, are affected.
---
 net/mptcp/protocol.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 54782bdce5fb..fa3d0522a696 100644
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

