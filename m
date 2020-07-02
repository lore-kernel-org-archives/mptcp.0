Content-Type: multipart/mixed; boundary="===============0687082820369495547=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] ss: mptcp: add msk diag interface support
Date: Thu, 02 Jul 2020 13:35:54 +0200
Message-ID: <2140c093a538ec4d48aaa09fcaee13eb0d332467.1593689647.git.pabeni@redhat.com>
In-Reply-To: cover.1593689647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4903

--===============0687082820369495547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This implement support for MPTCP sockets type, comprising
extended socket info. Note that we need to add an extended
attribute carrying the actual protocol number to the diag
request.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 misc/ss.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 10 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index f3d01812..8958efa5 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -63,6 +63,10 @@
 #define AF_VSOCK PF_VSOCK
 #endif
 =

+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
 #define BUF_CHUNK (1024 * 1024)	/* Buffer chunk allocation size */
 #define BUF_CHUNKS_MAX 5	/* Maximum number of allocated buffer chunks */
 #define LEN_ALIGN(x) (((x) + 1) & ~1)
@@ -189,6 +193,7 @@ static const char *dg_proto;
 =

 enum {
 	TCP_DB,
+	MPTCP_DB,
 	DCCP_DB,
 	UDP_DB,
 	RAW_DB,
@@ -209,7 +214,7 @@ enum {
 #define PACKET_DBM ((1<<PACKET_DG_DB)|(1<<PACKET_R_DB))
 #define UNIX_DBM ((1<<UNIX_DG_DB)|(1<<UNIX_ST_DB)|(1<<UNIX_SQ_DB))
 #define ALL_DB ((1<<MAX_DB)-1)
-#define INET_L4_DBM ((1<<TCP_DB)|(1<<UDP_DB)|(1<<DCCP_DB)|(1<<SCTP_DB))
+#define INET_L4_DBM ((1<<TCP_DB)|(1<<MPTCP_DB)|(1<<UDP_DB)|(1<<DCCP_DB)|(1=
<<SCTP_DB))
 #define INET_DBM (INET_L4_DBM | (1<<RAW_DB))
 #define VSOCK_DBM ((1<<VSOCK_ST_DB)|(1<<VSOCK_DG_DB))
 =

@@ -262,6 +267,10 @@ static const struct filter default_dbs[MAX_DB] =3D {
 		.states   =3D SS_CONN,
 		.families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
 	},
+	[MPTCP_DB] =3D {
+		.states   =3D SS_CONN,
+		.families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
+	},
 	[DCCP_DB] =3D {
 		.states   =3D SS_CONN,
 		.families =3D FAMILY_MASK(AF_INET) | FAMILY_MASK(AF_INET6),
@@ -376,14 +385,15 @@ static int filter_db_parse(struct filter *f, const ch=
ar *s)
 		int dbs[MAX_DB + 1];
 	} db_name_tbl[] =3D {
 #define ENTRY(name, ...) { #name, { __VA_ARGS__, MAX_DB } }
-		ENTRY(all, UDP_DB, DCCP_DB, TCP_DB, RAW_DB,
+		ENTRY(all, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, RAW_DB,
 			   UNIX_ST_DB, UNIX_DG_DB, UNIX_SQ_DB,
 			   PACKET_R_DB, PACKET_DG_DB, NETLINK_DB,
 			   SCTP_DB, VSOCK_ST_DB, VSOCK_DG_DB, XDP_DB),
-		ENTRY(inet, UDP_DB, DCCP_DB, TCP_DB, SCTP_DB, RAW_DB),
+		ENTRY(inet, UDP_DB, DCCP_DB, TCP_DB, MPTCP_DB, SCTP_DB, RAW_DB),
 		ENTRY(udp, UDP_DB),
 		ENTRY(dccp, DCCP_DB),
 		ENTRY(tcp, TCP_DB),
+		ENTRY(mptcp, MPTCP_DB),
 		ENTRY(sctp, SCTP_DB),
 		ENTRY(raw, RAW_DB),
 		ENTRY(unix, UNIX_ST_DB, UNIX_DG_DB, UNIX_SQ_DB),
@@ -890,6 +900,8 @@ static const char *proto_name(int protocol)
 		return "udp";
 	case IPPROTO_TCP:
 		return "tcp";
+	case IPPROTO_MPTCP:
+		return "mptcp";
 	case IPPROTO_SCTP:
 		return "sctp";
 	case IPPROTO_DCCP:
@@ -3117,6 +3129,55 @@ static void tcp_show_info(const struct nlmsghdr *nlh=
, struct inet_diag_msg *r,
 	}
 }
 =

+static void mptcp_stats_print(struct mptcp_info *s)
+{
+	if (s->mptcpi_subflows)
+		out(" subflows:%d", s->mptcpi_subflows);
+	if (s->mptcpi_add_addr_signal)
+		out(" add_addr_signal:%d", s->mptcpi_add_addr_signal);
+	if (s->mptcpi_add_addr_signal)
+		out(" add_addr_accepted:%d", s->mptcpi_add_addr_accepted);
+	if (s->mptcpi_subflows_max)
+		out(" subflows_max:%d", s->mptcpi_subflows_max);
+	if (s->mptcpi_add_addr_signal_max)
+		out(" add_addr_signal_max:%d", s->mptcpi_add_addr_signal_max);
+	if (s->mptcpi_add_addr_accepted_max)
+		out(" add_addr_accepted_max:%d", s->mptcpi_add_addr_accepted_max);
+	if (s->mptcpi_flags & MPTCP_INFO_FLAG_FALLBACK)
+		out(" fallback");
+	if (s->mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY)
+		out(" remote_key");
+	if (s->mptcpi_token)
+		out(" token:%x", s->mptcpi_token);
+	if (s->mptcpi_write_seq)
+		out(" write_seq:%llx", s->mptcpi_write_seq);
+	if (s->mptcpi_snd_una)
+		out(" snd_una:%llx", s->mptcpi_snd_una);
+	if (s->mptcpi_rcv_nxt)
+		out(" rcv_nxt:%llx", s->mptcpi_rcv_nxt);
+}
+
+static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_m=
sg *r,
+			    struct rtattr *tb[])
+{
+	print_skmeminfo(tb, INET_DIAG_SKMEMINFO);
+
+	if (tb[INET_DIAG_INFO]) {
+		struct mptcp_info *info;
+		int len =3D RTA_PAYLOAD(tb[INET_DIAG_INFO]);
+
+		/* workaround for older kernels with less fields */
+		if (len < sizeof(*info)) {
+			info =3D alloca(sizeof(*info));
+			memcpy(info, RTA_DATA(tb[INET_DIAG_INFO]), len);
+			memset((char *)info + len, 0, sizeof(*info) - len);
+		} else
+			info =3D RTA_DATA(tb[INET_DIAG_INFO]);
+
+		mptcp_stats_print(info);
+	}
+}
+
 static const char *format_host_sa(struct sockaddr_storage *sa)
 {
 	union {
@@ -3277,6 +3338,8 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 			out("\n\t");
 		if (s->type =3D=3D IPPROTO_SCTP)
 			sctp_show_info(nlh, r, tb);
+		else if (s->type =3D=3D IPPROTO_MPTCP)
+			mptcp_show_info(nlh, r, tb);
 		else
 			tcp_show_info(nlh, r, tb);
 	}
@@ -3365,9 +3428,11 @@ static int sockdiag_send(int family, int fd, int pro=
tocol, struct filter *f)
 	DIAG_REQUEST(req, struct inet_diag_req_v2 r);
 	char    *bc =3D NULL;
 	int	bclen;
+	__u32	proto;
 	struct msghdr msg;
-	struct rtattr rta;
-	struct iovec iov[3];
+	struct rtattr rta_bc;
+	struct rtattr rta_proto;
+	struct iovec iov[5];
 	int iovlen =3D 1;
 =

 	if (family =3D=3D PF_UNSPEC)
@@ -3400,15 +3465,26 @@ static int sockdiag_send(int family, int fd, int pr=
otocol, struct filter *f)
 	if (f->f) {
 		bclen =3D ssfilter_bytecompile(f->f, &bc);
 		if (bclen) {
-			rta.rta_type =3D INET_DIAG_REQ_BYTECODE;
-			rta.rta_len =3D RTA_LENGTH(bclen);
-			iov[1] =3D (struct iovec){ &rta, sizeof(rta) };
+			rta_bc.rta_type =3D INET_DIAG_REQ_BYTECODE;
+			rta_bc.rta_len =3D RTA_LENGTH(bclen);
+			iov[1] =3D (struct iovec){ &rta_bc, sizeof(rta_bc) };
 			iov[2] =3D (struct iovec){ bc, bclen };
 			req.nlh.nlmsg_len +=3D RTA_LENGTH(bclen);
 			iovlen =3D 3;
 		}
 	}
 =

+	/* put extended protocol attribute, if required */
+	if (protocol > 255) {
+		rta_proto.rta_type =3D INET_DIAG_REQ_PROTOCOL;
+		rta_proto.rta_len =3D RTA_LENGTH(sizeof(proto));
+		proto =3D protocol;
+		iov[iovlen] =3D (struct iovec){ &rta_proto, sizeof(rta_proto) };
+		iov[iovlen + 1] =3D (struct iovec){ &proto, sizeof(proto) };
+		req.nlh.nlmsg_len +=3D RTA_LENGTH(sizeof(proto));
+		iovlen +=3D 2;
+	}
+
 	msg =3D (struct msghdr) {
 		.msg_name =3D (void *)&nladdr,
 		.msg_namelen =3D sizeof(nladdr),
@@ -3668,6 +3744,18 @@ outerr:
 	} while (0);
 }
 =

+static int mptcp_show(struct filter *f)
+{
+	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
+		return 0;
+
+	if (!getenv("PROC_NET_MPTCP") && !getenv("PROC_ROOT")
+	    && inet_show_netlink(f, NULL, IPPROTO_MPTCP) =3D=3D 0)
+		return 0;
+
+	return 0;
+}
+
 static int dccp_show(struct filter *f)
 {
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
@@ -5108,6 +5196,7 @@ static void _usage(FILE *dest)
 "   -6, --ipv6          display only IP version 6 sockets\n"
 "   -0, --packet        display PACKET sockets\n"
 "   -t, --tcp           display only TCP sockets\n"
+"   -M, --mptcp         display only MPTCP sockets\n"
 "   -S, --sctp          display only SCTP sockets\n"
 "   -u, --udp           display only UDP sockets\n"
 "   -d, --dccp          display only DCCP sockets\n"
@@ -5123,7 +5212,7 @@ static void _usage(FILE *dest)
 "   -O, --oneline       socket's data printed on a single line\n"
 "\n"
 "   -A, --query=3DQUERY, --socket=3DQUERY\n"
-"       QUERY :=3D {all|inet|tcp|udp|raw|unix|unix_dgram|unix_stream|unix_=
seqpacket|packet|netlink|vsock_stream|vsock_dgram|tipc}[,QUERY]\n"
+"       QUERY :=3D {all|inet|tcp|mptcp|udp|raw|unix|unix_dgram|unix_stream=
|unix_seqpacket|packet|netlink|vsock_stream|vsock_dgram|tipc}[,QUERY]\n"
 "\n"
 "   -D, --diag=3DFILE     Dump raw information about TCP sockets to FILE\n"
 "   -F, --filter=3DFILE   read filter information from FILE\n"
@@ -5250,6 +5339,7 @@ static const struct option long_opts[] =3D {
 	{ "kill", 0, 0, 'K' },
 	{ "no-header", 0, 0, 'H' },
 	{ "xdp", 0, 0, OPT_XDPSOCK},
+	{ "mptcp", 0, 0, 'M' },
 	{ "oneline", 0, 0, 'O' },
 	{ 0 }
 =

@@ -5266,7 +5356,7 @@ int main(int argc, char *argv[])
 	int state_filter =3D 0;
 =

 	while ((ch =3D getopt_long(argc, argv,
-				 "dhaletuwxnro460spbEf:miA:D:F:vVzZN:KHSO",
+				 "dhaletuwxnro460spbEf:mMiA:D:F:vVzZN:KHSO",
 				 long_opts, NULL)) !=3D EOF) {
 		switch (ch) {
 		case 'n':
@@ -5341,6 +5431,9 @@ int main(int argc, char *argv[])
 		case OPT_XDPSOCK:
 			filter_af_set(&current_filter, AF_XDP);
 			break;
+		case 'M':
+			filter_db_set(&current_filter, MPTCP_DB, true);
+			break;
 		case 'f':
 			if (strcmp(optarg, "inet") =3D=3D 0)
 				filter_af_set(&current_filter, AF_INET);
@@ -5566,6 +5659,8 @@ int main(int argc, char *argv[])
 		tipc_show(&current_filter);
 	if (current_filter.dbs & (1<<XDP_DB))
 		xdp_show(&current_filter);
+	if (current_filter.dbs & (1<<MPTCP_DB))
+		mptcp_show(&current_filter);
 =

 	if (show_users || show_proc_ctx || show_sock_ctx)
 		user_ent_destroy();
-- =

2.26.2

--===============0687082820369495547==--
