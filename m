Content-Type: multipart/mixed; boundary="===============2514659252106098708=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/1] proposed export branch rebase
Date: Sun, 08 Dec 2019 19:24:16 +0100
Message-ID: <20191208182417.16789-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2845

--===============2514659252106098708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It includes 48 patches (down from 66), I will refrain from patch-bombing
the list with it.  There is one patch as followup here because its
"almost new" in the sense that its an amalgamation of different patches
that I placed in that commit because the others seemed quite large already.

The __tcp_poll patch is gone.  Later patches, in particular the changes to
only store 'tcp_sock' rather than 'struct socket' on the conn_list, have
been brought forward and squashed into the relevant commits, would thus
be implicitly part of basic mptcp submission.  I've amemded commit
messages where appropriate.

Here is the full diff to the current export branch:

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e0525a5eb1fb..354a4ce9e5e9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -396,7 +396,6 @@ void tcp_init_sock(struct sock *sk);
 void tcp_init_transfer(struct sock *sk, int bpf_op);
 __poll_t tcp_poll(struct file *file, struct socket *sock,
 		      struct poll_table_struct *wait);
-__poll_t __tcp_poll(struct sock *sk);
 int tcp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1cc7eb288029..9994bb49b8cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -490,12 +490,15 @@ static inline bool tcp_stream_is_readable(const struc=
t tcp_sock *tp,
  *	take care of normal races (between the test and the event) and we don't
  *	go look at any of the socket buffers directly.
  */
-__poll_t __tcp_poll(struct sock *sk)
+__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
 	__poll_t mask;
+	struct sock *sk =3D sock->sk;
 	const struct tcp_sock *tp =3D tcp_sk(sk);
 	int state;
 =

+	sock_poll_wait(file, sock, wait);
+
 	state =3D inet_sk_state_load(sk);
 	if (state =3D=3D TCP_LISTEN)
 		return inet_csk_listen_poll(sk);
@@ -587,13 +590,6 @@ __poll_t __tcp_poll(struct sock *sk)
 =

 	return mask;
 }
-
-__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
-{
-	sock_poll_wait(file, sock, wait);
-
-	return __tcp_poll(sock->sk);
-}
 EXPORT_SYMBOL(tcp_poll);
 =

 int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 156752e11591..57e092aca615 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -513,7 +513,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 =

 	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
-
 out:
 	release_sock(sk);
 	return ret;
@@ -902,9 +901,9 @@ static int __mptcp_init_sock(struct sock *sk)
 	INIT_LIST_HEAD(&msk->conn_list);
 	INIT_LIST_HEAD(&msk->join_list);
 	INIT_LIST_HEAD(&msk->rtx_queue);
+	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

 	INIT_WORK(&msk->rtx_work, mptcp_worker);
-	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
 =

 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
@@ -1012,15 +1011,6 @@ static void mptcp_close(struct sock *sk, long timeou=
t)
 	sk_common_release(sk);
 }
 =

-static int mptcp_disconnect(struct sock *sk, int flags)
-{
-	lock_sock(sk);
-	__mptcp_clear_xmit(sk);
-	release_sock(sk);
-	mptcp_cancel_work(sk);
-	return tcp_disconnect(sk, flags);
-}
-
 static void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
 {
 	const struct ipv6_pinfo *ssk6 =3D inet6_sk(ssk);
@@ -1044,6 +1034,15 @@ static void mptcp_copy_inaddrs(struct sock *msk, con=
st struct sock *ssk)
 #endif
 }
 =

+static int mptcp_disconnect(struct sock *sk, int flags)
+{
+	lock_sock(sk);
+	__mptcp_clear_xmit(sk);
+	release_sock(sk);
+	mptcp_cancel_work(sk);
+	return tcp_disconnect(sk, flags);
+}
+
 static struct sock *mptcp_accept(struct sock *sk, int flags, int *err,
 				 bool kern)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8251408610f0..1563d52eaa8d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -79,8 +79,8 @@
 =

 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	BIT(0)
-#define MPTCP_WORK_RTX		BIT(1)
-#define MPTCP_SEND_SPACE	BIT(2)
+#define MPTCP_SEND_SPACE	BIT(1)
+#define MPTCP_WORK_RTX		BIT(2)
 #define MPTCP_WORK_EOF		BIT(3)
 =

 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)



As you can see, the result is almost identical.

I've done the following tests:
1. all commits compile with MPTCP=3Dy and =3Dn
2. A build at the 'kselftest' commit passes the kselftests
3. The topmost commit passes kselftests.

Major changes are in the following commits:
mptcp: Create SUBFLOW socket for incoming connections

This squashed the patch that copied saddr/daddr from first subflow to msk
and the patch changing conn_list to store 'struct tcp_sock'.

mptcp: Add shutdown() socket operation
This merges the patch adding subflow_shutdown helper and uses it in all
needed places.

The change in the bit flag numbering is due to the need to have a
working mptcp_poll without calling into tcp_poll by the time the
kselftests are added -- for that, DATA_READY and SEND_SPACE flags
are needed, so they are added in a different ordering compared
to the current export branch.

There are more opportunities for squashing after the kselftest commit,
but I did not do this.  Unless there is a need to do so I would prefer
to add smaller patches after basic functionality is working.

I've reviewed the formatted patches up to 'kselftest' and I did not see
any silly 'add x; remove x; add x' sequences.

If you spot changes in 'Author' as result of the squashing --
please report and I will fix it up.

Thanks,
Florian


The following changes since commit 596cf45cbf6e4fa7bcb0df33e373a7d062b644b5:

  Merge branch 'akpm' (patches from Andrew) (2019-12-01 20:36:41 -0800)

are available in the Git repository at:

  git://git.breakpoint.cc/fw/mptcp-next.git export_rebase_19

for you to fetch changes up to e562b10de2abdcbda68aef01e36b35b7116b083e:

  subflow: place further subflows on new 'join_list' (2019-12-08 19:03:06 +=
0100)

----------------------------------------------------------------
Christoph Paasch (2):
      mptcp: parse and emit MP_CAPABLE option according to v1 spec.
      mptcp: process MP_CAPABLE data option.

Davide Caratti (1):
      mptcp: allow dumping subflow context to userspace

Florian Westphal (8):
      mptcp: add subflow write space signalling and mptcp_poll
      mptcp: add basic kselftest for mptcp
      mptcp: allow partial cleaning of rtx head dfrag
      mptcp: add MIB counter infrastructure
      mptcp: increment MIB counters in a few places
      subflow: check parent mptcp socket on subflow state change
      sendmsg: truncate source buffer if mptcp sndbuf size was set from use=
rspace
      subflow: place further subflows on new 'join_list'

Mat Martineau (12):
      net: Make sock protocol value checks more specific
      sock: Make sk_protocol a 16-bit value
      tcp: Define IPPROTO_MPTCP
      tcp: Add MPTCP option number
      tcp, ulp: Add clone operation to tcp_ulp_ops
      mptcp: Add MPTCP to skb extensions
      tcp: Prevent coalesce/collapse when skb has MPTCP extensions
      tcp: Export TCP functions and ops struct
      tcp: Check for filled TCP option space before SACK
      mptcp: Add MPTCP socket stubs
      mptcp: Write MPTCP DSS headers to outgoing data packets
      mptcp: Implement MPTCP receive path

Matthieu Baerts (1):
      mptcp: new sysctl to control the activation per NS

Paolo Abeni (11):
      tcp: clean ext on tx recycle
      skb: add helpers to allocate ext independently from sk_buff
      mptcp: recvmsg() can drain data from multiple subflows
      mptcp: allow collapsing consecutive sendpages on the same substream
      mptcp: move from sha1 (v0) to sha256 (v1)
      mptcp: update per unacked sequence on pkt reception
      mptcp: queue data for mptcp level retransmission
      mptcp: introduce MPTCP retransmission timer
      mptcp: implement memory accounting for mptcp rtx queue
      mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
      mptcp: implement and use MPTCP-level retransmission

Peter Krystad (13):
      mptcp: Handle MPTCP TCP options
      mptcp: Associate MPTCP context with TCP socket
      mptcp: Handle MP_CAPABLE options for outgoing connections
      mptcp: Create SUBFLOW socket for incoming connections
      mptcp: Add key generation and token tree
      mptcp: Add shutdown() socket operation
      mptcp: Add setsockopt()/getsockopt() socket operations
      mptcp: Add path manager interface
      mptcp: Add ADD_ADDR handling
      mptcp: Add handling of incoming MP_JOIN requests
      mptcp: Add handling of outgoing MP_JOIN requests
      mptcp: Implement path manager interface commands
      mptcp: Implement basic path manager

 include/linux/skbuff.h                             |    6 +
 include/linux/tcp.h                                |   48 +
 include/net/mptcp.h                                |  168 ++
 include/net/netns/mib.h                            |    3 +
 include/net/sock.h                                 |    6 +-
 include/net/tcp.h                                  |   22 +
 include/trace/events/sock.h                        |    5 +-
 include/uapi/linux/in.h                            |    2 +
 include/uapi/linux/inet_diag.h                     |    1 +
 include/uapi/linux/mptcp.h                         |   34 +
 net/Kconfig                                        |    1 +
 net/Makefile                                       |    1 +
 net/ax25/af_ax25.c                                 |    2 +-
 net/core/skbuff.c                                  |   42 +-
 net/decnet/af_decnet.c                             |    2 +-
 net/ipv4/af_inet.c                                 |    4 +
 net/ipv4/inet_connection_sock.c                    |    2 +
 net/ipv4/proc.c                                    |    2 +
 net/ipv4/tcp.c                                     |    8 +-
 net/ipv4/tcp_input.c                               |   29 +-
 net/ipv4/tcp_ipv4.c                                |    2 +-
 net/ipv4/tcp_minisocks.c                           |    6 +
 net/ipv4/tcp_output.c                              |   62 +-
 net/ipv4/tcp_ulp.c                                 |   12 +
 net/ipv6/tcp_ipv6.c                                |   13 +-
 net/mptcp/Kconfig                                  |   26 +
 net/mptcp/Makefile                                 |    4 +
 net/mptcp/basic.c                                  |  270 +++
 net/mptcp/crypto.c                                 |  151 ++
 net/mptcp/ctrl.c                                   |  130 ++
 net/mptcp/diag.c                                   |  101 ++
 net/mptcp/mib.c                                    |   66 +
 net/mptcp/mib.h                                    |   37 +
 net/mptcp/options.c                                |  906 ++++++++++
 net/mptcp/pm.c                                     |  273 +++
 net/mptcp/protocol.c                               | 1742 ++++++++++++++++=
++++
 net/mptcp/protocol.h                               |  376 +++++
 net/mptcp/subflow.c                                | 1014 ++++++++++++
 net/mptcp/token.c                                  |  222 +++
 tools/include/uapi/linux/in.h                      |    2 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/kselftest/runner.sh        |    2 +-
 tools/testing/selftests/net/mptcp/.gitignore       |    2 +
 tools/testing/selftests/net/mptcp/Makefile         |   13 +
 tools/testing/selftests/net/mptcp/config           |    2 +
 tools/testing/selftests/net/mptcp/mptcp_connect.c  |  834 ++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  595 +++++++
 tools/testing/selftests/net/mptcp/settings         |    1 +
 48 files changed, 7232 insertions(+), 21 deletions(-)
 create mode 100644 include/net/mptcp.h
 create mode 100644 include/uapi/linux/mptcp.h
 create mode 100644 net/mptcp/Kconfig
 create mode 100644 net/mptcp/Makefile
 create mode 100644 net/mptcp/basic.c
 create mode 100644 net/mptcp/crypto.c
 create mode 100644 net/mptcp/ctrl.c
 create mode 100644 net/mptcp/diag.c
 create mode 100644 net/mptcp/mib.c
 create mode 100644 net/mptcp/mib.h
 create mode 100644 net/mptcp/options.c
 create mode 100644 net/mptcp/pm.c
 create mode 100644 net/mptcp/protocol.c
 create mode 100644 net/mptcp/protocol.h
 create mode 100644 net/mptcp/subflow.c
 create mode 100644 net/mptcp/token.c
 create mode 100644 tools/testing/selftests/net/mptcp/.gitignore
 create mode 100644 tools/testing/selftests/net/mptcp/Makefile
 create mode 100644 tools/testing/selftests/net/mptcp/config
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_connect.c
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect.sh
 create mode 100644 tools/testing/selftests/net/mptcp/settings

--===============2514659252106098708==--
