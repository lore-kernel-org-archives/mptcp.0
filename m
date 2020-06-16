Content-Type: multipart/mixed; boundary="===============8036258667884262600=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 1/3] mptcp: add MP_PRIO suboption handling
Date: Tue, 16 Jun 2020 14:47:36 +0800
Message-ID: <f86a2f6f241b7f7a49fec17b3428ae5a0fadc93e.1592289629.git.geliangtang@gmail.com>
In-Reply-To: cover.1592289629.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4691

--===============8036258667884262600==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving MP_PRIO suboption.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/options.c  | 14 ++++++++++++++
 net/mptcp/protocol.h |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 490b92534afc..cc3039f0ac43 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -280,6 +280,14 @@ static void mptcp_parse_option(const struct sk_buff *s=
kb,
 		pr_debug("RM_ADDR: id=3D%d", mp_opt->rm_id);
 		break;
 =

+	case MPTCPOPT_MP_PRIO:
+		if (opsize !=3D TCPOLEN_MPTCP_PRIO)
+			break;
+
+		mp_opt->backup =3D (*ptr++) & MPTCP_PRIO_BACKUP;
+		pr_debug("MP_PRIO: backup=3D%d", mp_opt->backup);
+		break;
+
 	default:
 		break;
 	}
@@ -961,6 +969,12 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_out=
_options *opts)
 				      0, opts->rm_id);
 	}
 =

+	if (OPTION_MPTCP_PRIO & opts->suboptions) {
+		*ptr++ =3D mptcp_option(MPTCPOPT_MP_PRIO,
+				      TCPOLEN_MPTCP_PRIO,
+				      opts->backup, 0);
+	}
+
 	if (OPTION_MPTCP_MPJ_SYN & opts->suboptions) {
 		*ptr++ =3D mptcp_option(MPTCPOPT_MP_JOIN,
 				      TCPOLEN_MPTCP_MPJ_SYN,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index db56535dfc29..623c9a1c4343 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -23,6 +23,7 @@
 #define OPTION_MPTCP_ADD_ADDR	BIT(6)
 #define OPTION_MPTCP_ADD_ADDR6	BIT(7)
 #define OPTION_MPTCP_RM_ADDR	BIT(8)
+#define OPTION_MPTCP_PRIO	BIT(9)
 =

 /* MPTCP option subtypes */
 #define MPTCPOPT_MP_CAPABLE	0
@@ -58,6 +59,7 @@
 #define TCPOLEN_MPTCP_ADD_ADDR6_BASE_PORT	22
 #define TCPOLEN_MPTCP_PORT_LEN		2
 #define TCPOLEN_MPTCP_RM_ADDR_BASE	4
+#define TCPOLEN_MPTCP_PRIO		3
 =

 /* MPTCP MP_JOIN flags */
 #define MPTCPOPT_BACKUP		BIT(0)
@@ -84,6 +86,9 @@
 #define MPTCP_ADDR_IPVERSION_4	4
 #define MPTCP_ADDR_IPVERSION_6	6
 =

+/* MPTCP MP_PRIO flags */
+#define MPTCP_PRIO_BACKUP	BIT(0)
+
 /* MPTCP socket flags */
 #define MPTCP_DATA_READY	0
 #define MPTCP_SEND_SPACE	1
-- =

2.17.1

--===============8036258667884262600==--
