Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E733291D;
	Tue, 17 Feb 2026 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771331303; cv=none; b=ggcZemxnA38+g7vORLDvKBgwq4THZXPeCvCygS9ShSqN90f5NWmU+hC9Az0lVEyxh41vzpcFKt790eha9IkchiY0EnlU7YFLBO6HImC5ReIq9+klptO7H+PQQgT7faxo0vp7U5hPBHHvQtNkm5Aeurdmkm8z/p5T8Zl+qOyH2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771331303; c=relaxed/simple;
	bh=mmY9UbbSpD3/uXSOM563STcWwBzpqaDnsL1f4SXMtQk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=HYam7/1aCu4Wboc74JeIuYOf2+jQwBRiLvViUf/7a3+zxeI/7WAiCod8cJiU5Dqe9JY2yFxL+uASpoUPvT08XBJiO2UFSyJ2ib9J61ap/Cktj990FK3H1lVdqC3BuIT2QJEYvDpTGFhIdhqPOgODKbtjb3yKSQj3ZHvV6B4A4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pw355xHY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pw355xHY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EADC4CEF7;
	Tue, 17 Feb 2026 12:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771331303;
	bh=mmY9UbbSpD3/uXSOM563STcWwBzpqaDnsL1f4SXMtQk=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=pw355xHYMUVgFYe/7gV86aHD+AXzWH0Zot5XsRSKDbTCVxKdHz6lpxOD7Zhqc84LH
	 acSw7wQWdZibALAQ1Go+48jlleW/s7Emvun60v0HdVGyO5DtMgu5xRmRgJ58zjrdRM
	 abBuwzeH/HErp/5FiaYH8NmVnmE2/IxSuJdu6Wgo=
Subject: Patch "mptcp: ensure context reset on disconnect()" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org,matttbe@kernel.org,mptcp@lists.linux.dev,pabeni@redhat.com,sashal@kernel.org
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:28:19 +0100
In-Reply-To: <20260211190617.77192-11-matttbe@kernel.org>
Message-ID: <2026021719-handgun-shading-d4c1@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 


This is a note to let you know that I've just added the patch titled

    mptcp: ensure context reset on disconnect()

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     mptcp-ensure-context-reset-on-disconnect.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From stable+bounces-215870-greg=kroah.com@vger.kernel.org Wed Feb 11 20:07:03 2026
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 11 Feb 2026 20:06:21 +0100
Subject: mptcp: ensure context reset on disconnect()
To: mptcp@lists.linux.dev, stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>, sashal@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Message-ID: <20260211190617.77192-11-matttbe@kernel.org>

From: Paolo Abeni <pabeni@redhat.com>

commit 86730ac255b0497a272704de9a1df559f5d6602e upstream.

After the blamed commit below, if the MPC subflow is already in TCP_CLOSE
status or has fallback to TCP at mptcp_disconnect() time,
mptcp_do_fastclose() skips setting the `send_fastclose flag` and the later
__mptcp_close_ssk() does not reset anymore the related subflow context.

Any later connection will be created with both the `request_mptcp` flag
and the msk-level fallback status off (it is unconditionally cleared at
MPTCP disconnect time), leading to a warning in subflow_data_ready():

  WARNING: CPU: 26 PID: 8996 at net/mptcp/subflow.c:1519 subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
  Modules linked in:
  CPU: 26 UID: 0 PID: 8996 Comm: syz.22.39 Not tainted 6.18.0-rc7-05427-g11fc074f6c36 #1 PREEMPT(voluntary)
  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
  RIP: 0010:subflow_data_ready (net/mptcp/subflow.c:1519 (discriminator 13))
  Code: 90 0f 0b 90 90 e9 04 fe ff ff e8 b7 1e f5 fe 89 ee bf 07 00 00 00 e8 db 19 f5 fe 83 fd 07 0f 84 35 ff ff ff e8 9d 1e f5 fe 90 <0f> 0b 90 e9 27 ff ff ff e8 8f 1e f5 fe 4c 89 e7 48 89 de e8 14 09
  RSP: 0018:ffffc9002646fb30 EFLAGS: 00010293
  RAX: 0000000000000000 RBX: ffff88813b218000 RCX: ffffffff825c8435
  RDX: ffff8881300b3580 RSI: ffffffff825c8443 RDI: 0000000000000005
  RBP: 000000000000000b R08: ffffffff825c8435 R09: 000000000000000b
  R10: 0000000000000005 R11: 0000000000000007 R12: ffff888131ac0000
  R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f88330af6c0(0000) GS:ffff888a93dd2000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f88330aefe8 CR3: 000000010ff59000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   tcp_data_ready (net/ipv4/tcp_input.c:5356)
   tcp_data_queue (net/ipv4/tcp_input.c:5445)
   tcp_rcv_state_process (net/ipv4/tcp_input.c:7165)
   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1955)
   __release_sock (include/net/sock.h:1158 (discriminator 6) net/core/sock.c:3180 (discriminator 6))
   release_sock (net/core/sock.c:3737)
   mptcp_sendmsg (net/mptcp/protocol.c:1763 net/mptcp/protocol.c:1857)
   inet_sendmsg (net/ipv4/af_inet.c:853 (discriminator 7))
   __sys_sendto (net/socket.c:727 (discriminator 15) net/socket.c:742 (discriminator 15) net/socket.c:2244 (discriminator 15))
   __x64_sys_sendto (net/socket.c:2247)
   do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  RIP: 0033:0x7f883326702d

Address the issue setting an explicit `fastclosing` flag at fastclose
time, and checking such flag after mptcp_do_fastclose().

Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251212-net-mptcp-subflow_data_ready-warn-v1-2-d1f9fd1c36c8@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.[ch] because the context has changed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    9 ++++++---
 net/mptcp/protocol.h |    3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2456,10 +2456,10 @@ bool __mptcp_retransmit_pending_data(str
  */
 static void __mptcp_subflow_disconnect(struct sock *ssk,
 				       struct mptcp_subflow_context *subflow,
-				       unsigned int flags)
+				       bool fastclosing)
 {
 	if (((1 << ssk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)) ||
-	    subflow->send_fastclose) {
+	    fastclosing) {
 		/* The MPTCP code never wait on the subflow sockets, TCP-level
 		 * disconnect should never fail
 		 */
@@ -2511,7 +2511,7 @@ static void __mptcp_close_ssk(struct soc
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		__mptcp_subflow_disconnect(ssk, subflow, flags);
+		__mptcp_subflow_disconnect(ssk, subflow, msk->fastclosing);
 		if (msk->subflow && ssk == msk->subflow->sk)
 			msk->subflow->state = SS_UNCONNECTED;
 		release_sock(ssk);
@@ -2802,6 +2802,8 @@ static void mptcp_do_fastclose(struct so
 	struct mptcp_subflow_context *subflow, *tmp;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	msk->fastclosing = 1;
+
 	/* Explicitly send the fastclose reset as need */
 	if (__mptcp_check_fallback(msk))
 		return;
@@ -3290,6 +3292,7 @@ static int mptcp_disconnect(struct sock
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->fastclosing = 0;
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -289,7 +289,8 @@ struct mptcp_sock {
 			nodelay:1,
 			fastopening:1,
 			in_accept_queue:1,
-			free_first:1;
+			free_first:1,
+			fastclosing:1;
 	int		keepalive_cnt;
 	int		keepalive_idle;
 	int		keepalive_intvl;


Patches currently in stable-queue which might be from matttbe@kernel.org are

queue-6.1/selftests-mptcp-join-fix-local-endp-not-being-tracked.patch
queue-6.1/mptcp-schedule-rtx-timer-only-after-pushing-data.patch
queue-6.1/mptcp-ensure-context-reset-on-disconnect.patch
queue-6.1/selftests-mptcp-pm-ensure-unknown-flags-are-ignored.patch
queue-6.1/selftests-mptcp-check-no-dup-close-events-after-error.patch
queue-6.1/selftests-mptcp-check-subflow-errors-in-close-events.patch
