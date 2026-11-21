Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254179;
	b=me/G5gL367BxPmnrPupcWnU7LcH3RhbKij8TuYyeZZ4cSpwkQHGnI99+ACxTq9+FN/GP
	 cTXkOkXEJvX2pVPV5KWJWXuGfwIYo+5LKwJtYx5UIUQOgq6LXmGVu/vJlgZbkiDU5pS4t
	 fDu5AxgxzE6VgNc7ftdTEHUUX93Bl8PPgDbtqdXlS0x22rTj+oxuEf61irj2XF273YyiM
	 GIsBGi+LYnJlO9pNdX+FB0vM6t6KJ10AejrsOSBBZ1hJYhEnVFWvHFr3eWASBC9I5xgwv
	 rCQxPGXDCLdC/S4Rms1qXb2Qhlf2/a7emJUp+nShOhbwSHUFYuHR5gv4EXlqGoivBHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254179;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pcGYtyAO23yCx1qQ7SYJ3TqxAJFut2PkCGt0Of2CmX8=;
	b=WciVxHIX1DlSDVhn8utK4kr4n+C+KuShRQQdIAgOlJ6AyT4iNmKk5uqQBcquWf/x27Rv
	 KhMyo3+VTVRhnxa+kLBiHerpMpYr820Zhp5Up/3/1dKYdPySquXhet64z24Yxoy4GlmFI
	 FrnzmWJhFZrMEFVgZ/gFpdfUSwqAmtW3gVicpbMnJpL1nsndarLV02F2pU0zfUoyRWgf8
	 JXKmbAf5+D28ABDX6uWYGez4ZpG6i4mUrm7OURzrKCB9TAnnnHzN+YqH5W5C6j5819V2U
	 cqEka+phQO6hCBGuVF3tdMxQ3yaG3mFRQFGK8CfWmJoTfjt16wDKTEZI9WEEHR95vWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUXUKlsy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34EE606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mUXUKlsy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085061F000D3;
	Sat, 21 Nov 2026 09:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254178;
	bh=pcGYtyAO23yCx1qQ7SYJ3TqxAJFut2PkCGt0Of2CmX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mUXUKlsyb9R/LVnkO5LYl0xbfrk2GIAsfi/QY1mKiLde+1wnNxsDTcgM5ZE/qXe7R
	 jEyK+N7FR7U9CWQx4diMRyUcQrAARxqYqCW59j7jtSz2NudZB3QMIhtGtWUZouaO18
	 ius1B9the/RiCzValYdhtvC4sG1wdl+w8u4EPlcheEq9kQuJwlhD4mC+c+4mic4XaZ
	 xJ9tEuxMrbOHBB5s4yi5aSziTioZT2LEIr05gfATpOuvjRoFTWWljlSWxXbnzv+R8P
	 YKapUdxDCqaSAkXCcYgMo27xMcBYG7L+Ta+SpVoFKLVIDbOSAu87Sz24Z9wWmp+WU0
	 joa82Bm2Rcl3w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:43 +0100
Subject: [PATCH mptcp-net v2 45/62] tcp: do not pass a BPF reqsk to an
 MPTCP listener
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-45-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IvmeQ7gqSRSQdSaAIMgmjaWuhmb4ljyQU4wUOq4a0R4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ07Pcc4qeaLRPkaztnVGaxnPs8KrW8043+w/W3Qm/x
 6PY8L2yo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKcXgz/Qz+obnHc3rh76YoH
 /Z+7ngd8E9TgFTWc9XZxm1vIVt6d2xgZdq9aubE3znbWiZRqO2vbD3dDZkS/u7CenSPTZ2nLekk
 JbgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

A slab-out-of-bounds write and a panic can occur if a tc BPF program
that validates SYN cookies assigns an ACK to a TCP listener, and the ACK
then goes to an MPTCP listener of the same SO_REUSEPORT group.

bpf_sk_assign_tcp_reqsk() attaches a plain TCP request sock to the skb,
and returns -EINVAL if the program passes in an MPTCP listener. But
inet_steal_sock() and inet6_steal_sock() select a listener again from
the SO_REUSEPORT group of the listener that was passed in, and the
result can be an MPTCP listener. cookie_bpf_check() then passes the
request sock to mptcp_subflow_init_cookie_req(), which writes to members
of the larger struct mptcp_subflow_request_sock, so the writes can land
in the next object of the slab.

The fix used here is to drop the segment in cookie_bpf_check() if the
listener is an MPTCP listener.

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch:
a tc BPF program validating SYN cookies -- the one from the BPF
selftests -- and an SO_REUSEPORT group with a TCP listener and an MPTCP
one, the latter being selected. With KASAN, the original version of this
patch reported:

  BUG: KASAN: slab-out-of-bounds in mptcp_subflow_init_cookie_req
  Write of size 1 at addr ... by task python3
   mptcp_subflow_init_cookie_req
   cookie_bpf_check
   cookie_v4_check
   tcp_v4_do_rcv
   tcp_v4_rcv

Without debug options, and with request sockets of half-open connections
next to the corrupted one, the kernel panicked a second later, when the
timer of a request socket fired:

  BUG: kernel NULL pointer dereference, address: 000000000000058f
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.4.0-rc1+ #1 PREEMPT(lazy)
  RIP: 0010:tcp_syn_ack_timeout+0xd/0x30
  Call Trace:
   <IRQ>
   reqsk_timer_handler+0x22e/0x500
   call_timer_fn+0x2a/0x140
   __run_timers+0x1f7/0x280
   run_timer_softirq+0x49/0xf0
   handle_softirqs+0xfa/0x300
   __irq_exit_rcu+0xb5/0xf0
   sysvec_apic_timer_interrupt+0x73/0x80
   </IRQ>
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Shorter comment. Commit message: how the issue was found, and its
  symptoms. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/ipv4/syncookies.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 89169c82431c..f39600ee3f17 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -312,7 +312,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 	skb->sk = NULL;
 	skb->destructor = NULL;
 
-	if (cookie_tcp_reqsk_init(sk, skb, req)) {
+	/* reuseport can pick an MPTCP listener: req is too small for it */
+	if (sk_is_mptcp(sk) || cookie_tcp_reqsk_init(sk, skb, req)) {
 		reqsk_free(req);
 		req = NULL;
 	}

-- 
2.55.0

