Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4C1AE029
	for <mptcp@lists.linux.dev>; Fri,  2 Aug 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622680; cv=none; b=pgDhw1J2ESl4GucZvaGJYpFfte5PL/5PHk2xbCC5Q9ezSEuGgwZBvHSW+4YpkbAd22Hkc3PG6KrxDH0K3fF1eokHnwdl7MbNX+gaO1bqhIfRJThMwaCqMiy9W7xOXDO9zO7Qe+tXh21SOU4VYmSRUvCsaMIe82jqSz4xe4gcs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622680; c=relaxed/simple;
	bh=KFd87TzFgoUXwm2i13o+sx1nEl0pAg0CTX7sVeZay3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c8e/uCa76P4zpCE6rDZ3AsBcobtchBwLDDQtQzARVmqjU5L9N0Yn55nx9qYl9CdD5gV1SlIafFdfYKgv/xP18yyvtqYD/Ks+e6ZGOTyTZLjNOc4aB4GQopc5Zl9duNV7X04fK/5ajPKfvkOOoZMCMRceEtqzCl7mDIphbdxxRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYsLYCKk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYsLYCKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A509C4AF09;
	Fri,  2 Aug 2024 18:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722622680;
	bh=KFd87TzFgoUXwm2i13o+sx1nEl0pAg0CTX7sVeZay3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hYsLYCKkAMoGfyX6qqxAj4CWWWxe/881+aZCJMGdpu90gTcPSUizFjd6goP8vJWJp
	 IDXsC/3LuPEtQO8+fCGT2N5sI/ZdYH6OAD5UKqkR4z7i/gtAqNwCD4ZxS5PHeADo/5
	 2qpatg0uM6rJZGZfKuKwm6KcLzB3D0tL8OUOcZ9TgIxxPlRezdBUOaAcFs+ockoxvn
	 rmmiqiBnbrqp5y5YfNPlqtxDY4s6W8aCnmTnk3fArLufrLt4bsv8OKmVLr5yfxXg7H
	 Sy0pbX0EcCJ/n2WtvEggRwUVzjEt/V7J1qKQZairYg8mP4qd6CxzL3BCydnjgP2arI
	 VQkzvS4ZBAprQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 Aug 2024 20:17:46 +0200
Subject: [PATCH mptcp-net v6 09/11] mptcp: close subflow when receiving
 TCP+FIN
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-mptcp-pm-avail-v6-9-964ba9ce279f@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
In-Reply-To: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KFd87TzFgoUXwm2i13o+sx1nEl0pAg0CTX7sVeZay3A=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmrSLLbpYjThkcbZ88osKQAh1OWfvqQGMBSEUsj
 PRVRGz+PbSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZq0iywAKCRD2t4JPQmmg
 c1fHD/44+lg51db9MycsPRSFj7PnPdhrtRgLe0vipZje/cmu0bq4eXW0sOJLMxBPj9vH75eK/im
 OvUfaMVsh3WoZ3fMdJJ7FCluCe2nNkh8BwiAVm0OrhQ9WgZPNFqYoXXmF77brobvmBuUzGdIYFp
 i6uIfqug6yHSaViWYsq/ZSX/guzwAdpDX1oSzEZlrp3GCWg9ijD84yXh91+KhC/QtM+tsUCM5D6
 vgWkGFEcYgPRG6cQNzgUartgnUU/6upqyOs02tdRle3oqi1hCJulVFr6cqsnTJ8YxcOIP3gaceu
 IlSfWD9aLeGoGsuFZOeOItl+isbLBAedCe50MBH7x9h/B2IPCb3ryd2U0np+JibV1ZoD+4YW34h
 29RJRvf9o/ZjvBzmyc8Shm66VRQy3Itn+WkYLr6LwOugCy06F3cQb/llWmybEIHHyQdbETbiouZ
 2kHlp5knAZSxKlY6sor+PA6oB3a3exRsZ2zsN+koe+w02qUOdvCOTJwsy4TFYycVuSUu9npbUZf
 eV1aAyNRtjUudIh2iuh7hsqU3XnDG6CU/GHf1Mjr7Fv77YmA/GSQcahWhwCeJLqR/CVfPcfBNA8
 T5etE7YpDkOCTcYjQnFuooZcmbNrUj2Y9doIaMRnF0BoMm8k0WyTkxZVy4Nt25NbXQRhz0zq3g2
 /tnSG7qx/XkVu7A==
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
 net/mptcp/protocol.c | 5 ++++-
 net/mptcp/subflow.c  | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 13777c35496c..609d684135dc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2533,8 +2533,11 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ssk_state = inet_sk_state_load(ssk);
 
-		if (inet_sk_state_load(ssk) != TCP_CLOSE)
+		if (ssk_state != TCP_CLOSE &&
+		    (ssk->sk_state != TCP_CLOSE_WAIT ||
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

