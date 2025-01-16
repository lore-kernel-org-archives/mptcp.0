Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E1722C356
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051363; cv=none; b=BtiKp3Rzor7yrHlzsc7sb/uZbforf5VZhlHL4wYaQ6mOsusz3tgOFGsJl+kEeq2d6qPBFwSM68ktzWWHDx84ZjjiAuwNPnf3vplhF2M7rEbXJfMf8AFzh7i8XpLbPGQ4xOSTFpGxDXLZYO69u0T+glE0qHZIK+oGpc9LLBF+NoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051363; c=relaxed/simple;
	bh=+TrdSsubgRwaS+SCyxbLvgvGjs7ZS+C2JMGm35Nzy+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N+zQVa1DdZ8OJehktba4hQxcyH1g9yJhgm8Rm+AQaEg7YjRSYuoLJPnYd6Fpeexu4uMPogxO8SRvcGmSTyGDi7NROGyrouuPKJDMDOhcGbAvxPZVXLfp3yIYtjupfHAY60tXfH9sgEU0UALBu+0yAFINUJOMudikS7z9IWvJ58w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzN6HsPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzN6HsPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA93C4CED6;
	Thu, 16 Jan 2025 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737051363;
	bh=+TrdSsubgRwaS+SCyxbLvgvGjs7ZS+C2JMGm35Nzy+0=;
	h=From:Date:Subject:To:Cc:From;
	b=hzN6HsPlLAPIC/jgjSRRbzKqphfcz2uoinneFdXF2t4Ymq3fpz7YHmAJjVGiQAmd/
	 40em1xCSMVgmcorEKvi+Kct8VPu0bUdu+jq/ueNWhmYIkSGUr+MLGOru5YEHD8LOcv
	 8vjfcBx38Hwtty9Nv1EyJgHE/uh8Mvb9mWUul03ero3715AYbnoWTpdbQwe5jGq+7N
	 p+m5lKNq1ffhD8rWkSM2U/DGeI6nRfDdeS65VR0xlltDLZYdPXd+Umuw2tSZHQZli1
	 /z2+d0OcSaL6EwW5BzABl97gG8l8/bokqr5ZRuAWkNO2vcc8rRZxm4ysW7hOui3rmO
	 tVNPgBxdSf9KA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 16 Jan 2025 19:15:55 +0100
Subject: [PATCH mptcp-net] mptcp: pm: only set fullmesh for subflow endp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-mptcp-issue-540-v1-1-b0ba2c126eb8@kernel.org>
X-B4-Tracking: v=1; b=H4sIANpMiWcC/yWMQQ5AMBAAvyJ7tklLSfiKOJQu9qCaLiIRf9dwn
 GRmbhCKTAJtdkOkk4U3n0DnGYyL9TMhu8RQqKJSWte4hn0MyCIHYWUUmsZpN5SlqW0DqQqRJr6
 +Ywe/7GmH/nle8pgi9WwAAAA=
X-Change-ID: 20250116-mptcp-issue-540-49d1db3346a9
To: mptcp@lists.linux.dev
Cc: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5717; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+TrdSsubgRwaS+SCyxbLvgvGjs7ZS+C2JMGm35Nzy+0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBniUziLYsNgSdrNvpYT+a5V1b8H35a3gvNissKn
 qc5W9pUPtSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4lM4gAKCRD2t4JPQmmg
 c+28D/4tPOdffmd4wLVYqVNbQGqd+Q6xocZnJzddIuvuVGnnXQC7+5fdDnxEYdsm+BY0YFtVnSw
 A0T+Hi4+dt6BuskNzQ6100YY/Bj325bHXyENrS/ci7smUtHtGWuxvTEbEGBnkk+cEH4JokhF+zp
 2ufkoGd/mFLBpjnpt9B3JktOeucKaJVi6JbQWbWGTMxzoNI2R6EQnkMAw5NtiledWed8NRTlh4y
 PPFKpb8JwWMs6YKoMGpAIRctBVyRwvJ5FHD8L7PK7vu8Rp7EFt93YCV9n7qmq5yvVnoRCo5hQnr
 RgJDWIqd1PNcy9WbXRp4vKlxubiwE4VeodqrM/RW+I9Zv7RhwBLwuDV0jMHMnpkyTIzPm/ZFKVH
 chn33jB1pP4hAx5wzY8CTWwCib6BbetGLRCAIZwdAyCDkzJhLha9TYM1V+EVWbnj+QAmtjdvGGL
 ydsRRVKjBCly3NHCip+PKsyCeoviX6dZn8m99XIsi+LV2jfLPeVYismVK7VG7RkQUmmHGuzusqO
 VLIh50y9CY3peQqQpNg6kWpogWz36V0R0jvL/X4z9QVtmqd271ovC24r2g+knCdfA6ivTDyQmK+
 TsdwuSKf5ulXJO21FQxx87v/Z0yIM9jhjwAG7L7+M41DKGlERgj9ge/eISj6n4y1QnUNyw6M6gP
 wWFrIHB0qJyoO9Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

With the in-kernel path-manager, it is possible to change the 'fullmesh'
flag. The code in mptcp_pm_nl_fullmesh() expects to change it only on
'subflow' endpoints, to recreate more or less subflows using the linked
address.

Unfortunately, the set_flags() hook was a bit more permissive, and
allowed 'implicit' endpoints to get the 'fullmesh' flag while it is not
allowed before.

That's what syzbot found, triggering the following warning:

  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 __mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  WARNING: CPU: 0 PID: 6499 at net/mptcp/pm_netlink.c:1496 mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Modules linked in:
  CPU: 0 UID: 0 PID: 6499 Comm: syz.1.413 Not tainted 6.13.0-rc5-syzkaller-00172-gd1bf27c4e176 #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  RIP: 0010:__mark_subflow_endp_available net/mptcp/pm_netlink.c:1496 [inline]
  RIP: 0010:mptcp_pm_nl_fullmesh net/mptcp/pm_netlink.c:1980 [inline]
  RIP: 0010:mptcp_nl_set_flags net/mptcp/pm_netlink.c:2003 [inline]
  RIP: 0010:mptcp_pm_nl_set_flags+0x974/0xdc0 net/mptcp/pm_netlink.c:2064
  Code: 01 00 00 49 89 c5 e8 fb 45 e8 f5 e9 b8 fc ff ff e8 f1 45 e8 f5 4c 89 f7 be 03 00 00 00 e8 44 1d 0b f9 eb a0 e8 dd 45 e8 f5 90 <0f> 0b 90 e9 17 ff ff ff 89 d9 80 e1 07 38 c1 0f 8c c9 fc ff ff 48
  RSP: 0018:ffffc9000d307240 EFLAGS: 00010293
  RAX: ffffffff8bb72e03 RBX: 0000000000000000 RCX: ffff88807da88000
  RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  RBP: ffffc9000d307430 R08: ffffffff8bb72cf0 R09: 1ffff1100b842a5e
  R10: dffffc0000000000 R11: ffffed100b842a5f R12: ffff88801e2e5ac0
  R13: ffff88805c214800 R14: ffff88805c2152e8 R15: 1ffff1100b842a5d
  FS:  00005555619f6500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020002840 CR3: 00000000247e6000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0xb14/0xec0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
   sock_sendmsg_nosec net/socket.c:711 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:726
   ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
   ___sys_sendmsg net/socket.c:2637 [inline]
   __sys_sendmsg+0x269/0x350 net/socket.c:2669
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f5fe8785d29
  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007fff571f5558 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f5fe8975fa0 RCX: 00007f5fe8785d29
  RDX: 0000000000000000 RSI: 0000000020000480 RDI: 0000000000000007
  RBP: 00007f5fe8801b08 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 00007f5fe8975fa0 R14: 00007f5fe8975fa0 R15: 00000000000011f4
   </TASK>

Here, syzbot managed to set the 'fullmesh' flag on an 'implicit' and
used -- according to 'id_avail_bitmap' -- endpoint, causing the PM to
try decrement the local_addr_used counter which is only incremented for
the 'subflow' endpoint.

Note that 'no type' endpoints -- not 'subflow', 'signal', 'implicit' --
are fine, because their ID will not be marked as used in the 'id_avail'
bitmap, and setting 'fullmesh' can help forcing the creation of subflow
when receiving an ADD_ADDR.

Fixes: 73c762c1f07d ("mptcp: set fullmesh flag in pm_netlink")
Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6786ac51.050a0220.216c54.00a6.GAE@google.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/540
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index fef01692eaed404e272359df691264f797240d10..7131dc2f312d923a31bb4b0460b6b4663376fbd0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1986,7 +1986,8 @@ int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 		return -EINVAL;
 	}
 	if ((local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH) &&
-	    (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+	    ((entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) ||
+	     (entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT))) {
 		spin_unlock_bh(&pernet->lock);
 		NL_SET_ERR_MSG_ATTR(info->extack, attr, "invalid addr flags");
 		return -EINVAL;

---
base-commit: 9f10cc97addfb3a81b4aaf4b13f59b36b5bcc7a6
change-id: 20250116-mptcp-issue-540-49d1db3346a9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

