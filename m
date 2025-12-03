Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA37314B8B
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764786289; cv=none; b=NjasyOtulwV14efBwEqeovqWhBlykKU8b1tVTgZe8v+iDP6m2uDakBmYZn7dK/ZPR5UEfb848/UL/2nihU6s9WxE/CborjjWWtohk6ltiGrcPku4XrLL2dRdrNs5XggqY8hX146G0YxPkQnDnA36k+ruBxhtpGMkbMsfl/AerBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764786289; c=relaxed/simple;
	bh=jqNmFk+/1duw/Gr99YqnH0G+DeHszM9CnIfGwrIKl6g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=O5uRK5a9NyVCZx8rVObAtaOyzO0puoT2XD81ySflJkFWm1rl0574S5EwUFszyHyPI43c5gVgHwMKn7z/tP7Ur081xGV0a1JP3QkaB6hLqihQbSSMrVm0bIT5jSmIHvrE7OwqyHKJkcDLut7L5BP9M9sy0tkdQ7iAa4FyqVe4qs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dlOk0X5u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlOk0X5u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764786286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RbloZGjUGTkgyyPDiAC1AyFhRvmMllDnoYn79jSJ53c=;
	b=dlOk0X5u1x9Rd0wkYDDs8NXwlbuBd8FF9Vcvrz1WIZf4ciXsxAKY1mNB+v4MCJtD9niON1
	uu58S48rYZ0Bipl12ALQ5DL4Oqp17JcyPMns0wBn+tZaq6CtKV+ilg7ochYw2mws4qLLzO
	li98qzdr/vCld6+B6Wjb+Lqb3yLfapA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-QYw4wMarOnOofPL1pFXwuw-1; Wed,
 03 Dec 2025 13:24:45 -0500
X-MC-Unique: QYw4wMarOnOofPL1pFXwuw-1
X-Mimecast-MFC-AGG-ID: QYw4wMarOnOofPL1pFXwuw_1764786284
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4456119560AD
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:44 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6619519560A7
	for <mptcp@lists.linux.dev>; Wed,  3 Dec 2025 18:24:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 1/2] mptcp: fallback earlier on simult connection
Date: Wed,  3 Dec 2025 19:24:34 +0100
Message-ID: <078e2754149228cbcda09182870520bd5d0a4aae.1764786151.git.pabeni@redhat.com>
In-Reply-To: <cover.1764786151.git.pabeni@redhat.com>
References: <cover.1764786151.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vT-t13qY8M5bLJWkcIanrKcj4fi2EbWabIndtUpODBw_1764786284
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Syzkaller reports a simult-connect race leading to inconsistent fallback
status:

WARNING: CPU: 3 PID: 33 at net/mptcp/subflow.c:1515 subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
Modules linked in:
CPU: 3 UID: 0 PID: 33 Comm: ksoftirqd/3 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:subflow_data_ready+0x40b/0x7c0 net/mptcp/subflow.c:1515
Code: 89 ee e8 78 61 3c f6 40 84 ed 75 21 e8 8e 66 3c f6 44 89 fe bf 07 00 00 00 e8 c1 61 3c f6 41 83 ff 07 74 09 e8 76 66 3c f6 90 <0f> 0b 90 e8 6d 66 3c f6 48 89 df e8 e5 ad ff ff 31 ff 89 c5 89 c6
RSP: 0018:ffffc900006cf338 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888031acd100 RCX: ffffffff8b7f2abf
RDX: ffff88801e6ea440 RSI: ffffffff8b7f2aca RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000007
R10: 0000000000000004 R11: 0000000000002c10 R12: ffff88802ba69900
R13: 1ffff920000d9e67 R14: ffff888046f81800 R15: 0000000000000004
FS:  0000000000000000(0000) GS:ffff8880d69bc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000560fc0ca1670 CR3: 0000000032c3a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 tcp_data_queue+0x13b0/0x4f90 net/ipv4/tcp_input.c:5197
 tcp_rcv_state_process+0xfdf/0x4ec0 net/ipv4/tcp_input.c:6922
 tcp_v6_do_rcv+0x492/0x1740 net/ipv6/tcp_ipv6.c:1672
 tcp_v6_rcv+0x2976/0x41e0 net/ipv6/tcp_ipv6.c:1918
 ip6_protocol_deliver_rcu+0x188/0x1520 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x1e4/0x4b0 net/ipv6/ip6_input.c:489
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip6_input+0x105/0x2f0 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:471 [inline]
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ipv6_rcv+0x264/0x650 net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core+0x12d/0x1e0 net/core/dev.c:5979
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:6092
 process_backlog+0x442/0x15e0 net/core/dev.c:6444
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7494
 napi_poll net/core/dev.c:7557 [inline]
 net_rx_action+0xa9f/0xfe0 net/core/dev.c:7684
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 run_ksoftirqd kernel/softirq.c:968 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:960
 smpboot_thread_fn+0x3f7/0xae0 kernel/smpboot.c:160
 kthread+0x3c2/0x780 kernel/kthread.c:463
 ret_from_fork+0x5d7/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The TCP subflow can process the simult-connect syn-ack packet after
transitioning to TCP_FIN1 state, bypassing the MPTCP fallback check,
as the sk_state_change() callback is not invoked for * -> FIN_WAIT1
transitions.

That will move the msk socket to an inconsistent status and the next
incoming data will hit the reported splat.

Close the race moving the simult-fallback check at the earliest possible
stage - that is at syn-ack generation time.

Fixes: 23e89e8ee7be ("tcp: Don't drop SYN+ACK for simultaneous connect().")
Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/586
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - re-add is_active_ssk(). MPJ subflow would likely still need more love
    to handle simult connect correctly, but let's not mix-up things.

Note: I kept the subflow_simultaneous_connect() helper around because
its name itself is/should be well self-documenting.

simult connect pkt drill test will need a paired change; not reporting
the full diff to avoid confusing the patch importer:

 +0  >  S  0:0(0)                    <mss 1460, sackOK, TS val 100 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
 +0  <  S  0:0(0)         win 1000   <mss 1460, sackOK, TS val 407 ecr 0,   nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
-+0  >  S. 0:0(0)  ack 1             <mss 1460, sackOK, TS val 330 ecr 407, nop, wscale 8, mpcapable v1 flags[flag_h] nokey>
-+0  <  S. 0:0(0)  ack 1  win 65535  <mss 1460, sackOK, TS val 507 ecr 100, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey=2]>
++0  >  S. 0:0(0)  ack 1             <mss 1460, sackOK, TS val 330 ecr 407, nop,wscale 8>
++0  <  S. 0:0(0)  ack 1  win 65535  <mss 1460, sackOK, TS val 507 ecr 100, nop,wscale 8>
 +0  >   . 1:1(0)  ack 1             <nop,      nop,    TS val 430 ecr 507, nop, nop, sack 0:1>
---
 net/mptcp/options.c  | 10 ++++++++++
 net/mptcp/protocol.h |  6 ++----
 net/mptcp/subflow.c  |  6 ------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ff2b9fc7c01f..ac16e4bd496f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -408,6 +408,16 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 	 */
 	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
 	if (subflow->request_mptcp) {
+		if (unlikely(subflow_simultaneous_connect(sk))) {
+			WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
+
+			/* Ensure mptcp_finish_connect() will not process the
+			 * MPC handshake.
+			 */
+			subflow->request_mptcp = 0;
+			return false;
+		}
+
 		opts->suboptions = OPTION_MPTCP_MPC_SYN;
 		opts->csum_reqd = mptcp_is_checksum_enabled(sock_net(sk));
 		opts->allow_join_id0 = mptcp_allow_join_id0(sock_net(sk));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index bc470254bd6b..41d80df1ba3e 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1334,10 +1334,8 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return (1 << sk->sk_state) &
-	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
-	       is_active_ssk(subflow) &&
-	       !subflow->conn_finished;
+	/* Note that the sk state implies !subflow->conn_finished. */
+	return sk->sk_state == TCP_SYN_RECV && is_active_ssk(subflow);
 }
 
 #ifdef CONFIG_SYN_COOKIES
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 86ce58ae533d..96d54cb2cd93 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1878,12 +1878,6 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
-	if (subflow_simultaneous_connect(sk)) {
-		WARN_ON_ONCE(!mptcp_try_fallback(sk, MPTCP_MIB_SIMULTCONNFALLBACK));
-		subflow->conn_finished = 1;
-		mptcp_propagate_state(parent, sk, subflow, NULL);
-	}
-
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
-- 
2.52.0

