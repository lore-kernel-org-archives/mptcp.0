Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99D339182D
	for <mptcp@lists.linux.dev>; Mon, 16 Mar 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661649; cv=none; b=d87gyboXprYUL+xyT++Oc9wi8PWgTcYYQpcJifeH/ZfRNA5QUjO+Nr4ta7KZwvn4NgbNREtdTHHfbvGRF8/8AJ50Xif4LPjprEe7qy0iORva0aK4XKWOF+Zvw/SFBRIAKXN+L4BWtEyuJ9DVMmig8LAOuifHHb3cvWC0NNIYm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661649; c=relaxed/simple;
	bh=L/xTUfFjTe//Xjq0LWK7hVIR6UiiEC70dCZ9ZHakRHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gAeHh/NkpioaKEjL70izgnVT6b7z9/fUTAiIhn74erLDaC9vapLu5u3T07oiA0xzx51qgroUygCIl9qVEEYNwMjPw7ljq/bEsmryoMZDkAU5JGv4mm4QYZlmdAgkQtkONgc0FxmyZUetfY2gMizkeEQYL/KcTS+r1yitSvPzszc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMUnv9Lc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMUnv9Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE5C19425;
	Mon, 16 Mar 2026 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773661649;
	bh=L/xTUfFjTe//Xjq0LWK7hVIR6UiiEC70dCZ9ZHakRHs=;
	h=From:Date:Subject:To:Cc:From;
	b=SMUnv9LcQj+7zrzCEkhyYFFSluzPZwv3H6vBvKJS7wVsBiv0K23oZTtgMsLJMNPRm
	 OCr8Ed6+pvW4FD3aHxPyHpN6K6orNm1h3nbZq5mutcpTbZPUZM2NRnn3Cm3C/KBTfB
	 b92tGZfvzdOYjULroxoJSy0PFKghGMyTvokzcXRbed1tA9J9NAoj7xzEy7NUj5L1Ly
	 3eGGSLDm1cpJeAGYrygCXKbVKVIbraCoLOkShQWiovP7THgoNLRnjztT9q+K0PkLGZ
	 cr2C090VUv6ookcF1O3g/OMtNiNGpn3bsvj+GNgwJ6lymzbFaaT45gZl9/bQAx60ED
	 Iii1OMxCiZqQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Mar 2026 12:47:13 +0100
Subject: [PATCH mptcp-net] mptcp: fix data-race in __mptcp_retrans /
 mptcp_incoming_options
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-mptcp-data-race-snd_una-v1-1-221704522c67@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgogTtVUopk2Sqs+g0JLEUx
 Ls32OVfvL9D4Sxc4NrtkPkjRd7awlw6CCvpwiixNdjeun4wDl+phoSRKmGmwFg0PjYldN7zaIb
 ZWztB0ynzU77n+QZ/pFzhfhw/VAUEGnQAAAA=
X-Change-ID: 20260316-mptcp-data-race-snd_una-6bbe4139b228
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3455; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L/xTUfFjTe//Xjq0LWK7hVIR6UiiEC70dCZ9ZHakRHs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK3v70woTM1/3LJWZOGtluvt3bolfbNZD5+Q4JfcEl41
 aRNxx8YdJSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenANzkpYwMD/fNrONl4uutdf+X
 cmnCU80d27muMrgUWB+X/p1f2Hf0PcM/g1kbbMTt9vckntWQUDu0zkR/m1Dip+2XFLjOFnRMYhd
 gAQA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

SyzKaller found this data-race:

  BUG: KCSAN: data-race in __mptcp_retrans / mptcp_incoming_options

  write (marked) to 0xffff888015e8e5f0 of 8 bytes by interrupt on cpu 0:
   __mptcp_snd_una_update net/mptcp/options.c:1055 [inline]
   mptcp_incoming_options+0x6a3/0x1ac0 net/mptcp/options.c:1183
   tcp_data_queue+0x101b/0x2440 net/ipv4/tcp_input.c:5583
   tcp_rcv_established+0x684/0x1fc0 net/ipv4/tcp_input.c:6654
   tcp_v4_do_rcv+0x35c/0x690 net/ipv4/tcp_ipv4.c:1866
   tcp_v4_rcv+0x1d91/0x25a0 net/ipv4/tcp_ipv4.c:2263
   ip_protocol_deliver_rcu+0x46/0x280 net/ipv4/ip_input.c:207
   ip_local_deliver_finish+0x190/0x270 net/ipv4/ip_input.c:241
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ip_local_deliver+0xe3/0x210 net/ipv4/ip_input.c:262
   dst_input include/net/dst.h:480 [inline]
   ip_rcv_finish net/ipv4/ip_input.c:492 [inline]
   NF_HOOK include/linux/netfilter.h:318 [inline]
   NF_HOOK include/linux/netfilter.h:312 [inline]
   ip_rcv+0x200/0x220 net/ipv4/ip_input.c:612
   __netif_receive_skb_one_core+0xeb/0x110 net/core/dev.c:6178
   __netif_receive_skb+0x1f/0xc0 net/core/dev.c:6291
   process_backlog+0x168/0x360 net/core/dev.c:6642
   __napi_poll+0x71/0x460 net/core/dev.c:7706
   napi_poll net/core/dev.c:7769 [inline]
   net_rx_action+0x6f8/0x810 net/core/dev.c:7926
   handle_softirqs+0xc9/0x2e0 kernel/softirq.c:622
   run_ksoftirqd kernel/softirq.c:1063 [inline]
   run_ksoftirqd+0x20/0x30 kernel/softirq.c:1055
   smpboot_thread_fn+0x287/0x520 kernel/smpboot.c:160
   kthread+0x1f2/0x240 kernel/kthread.c:436
   ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

  read to 0xffff888015e8e5f0 of 8 bytes by task 24 on cpu 1:
   mptcp_rtx_head net/mptcp/protocol.h:487 [inline]
   __mptcp_retrans+0x169/0x8f0 net/mptcp/protocol.c:2759
   mptcp_worker+0x6a6/0xb30 net/mptcp/protocol.c:2980
   process_one_work+0x3ee/0x970 kernel/workqueue.c:3275
   process_scheduled_works kernel/workqueue.c:3358 [inline]
   worker_thread+0x3c3/0x730 kernel/workqueue.c:3439
   kthread+0x1f2/0x240 kernel/kthread.c:436
   ret_from_fork+0x321/0x440 arch/x86/kernel/process.c:158
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

  value changed: 0x0b17a4285ae6137d -> 0x0b17a4285b078905

It looks like msk->snd_una was being modified in __mptcp_snd_una_update
while being accessed in mptcp_rtx_head().

Annotate access to msk->snd_una in mptcp_rtx_head() to prevent such
issue.

Fixes: 64b9cea7a0af ("mptcp: fix spurious retransmissions")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f5d4d7d030f2..25f8663cb6cd 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -484,7 +484,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	if (msk->snd_una == msk->snd_nxt)
+	if (READ_ONCE(msk->snd_una) == msk->snd_nxt)
 		return NULL;
 
 	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, list);

---
base-commit: d78f500a3f4590b662960287ecb831b070c23cad
change-id: 20260316-mptcp-data-race-snd_una-6bbe4139b228

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

