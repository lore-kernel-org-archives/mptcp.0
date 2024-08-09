Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638E1DFF5
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207085; cv=none; b=YOQ9P8km2q9Iy3sXG97Ked0XerPkwAaca0lg0/rgu3dgF6oO7Hpit0X/KGfSdOANtuV+BfN+cIQRuX28HXUlkG97FHmR3HQVCAlinbdQ7ZmlFvawrRd0mARO/dfkYlfT1qLrYZuZ4vO70X7FFDgMCbej6E9fQJpLaGIVQOSebGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207085; c=relaxed/simple;
	bh=5VnEQ7lL31LgxTCTmas2JNcabMLme32mKIxTeFksTd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRKGyn3lsRn8HUuvLe6nDPYZP6v7usTILq82MGdypmNogB+ub6MdHdDOolrQqbpFZe8NeYi3kwUbgUZI1+JNuk49jd71DFGMBOLPsbXZ23pMEj4xdFsrTBlQ7etIrpQ5vPiTn9HjZLwdjN0IqegWA4IuuAE+1yNUe5h1HZR1hxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brIpLkmv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brIpLkmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148FAC4AF0B;
	Fri,  9 Aug 2024 12:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723207084;
	bh=5VnEQ7lL31LgxTCTmas2JNcabMLme32mKIxTeFksTd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=brIpLkmvQhiC+pYzpd8Trs11xK1WVx5LZB2qFqO0YhIcYyigHYratCKne4KTGHEDx
	 5wE4Ty87qUhPtBSoUILZp3Sm1+g17ERvJb/Nbyk2cFXoGTqtJwPtBWGj918aeGi6Mk
	 E/5oMfx0MozT3fVuIzHJCc4zz2gueUA9QtEiiYwvPWkEsLDOvOipjizJpsvSj320vX
	 sqEfkhszVt7m4vhVuQPgRQXAtZu2RLMTmv9Zmkmr9nNR0fcj2dboehRutnYfZGKZJ+
	 h/MI2/jr00lVFCBNs6TOTZmIB7jmf2FxqN20Kh7Nr3C5TPtF/qmHSsl+Wcqi9ISzlB
	 bnEwLTQSGmd+g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 09 Aug 2024 14:37:49 +0200
Subject: [PATCH mptcp-net v7 1/3] mptcp: close subflow when receiving
 TCP+FIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mptcp-pm-avail-v7-1-3d0916ba39b4@kernel.org>
References: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
In-Reply-To: <20240809-mptcp-pm-avail-v7-0-3d0916ba39b4@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5VnEQ7lL31LgxTCTmas2JNcabMLme32mKIxTeFksTd4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtg2qc6wkbX28uL5/F3MtFPnqNpCVLZRVFewuy
 24ArIuRzSCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrYNqgAKCRD2t4JPQmmg
 cxdCD/9hN7IICTT4hF1szbKYjqwaF+xf/zkd+xLy4xhudyJTYSfapipBXEeMatgfZocpZRtmzsL
 dyXH98QcuqidUhmj/XPg2nyX/TZBOeooi3fsTLaGMmHQgAehwQRfOsUPVPz5x9riIEioLFPum+Q
 2mg+BVHKuLY4wYa5zGONtWQlY2wdf3z7c3l6DoLW+6G6xYV/aJgko4hDjyU6weR797FhaZBnnYU
 SWOg7mz3kkhp2rsQCSzx48xOdEXerAv3RDCciLWUDuvLBrJTg3ER8enaPiv5f1CBO2RluF7xsJW
 0pEfN93HNQt8jqQ7HAHIxoRVL+sfRmoepZ8XYKX+xEiJ1u1CVGVvbpxMOvgMYscIGDhvHgHmAtj
 hm6nTCq0GP+z042yC8iqOhMDsfMSOhFWTgGm3+w+zTRLpoXNXREXWNgh9dA0Seca5j72gUG3eOR
 sfeEnZwefI/3D+QDutBQglDcckElSShbNYrVoMwNzUN7z5/E4enoStwYjBp6d99NIBMiqpZQzn0
 CPy+PGpIQdOLPN5MXEGIDX+pE3l5k4XrSh3YeKwnq0r7ZLCs2DDSW+o/mbbJnLbpnT/5waAl6V5
 v16W5kgcsdjnqazD6DXf/dp8iYisLuJ/77Z9wnvn0IjORyytL4c9vERhpnx0OKUI1j+o2jlNKs1
 aFCAd0sejJpDsKQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When a peer decides to close one subflow in the middle of a connection
having multiple subflows, the receiver of the first FIN should accept
that, and close the subflow on its side as well. If not, the subflow
will stay half closed, and would even continue to be used until the end
of the MPTCP connection or a reset from the network.

The issue has not been seen before, probably because the in-kernel
path-manager always sends a RM_ADDR before closing the subflow. Upon the
reception of this RM_ADDR, the other peer will initiate the closure on
its side as well. On the other hand, if the RM_ADDR is lost, or if the
path-manager of the other peer only closes the subflow without sending a
RM_ADDR, the subflow would switch to TCP_CLOSE_WAIT, but that's it,
leaving the subflow half-closed.

So now, when the subflow switches to the TCP_CLOSE_WAIT state, and if
the MPTCP connection has not been closed before with a DATA_FIN, the
kernel owning the subflow schedules its worker to initiate the closure
on its side as well.

This issue can be easily reproduced with packetdrill, as visible in [1],
by creating an additional subflow, injecting a FIN+ACK before sending
the DATA_FIN, and expecting a FIN+ACK in return.

Fixes: 40947e13997a ("mptcp: schedule worker when subflow is closed")
Link: https://github.com/multipath-tcp/packetdrill/pull/154 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - v7:
    - use ssk_state instead of ssk->sk_state. (Mat)
---
 net/mptcp/protocol.c | 5 ++++-
 net/mptcp/subflow.c  | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..9ad48c798144 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2533,8 +2533,11 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ssk_state = inet_sk_state_load(ssk);
 
-		if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		if (ssk_state != TCP_CLOSE &&
+		    (ssk_state != TCP_CLOSE_WAIT ||
+		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index a7fb4d46e024..723cd3fbba32 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1255,12 +1255,16 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 /* sched mptcp worker to remove the subflow if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (likely(ssk->sk_state != TCP_CLOSE))
+	struct sock *sk = (struct sock *)msk;
+
+	if (likely(ssk->sk_state != TCP_CLOSE &&
+		   (ssk->sk_state != TCP_CLOSE_WAIT ||
+		    inet_sk_state_load(sk) != TCP_ESTABLISHED)))
 		return;
 
 	if (skb_queue_empty(&ssk->sk_receive_queue) &&
 	    !test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
-		mptcp_schedule_work((struct sock *)msk);
+		mptcp_schedule_work(sk);
 }
 
 static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)

-- 
2.45.2

