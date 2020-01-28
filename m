Content-Type: multipart/mixed; boundary="===============3353055236745770598=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v4 2/4] mptcp: protocol: fix panic on user
 pointer access
Date: Tue, 28 Jan 2020 16:01:22 +0100
Message-ID: <20200128150125.26625-3-fw@strlen.de>
In-Reply-To: 20200128150125.26625-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3537

--===============3353055236745770598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Its not possible to call the kernel_(s|g)etsockopt functions here,
the address points to user memory:

General protection fault in user access. Non-canonical address?
WARNING: CPU: 1 PID: 5352 at arch/x86/mm/extable.c:77 ex_handler_uaccess+0x=
ba/0xe0 arch/x86/mm/extable.c:77
Kernel panic - not syncing: panic_on_warn set ...
[..]
Call Trace:
 fixup_exception+0x9d/0xcd arch/x86/mm/extable.c:178
 general_protection+0x2d/0x40 arch/x86/entry/entry_64.S:1202
 do_ip_getsockopt+0x1f6/0x1860 net/ipv4/ip_sockglue.c:1323
 ip_getsockopt+0x87/0x1c0 net/ipv4/ip_sockglue.c:1561
 tcp_getsockopt net/ipv4/tcp.c:3691 [inline]
 tcp_getsockopt+0x8c/0xd0 net/ipv4/tcp.c:3685
 kernel_getsockopt+0x121/0x1f0 net/socket.c:3736
 mptcp_getsockopt+0x69/0x90 net/mptcp/protocol.c:830
 __sys_getsockopt+0x13a/0x220 net/socket.c:2175

v2: also fix a circular locking dependency reported by Christoph:
    release the mptcp-level lock before calling set/getsockopt on the
    underlying tcp subflow socket, else this yields:
 v4: no need to check for SOL_SOCKET again (Paolo)

 WARNING: possible circular locking dependency detected
 5.5.0-rc6 #2 Not tainted
 ------------------------------------------------------
 syz-executor.0/16334 is trying to acquire lock:
 ffffffff84f7a080 (rtnl_mutex){+.+.}, at: do_ip_setsockopt.isra.0+0x277/0x3=
820 net/ipv4/ip_sockglue.c:644
 but task is already holding lock:
 ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: lock_sock include/net/sock.h=
:1516 [inline]
 ffff888116503b90 (sk_lock-AF_INET){+.+.}, at: mptcp_setsockopt+0x28/0x90 n=
et/mptcp/protocol.c:1284

 which lock already depends on the new lock.
 the existing dependency chain (in reverse order) is:

 -> #1 (sk_lock-AF_INET){+.+.}:
        lock_sock_nested+0xca/0x120 net/core/sock.c:2944
        lock_sock include/net/sock.h:1516 [inline]
        do_ip_setsockopt.isra.0+0x281/0x3820 net/ipv4/ip_sockglue.c:645
        ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
        udp_setsockopt+0x5d/0xa0 net/ipv4/udp.c:2639
        __sys_setsockopt+0x152/0x240 net/socket.c:2130
        __do_sys_setsockopt net/socket.c:2146 [inline]
        __se_sys_setsockopt net/socket.c:2143 [inline]
        __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
        do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #0 (rtnl_mutex){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2475 [inline]
        check_prevs_add kernel/locking/lockdep.c:2580 [inline]
        validate_chain kernel/locking/lockdep.c:2970 [inline]
        __lock_acquire+0x1fb2/0x4680 kernel/locking/lockdep.c:3954
        lock_acquire+0x127/0x330 kernel/locking/lockdep.c:4484
        __mutex_lock_common kernel/locking/mutex.c:956 [inline]
        __mutex_lock+0x158/0x1340 kernel/locking/mutex.c:1103
        do_ip_setsockopt.isra.0+0x277/0x3820 net/ipv4/ip_sockglue.c:644
        ip_setsockopt+0x44/0xf0 net/ipv4/ip_sockglue.c:1248
        tcp_setsockopt net/ipv4/tcp.c:3159 [inline]
        tcp_setsockopt+0x8c/0xd0 net/ipv4/tcp.c:3153
        kernel_setsockopt+0x121/0x1f0 net/socket.c:3767
        mptcp_setsockopt+0x69/0x90 net/mptcp/protocol.c:1288
        __sys_setsockopt+0x152/0x240 net/socket.c:2130
        __do_sys_setsockopt net/socket.c:2146 [inline]
        __se_sys_setsockopt net/socket.c:2143 [inline]
        __x64_sys_setsockopt+0xba/0x150 net/socket.c:2143
        do_syscall_64+0xbd/0x5b0 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sk_lock-AF_INET);
                                lock(rtnl_mutex);
                                lock(sk_lock-AF_INET);
   lock(rtnl_mutex);

v4: no need to handle SOL_SOCKET, sys_s/getsockopt handles this already.

Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operatio=
ns")
Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f1b1160dbbb4..432265f84a65 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -780,17 +780,19 @@ static void mptcp_destroy(struct sock *sk)
 		__skb_ext_put(msk->cached_ext);
 }
 =

+static int subflow_setsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, unsigned int optlen)
+{
+	return sock->ops->setsockopt(sock, level, optname, optval, optlen);
+}
+
 static int mptcp_setsockopt(struct sock *sk, int level, int optname,
-			    char __user *uoptval, unsigned int optlen)
+			    char __user *optval, unsigned int optlen)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	char __kernel *optval;
 	int ret =3D -EOPNOTSUPP;
 	struct socket *ssock;
 =

-	/* will be treated as __user in tcp_setsockopt */
-	optval =3D (char __kernel __force *)uoptval;
-
 	pr_debug("msk=3D%p", msk);
 =

 	/* @@ the meaning of setsockopt() when the socket is connected and
@@ -798,28 +800,28 @@ static int mptcp_setsockopt(struct sock *sk, int leve=
l, int optname,
 	 */
 	lock_sock(sk);
 	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	release_sock(sk);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D kernel_setsockopt(ssock, level, optname, optval, optlen);
+		ret =3D subflow_setsockopt(ssock, level, optname, optval, optlen);
 	}
-	release_sock(sk);
 =

 	return ret;
 }
 =

+static int subflow_getsockopt(struct socket *sock, int level, int optname,
+			       char __user *optval, int __user *optlen)
+{
+	return sock->ops->getsockopt(sock, level, optname, optval, optlen);
+}
+
 static int mptcp_getsockopt(struct sock *sk, int level, int optname,
-			    char __user *uoptval, int __user *uoption)
+			    char __user *optval, int __user *option)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
-	char __kernel *optval;
 	int ret =3D -EOPNOTSUPP;
-	int __kernel *option;
 	struct socket *ssock;
 =

-	/* will be treated as __user in tcp_getsockopt */
-	optval =3D (char __kernel __force *)uoptval;
-	option =3D (int __kernel __force *)uoption;
-
 	pr_debug("msk=3D%p", msk);
 =

 	/* @@ the meaning of getsockopt() when the socket is connected and
@@ -827,11 +829,11 @@ static int mptcp_getsockopt(struct sock *sk, int leve=
l, int optname,
 	 */
 	lock_sock(sk);
 	ssock =3D __mptcp_socket_create(msk, MPTCP_SAME_STATE);
+	release_sock(sk);
 	if (!IS_ERR(ssock)) {
 		pr_debug("subflow=3D%p", ssock->sk);
-		ret =3D kernel_getsockopt(ssock, level, optname, optval, option);
+		ret =3D subflow_getsockopt(ssock, level, optname, optval, option);
 	}
-	release_sock(sk);
 =

 	return ret;
 }
-- =

2.24.1

--===============3353055236745770598==--
