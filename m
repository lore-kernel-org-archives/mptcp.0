Content-Type: multipart/mixed; boundary="===============2920636821199233258=="
MIME-Version: 1.0
From: Nicolas Rybowski <nicolas.rybowski at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 1/5] bpf: expose is_mptcp flag to
 bpf_tcp_sock
Date: Wed, 02 Sep 2020 19:04:39 +0200
Message-ID: <20200902170443.272113-2-nicolas.rybowski@tessares.net>
In-Reply-To: 20200902170443.272113-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5702

--===============2920636821199233258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

is_mptcp is a field from struct tcp_sock used to indicate that the
current tcp_sock is part of the MPTCP protocol.

In this protocol, a first socket (mptcp_sock) is created with
sk_protocol set to IPPROTO_MPTCP (=3D262) for control purpose but it
isn't directly on the wire. This is the role of the subflow (kernel)
sockets which are classical tcp_sock with sk_protocol set to
IPPROTO_TCP. The only way to differentiate such sockets from plain TCP
sockets is the is_mptcp field from tcp_sock.

Such an exposure in BPF is thus required to be able to differentiate
plain TCP sockets from MPTCP subflow sockets in BPF_PROG_TYPE_SOCK_OPS
programs.

The choice has been made to silently pass the case when CONFIG_MPTCP is
unset by defaulting is_mptcp to 0 in order to make BPF independent of
the MPTCP configuration. Another solution is to make the verifier fail
in 'bpf_tcp_sock_is_valid_ctx_access' but this will add an additional
'#ifdef CONFIG_MPTCP' in the BPF code and a same injected BPF program
will not run if MPTCP is not set.

An example use-case is provided in
https://github.com/multipath-tcp/mptcp_net-next/tree/scripts/bpf/examples

Suggested-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Acked-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>
---
 include/uapi/linux/bpf.h       | 1 +
 net/core/filter.c              | 9 ++++++++-
 tools/include/uapi/linux/bpf.h | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8dda13880957..88fd3ad0d4b2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4057,6 +4057,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 =

 struct bpf_sock_tuple {
diff --git a/net/core/filter.c b/net/core/filter.c
index 47eef9a0be6a..c9092b6dc6f6 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5847,7 +5847,7 @@ bool bpf_tcp_sock_is_valid_access(int off, int size, =
enum bpf_access_type type,
 				  struct bpf_insn_access_aux *info)
 {
 	if (off < 0 || off >=3D offsetofend(struct bpf_tcp_sock,
-					  icsk_retransmits))
+					  is_mptcp))
 		return false;
 =

 	if (off % size !=3D 0)
@@ -5981,6 +5981,13 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access_=
type type,
 	case offsetof(struct bpf_tcp_sock, icsk_retransmits):
 		BPF_INET_SOCK_GET_COMMON(icsk_retransmits);
 		break;
+	case offsetof(struct bpf_tcp_sock, is_mptcp):
+#ifdef CONFIG_MPTCP
+		BPF_TCP_SOCK_GET_COMMON(is_mptcp);
+#else
+		*insn++ =3D BPF_MOV32_IMM(si->dst_reg, 0);
+#endif
+		break;
 	}
 =

 	return insn - insn_buf;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8dda13880957..88fd3ad0d4b2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4057,6 +4057,7 @@ struct bpf_tcp_sock {
 	__u32 delivered;	/* Total data packets delivered incl. rexmits */
 	__u32 delivered_ce;	/* Like the above but only ECE marked packets */
 	__u32 icsk_retransmits;	/* Number of unrecovered [RTO] timeouts */
+	__u32 is_mptcp;		/* Is MPTCP subflow? */
 };
 =

 struct bpf_sock_tuple {
-- =

2.28.0

--===============2920636821199233258==--
