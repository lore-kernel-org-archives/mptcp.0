Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AA419DF4A
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700304; cv=none; b=CH1iDeYwHJ0ONm8Y27CeN/DFbnG9fgV8DMObACAaFxlZRSmybPS/YZ83zWCmhMZeZkXsAuCRiXGkMXw1dbQ1knmuq/D1CZqsNvmpXPFBdm4JJ7v+DLMP4hjXfd+Z9rxfQbmn53LcCrbZGjTZzYenUKmUxrunhUv92oYrKQ54OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700304; c=relaxed/simple;
	bh=SeHLUzs8KKNHZSzxKEjbBukauuI/e2kdK9L/9Vmgnvg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CfeT9nsiunZfrZ6T7kAunZAza+PKVCmfEemdxDxV8pFFj8xKVBtRqD2DhovHQw4Gpht30ZGjXNUIV5QedM84NQgv7sOT94j8dw+zMTXZTEZ6QMlN0EJ1gddKmHD8KRA81k2GqLDlE8i/5xm6rDiW5MTJwgFMtXHR8+2Sd2WcPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gzcxww4b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gzcxww4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751700300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vLyH1si+oWfnKDEBTP5aBF3msR1hNkkcpc2TJ+N9okQ=;
	b=Gzcxww4b/9WACgju09kgMtdvPhsiguwzKnLrNICbo4CbxD3pUqlxdEhR6gjhoLgXHI01fE
	9gIs/ox39oFcuKA61IKNBqpOBQq5fEcxvIOxFb1A1kxUaaRALHqBIYDzi/16nKMckGFasU
	3eMQ1y06UIMWXY0PcaTba25u8qPIhhc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-ICmfXaghPQakSJoHe-CPtA-1; Sat,
 05 Jul 2025 03:24:59 -0400
X-MC-Unique: ICmfXaghPQakSJoHe-CPtA-1
X-Mimecast-MFC-AGG-ID: ICmfXaghPQakSJoHe-CPtA_1751700298
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 316B51956086
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2864D195608F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/5] mptcp: make fallback action and fallback decision atomic
Date: Sat,  5 Jul 2025 09:24:45 +0200
Message-ID: <7220b3c204d75d50e480f6045295a825ae80fd38.1751699999.git.pabeni@redhat.com>
In-Reply-To: <cover.1751699999.git.pabeni@redhat.com>
References: <cover.1751699999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ZnAY9I4H7QQoq9wVJLRRbMjjPEqBA4nhG7WuUTVqFc_1751700298
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Syzkaller reported the following splat:

WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 __mptcp_do_fallback net/mptcp/protocol.h:1223 [inline]
WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 mptcp_do_fallback net/mptcp/protocol.h:1244 [inline]
WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 check_fully_established net/mptcp/options.c:982 [inline]
WARNING: CPU: 1 PID: 7704 at net/mptcp/protocol.h:1223 mptcp_incoming_options+0x21a8/0x2510 net/mptcp/options.c:1153
Modules linked in:
CPU: 1 UID: 0 PID: 7704 Comm: syz.3.1419 Not tainted 6.16.0-rc3-gbd5ce2324dba #20 PREEMPT(voluntary)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__mptcp_do_fallback net/mptcp/protocol.h:1223 [inline]
RIP: 0010:mptcp_do_fallback net/mptcp/protocol.h:1244 [inline]
RIP: 0010:check_fully_established net/mptcp/options.c:982 [inline]
RIP: 0010:mptcp_incoming_options+0x21a8/0x2510 net/mptcp/options.c:1153
Code: 24 18 e8 bb 2a 00 fd e9 1b df ff ff e8 b1 21 0f 00 e8 ec 5f c4 fc 44 0f b7 ac 24 b0 00 00 00 e9 54 f1 ff ff e8 d9 5f c4 fc 90 <0f> 0b 90 e9 b8 f4 ff ff e8 8b 2a 00 fd e9 8d e6 ff ff e8 81 2a 00
RSP: 0018:ffff8880a3f08448 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8880180a8000 RCX: ffffffff84afcf45
RDX: ffff888090223700 RSI: ffffffff84afdaa7 RDI: 0000000000000001
RBP: ffff888017955780 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880180a8910 R14: ffff8880a3e9d058 R15: 0000000000000000
FS:  00005555791b8500(0000) GS:ffff88811c495000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2800b7 CR3: 0000000058e44000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 tcp_reset+0x26f/0x2b0 net/ipv4/tcp_input.c:4432
 tcp_validate_incoming+0x1057/0x1b60 net/ipv4/tcp_input.c:5975
 tcp_rcv_established+0x5b5/0x21f0 net/ipv4/tcp_input.c:6166
 tcp_v4_do_rcv+0x5dc/0xa70 net/ipv4/tcp_ipv4.c:1925
 tcp_v4_rcv+0x3473/0x44a0 net/ipv4/tcp_ipv4.c:2363
 ip_protocol_deliver_rcu+0xba/0x480 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2f1/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:317 [inline]
 NF_HOOK include/linux/netfilter.h:311 [inline]
 ip_local_deliver+0x1be/0x560 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:469 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:447 [inline]
 NF_HOOK include/linux/netfilter.h:317 [inline]
 NF_HOOK include/linux/netfilter.h:311 [inline]
 ip_rcv+0x514/0x810 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:5975
 __netif_receive_skb+0x1f/0x120 net/core/dev.c:6088
 process_backlog+0x301/0x1360 net/core/dev.c:6440
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7453
 napi_poll net/core/dev.c:7517 [inline]
 net_rx_action+0xb44/0x1010 net/core/dev.c:7644
 handle_softirqs+0x1d0/0x770 kernel/softirq.c:579
 do_softirq+0x3f/0x90 kernel/softirq.c:480
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xed/0x110 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 inet_csk_listen_stop+0x2c5/0x1070 net/ipv4/inet_connection_sock.c:1524
 mptcp_check_listen_stop.part.0+0x1cc/0x220 net/mptcp/protocol.c:2985
 mptcp_check_listen_stop net/mptcp/mib.h:118 [inline]
 __mptcp_close+0x9b9/0xbd0 net/mptcp/protocol.c:3000
 mptcp_close+0x2f/0x140 net/mptcp/protocol.c:3066
 inet_release+0xed/0x200 net/ipv4/af_inet.c:435
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:487
 __sock_release+0xb3/0x270 net/socket.c:649
 sock_close+0x1c/0x30 net/socket.c:1439
 __fput+0x402/0xb70 fs/file_table.c:465
 task_work_run+0x150/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xd4/0xe0 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x245/0x360 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc92f8a36ad
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf52802d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007ffcf52803a8 RCX: 00007fc92f8a36ad
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fc92fae7ba0 R08: 0000000000000001 R09: 0000002800000000
R10: 00007fc92f700000 R11: 0000000000000246 R12: 00007fc92fae5fac
R13: 00007fc92fae5fa0 R14: 0000000000026d00 R15: 0000000000026c51
 </TASK>
irq event stamp: 4068
hardirqs last  enabled at (4076): [<ffffffff81544816>] __up_console_sem+0x76/0x80 kernel/printk/printk.c:344
hardirqs last disabled at (4085): [<ffffffff815447fb>] __up_console_sem+0x5b/0x80 kernel/printk/printk.c:342
softirqs last  enabled at (3096): [<ffffffff840e1be0>] local_bh_enable include/linux/bottom_half.h:33 [inline]
softirqs last  enabled at (3096): [<ffffffff840e1be0>] inet_csk_listen_stop+0x2c0/0x1070 net/ipv4/inet_connection_sock.c:1524
softirqs last disabled at (3097): [<ffffffff813b6b9f>] do_softirq+0x3f/0x90 kernel/softirq.c:480

Since we need to track the 'fallback is possible' condition and the
fallback status separately, there are a few possible races open between
the check and the actual fallback action.

Add a spinlock to protect the fallback related information and use
it close all the possible related races. While at it also remove the
too-early clearing of allow_infinite_fallback in __mptcp_subflow_connect():
the field will be correctly cleared by subflow_finish_connect() if/
when the connection will complete successfully.

If fallback is not possible, as per RFC, reset the current subflow.

Reported by: Matthieu Baerts <matttbe@kernel.org>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/570
Reported-by: syzbot+5cf807c20386d699b524@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/555
Fixes: 0530020a7c8f ("mptcp: track and update contiguous data status")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - remove unneeded and racing allow_infinite_fallback in
    __mptcp_subflow_connect()
  - really close race in subflow_check_data_avail()

Sharing earlier to feed syzkaller.
Hopefully a follow-up on mptcp-net-next will cleanup a bit the fallback
handling, I tried to minimize the delta for backport's sake
---
 net/mptcp/options.c  |  3 ++-
 net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++-----
 net/mptcp/protocol.h | 21 +++++++++++++++------
 net/mptcp/subflow.c  |  8 ++++----
 4 files changed, 56 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 56fd7bcb786c..4680d980e605 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -978,8 +978,9 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		if (subflow->mp_join)
 			goto reset;
 		subflow->mp_capable = 0;
+		if (mptcp_do_fallback(ssk))
+			goto reset;
 		pr_fallback(msk);
-		mptcp_do_fallback(ssk);
 		return false;
 	}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1de42dc4e8ea..38bb11865b50 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -560,10 +560,9 @@ static bool mptcp_check_data_fin(struct sock *sk)
 
 static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock *ssk)
 {
-	if (READ_ONCE(msk->allow_infinite_fallback)) {
+	if (mptcp_do_fallback(ssk)) {
 		MPTCP_INC_STATS(sock_net(ssk),
 				MPTCP_MIB_DSSCORRUPTIONFALLBACK);
-		mptcp_do_fallback(ssk);
 	} else {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
 		mptcp_subflow_reset(ssk);
@@ -803,6 +802,14 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
+	spin_lock_bh(&msk->fallback_lock);
+	if (__mptcp_check_fallback(msk)) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+	mptcp_subflow_joined(msk, ssk);
+	spin_unlock_bh(&msk->fallback_lock);
+
 	/* attach to msk socket only after we are sure we will deal with it
 	 * at close time
 	 */
@@ -811,7 +818,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
-	mptcp_subflow_joined(msk, ssk);
 	mptcp_stop_tout_timer(sk);
 	__mptcp_propagate_sndbuf(sk, ssk);
 	return true;
@@ -1136,10 +1142,14 @@ static void mptcp_update_infinite_map(struct mptcp_sock *msk,
 	mpext->infinite_map = 1;
 	mpext->data_len = 0;
 
+	if (!mptcp_do_fallback(ssk)) {
+		mptcp_subflow_reset(ssk);
+		return;
+	}
+
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPTX);
 	mptcp_subflow_ctx(ssk)->send_infinite_map = 0;
 	pr_fallback(msk);
-	mptcp_do_fallback(ssk);
 }
 
 #define MPTCP_MAX_GSO_SIZE (GSO_LEGACY_MAX_SIZE - (MAX_TCP_HEADER + 1))
@@ -2543,9 +2553,9 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 
 static void __mptcp_retrans(struct sock *sk)
 {
+	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_sendmsg_info info = {};
 	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
 	int ret, err;
@@ -2590,6 +2600,18 @@ static void __mptcp_retrans(struct sock *sk)
 			info.sent = 0;
 			info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
 								    dfrag->already_sent;
+
+			/*
+			 * make the whole retrans decision, xmit, disallow
+			 * fallback atomic
+			 */
+			spin_lock_bh(&msk->fallback_lock);
+			if (__mptcp_check_fallback(msk)) {
+				spin_unlock_bh(&msk->fallback_lock);
+				release_sock(ssk);
+				return;
+			}
+
 			while (info.sent < info.limit) {
 				ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
 				if (ret <= 0)
@@ -2605,6 +2627,7 @@ static void __mptcp_retrans(struct sock *sk)
 					 info.size_goal);
 				WRITE_ONCE(msk->allow_infinite_fallback, false);
 			}
+			spin_unlock_bh(&msk->fallback_lock);
 
 			release_sock(ssk);
 		}
@@ -2738,6 +2761,7 @@ static void __mptcp_init_sock(struct sock *sk)
 	msk->last_ack_recv = tcp_jiffies32;
 
 	mptcp_pm_data_init(msk);
+	spin_lock_init(&msk->fallback_lock);
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -3524,7 +3548,13 @@ bool mptcp_finish_join(struct sock *ssk)
 
 	/* active subflow, already present inside the conn_list */
 	if (!list_empty(&subflow->node)) {
+		spin_lock_bh(&msk->fallback_lock);
+		if (__mptcp_check_fallback(msk)) {
+			spin_unlock_bh(&msk->fallback_lock);
+			return false;
+		}
 		mptcp_subflow_joined(msk, ssk);
+		spin_unlock_bh(&msk->fallback_lock);
 		mptcp_propagate_sndbuf(parent, ssk);
 		return true;
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e36ae88b10ad..52c9175c7e49 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -352,6 +352,7 @@ struct mptcp_sock {
 	u32		subflow_id;
 	u32		setsockopt_seq;
 	char		ca_name[TCP_CA_NAME_MAX];
+	spinlock_t	fallback_lock;	/* protects fallback && allow_infinite_fallback */
 };
 
 #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
@@ -1214,15 +1215,21 @@ static inline bool mptcp_check_fallback(const struct sock *sk)
 	return __mptcp_check_fallback(msk);
 }
 
-static inline void __mptcp_do_fallback(struct mptcp_sock *msk)
+static inline bool __mptcp_do_fallback(struct mptcp_sock *msk)
 {
 	if (__mptcp_check_fallback(msk)) {
 		pr_debug("TCP fallback already done (msk=%p)\n", msk);
-		return;
+		return true;
 	}
-	if (WARN_ON_ONCE(!READ_ONCE(msk->allow_infinite_fallback)))
-		return;
+	spin_lock_bh(&msk->fallback_lock);
+	if (!msk->allow_infinite_fallback) {
+		spin_unlock_bh(&msk->fallback_lock);
+		return false;
+	}
+
 	set_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	spin_unlock_bh(&msk->fallback_lock);
+	return true;
 }
 
 static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
@@ -1234,14 +1241,15 @@ static inline bool __mptcp_has_initial_subflow(const struct mptcp_sock *msk)
 			TCPF_SYN_RECV | TCPF_LISTEN));
 }
 
-static inline void mptcp_do_fallback(struct sock *ssk)
+static inline bool mptcp_do_fallback(struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 	struct mptcp_sock *msk;
 
 	msk = mptcp_sk(sk);
-	__mptcp_do_fallback(msk);
+	if (!__mptcp_do_fallback(msk))
+		return false;
 	if (READ_ONCE(msk->snd_data_fin_enable) && !(ssk->sk_shutdown & SEND_SHUTDOWN)) {
 		gfp_t saved_allocation = ssk->sk_allocation;
 
@@ -1253,6 +1261,7 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 		tcp_shutdown(ssk, SEND_SHUTDOWN);
 		ssk->sk_allocation = saved_allocation;
 	}
+	return true;
 }
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 15613d691bfe..433c0b25dbc1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -544,9 +544,11 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 	mptcp_get_options(skb, &mp_opt);
 	if (subflow->request_mptcp) {
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPC_SYNACK)) {
+			if (!mptcp_do_fallback(sk))
+				goto do_reset;
+
 			MPTCP_INC_STATS(sock_net(sk),
 					MPTCP_MIB_MPCAPABLEACTIVEFALLBACK);
-			mptcp_do_fallback(sk);
 			pr_fallback(msk);
 			goto fallback;
 		}
@@ -1395,7 +1397,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!READ_ONCE(msk->allow_infinite_fallback)) {
+		if (!mptcp_do_fallback(ssk)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
@@ -1414,7 +1416,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return false;
 		}
 
-		mptcp_do_fallback(ssk);
 	}
 
 	skb = skb_peek(&ssk->sk_receive_queue);
@@ -1679,7 +1680,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	/* discard the subflow socket */
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
-	WRITE_ONCE(msk->allow_infinite_fallback, false);
 	mptcp_stop_tout_timer(sk);
 	return 0;
 
-- 
2.49.0

