Content-Type: multipart/mixed; boundary="===============0727999854713819089=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 3/3] mptcp: add MP_FASTCLOSE suboption
 handling
Date: Tue, 16 Jun 2020 14:47:38 +0800
Message-ID: <6f0156a5c3304ce50521306a57e2483406f4d122.1592289629.git.geliangtang@gmail.com>
In-Reply-To: cover.1592289629.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4693

--===============0727999854713819089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving MP_FASTCLOSE suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 16 ++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 82b3d7c566b4..a99b3989fec1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -297,6 +297,15 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		pr_debug("MP_FAIL: data_seq=3D%lld", mp_opt->data_seq);
 		break;
 =

+	case MPTCPOPT_MP_FASTCLOSE:
+		if (opsize !=3D TCPOLEN_MPTCP_FASTCLOSE)
+			break;
+
+		ptr +=3D 2;
+		mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
+		pr_debug("MP_FASTCLOSE: rcvr_key=3D%lld", mp_opt->rcvr_key);
+		break;
+
 	default:
 		break;
 	}
@@ -993,6 +1002,13 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
 		put_unaligned_be64(mpext->data_seq, ptr);
 	}
 =

+	if (OPTION_MPTCP_FASTCLOSE & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FASTCLOSE,
+				      TCPOLEN_MPTCP_FASTCLOSE,
+				      0, 0);
+		put_unaligned_be64(opts->rcvr_key, ptr);
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index e6ae0a73716b..a8faab61e7af 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -25,6 +25,7 @@
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
 #define OPTION_MPTCP_PRIO	BIT(9)
 #define OPTION_MPTCP_FAIL	BIT(10)
+#define OPTION_MPTCP_FASTCLOSE	BIT(11)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -62,6 +63,7 @@
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 #define TCPOLEN_MPTCP_PRIO		3
 #define TCPOLEN_MPTCP_FAIL		12
+#define TCPOLEN_MPTCP_FASTCLOSE		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
-- =

2.17.1

--===============0727999854713819089==--
