Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599694;
	b=3XJ1UpXoYAbB6s2W7jk+QwYhjDZBmRva8jXXyvVuqalyf1Wbp+dbZDEy3ovtxRggOWW9
	 dEws3aKKoI2IZUo48sdmcy+syuZbCgJFx9ryhgH5iNL93lxS/OxRKwQsOhUSPJjN72Rmm
	 /fEx+Ob6MrwvRXtmblTclOY525/sHbK8eYjT0qp4HZiYL0OTbvvsp+S05co42nYUju+AW
	 +Uaw4Is09PiuS7yJvHwK3ybWPvNV+MfiL40nJeO7BbrCCmvqgEvT6YWHv/ZECIbAxOrLN
	 pzbZ/l3+rWXwLZ9PFB8usV+9TIBWNHCOGSKjnGIg4pW/ReaCXoKYy+ndWJFA0gLNdHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599694;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1+GMm9bo2jBU50QEK+49Z942SdK0zztpyaweSmkMiEo=;
	b=PdqPC8WaNbDSdWha0Pj0eZTgTHpJEWk2rSZlY1HDcUILMuachHqQUHZkZPYYJoBL03jO
	 O5Nlrpx44APOQ4di7kt7qL8DL2vGM6uAFzUgH8VPHO4/wYnsE5hUf0amRUcgKuVHH2ndq
	 cCw6SWdrpG5Iq1i8h3mpjOYlmoMhMUpp1Pz+d/Ld7cPuLK+TLE5hL33MhOri/eEHG8ZW/
	 y5TGGzm5M2/NO7aZjUM3lu+wRqTfTeYqkiiVK0VSwyRKanimz9bYy5sj/JrHcpCxmM8qZ
	 NQx84JnTbiZh1fAPZb73bnjpPbpfXJv6h168Y99B/QmOzPK+Irli9/V7W21hstr4FPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DdW0b+/c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61285606D0EB
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdW0b+/c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77A571F000C6;
	Fri, 13 Nov 2026 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599694;
	bh=1+GMm9bo2jBU50QEK+49Z942SdK0zztpyaweSmkMiEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DdW0b+/ccTjBJ+zh/viTUQCZ2yOwQrpYYzc5V3wTemzLUc0JzYDQMjGHDfN1FGieZ
	 IG26La2tNwIqwnWbzMTCNGVmGSprE+cmAWT4cXTG20ZDoCDn087UN6ZRiTxw0eBcWe
	 Y6xdkxnaXKzBC4ChDJu+qST6x8JVSStPuy/rn+vpb617lHlHMJ8JR1U32KhsAUkusK
	 qV/pn8MzIPkWjj6Uej7bXZ8BGBvqJ115cNqJiIwtjIq6UUZyfiDifc5WdUmHpVmrnu
	 9ADPqW5WnWxA2cu7l18Kipn5krJLqO5i3luvDqKKUYpzZyGYOBdIDX20mw8Xarbk9A
	 bYjqkn185iQ1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:54:05 +0100
Subject: [PATCH mptcp-net 27/34] tcp: do not pass a BPF reqsk to an MPTCP
 listener
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-27-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6HheWE2kPACK0MgpwEPXOtAzyEFwPPlvyzfTK7gyE9k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Zz3dfPSImLyiWt/xkgVqv8xDLwpqC0ZuutHtafgvT
 nZ1of2LjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkIL2BkmOl4IX9rxsULEq0/
 M/54uv4yfVny/4FL3aGNb2NVrYT72Rj+uz07+MtVUZnpbNzHr3me7fbrfB/xbNrCFplqoS7Zl7q
 JBwA=
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
index 4e0ff3b82062..8433c856a7d8 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -308,7 +308,8 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
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

