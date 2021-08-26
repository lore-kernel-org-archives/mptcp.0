Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD672
	for <mptcp@lists.linux.dev>; Thu, 26 Aug 2021 00:46:21 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217360497"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="217360497"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 17:46:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="684700851"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.12.88])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 17:46:12 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev,
	pabeni@redhat.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	geliangtang@gmail.com
Subject: [PATCH mptcp-net] mptcp: Only send extra TCP acks in eligible socket states
Date: Wed, 25 Aug 2021 17:46:01 -0700
Message-Id: <20210826004601.196834-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent changes exposed a bug where specifically-timed requests to the
path manager netlink API could trigger a divide-by-zero in
__tcp_select_window(), as syzkaller does:

divide error: 0000 [#1] SMP KASAN NOPTI
CPU: 0 PID: 9667 Comm: syz-executor.0 Not tainted 5.14.0-rc6+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__tcp_select_window+0x509/0xa60 net/ipv4/tcp_output.c:3016
Code: 44 89 ff e8 c9 29 e9 fd 45 39 e7 0f 8d 20 ff ff ff e8 db 28 e9 fd 44 89 e3 e9 13 ff ff ff e8 ce 28 e9 fd 44 89 e0 44 89 e3 99 <f7> 7c 24 04 29 d3 e9 fc fe ff ff e8 b7 28 e9 fd 44 89 f1 48 89 ea
RSP: 0018:ffff888031ccf020 EFLAGS: 00010216
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000040000
RDX: 0000000000000000 RSI: ffff88811532c080 RDI: 0000000000000002
RBP: 0000000000000000 R08: ffffffff835807c2 R09: 0000000000000000
R10: 0000000000000004 R11: ffffed1020b92441 R12: 0000000000000000
R13: 1ffff11006399e08 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fa4c8344700(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f424000 CR3: 000000003e4e2003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 tcp_select_window net/ipv4/tcp_output.c:264 [inline]
 __tcp_transmit_skb+0xc00/0x37a0 net/ipv4/tcp_output.c:1351
 __tcp_send_ack.part.0+0x3ec/0x760 net/ipv4/tcp_output.c:3972
 __tcp_send_ack net/ipv4/tcp_output.c:3978 [inline]
 tcp_send_ack+0x7d/0xa0 net/ipv4/tcp_output.c:3978
 mptcp_pm_nl_addr_send_ack+0x1ab/0x380 net/mptcp/pm_netlink.c:654
 mptcp_pm_remove_addr+0x161/0x200 net/mptcp/pm.c:58
 mptcp_nl_remove_id_zero_address+0x197/0x460 net/mptcp/pm_netlink.c:1328
 mptcp_nl_cmd_del_addr+0x98b/0xd40 net/mptcp/pm_netlink.c:1359
 genl_family_rcv_msg_doit.isra.0+0x225/0x340 net/netlink/genetlink.c:731
 genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
 genl_rcv_msg+0x341/0x5b0 net/netlink/genetlink.c:792
 netlink_rcv_skb+0x148/0x430 net/netlink/af_netlink.c:2504
 genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
 netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
 netlink_unicast+0x537/0x750 net/netlink/af_netlink.c:1340
 netlink_sendmsg+0x846/0xd80 net/netlink/af_netlink.c:1929
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0x14e/0x190 net/socket.c:724
 ____sys_sendmsg+0x709/0x870 net/socket.c:2403
 ___sys_sendmsg+0xff/0x170 net/socket.c:2457
 __sys_sendmsg+0xe5/0x1b0 net/socket.c:2486
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

mptcp_pm_nl_addr_send_ack() was attempting to send a TCP ACK on the
first subflow in the MPTCP socket's connection list without validating
that the subflow was in a suitable connection state. To address this,
always validate subflow state when sending extra ACKs on subflows
for address advertisement or subflow priority change.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/229
Co-developed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

Paolo made the code changes and posted them in a pastebin draft while we
discussed on irc, so I figure he can either add his signoff in a reply,
or repost as the patch author (whatever works for you, Paolo).

I'm running this in syzkaller, but the bug was usually taking a few days
to show up so it will need more time to confirm the fix.

It's probably going to be too late to get this in v5.14, so I'll have to
watch to make sure it gets in to the v5.14 and v5.13 stable
branches. v5.10 does not have the problem, so no further backporting
beyond v5.13.


 net/mptcp/pm_netlink.c | 10 ++--------
 net/mptcp/protocol.c   | 21 ++++++++++++---------
 net/mptcp/protocol.h   |  1 +
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1e4289c507ff..c4f9a5ce3815 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -644,15 +644,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
 	if (subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
 
 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for %s",
 			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
 
-		slow = lock_sock_fast(ssk);
-		tcp_send_ack(ssk);
-		unlock_sock_fast(ssk, slow);
+		mptcp_subflow_send_ack(ssk);
 		spin_lock_bh(&msk->pm.lock);
 	}
 }
@@ -669,7 +666,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
-		bool slow;
 
 		local_address((struct sock_common *)ssk, &local);
 		if (!addresses_equal(&local, addr, addr->port))
@@ -682,9 +678,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 
 		spin_unlock_bh(&msk->pm.lock);
 		pr_debug("send ack for mp_prio");
-		slow = lock_sock_fast(ssk);
-		tcp_send_ack(ssk);
-		unlock_sock_fast(ssk, slow);
+		mptcp_subflow_send_ack(ssk);
 		spin_lock_bh(&msk->pm.lock);
 
 		return 0;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index af8f677162f3..898485e4c1dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -440,19 +440,22 @@ static bool tcp_can_send_ack(const struct sock *ssk)
 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
 }
 
+void mptcp_subflow_send_ack(struct sock *ssk)
+{
+	bool slow;
+
+	slow = lock_sock_fast(ssk);
+	if (tcp_can_send_ack(ssk))
+		tcp_send_ack(ssk);
+	unlock_sock_fast(ssk, slow);
+}
+
 static void mptcp_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
 
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow;
-
-		slow = lock_sock_fast(ssk);
-		if (tcp_can_send_ack(ssk))
-			tcp_send_ack(ssk);
-		unlock_sock_fast(ssk, slow);
-	}
+	mptcp_for_each_subflow(msk, subflow)
+		mptcp_subflow_send_ack(mptcp_subflow_tcp_sock(subflow));
 }
 
 static void mptcp_subflow_cleanup_rbuf(struct sock *ssk)
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d7aba1c4dc48..99a23fff7b03 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -573,6 +573,7 @@ void __init mptcp_subflow_init(void);
 void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		     struct mptcp_subflow_context *subflow);
+void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
-- 
2.33.0

