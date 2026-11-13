Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599666;
	b=1g7aXPs6hPXwXWkjAGQKL1E3BlCDuesB+vHieozX1ujFhqs6VngC2WBTrhhKK3Ot/Q64
	 4TM78Uwuq/zFQ6riz9/2vgsq9/t59bUPUTyW3/rUCRJg41s56K70tpdU6ORYBoN8GzDUu
	 JF3vFh/JK1fht4FelqMCla19HYwsca0pY5DKWwkelqOohQcZljpNaQ+SL7f0EDxLYpogW
	 rwRHLofAz4l76BeNK6EhFpQwIl1ZJDdkAKdkFjAmf/b6g+mCDFJaI0GrW1mjzFzud7KCc
	 ls7TOzwvuR3YeFUFRcyO6xmRfMYzarm0+GWovfeLPB4WizJyvQvfZiBevBeQCyeNFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599666;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6T6vAM/UYYNAG/KfBhyUtGdv9jtMFIL9SqqzO9sTaos=;
	b=F6xdmL+SuZ1Z2zpZ6qhY0eyUKc69NRwMuCfzq8btqXQC9vh9zge59s3bcN1RvuZc3w39
	 t4WnoLm22+Bo+KRn8wnxhRo7HJ9qaWARhIJluyIO18D8HS/yQrmSRPOtgn73+eITG/G+M
	 SqE3iNpA1kM5llb/l5ckEKCnQCUh99eMZlk8D+sic6IlyMaotLEGXYmoImAA8qZMoUTsu
	 tPWr80hb8FDS8CXHoRHDdi2e6AEe4riMp7Eadagu1Tbt5BR2QU+CjsyqcjtZTOqmizMO/
	 LjP/50TN+sgbZV71xcv5K6ntr1ZatFb2oHbeg0Y7EV1z2uoyOiETzJ/bpctaM4KPGiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnqX98it;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387D160A6F6D
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lnqX98it
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FEA1F000C5;
	Fri, 13 Nov 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599666;
	bh=6T6vAM/UYYNAG/KfBhyUtGdv9jtMFIL9SqqzO9sTaos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lnqX98it6T623KEG9NZr5w5J0885tRbtoDRrkcxzou/15GTSWgXxP6ImsS4saTSBV
	 pSTWhgF3ewNdEzOwdw4znUmZjcd7m+Lpv7FsR0XFcZL7T6lUChkFDk4i5Fhzp6VPIN
	 sLeLZm5V78JYG18W0oCj3fyKZd7GVZEwA8THJFiJJ9AstqBVGnG2nK81Hoy4UxciVu
	 0DunIxzvQpgE1eI7tQ6gA1YRkR7yl6P5fvo7rTxRQFTZ9logPEQ17kNVLN0q/9TBfL
	 tegiPWH/f0DKTdA/eMF7U5kiDbaOJrJFGYfdDWnzWO08rKSz7zm6IFoc0/BjPV4g0E
	 dN8N5jM4TpuOg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 13 Nov 2026 20:53:41 +0100
Subject: [PATCH mptcp-net 03/34] mptcp: clear inet_opt in the child of an
 IPv6 listener
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
Message-Id: <20261113-mptcp-cmason-fixes-v1-3-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Chris Mason <mason@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4179; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Rzcn4x0uv7194O3/3ueVGB7t+tIsqSmBs3iIC4u/oSI=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLK+Z112YvWX1DqwJZi/ZOuEb1lmS/ocROb4ydhZh81T/
 cd21+dJRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwERMQhgZvq7dL3f3/2KvlTMP
 ik/ma9ihOXF/hBV3TcqH46cMMpd952L4Z5PFcqek+GLb1qY1qn5XWuMPam+Y9iFYnHHfQ9vrAR6
 xzAA=
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
index dd9fb803cad5..e484f7edad49 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3718,6 +3718,9 @@ static void mptcp_copy_ip6_options(struct sock *newsk, const struct sock *sk)
 
 	newnp = inet6_sk(newsk);
 
+	/* The IPv4 options belong to the listener, which frees them */
+	RCU_INIT_POINTER(inet_sk(newsk)->inet_opt, NULL);
+
 	rcu_read_lock();
 	opt = rcu_dereference(np->opt);
 	if (opt) {

-- 
2.55.0

