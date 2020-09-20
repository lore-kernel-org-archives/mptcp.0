Content-Type: multipart/mixed; boundary="===============7009385696710777738=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6 support
Date: Sun, 20 Sep 2020 21:42:32 +0800
Message-ID: <aa214a833e31f406fe542366a56198d6edc91fd9.1600608822.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5946

--===============7009385696710777738==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When ADD_ADDR suboption include an IPv6 address, the size is 28 octets.
It will not fit when other options are included, e.g. TCP Timestamps. So
here we send out a mptcp dedicated packet to carry only mptcp options.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/55
Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
v2:
 - avoid adding new field to tcp_sock, add new field in mptcp_pm_data.
 - drop OPTION_TS in mptcp_established_options_add_addr, not in
tcp_established_options.
---
 include/net/mptcp.h                           |  3 +-
 include/net/tcp.h                             | 21 ++++++++++++
 net/ipv4/tcp_output.c                         | 23 +------------
 net/mptcp/options.c                           | 26 ++++++++++++---
 net/mptcp/pm.c                                | 16 +++++++--
 net/mptcp/protocol.h                          |  4 ++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 33 ++++++++++++++++++-
 7 files changed, 94 insertions(+), 32 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index a7fc486e1035..c5fd207bef83 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -13,6 +13,7 @@
 #include <linux/types.h>
 =

 struct seq_file;
+struct tcp_out_options;
 =

 /* MPTCP sk_buff extension data */
 struct mptcp_ext {
@@ -85,7 +86,7 @@ bool mptcp_synack_options(const struct request_sock *req,=
 unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts);
+			       struct tcp_out_options *opts);
 void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
 			    struct tcp_options_received *opt_rx);
 =

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 852f0d71dd40..c860358d8067 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -416,6 +416,27 @@ void tcp_parse_options(const struct net *net, const st=
ruct sk_buff *skb,
 		       int estab, struct tcp_fastopen_cookie *foc);
 const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
 =

+#define OPTION_SACK_ADVERTISE	(1 << 0)
+#define OPTION_TS		(1 << 1)
+#define OPTION_MD5		(1 << 2)
+#define OPTION_WSCALE		(1 << 3)
+#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
+#define OPTION_SMC		(1 << 9)
+#define OPTION_MPTCP		(1 << 10)
+
+struct tcp_out_options {
+	u16 options;		/* bit field of OPTION_* */
+	u16 mss;		/* 0 to disable */
+	u8 ws;			/* window scale, 0 to disable */
+	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 hash_size;		/* bytes in hash_location */
+	u8 bpf_opt_len;		/* length of BPF hdr option */
+	__u8 *hash_location;	/* temporary pointer, overloaded */
+	__u32 tsval, tsecr;	/* need to include OPTION_TS */
+	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
+	struct mptcp_out_options mptcp;
+};
+
 /*
  *	BPF SKB-less helpers
  */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 88f6872751d3..6226f1d4f31b 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -409,14 +409,6 @@ static inline bool tcp_urg_mode(const struct tcp_sock =
*tp)
 	return tp->snd_una !=3D tp->snd_up;
 }
 =

-#define OPTION_SACK_ADVERTISE	(1 << 0)
-#define OPTION_TS		(1 << 1)
-#define OPTION_MD5		(1 << 2)
-#define OPTION_WSCALE		(1 << 3)
-#define OPTION_FAST_OPEN_COOKIE	(1 << 8)
-#define OPTION_SMC		(1 << 9)
-#define OPTION_MPTCP		(1 << 10)
-
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
 #if IS_ENABLED(CONFIG_SMC)
@@ -432,19 +424,6 @@ static void smc_options_write(__be32 *ptr, u16 *option=
s)
 #endif
 }
 =

-struct tcp_out_options {
-	u16 options;		/* bit field of OPTION_* */
-	u16 mss;		/* 0 to disable */
-	u8 ws;			/* window scale, 0 to disable */
-	u8 num_sack_blocks;	/* number of SACK blocks to include */
-	u8 hash_size;		/* bytes in hash_location */
-	u8 bpf_opt_len;		/* length of BPF hdr option */
-	__u8 *hash_location;	/* temporary pointer, overloaded */
-	__u32 tsval, tsecr;	/* need to include OPTION_TS */
-	struct tcp_fastopen_cookie *fastopen_cookie;	/* Fast open cookie */
-	struct mptcp_out_options mptcp;
-};
-
 static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *opts)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
@@ -950,7 +929,7 @@ static unsigned int tcp_established_options(struct sock=
 *sk, struct sk_buff *skb
 		unsigned int opt_size =3D 0;
 =

 		if (mptcp_established_options(sk, skb, &opt_size, remaining,
-					      &opts->mptcp)) {
+					      opts)) {
 			opts->options |=3D OPTION_MPTCP;
 			size +=3D opt_size;
 		}
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 171039cbe9c4..505a0477f119 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -243,7 +243,9 @@ static void mptcp_parse_option(const struct sk_buff *sk=
b,
 		mp_opt->add_addr =3D 1;
 		mp_opt->port =3D 0;
 		mp_opt->addr_id =3D *ptr++;
-		pr_debug("ADD_ADDR: id=3D%d, echo=3D%d", mp_opt->addr_id, mp_opt->echo);
+		pr_debug("ADD_ADDR%s: id=3D%d, echo=3D%d",
+			 (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) ? "6" : "",
+			 mp_opt->addr_id, mp_opt->echo);
 		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			memcpy((u8 *)&mp_opt->addr.s_addr, (u8 *)ptr, 4);
 			ptr +=3D 4;
@@ -573,18 +575,29 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2=
, u8 addr_id,
 #endif
 =

 static bool mptcp_established_options_add_addr(struct sock *sk,
+					       struct sk_buff *skb,
 					       unsigned int *size,
 					       unsigned int remaining,
-					       struct mptcp_out_options *opts)
+					       struct tcp_out_options *tcp_opts)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_out_options *opts =3D &tcp_opts->mptcp;
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
 	struct mptcp_addr_info saddr;
+	bool drop_ts =3D false;
 	bool echo;
 	int len;
 =

+	if (skb && skb_is_tcp_pure_ack(skb) && READ_ONCE(msk->pm.add_addr6_nospc)=
) {
+		if (likely(OPTION_TS & tcp_opts->options)) {
+			tcp_opts->options &=3D ~OPTION_TS;
+			remaining +=3D TCPOLEN_TSTAMP_ALIGNED;
+			drop_ts =3D true;
+		}
+	}
+
 	if (!mptcp_pm_should_add_signal(msk) ||
-	    !(mptcp_pm_add_addr_signal(msk, remaining, &saddr, &echo)))
+	    !(mptcp_pm_add_addr_signal(msk, sk, remaining, &saddr, &echo)))
 		return false;
 =

 	len =3D mptcp_add_addr_len(saddr.family);
@@ -592,6 +605,8 @@ static bool mptcp_established_options_add_addr(struct s=
ock *sk,
 		return false;
 =

 	*size =3D len;
+	if (drop_ts)
+		*size -=3D TCPOLEN_TSTAMP_ALIGNED;
 	opts->addr_id =3D saddr.id;
 	if (saddr.family =3D=3D AF_INET) {
 		opts->suboptions |=3D OPTION_MPTCP_ADD_ADDR;
@@ -647,8 +662,9 @@ static bool mptcp_established_options_rm_addr(struct so=
ck *sk,
 =

 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options *opts)
+			       struct tcp_out_options *tcp_opts)
 {
+	struct mptcp_out_options *opts =3D &tcp_opts->mptcp;
 	unsigned int opt_size =3D 0;
 	bool ret =3D false;
 =

@@ -671,7 +687,7 @@ bool mptcp_established_options(struct sock *sk, struct =
sk_buff *skb,
 =

 	*size +=3D opt_size;
 	remaining -=3D opt_size;
-	if (mptcp_established_options_add_addr(sk, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, tcp=
_opts)) {
 		*size +=3D opt_size;
 		remaining -=3D opt_size;
 		ret =3D true;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ca88422e774..9c37c1611478 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -172,7 +172,8 @@ void mptcp_pm_rm_addr_received(struct mptcp_sock *msk, =
u8 rm_id)
 =

 /* path manager helpers */
 =

-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *ssk,
+			      unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo)
 {
 	int ret =3D false;
@@ -183,16 +184,26 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
 	if (!mptcp_pm_should_add_signal(msk))
 		goto out_unlock;
 =

-	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
+	if (remaining < mptcp_add_addr_len(msk->pm.local.family)) {
+		if (msk->pm.local.family =3D=3D AF_INET6)
+			WRITE_ONCE(msk->pm.add_addr6_nospc, true);
 		goto out_unlock;
+	}
 =

 	*saddr =3D msk->pm.local;
 	*echo =3D READ_ONCE(msk->pm.add_addr_echo);
 	WRITE_ONCE(msk->pm.add_addr_signal, false);
+	WRITE_ONCE(msk->pm.add_addr6_nospc, false);
 	ret =3D true;
 =

 out_unlock:
 	spin_unlock_bh(&msk->pm.lock);
+
+	if (READ_ONCE(msk->pm.add_addr6_nospc)) {
+		pr_debug("send ack for add_addr6");
+		tcp_send_ack(ssk);
+	}
+
 	return ret;
 }
 =

@@ -237,6 +248,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 	WRITE_ONCE(msk->pm.accept_addr, false);
 	WRITE_ONCE(msk->pm.accept_subflow, false);
 	WRITE_ONCE(msk->pm.add_addr_echo, false);
+	WRITE_ONCE(msk->pm.add_addr6_nospc, false);
 	msk->pm.status =3D 0;
 =

 	spin_lock_init(&msk->pm.lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db1e5de2fee7..31bf0e8845fb 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -171,6 +171,7 @@ struct mptcp_pm_data {
 	bool		accept_addr;
 	bool		accept_subflow;
 	bool		add_addr_echo;
+	bool		add_addr6_nospc;
 	u8		add_addr_signaled;
 	u8		add_addr_accepted;
 	u8		local_addr_used;
@@ -468,7 +469,8 @@ static inline unsigned int mptcp_add_addr_len(int famil=
y)
 	return TCPOLEN_MPTCP_ADD_ADDR6;
 }
 =

-bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
+bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sock *sk,
+			      unsigned int remaining,
 			      struct mptcp_addr_info *saddr, bool *echo);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
 			     u8 *rm_id);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testin=
g/selftests/net/mptcp/mptcp_join.sh
index 08f53d86dedc..b37e63b04772 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -126,6 +126,12 @@ do_ping()
 	fi
 }
 =

+# $1: IP address
+is_v6()
+{
+	[ -z "${1##*:*}" ]
+}
+
 do_transfer()
 {
 	listener_ns=3D"$1"
@@ -165,7 +171,15 @@ do_transfer()
 		mptcp_connect=3D"./mptcp_connect -r"
 	fi
 =

-	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} 0.0.0.0 < "$sin" > "$sout" &
+	local local_addr
+	if is_v6 "${connect_addr}"; then
+		local_addr=3D"::"
+		mptcp_connect=3D"./mptcp_connect -r"
+	else
+		local_addr=3D"0.0.0.0"
+	fi
+
+	ip netns exec ${listener_ns} $mptcp_connect -t $timeout -l -p $port -s ${=
srv_proto} ${local_addr} < "$sin" > "$sout" &
 	spid=3D$!
 =

 	sleep 1
@@ -491,6 +505,23 @@ run_tests $ns1 $ns2 10.0.1.1
 chk_join_nr "multiple subflows and signal" 3 3 3
 chk_add_nr 1 1
 =

+# subflow IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl limits 0 1
+ip netns exec $ns2 ./pm_nl_ctl add dead:beef:3::2 flags subflow
+run_tests $ns1 $ns2 dead:beef:1::1
+chk_join_nr "single subflow IPv6" 1 1 1
+
+# signal address IPv6
+reset
+ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+ip netns exec $ns1 ./pm_nl_ctl add dead:beef:2::1 flags signal
+ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+run_tests $ns1 $ns2 dead:beef:1::1
+chk_join_nr "single address IPv6" 1 1 1
+chk_add_nr 1 1
+
 # single subflow, remove
 reset
 ip netns exec $ns1 ./pm_nl_ctl limits 0 1
-- =

2.17.1

--===============7009385696710777738==--
