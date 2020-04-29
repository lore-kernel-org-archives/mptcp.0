Content-Type: multipart/mixed; boundary="===============4639488399327003129=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net 2/5] mptcp: move option parsing into
 mptcp_incoming_options()
Date: Wed, 29 Apr 2020 12:41:46 +0200
Message-ID: <aa86653cfe250462144b5635e235a92279eaf288.1588156257.git.pabeni@redhat.com>
In-Reply-To: cover.1588156257.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4268

--===============4639488399327003129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The mptcp_options_received structure carries several per
packet flags (mp_capable, mp_join, etc.). Such fields must
be cleared on each packet, even on dropped ones or packet
not carrying any MPTCP options, but the current mptcp
code clears them only on TCP option reset.

On several races/corner cases we end-up with stray bits in
incoming options, leading to WARN_ON splats. e.g.:

[  171.164906] Bad mapping: ssn=3D32714 map_seq=3D1 map_data_len=3D32713
[  171.165006] WARNING: CPU: 1 PID: 5026 at net/mptcp/subflow.c:533 warn_ba=
d_map (linux-mptcp/net/mptcp/subflow.c:533 linux-mptcp/net/mptcp/subflow.c:=
531)
[  171.167632] Modules linked in: ip6_vti ip_vti ip_gre ipip sit tunnel4 ip=
_tunnel geneve ip6_udp_tunnel udp_tunnel macsec macvtap tap ipvlan macvlan =
8021q garp mrp xfrm_interface veth netdevsim nlmon dummy team bonding vcan =
bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun binfmt_misc intel_rapl_ms=
r intel_rapl_common rfkill kvm_intel kvm irqbypass crct10dif_pclmul crc32_p=
clmul ghash_clmulni_intel joydev virtio_balloon pcspkr i2c_piix4 sunrpc ip_=
tables xfs libcrc32c crc32c_intel serio_raw virtio_console ata_generic virt=
io_blk virtio_net net_failover failover ata_piix libata
[  171.199464] CPU: 1 PID: 5026 Comm: repro Not tainted 5.7.0-rc1.mptcp_f22=
7fdf5d388+ #95
[  171.200886] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-2.fc30 04/01/2014
[  171.202546] RIP: 0010:warn_bad_map (linux-mptcp/net/mptcp/subflow.c:533 =
linux-mptcp/net/mptcp/subflow.c:531)
[  171.206537] Code: c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 =
7c 04 84 d2 75 1d 8b 55 3c 44 89 e6 48 c7 c7 20 51 13 95 e8 37 8b 22 fe <0f=
> 0b 48 83 c4 08 5b 5d 41 5c c3 89 4c 24 04 e8 db d6 94 fe 8b 4c
[  171.220473] RSP: 0018:ffffc90000150560 EFLAGS: 00010282
[  171.221639] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[  171.223108] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff520000=
2a09e
[  171.224388] RBP: ffff8880aa6e3c00 R08: 0000000000000001 R09: fffffbfff2e=
c9955
[  171.225706] R10: ffffffff9764caa7 R11: fffffbfff2ec9954 R12: 00000000000=
07fca
[  171.227211] R13: ffff8881066f4a7f R14: ffff8880aa6e3c00 R15: 00000000000=
00020
[  171.228460] FS:  00007f8623719740(0000) GS:ffff88810be00000(0000) knlGS:=
0000000000000000
[  171.230065] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  171.231303] CR2: 00007ffdab190a50 CR3: 00000001038ea006 CR4: 00000000001=
60ee0
[  171.232586] Call Trace:
[  171.233109]  <IRQ>
[  171.233531] get_mapping_status (linux-mptcp/net/mptcp/subflow.c:691)
[  171.234371] mptcp_subflow_data_available (linux-mptcp/net/mptcp/subflow.=
c:736 linux-mptcp/net/mptcp/subflow.c:832)
[  171.238181] subflow_state_change (linux-mptcp/net/mptcp/subflow.c:1085 (=
discriminator 1))
[  171.239066] tcp_fin (linux-mptcp/net/ipv4/tcp_input.c:4217)
[  171.240123] tcp_data_queue (linux-mptcp/./include/linux/compiler.h:199 l=
inux-mptcp/net/ipv4/tcp_input.c:4822)
[  171.245083] tcp_rcv_established (linux-mptcp/./include/linux/skbuff.h:17=
85 linux-mptcp/./include/net/tcp.h:1774 linux-mptcp/./include/net/tcp.h:184=
7 linux-mptcp/net/ipv4/tcp_input.c:5238 linux-mptcp/net/ipv4/tcp_input.c:57=
30)
[  171.254089] tcp_v4_rcv (linux-mptcp/./include/linux/spinlock.h:393 linux=
-mptcp/net/ipv4/tcp_ipv4.c:2009)
[  171.258969] ip_protocol_deliver_rcu (linux-mptcp/net/ipv4/ip_input.c:204=
 (discriminator 1))
[  171.260214] ip_local_deliver_finish (linux-mptcp/./include/linux/rcupdat=
e.h:651 linux-mptcp/net/ipv4/ip_input.c:232)
[  171.261389] ip_local_deliver (linux-mptcp/./include/linux/netfilter.h:30=
7 linux-mptcp/./include/linux/netfilter.h:301 linux-mptcp/net/ipv4/ip_input=
.c:252)
[  171.265884] ip_rcv (linux-mptcp/./include/linux/netfilter.h:307 linux-mp=
tcp/./include/linux/netfilter.h:301 linux-mptcp/net/ipv4/ip_input.c:539)
[  171.273666] process_backlog (linux-mptcp/./include/linux/rcupdate.h:651 =
linux-mptcp/net/core/dev.c:6135)
[  171.275328] net_rx_action (linux-mptcp/net/core/dev.c:6572 linux-mptcp/n=
et/core/dev.c:6640)
[  171.280472] __do_softirq (linux-mptcp/./arch/x86/include/asm/jump_label.=
h:25 linux-mptcp/./include/linux/jump_label.h:200 linux-mptcp/./include/tra=
ce/events/irq.h:142 linux-mptcp/kernel/softirq.c:293)
[  171.281379] do_softirq_own_stack (linux-mptcp/arch/x86/entry/entry_64.S:=
1083)
[  171.282358]  </IRQ>

We could address the issue clearing explicitly the relevant fields
in several places - tcp_parse_option, tcp_fast_parse_options,
possibly others.

Instead we move the MPTCP option parsing into the already existing
mptcp ingress hook, so that we need to clear the fields in a single
place.

This allows us dropping an MPTCP hook from the TCP code and
removing the quite large mptcp_options_received from the tcp_sock
struct. On the flip side, the MPTCP sockets will traverse the
option space twice (in tcp_parse_option() and in
mptcp_incoming_options(). That looks acceptable: we already
do that for syn and 3rd ack packets, plain TCP socket will
benefit from it, and even MPTCP sockets will experience better
code locality, reducing the jumps between TCP and MPTCP code.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/linux/tcp.h  | 51 ----------------------------------
 include/net/mptcp.h  |  2 --
 net/ipv4/tcp_input.c |  4 ---
 net/mptcp/options.c  | 66 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.c |  6 ++--
 net/mptcp/protocol.h | 43 +++++++++++++++++++++++++++--
 net/mptcp/subflow.c  | 66 +++++++++++++++++++++++---------------------
 7 files changed, 115 insertions(+), 123 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 421c99c12291..4f8159e90ce1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -78,47 +78,6 @@ struct tcp_sack_block {
 #define TCP_SACK_SEEN     (1 << 0)   /*1 =3D peer is SACK capable, */
 #define TCP_DSACK_SEEN    (1 << 2)   /*1 =3D DSACK was received from peer*/
 =

-#if IS_ENABLED(CONFIG_MPTCP)
-struct mptcp_options_received {
-	u64	sndr_key;
-	u64	rcvr_key;
-	u64	data_ack;
-	u64	data_seq;
-	u32	subflow_seq;
-	u16	data_len;
-	u16	mp_capable : 1,
-		mp_join : 1,
-		dss : 1,
-		add_addr : 1,
-		rm_addr : 1,
-		family : 4,
-		echo : 1,
-		backup : 1;
-	u32	token;
-	u32	nonce;
-	u64	thmac;
-	u8	hmac[20];
-	u8	join_id;
-	u8	use_map:1,
-		dsn64:1,
-		data_fin:1,
-		use_ack:1,
-		ack64:1,
-		mpc_map:1,
-		__unused:2;
-	u8	addr_id;
-	u8	rm_id;
-	union {
-		struct in_addr	addr;
-#if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		struct in6_addr	addr6;
-#endif
-	};
-	u64	ahmac;
-	u16	port;
-};
-#endif
-
 struct tcp_options_received {
 /*	PAWS/RTTM data	*/
 	int	ts_recent_stamp;/* Time we stored ts_recent (for aging) */
@@ -136,9 +95,6 @@ struct tcp_options_received {
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
-#if IS_ENABLED(CONFIG_MPTCP)
-	struct mptcp_options_received	mptcp;
-#endif
 };
 =

 static inline void tcp_clear_options(struct tcp_options_received *rx_opt)
@@ -148,13 +104,6 @@ static inline void tcp_clear_options(struct tcp_option=
s_received *rx_opt)
 #if IS_ENABLED(CONFIG_SMC)
 	rx_opt->smc_ok =3D 0;
 #endif
-#if IS_ENABLED(CONFIG_MPTCP)
-	rx_opt->mptcp.mp_capable =3D 0;
-	rx_opt->mptcp.mp_join =3D 0;
-	rx_opt->mptcp.add_addr =3D 0;
-	rx_opt->mptcp.rm_addr =3D 0;
-	rx_opt->mptcp.dss =3D 0;
-#endif
 }
 =

 /* This is the max number of SACKS that we'll generate and process. It's s=
afe
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 57d5a89d167f..91c0e9224586 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -70,8 +70,6 @@ static inline bool rsk_is_mptcp(const struct request_sock=
 *req)
 =

 void mptcp_space(const struct sock *ssk, int *space, int *full_space);
 =

-void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
-			int opsize, struct tcp_options_received *opt_rx);
 bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
 		       unsigned int *size, struct mptcp_out_options *opts);
 bool mptcp_synack_options(const struct request_sock *req, unsigned int *si=
ze,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 81425542da44..b996dc1069c5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3926,10 +3926,6 @@ void tcp_parse_options(const struct net *net,
 				 */
 				break;
 #endif
-			case TCPOPT_MPTCP:
-				mptcp_parse_option(skb, ptr, opsize, opt_rx);
-				break;
-
 			case TCPOPT_FASTOPEN:
 				tcp_parse_fastopen_option(
 					opsize - TCPOLEN_FASTOPEN_BASE,
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8fea686a5562..eadbd59586e4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -16,10 +16,10 @@ static bool mptcp_cap_flag_sha256(u8 flags)
 	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
 }
 =

-void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *pt=
r,
-			int opsize, struct tcp_options_received *opt_rx)
+static void mptcp_parse_option(const struct sk_buff *skb,
+			       const unsigned char *ptr, int opsize,
+			       struct mptcp_options_received *mp_opt)
 {
-	struct mptcp_options_received *mp_opt =3D &opt_rx->mptcp;
 	u8 subtype =3D *ptr >> 4;
 	int expected_opsize;
 	u8 version;
@@ -283,12 +283,20 @@ void mptcp_parse_option(const struct sk_buff *skb, co=
nst unsigned char *ptr,
 }
 =

 void mptcp_get_options(const struct sk_buff *skb,
-		       struct tcp_options_received *opt_rx)
+		       struct mptcp_options_received *mp_opt)
 {
-	const unsigned char *ptr;
 	const struct tcphdr *th =3D tcp_hdr(skb);
-	int length =3D (th->doff * 4) - sizeof(struct tcphdr);
+	const unsigned char *ptr;
+	int length;
 =

+	/* initialize option status */
+	mp_opt->mp_capable =3D 0;
+	mp_opt->mp_join =3D 0;
+	mp_opt->add_addr =3D 0;
+	mp_opt->rm_addr =3D 0;
+	mp_opt->dss =3D 0;
+
+	length =3D (th->doff * 4) - sizeof(struct tcphdr);
 	ptr =3D (const unsigned char *)(th + 1);
 =

 	while (length > 0) {
@@ -308,7 +316,7 @@ void mptcp_get_options(const struct sk_buff *skb,
 			if (opsize > length)
 				return;	/* don't parse partial options */
 			if (opcode =3D=3D TCPOPT_MPTCP)
-				mptcp_parse_option(skb, ptr, opsize, opt_rx);
+				mptcp_parse_option(skb, ptr, opsize, mp_opt);
 			ptr +=3D opsize - 2;
 			length -=3D opsize;
 		}
@@ -797,41 +805,41 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk =3D mptcp_sk(subflow->conn);
-	struct mptcp_options_received *mp_opt;
+	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;
 =

-	mp_opt =3D &opt_rx->mptcp;
-	if (!check_fully_established(msk, sk, subflow, skb, mp_opt))
+	mptcp_get_options(skb, &mp_opt);
+	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return;
 =

-	if (mp_opt->add_addr && add_addr_hmac_valid(msk, mp_opt)) {
+	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
 		struct mptcp_addr_info addr;
 =

-		addr.port =3D htons(mp_opt->port);
-		addr.id =3D mp_opt->addr_id;
-		if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_4) {
+		addr.port =3D htons(mp_opt.port);
+		addr.id =3D mp_opt.addr_id;
+		if (mp_opt.family =3D=3D MPTCP_ADDR_IPVERSION_4) {
 			addr.family =3D AF_INET;
-			addr.addr =3D mp_opt->addr;
+			addr.addr =3D mp_opt.addr;
 		}
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
-		else if (mp_opt->family =3D=3D MPTCP_ADDR_IPVERSION_6) {
+		else if (mp_opt.family =3D=3D MPTCP_ADDR_IPVERSION_6) {
 			addr.family =3D AF_INET6;
-			addr.addr6 =3D mp_opt->addr6;
+			addr.addr6 =3D mp_opt.addr6;
 		}
 #endif
-		if (!mp_opt->echo)
+		if (!mp_opt.echo)
 			mptcp_pm_add_addr_received(msk, &addr);
-		mp_opt->add_addr =3D 0;
+		mp_opt.add_addr =3D 0;
 	}
 =

-	if (!mp_opt->dss)
+	if (!mp_opt.dss)
 		return;
 =

 	/* we can't wait for recvmsg() to update the ack_seq, otherwise
 	 * monodirectional flows will stuck
 	 */
-	if (mp_opt->use_ack)
-		update_una(msk, mp_opt);
+	if (mp_opt.use_ack)
+		update_una(msk, &mp_opt);
 =

 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
@@ -839,8 +847,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 =

 	memset(mpext, 0, sizeof(*mpext));
 =

-	if (mp_opt->use_map) {
-		if (mp_opt->mpc_map) {
+	if (mp_opt.use_map) {
+		if (mp_opt.mpc_map) {
 			/* this is an MP_CAPABLE carrying MPTCP data
 			 * we know this map the first chunk of data
 			 */
@@ -851,12 +859,12 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 			mpext->dsn64 =3D 1;
 			mpext->mpc_map =3D 1;
 		} else {
-			mpext->data_seq =3D mp_opt->data_seq;
-			mpext->subflow_seq =3D mp_opt->subflow_seq;
-			mpext->dsn64 =3D mp_opt->dsn64;
-			mpext->data_fin =3D mp_opt->data_fin;
+			mpext->data_seq =3D mp_opt.data_seq;
+			mpext->subflow_seq =3D mp_opt.subflow_seq;
+			mpext->dsn64 =3D mp_opt.dsn64;
+			mpext->data_fin =3D mp_opt.data_fin;
 		}
-		mpext->data_len =3D mp_opt->data_len;
+		mpext->data_len =3D mp_opt.data_len;
 		mpext->use_map =3D 1;
 	}
 }
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7104504dc8b7..32e260ab3052 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1342,7 +1342,7 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct=
 sock *sk)
 #endif
 =

 struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct tcp_options_received *opt_rx,
+			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req)
 {
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
@@ -1381,9 +1381,9 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 =

 	msk->write_seq =3D subflow_req->idsn + 1;
 	atomic64_set(&msk->snd_una, msk->write_seq);
-	if (opt_rx->mptcp.mp_capable) {
+	if (mp_opt->mp_capable) {
 		msk->can_ack =3D true;
-		msk->remote_key =3D opt_rx->mptcp.sndr_key;
+		msk->remote_key =3D mp_opt->sndr_key;
 		mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
 		ack_seq++;
 		msk->ack_seq =3D ack_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a2b3048037d0..e4ca6320ce76 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -91,6 +91,45 @@
 #define MPTCP_WORK_RTX		2
 #define MPTCP_WORK_EOF		3
 =

+struct mptcp_options_received {
+	u64	sndr_key;
+	u64	rcvr_key;
+	u64	data_ack;
+	u64	data_seq;
+	u32	subflow_seq;
+	u16	data_len;
+	u16	mp_capable : 1,
+		mp_join : 1,
+		dss : 1,
+		add_addr : 1,
+		rm_addr : 1,
+		family : 4,
+		echo : 1,
+		backup : 1;
+	u32	token;
+	u32	nonce;
+	u64	thmac;
+	u8	hmac[20];
+	u8	join_id;
+	u8	use_map:1,
+		dsn64:1,
+		data_fin:1,
+		use_ack:1,
+		ack64:1,
+		mpc_map:1,
+		__unused:2;
+	u8	addr_id;
+	u8	rm_id;
+	union {
+		struct in_addr	addr;
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+		struct in6_addr	addr6;
+#endif
+	};
+	u64	ahmac;
+	u16	port;
+};
+
 static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 {
 	return htonl((TCPOPT_MPTCP << 24) | (len << 16) | (subopt << 12) |
@@ -331,10 +370,10 @@ int mptcp_proto_v6_init(void);
 #endif
 =

 struct sock *mptcp_sk_clone(const struct sock *sk,
-			    const struct tcp_options_received *opt_rx,
+			    const struct mptcp_options_received *mp_opt,
 			    struct request_sock *req);
 void mptcp_get_options(const struct sk_buff *skb,
-		       struct tcp_options_received *opt_rx);
+		       struct mptcp_options_received *mp_opt);
 =

 void mptcp_finish_connect(struct sock *sk);
 void mptcp_data_ready(struct sock *sk, struct sock *ssk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 519b3d7570a3..f412e886aa9b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -124,12 +124,11 @@ static void subflow_init_req(struct request_sock *req,
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk_listener);
 	struct mptcp_subflow_request_sock *subflow_req =3D mptcp_subflow_rsk(req);
-	struct tcp_options_received rx_opt;
+	struct mptcp_options_received mp_opt;
 =

 	pr_debug("subflow_req=3D%p, listener=3D%p", subflow_req, listener);
 =

-	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
-	mptcp_get_options(skb, &rx_opt);
+	mptcp_get_options(skb, &mp_opt);
 =

 	subflow_req->mp_capable =3D 0;
 	subflow_req->mp_join =3D 0;
@@ -142,16 +141,16 @@ static void subflow_init_req(struct request_sock *req,
 		return;
 #endif
 =

-	if (rx_opt.mptcp.mp_capable) {
+	if (mp_opt.mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 =

-		if (rx_opt.mptcp.mp_join)
+		if (mp_opt.mp_join)
 			return;
-	} else if (rx_opt.mptcp.mp_join) {
+	} else if (mp_opt.mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 	}
 =

-	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
+	if (mp_opt.mp_capable && listener->request_mptcp) {
 		int err;
 =

 		err =3D mptcp_token_new_request(req);
@@ -159,13 +158,13 @@ static void subflow_init_req(struct request_sock *req,
 			subflow_req->mp_capable =3D 1;
 =

 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
+	} else if (mp_opt.mp_join && listener->request_mptcp) {
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
 		subflow_req->mp_join =3D 1;
-		subflow_req->backup =3D rx_opt.mptcp.backup;
-		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
-		subflow_req->token =3D rx_opt.mptcp.token;
-		subflow_req->remote_nonce =3D rx_opt.mptcp.nonce;
+		subflow_req->backup =3D mp_opt.backup;
+		subflow_req->remote_id =3D mp_opt.join_id;
+		subflow_req->token =3D mp_opt.token;
+		subflow_req->remote_nonce =3D mp_opt.nonce;
 		pr_debug("token=3D%u, remote_nonce=3D%u", subflow_req->token,
 			 subflow_req->remote_nonce);
 		if (!subflow_token_join_request(req, skb)) {
@@ -221,8 +220,8 @@ static bool subflow_thmac_valid(struct mptcp_subflow_co=
ntext *subflow)
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
 {
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+	struct mptcp_options_received mp_opt;
 	struct sock *parent =3D subflow->conn;
-	struct tcp_sock *tp =3D tcp_sk(sk);
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

@@ -237,16 +236,17 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
 =

 	subflow->conn_finished =3D 1;
 =

-	if (subflow->request_mptcp && tp->rx_opt.mptcp.mp_capable) {
+	mptcp_get_options(skb, &mp_opt);
+	if (subflow->request_mptcp && mp_opt.mp_capable) {
 		subflow->mp_capable =3D 1;
 		subflow->can_ack =3D 1;
-		subflow->remote_key =3D tp->rx_opt.mptcp.sndr_key;
+		subflow->remote_key =3D mp_opt.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
-	} else if (subflow->request_join && tp->rx_opt.mptcp.mp_join) {
+	} else if (subflow->request_join && mp_opt.mp_join) {
 		subflow->mp_join =3D 1;
-		subflow->thmac =3D tp->rx_opt.mptcp.thmac;
-		subflow->remote_nonce =3D tp->rx_opt.mptcp.nonce;
+		subflow->thmac =3D mp_opt.thmac;
+		subflow->remote_nonce =3D mp_opt.nonce;
 		pr_debug("subflow=3D%p, thmac=3D%llu, remote_nonce=3D%u", subflow,
 			 subflow->thmac, subflow->remote_nonce);
 	} else if (subflow->request_mptcp) {
@@ -343,7 +343,7 @@ static int subflow_v6_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 =

 /* validate hmac received in third ACK */
 static bool subflow_hmac_valid(const struct request_sock *req,
-			       const struct tcp_options_received *rx_opt)
+			       const struct mptcp_options_received *mp_opt)
 {
 	const struct mptcp_subflow_request_sock *subflow_req;
 	u8 hmac[MPTCPOPT_HMAC_LEN];
@@ -360,7 +360,7 @@ static bool subflow_hmac_valid(const struct request_soc=
k *req,
 			      subflow_req->local_nonce, hmac);
 =

 	ret =3D true;
-	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
+	if (crypto_memneq(hmac, mp_opt->hmac, sizeof(hmac)))
 		ret =3D false;
 =

 	sock_put((struct sock *)msk);
@@ -416,7 +416,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 {
 	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
 	struct mptcp_subflow_request_sock *subflow_req;
-	struct tcp_options_received opt_rx;
+	struct mptcp_options_received mp_opt;
 	bool fallback_is_fatal =3D false;
 	struct sock *new_msk =3D NULL;
 	bool fallback =3D false;
@@ -424,7 +424,10 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 =

 	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listener->c=
onn);
 =

-	opt_rx.mptcp.mp_capable =3D 0;
+	/* we need later a valid 'mp_capable' value even when options are not
+	 * parsed
+	 */
+	mp_opt.mp_capable =3D 0;
 	if (tcp_rsk(req)->is_mptcp =3D=3D 0)
 		goto create_child;
 =

@@ -439,22 +442,21 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
 			goto create_msk;
 		}
 =

-		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_capable) {
+		mptcp_get_options(skb, &mp_opt);
+		if (!mp_opt.mp_capable) {
 			fallback =3D true;
 			goto create_child;
 		}
 =

 create_msk:
-		new_msk =3D mptcp_sk_clone(listener->conn, &opt_rx, req);
+		new_msk =3D mptcp_sk_clone(listener->conn, &mp_opt, req);
 		if (!new_msk)
 			fallback =3D true;
 	} else if (subflow_req->mp_join) {
 		fallback_is_fatal =3D true;
-		opt_rx.mptcp.mp_join =3D 0;
-		mptcp_get_options(skb, &opt_rx);
-		if (!opt_rx.mptcp.mp_join ||
-		    !subflow_hmac_valid(req, &opt_rx)) {
+		mptcp_get_options(skb, &mp_opt);
+		if (!mp_opt.mp_join ||
+		    !subflow_hmac_valid(req, &mp_opt)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			return NULL;
 		}
@@ -494,9 +496,9 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			/* with OoO packets we can reach here without ingress
 			 * mpc option
 			 */
-			ctx->remote_key =3D opt_rx.mptcp.sndr_key;
-			ctx->fully_established =3D opt_rx.mptcp.mp_capable;
-			ctx->can_ack =3D opt_rx.mptcp.mp_capable;
+			ctx->remote_key =3D mp_opt.sndr_key;
+			ctx->fully_established =3D mp_opt.mp_capable;
+			ctx->can_ack =3D mp_opt.mp_capable;
 		} else if (ctx->mp_join) {
 			struct mptcp_sock *owner;
 =

-- =

2.21.1

--===============4639488399327003129==--
