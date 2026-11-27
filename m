Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809738;
	b=isBZ40r996UYKXrYTSM8sgH+O9+BwS/uKtjxll+kU7Lztr6+kFU0xoBBGh0Xogf4wp2N
	 Nm8VxSpezu7SY+ZNI5O6rul9mV+0rlhNQO162pjRbIWe9I+Hl9t5BR4oMwJiDzRNEUtND
	 iCnIgudtXWDQLAeD0K6ARnvAwkyxGulszuLrUmPz+jLCwxCBKdMoYcFIgmv2TfUfrratW
	 szIafv06qd5LJ2qrKt1c9VlhmTPMsJh1lCs2PdUsoaBE7BopTDOTcJNIVmeBDQl8wDg6v
	 u0Gpjp0X6UUnCb579VEpfpfj1q96oDQU3Hdpr3vbn6pVGOf+Lw44hGVmQ/S71F6UUdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809738;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UDuf4f/gSUF6CgOoO70K8K1KA/PcON7n+wO5IQFXWIE=;
	b=eu9xNK99YuE7qdWsXcWyrCsW5cbSlrwYB0Cx2jaSi+B0K/FNYDiujELTYvs4/Cmpf8je
	 fOLxENAFmrf751WoxUHnkb4vnZ9pG5yQ7QP4kK1kbEpRBBWlMMUFvy7OaazzsIYN5eNvn
	 rWjTox14UGR4KuBbm2U9zwZ1oLzM1MTLGtLcz5ljXkBwDAYw5x8NM80Wmrif9QK/iaSdE
	 12RqmAMvp+q6E+Flfi4TJeT2GN+MPOZUlFhdYvBDQWfspgseBF1+Nc8wPNldcpVwUXgta
	 11XLrJ57DRul1/HhsmlmDz+HgSoR3zIx1fm5lD4rk6CBL6dZIvnrxA7F4TfuztZ3dCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY7U9fSt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575AD606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY7U9fSt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9249B1F0089C;
	Fri, 27 Nov 2026 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809738;
	bh=UDuf4f/gSUF6CgOoO70K8K1KA/PcON7n+wO5IQFXWIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IY7U9fStcVdbKViGyeOJ+py0oQqRti82KE+H/t312VyZW3QJL8e3/xPrRMp+TBtTY
	 pt04S/BrR6HM0niFjCbTQh7HwmzeZlRivstzfqKHrxGiQe5nwUYmI7vjMzMvVEy1yN
	 As9M3bUNcih22IZWpsGU9CvKoM3Ikc+901Pi1rxMTprEnGhQS9qC7bamYiKAh3h33B
	 Mp7yl80VRqQkjkWnbXsPRvsH4rnV8zy3mEra6azPy9UZ8FsWm1q2PHEeoh3SQHgI8M
	 gsN2c8BtdBX8xynEHvE9pn29wAJ4wHhhHxkBw3JgddRlSvss4i1TH1F43jkHEuxt/c
	 LgQZaZ53hz5NA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:38 +0100
Subject: [PATCH mptcp-net v4 14/20] Squash to "bpf: Add mptcp packet
 scheduler struct_ops"
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-14-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9EVyhx1UsI9e1Hb+QJD9yWNsd1GtRvt2vmpOebg4vJA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H25mKw6Y4+VcvnhpV5X4XZ7dglkFObeyJcw7ajMk9
 vBcK53VUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMBHFOYwMG21/7XztOelX2Y3V
 Il3Hvh350lHmvmTrrbNcj8PnPF4w25Thv/OGGo47ix18g5dfEY9q9UqXjr91m+fhnf8OL/s0be6
 XcAAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A BPF scheduler can return 0 from get_send() without picking any
subflow, e.g. the bkup one from the BPF selftests, when all the subflows
are backup on both sides. With data to send, a DATA_ACK received while
the msk is not owned by the user then makes the push loop of
__mptcp_subflow_push_pending() spin forever, in softirq:

  watchdog: BUG: soft lockup - CPU#2 stuck for 49s! [python3:182]
  (...)
  RIP: 0010:bpf_iter_mptcp_subflow_next+0xf/0x40
  (...)
  Call Trace:
   <IRQ>
   bpf_prog_bf2471f1d206d5cc_bpf_bkup_get_send+0x78/0xd7
   bpf__mptcp_sched_ops_get_send+0x4c/0xb0
   __mptcp_subflow_push_pending+0x148/0x390
   mptcp_incoming_options+0x836/0xba0
   tcp_data_queue+0x6da/0x10c0
   tcp_rcv_established+0x2d5/0xce0
   tcp_v4_do_rcv+0x13f/0x300
   tcp_v4_rcv+0xbff/0x1200
   (...)

Stop this loop when the current subflow is not picked: if another one
is, the loop already stops after delegating the push to it. The default
scheduler always picks a subflow when returning 0: not affected.

This issue has been found by an AI code review agent, while reviewing a
patch for the BPF schedulers, and confirmed with a reproducer: the bkup
scheduler on the client side, its only subflow marked as backup on both
sides, data queued by the client, then data sent by the server, carrying
the DATA_ACK causing the soft lockup above.

Similarly, the push loop of __mptcp_push_pending() spins forever, with
the msk and subflow locks held, when a BPF scheduler keeps picking a
subflow that cannot send, e.g. a new subflow in SYN_SENT picked by the
bkup scheduler before its backup flag is set: mptcp_sendmsg_frag() then
returns -EAGAIN, which does not decrease push_count in this state.
Decrease it after any failure: -EAGAIN is only returned for a subflow
that cannot send, or that has just been reset. The default scheduler
does not pick such subflows: not affected.

This second issue has been found by an AI code review agent (Clashiko),
while reviewing a previous version of this patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
v3: also stop the push loop of __mptcp_push_pending() when the picked
    subflow cannot send (Clashiko)

Note: when squashing, the commit message could explain why these loops
are stopped, and why the default scheduler is not affected (Clashiko on
v3).
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d9031940360..178792ebcc78 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1910,10 +1910,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 
 				ret = __subflow_push_pending(sk, ssk, &info);
 				if (ret <= 0) {
-					if (ret != -EAGAIN ||
-					    (1 << ssk->sk_state) &
-					     (TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSE))
-						push_count--;
+					push_count--;
 					continue;
 				}
 				copied = true;
@@ -1970,6 +1967,9 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 				keep_pushing = false;
 			else
 				copied += ret;
+		} else {
+			/* a BPF scheduler might not pick any subflow */
+			keep_pushing = false;
 		}
 
 		mptcp_for_each_subflow(msk, subflow) {

-- 
2.55.0

