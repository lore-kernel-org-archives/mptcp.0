Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4346AB6
	for <mptcp@lists.linux.dev>; Fri, 21 Oct 2022 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666393146; x=1697929146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gXNmSpNkiu0qZwX34gMr7ZrLlRCl7DXUpHrvm/2Ux9E=;
  b=ZSikJ3uEAyWCsQT3XW6NVCgUqsqb4nDQG5cxN63gNejiaMdC0Vf2jEJh
   oVmGsZdZ5l5hNrOTuVda1zIa3mNKkxq39M4VHtqqPFr2oh+uigRTJtL4Z
   +oBNb3WWR3Bvjh0EW3BCJqwQrT+SiKjubbPMx5RDfu2HYk8rm1rSH45ev
   C8tJYjWr6pmiqJZaQ1EE2WnxhiQvM+T9nWW/45QBB0j0gz/BwiJLnQ2vP
   W7n0qyhviF0AhUrBeFFgq8bHLlVPp5Uw7FPNI/sL0FOfEA6GSUhwLATBy
   cuDdo4CwLBM3o/SikNGpwppGPDYCHf9fvQcAbOZvKOPGsZOc/OB4RikBY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333699093"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="333699093"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="663928734"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="663928734"
Received: from tremple-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.81])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:59:02 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	dmytro@shytyi.net,
	benjamin.hesmans@tessares.net,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net 3/3] mptcp: fix abba deadlock on fastopen
Date: Fri, 21 Oct 2022 15:58:56 -0700
Message-Id: <20221021225856.88119-4-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
References: <20221021225856.88119-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Our CI reported lockdep splat in the fastopen code:
 ======================================================
 WARNING: possible circular locking dependency detected
 6.0.0.mptcp_f5e8bfe9878d+ #1558 Not tainted
 ------------------------------------------------------
 packetdrill/1071 is trying to acquire lock:
 ffff8881bd198140 (sk_lock-AF_INET){+.+.}-{0:0}, at: inet_wait_for_connect+0x19c/0x310

 but task is already holding lock:
 ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (k-sk_lock-AF_INET){+.+.}-{0:0}:
        __lock_acquire+0xb6d/0x1860
        lock_acquire+0x1d8/0x620
        lock_sock_nested+0x37/0xd0
        inet_stream_connect+0x3f/0xa0
        mptcp_connect+0x411/0x800
        __inet_stream_connect+0x3ab/0x800
        mptcp_stream_connect+0xac/0x110
        __sys_connect+0x101/0x130
        __x64_sys_connect+0x6e/0xb0
        do_syscall_64+0x59/0x90
        entry_SYSCALL_64_after_hwframe+0x63/0xcd

 -> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
        check_prev_add+0x15e/0x2110
        validate_chain+0xace/0xdf0
        __lock_acquire+0xb6d/0x1860
        lock_acquire+0x1d8/0x620
        lock_sock_nested+0x37/0xd0
        inet_wait_for_connect+0x19c/0x310
        __inet_stream_connect+0x26c/0x800
        tcp_sendmsg_fastopen+0x341/0x650
        mptcp_sendmsg+0x109d/0x1740
        sock_sendmsg+0xe1/0x120
        __sys_sendto+0x1c7/0x2a0
        __x64_sys_sendto+0xdc/0x1b0
        do_syscall_64+0x59/0x90
        entry_SYSCALL_64_after_hwframe+0x63/0xcd

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(k-sk_lock-AF_INET);
                                lock(sk_lock-AF_INET);
                                lock(k-sk_lock-AF_INET);
   lock(sk_lock-AF_INET);

  *** DEADLOCK ***

 1 lock held by packetdrill/1071:
  #0: ffff8881b8346540 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_sendmsg+0xfdf/0x1740
 ======================================================

The problem is caused by the blocking inet_wait_for_connect() releasing
and re-acquiring the msk socket lock while the subflow socket lock is
still held and the MPTCP socket requires that the msk socket lock must
be acquired before the subflow socket lock.

Address the issue always invoking tcp_sendmsg_fastopen() in an
unblocking manner, and later eventually complete the blocking
__inet_stream_connect() as needed.

Fixes: d98a82a6afc7 ("mptcp: handle defer connect in mptcp_sendmsg")
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/protocol.c | 49 ++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f2930699c6d3..b6dc6e260334 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
 	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
 }
 
+static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
+				  size_t len, int *copied_syn)
+{
+	unsigned int saved_flags = msg->msg_flags;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	int ret;
+
+	lock_sock(ssk);
+	msg->msg_flags |= MSG_DONTWAIT;
+	msk->connect_flags = O_NONBLOCK;
+	msk->is_sendmsg = 1;
+	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
+	msk->is_sendmsg = 0;
+	msg->msg_flags = saved_flags;
+	release_sock(ssk);
+
+	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
+	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
+		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
+					    msg->msg_namelen, msg->msg_flags, 1);
+
+		/* Keep the same behaviour of plain TCP: zero the copied bytes in
+		 * case of any error, except timeout or signal
+		 */
+		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
+			*copied_syn = 0;
+	}
+
+	return ret;
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ssock = __mptcp_nmpc_socket(msk);
 	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
-		struct sock *ssk = ssock->sk;
 		int copied_syn = 0;
 
-		lock_sock(ssk);
-
-		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
-		msk->is_sendmsg = 1;
-		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
-		msk->is_sendmsg = 0;
+		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
 		copied += copied_syn;
-		if (ret == -EINPROGRESS && copied_syn > 0) {
-			/* reflect the new state on the MPTCP socket */
-			inet_sk_state_store(sk, inet_sk_state_load(ssk));
-			release_sock(ssk);
+		if (ret == -EINPROGRESS && copied_syn > 0)
 			goto out;
-		} else if (ret) {
-			release_sock(ssk);
+		else if (ret)
 			goto do_error;
-		}
-		release_sock(ssk);
 	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-- 
2.38.1

