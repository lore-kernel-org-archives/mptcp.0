Content-Type: multipart/mixed; boundary="===============7222049208014101765=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 2/3] mptcp: add MP_FAIL suboption handling
Date: Tue, 16 Jun 2020 14:47:37 +0800
Message-ID: <9bb5cb494f4ac53845f2d233409073d8e71d0e4f.1592289629.git.geliangtang@gmail.com>
In-Reply-To: cover.1592289629.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4692

--===============7222049208014101765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 18 ++++++++++++++++++
 net/mptcp/protocol.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cc3039f0ac43..82b3d7c566b4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -288,6 +288,15 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		pr_debug("MP_PRIO: backup=3D%d", mp_opt->backup);
 		break;
 =

+	case MPTCPOPT_MP_FAIL:
+		if (opsize !=3D TCPOLEN_MPTCP_FAIL)
+			break;
+
+		ptr +=3D 2;
+		mp_opt->data_seq =3D get_unaligned_be64(ptr);
+		pr_debug("MP_FAIL: data_seq=3D%lld", mp_opt->data_seq);
+		break;
+
 	default:
 		break;
 	}
@@ -975,6 +984,15 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				      opts->backup, 0);
 	}
 =

+	if (OPTION_MPTCP_FAIL & opts->suboptions) {
+		struct mptcp_ext *mpext =3D &opts->ext_copy;
+
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_FAIL,
+				      TCPOLEN_MPTCP_FAIL,
+				      0, 0);
+		put_unaligned_be64(mpext->data_seq, ptr);
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 623c9a1c4343..e6ae0a73716b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -24,6 +24,7 @@
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
 #define OPTION_MPTCP_PRIO	BIT(9)
+#define OPTION_MPTCP_FAIL	BIT(10)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -60,6 +61,7 @@
 #define TCPOLEN_MPTCP_PORT_LEN		2
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
 #define TCPOLEN_MPTCP_PRIO		3
+#define TCPOLEN_MPTCP_FAIL		12
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
-- =

2.17.1

--===============7222049208014101765==--
