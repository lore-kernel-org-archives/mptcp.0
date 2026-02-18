Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DC344DAE
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771442708; cv=none; b=M2A+mi9ZDWS1PyvUuo5S8Q3ErABS9wrWnteZIZb8GvC8D2qbqITxlVWBlpBxWYjA1fvcaDS8ASr8zKGtJCnVBF3CZDTQX7dSL9OALSN1t43NFvVbTfeIR0vaAj/o7aD/1/7HJHTB3pZPH810dPH3TPEBSTgRMB1sPQKG1arsKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771442708; c=relaxed/simple;
	bh=gfkgrGanGjFMRRW6wiVBK5Bjq8qnqju16909Uey9QFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c+BUg92p5Priw0JMnBcnkRV87+a29CzhYnUlKLfEK6MeVoupD7Y0ZvZfKLnm/IInDGegMd2ZbRoO2GACdb5oWdi7GJ1iyyjVWQ1VHBBHO/7+atxG4NRTSC1uRuhh5+iL9wFxp8jCdAef3vgt/fQEALU2wcLlRe530EZCkFsq4Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIqGE/Xh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIqGE/Xh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99F8C116D0;
	Wed, 18 Feb 2026 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771442708;
	bh=gfkgrGanGjFMRRW6wiVBK5Bjq8qnqju16909Uey9QFc=;
	h=From:Date:Subject:To:Cc:From;
	b=sIqGE/Xhip2Mntb9Ub+U37vuu/gUI63mylN9gT58H29gXu2LxdFRLXB6ooPirRTaU
	 vlwDh5MUVypMArr3lOufDq2do/ZCkebaDTiejtWadU29OmKohT9zEW25mdTHkSOk5h
	 5N6OMgazOOSoEl5q2YQy6IjtZ4SXNuIg9gGJrv2s6ZrsC5qN6ssXWAd49diQeGfSqB
	 +F9iQC/HAQuWXvnpgKEQVyu5UDYCeDIQv4KgcOkRPTVXggmQQ6t56Z7JK1jR9O13OB
	 LH7gEWkJq9AUZnzBi9Sjco51P/OKnzFGUYI9YNKJdMgKlqwG30lr2nXg//IP53B+MW
	 CUi6PKuF4kAtw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 18 Feb 2026 20:24:58 +0100
Subject: [PATCH mptcp-net] mptcp: pm: in-kernel: always mark signal+subflow
 endp as used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAkSlmkC/yWMQQqEMAwAvyI5G2gqivgV8VBrds3BWhoVofh3y
 +5xYGYyKCdhhaHKkPgSlT0UoLoCv7rwZZSlMFhjO2Opxy0ePqKonowdNWjcQnPbeke9h1LFxB+
 5f8cR/nLgA6bneQFzD5SVbAAAAA==
X-Change-ID: 20260218-mptcp-issue-613-0ad1b55ca18c
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6160; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gfkgrGanGjFMRRW6wiVBK5Bjq8qnqju16909Uey9QFc=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmWEhOg0IrLOfwSeVidVRjn92Xc0iX/EbTck/wBLH013YkFc
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmWEhMACgkQfCLwwvNHCpcolQD9EHCT
 ocKmufHiS0fwGJT/O9DH1UxJrXeX5AVWDXmZBdIBAMQ8gRXJZRfoUZ63uUrL/J4qsSLudz2vrC/
 L9jZBVk4B
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Syzkaller managed to find a combination of actions that was generating
this warning:

  msk->pm.local_addr_used == 0
  WARNING: net/mptcp/pm_kernel.c:1071 at __mark_subflow_endp_available net/mptcp/pm_kernel.c:1071 [inline], CPU#1: syz.2.17/961
  WARNING: net/mptcp/pm_kernel.c:1071 at mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1103 [inline], CPU#1: syz.2.17/961
  WARNING: net/mptcp/pm_kernel.c:1071 at mptcp_pm_nl_del_addr_doit+0x81d/0x8f0 net/mptcp/pm_kernel.c:1210, CPU#1: syz.2.17/961
  Modules linked in:
  CPU: 1 UID: 0 PID: 961 Comm: syz.2.17 Not tainted 6.19.0-08368-gfafda3b4b06b #22 PREEMPT(full)
  Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.17.0-debian-1.17.0-1build1 04/01/2014
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_kernel.c:1071 [inline]
  RIP: 0010:mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_kernel.c:1103 [inline]
  RIP: 0010:mptcp_pm_nl_del_addr_doit+0x81d/0x8f0 net/mptcp/pm_kernel.c:1210
  Code: 89 c5 e8 46 30 6f fe e9 21 fd ff ff 49 83 ed 80 e8 38 30 6f fe 4c 89 ef be 03 00 00 00 e8 db 49 df fe eb ac e8 24 30 6f fe 90 <0f> 0b 90 e9 1d ff ff ff e8 16 30 6f fe eb 05 e8 0f 30 6f fe e8 9a
  RSP: 0018:ffffc90001663880 EFLAGS: 00010293
  RAX: ffffffff82de1a6c RBX: 0000000000000000 RCX: ffff88800722b500
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffff8880158b22d0 R08: 0000000000010425 R09: ffffffffffffffff
  R10: ffffffff82de18ba R11: 0000000000000000 R12: ffff88800641a640
  R13: ffff8880158b1880 R14: ffff88801ec3c900 R15: ffff88800641a650
  FS:  00005555722c3500(0000) GS:ffff8880f909d000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f66346e0f60 CR3: 000000001607c000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   genl_family_rcv_msg_doit+0x117/0x180 net/netlink/genetlink.c:1115
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0x3a8/0x3f0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x16d/0x240 net/netlink/af_netlink.c:2550
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
   netlink_unicast+0x3e9/0x4c0 net/netlink/af_netlink.c:1344
   netlink_sendmsg+0x4aa/0x5b0 net/netlink/af_netlink.c:1894
   sock_sendmsg_nosec net/socket.c:727 [inline]
   __sock_sendmsg+0xc9/0xf0 net/socket.c:742
   ____sys_sendmsg+0x272/0x3b0 net/socket.c:2592
   ___sys_sendmsg+0x2de/0x320 net/socket.c:2646
   __sys_sendmsg net/socket.c:2678 [inline]
   __do_sys_sendmsg net/socket.c:2683 [inline]
   __se_sys_sendmsg net/socket.c:2681 [inline]
   __x64_sys_sendmsg+0x110/0x1a0 net/socket.c:2681
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0x143/0x440 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f66346f826d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007ffc83d8bdc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f6634985fa0 RCX: 00007f66346f826d
  RDX: 00000000040000b0 RSI: 0000200000000740 RDI: 0000000000000007
  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6634985fa8
  R13: 00007f6634985fac R14: 0000000000000000 R15: 0000000000001770
   </TASK>

The actions that caused that seem to be:

 - Set the MPTCP subflows limit to 0
 - Create an MPTCP endpoint with both the 'signal' and 'subflow' flags
 - Create a new MPTCP connection from a different address: an ADD_ADDR
   linked to the MPTCP endpoint will be sent ('signal' flag), but no
   subflows is initiated ('subflow' flag)
 - Remove the MPTCP endpoint

In this case, msk->pm.local_addr_used has been kept to 0 -- because no
subflows have been created -- but the corresponding bit in
msk->pm.id_avail_bitmap has been cleared when the ADD_ADDR has been
sent. This later causes a splat when removing the MPTCP endpoint because
msk->pm.local_addr_used has been kept to 0.

Now, if an endpoint has both the signal and subflow flags, but it is not
possible to create subflows because of the limits or the c-flag case,
then the local endpoint counter is still incremented: the endpoint is
used at the end. This avoids issues later when removing the endpoint and
calling __mark_subflow_endp_available(), which expects
msk->pm.local_addr_used to have been previously incremented if the
endpoint was marked as used according to msk->pm.id_avail_bitmap.

Note that signal_and_subflow variable is reset to false when the limits
and the c-flag case allows subflows creation. Also, local_addr_used is
only incremented for non ID0 subflows.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/613
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 87e37c729f81..2710abcd4065 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -418,6 +418,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 	}
 
 exit:
+	/* If an endpoint has both the signal and subflow flags, but it is not
+	 * possible to create subflows because of the limits or the c-flag case,
+	 * then still mark the endp as used, which is the case. This avoids
+	 * issues later when removing the endpoint and calling
+	 * __mark_subflow_endp_available(), which expects the increment here.
+	 */
+	if (signal_and_subflow && local.addr.id != msk->mpc_endpoint_id)
+		msk->pm.local_addr_used++;
+
 	mptcp_pm_nl_check_work_pending(msk);
 }
 

---
base-commit: eb01783b4b05934951774780509d96f7fe64c4a3
change-id: 20260218-mptcp-issue-613-0ad1b55ca18c

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

