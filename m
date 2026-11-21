Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254142;
	b=tyxIC21XoW9A1pXWLEjWcaqCFImNoHIfV/CW9N+957LCnOX60j1Btew7xZywhdf6pzLX
	 +fG9OgUUDAWUhUXLhgNWWpCu1kDjncEk3llTGnlC1CGHseD0QZBAX2RFNjoQDw6N4HWtZ
	 If8boIKTunH5+i0Z+MGecDrB1aeXldw41YlbgPIuC3M6aG6VOP4hOiN7LfExHoHH1c7V2
	 S2rzKXqrOa1FdUxy3kGnwGEixVsBmmzVJwWAGkvi4pFHY5kLyUka1U6cHlzXyFGbMAy87
	 Ylzrr9V3C/qKixJkp+L3RABzeh/ZKDDZRTaNlwejxOxlVpgIVy6wK1mkerS7J2lh1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254142;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mwizWJC4vbYxbo/rfWwMiJAXiRSi3rcOVXN6YPXeJ8c=;
	b=nVYnxZarzsPeCvr8OZz/HAGQmw22SwUPFEIW5aog3OtEkbqWsmInDsEWywwCOve2GdCV
	 zPHnO3kLOraLS0ZyJyxryprBCskpbQStJo09lHeoeP2X9vdysF1Mch5LfkIDjeGCx8ZzP
	 6eW10pLKT3eE6IPZIIIw+WUKX46dqPbZNrqOzuzMypwkI1iUWR3N3F73ElBchu2NZuNtj
	 kpp1mnrd2K1JyssKFb8nkrn9ZrjaMX5Ad9lRQyvVZhM1wsfbcC0CYU9UhOVe7Dwj5gFoU
	 BveS4FErjLy/uI4pzS5MbwqK/t+UUtBXCgLdlur2WRTLOb8Mqnquk2kSa1ga2hjHW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NLbMgq7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F42606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLbMgq7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5B21F000C0;
	Sat, 21 Nov 2026 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254142;
	bh=mwizWJC4vbYxbo/rfWwMiJAXiRSi3rcOVXN6YPXeJ8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NLbMgq7/fa9dEzztwsxyteF44b+xoUJmBHlYcbjeHpT+1wqESKEgDhTts3DaT0kT9
	 lZgesa1AFPseInKeH9zlipDDKruho/0ogNBO1WNeWXgzBOQfyrp3i2LDJkzpBYa/hr
	 FKG5bbr5AJhTGfb967FXfonwJOQuD0KfLxc7whfN8QHLBJNPKITI2JrZECZHlibEBs
	 NT1Ei/iN6crl5d+wFprZt5Uu8wkdgIOd2WFtitllJ7S0/l4k3ZhkOnSOGZdi7slyTR
	 3MDmly2e6KHKzOmVVKV7vOM4H2C1FRLPbdrUxpddblv3H1q6kXIny0DybGr2T1eZPi
	 +DEFb4/PniFNw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:01 +0100
Subject: [PATCH mptcp-net v2 03/62] mptcp: clear inet_opt in the child of
 an IPv6 listener
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-3-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4179; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RpKcXJ5+ychxfYTZbCru/7OJbFKn+vDQg7Vc2/Ieo1U=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ073CI1xFmXtUNryT4blfl/1WaamR5FE+rXaT7q+fu
 IM2+xztKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmEjrP0aGF7Okb090D9+RJFQS
 ztr6Vc5GPLBmWUD/xU+OXUuYylMcGP576LT65XcaTTVs45341GnlSdutglesH08+Ero37J914g4
 GAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Chris Mason <mason@kernel.org>

With SELinux, an IPv6 MPTCP listener and its children can cause a double
free of one CIPSO option, and then a use-after-free read of it, if
NetLabel uses CIPSO for IPv4 and selects the IPv6 labels by address.

mptcp_sk_clone_init() creates the child of a listener with
sk_clone_lock(), as a byte copy of the listener, so each pointer in the
copy that the socket destructor frees has to be replaced or cleared.
mptcp_copy_ip_options() duplicates inet_opt, the IPv4 options, for
AF_INET, and mptcp_copy_ip6_options() duplicates the IPv6 options for
AF_INET6. But an AF_INET6 socket has an inet_opt pointer too, and its
child keeps the listener's pointer.

MPTCP does not support setsockopt(IP_OPTIONS), so that pointer is
usually NULL. But if connect() gets a struct sockaddr_in,
netlbl_conn_setattr() does not look at the family of the socket, so the
connect() hook of SELinux can store a CIPSO option in inet_opt of an
AF_INET6 MPTCP listener. inet_sock_destruct() then passes that option to
kfree_rcu() for each child and again for the listener, and after a child
has freed it, another such connect() on the listener reads it in
cipso_v4_sock_setattr().

The fix used here is to clear inet_opt of the child in
mptcp_copy_ip6_options().

This issue has been found with the help of an LLM, and reproduced in a
VM, with the reproducer shared with the original version of this patch,
with SELinux, NetLabel -- CIPSO for some IPv4 addresses, and the
address-based selection used for IPv6 too -- and KASAN: an unprivileged
user calls connect() with an IPv4 address on an IPv6 MPTCP listener.
Without this patch, an object is freed twice:

  BUG: KASAN: double-free in rcu_free_sheaf+0x23/0x100
  Free of addr ffff888012c27a80 by task kworker/1:1/50
  CPU: 1 UID: 0 PID: 50 Comm: kworker/1:1 Not tainted 7.4.0-rc1+ #1 PREEMPT(full)
  Workqueue: events mptcp_worker
  Call Trace:
   <IRQ>
   kasan_report_invalid_free+0xd4/0x1b0
   check_slab_allocation+0xc2/0xf0
   __rcu_free_sheaf_prepare+0x102/0x2a0
   rcu_free_sheaf+0x23/0x100
   rcu_do_batch+0x29a/0xf80
   rcu_core+0x33c/0x830
   handle_softirqs+0x212/0x980
   do_softirq+0xb4/0xf0
   </IRQ>
   <TASK>
   __local_bh_enable_ip+0x11c/0x150
   mptcp_token_destroy+0x1c9/0x360
   mptcp_destroy_common+0x2d9/0x430
   mptcp_destroy+0x86/0x110
   __mptcp_destroy_sock+0x176/0x350
   mptcp_worker+0xbb5/0xf80
  [...]
  Allocated by task 176:
  [...]
   cipso_v4_sock_setattr+0x9b/0x3d0
   netlbl_conn_setattr+0x3ac/0x500
   selinux_netlbl_socket_connect_locked+0x102/0x210
   selinux_netlbl_socket_connect+0x23/0x40
   security_socket_connect+0x2e/0x60
   __sys_connect_file+0xcb/0x200
  [...]

In another case, the CIPSO option is used after having been freed:

  BUG: KASAN: slab-use-after-free in cipso_v4_sock_setattr+0x3c7/0x3d0
  Read of size 1 at addr ffff8880161c2f18 by task python3/177
  CPU: 1 UID: 65534 PID: 177 Comm: python3 Not tainted 7.4.0-rc1+ #1 PREEMPT(full)
  Call Trace:
   <TASK>
   kasan_report+0x101/0x140
   cipso_v4_sock_setattr+0x3c7/0x3d0
   netlbl_conn_setattr+0x3ac/0x500
   selinux_netlbl_socket_connect_locked+0x102/0x210
   selinux_netlbl_socket_connect+0x23/0x40
   security_socket_connect+0x2e/0x60
   __sys_connect_file+0xcb/0x200
   __sys_connect+0xfd/0x130
   __x64_sys_connect+0x72/0xd0
  [...]

Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming connections")
Signed-off-by: Chris Mason <mason@kernel.org>
[ Commit message: how the issue was found, and its symptoms ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 08c3b005949d..54782bdce5fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3720,6 +3720,9 @@ static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
 
 	newnp = inet6_sk(newsk);
 
+	/* The IPv4 options belong to the listener, which frees them */
+	RCU_INIT_POINTER(inet_sk(newsk)->inet_opt, NULL);
+
 	rcu_read_lock();
 	opt = rcu_dereference(np->opt);
 	if (opt) {

-- 
2.55.0

