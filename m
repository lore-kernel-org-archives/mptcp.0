Content-Type: multipart/mixed; boundary="===============8546085179103490601=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v7 mptcp-next 6/7] mptcp: add the mibs for
 ADD_ADDR with port
Date: Mon, 30 Nov 2020 14:17:54 +0800
Message-ID: <119365e22834280ba21b71fdaf6b18cf403229bf.1606716547.git.geliangtang@gmail.com>
In-Reply-To: 883454467503573bd37d633fb12644a67b10d4bf.1606716547.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6977

--===============8546085179103490601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the mibs for ADD_ADDR with port:

MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
number.

MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX, for
receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number which
is different from the msk's port number.

MPTCP_MIB_MISMATCHPORTSYNRX and MPTCP_MIB_MISMATCHPORTACKRX, for
receiving a SYN or ACK MP_JOIN with a mismatched port-number.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 6 ++++++
 net/mptcp/mib.h     | 6 ++++++
 net/mptcp/options.c | 4 ++++
 net/mptcp/subflow.c | 8 +++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..d1d11e000539 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -29,6 +29,12 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
+	SNMP_MIB_ITEM("MPJoinPortSynRx", MPTCP_MIB_JOINPORTSYNRX),
+	SNMP_MIB_ITEM("MPJoinPortSynAckRx", MPTCP_MIB_JOINPORTSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinPortAckRx", MPTCP_MIB_JOINPORTACKRX),
+	SNMP_MIB_ITEM("MismatchPortSynRx", MPTCP_MIB_MISMATCHPORTSYNRX),
+	SNMP_MIB_ITEM("MismatchPortAckRx", MPTCP_MIB_MISMATCHPORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..447ef50118a3 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -22,6 +22,12 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
+	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with a port-number */
+	MPTCP_MIB_JOINPORTSYNRX,	/* Received a SYN MP_JOIN with a different port-=
number */
+	MPTCP_MIB_JOINPORTSYNACKRX,	/* Received a SYNACK MP_JOIN with a different=
 port-number */
+	MPTCP_MIB_JOINPORTACKRX,	/* Received an ACK MP_JOIN with a different port=
-number */
+	MPTCP_MIB_MISMATCHPORTSYNRX,	/* Received a SYN MP_JOIN with a mismatched =
port-number */
+	MPTCP_MIB_MISMATCHPORTACKRX,	/* Received an ACK MP_JOIN with a mismatched=
 port-number */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6088fc80db75..57b5cf92769b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -974,6 +974,10 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
_buff *skb)
 			mptcp_pm_del_add_timer(msk, &addr);
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
+
+		if (mp_opt.port)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
+
 		mp_opt.add_addr =3D 0;
 	}
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 7da6a00a35a6..9fd330094b76 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -190,8 +190,10 @@ static void subflow_init_req(struct request_sock *req,
 				tcp_request_sock_ops.destructor(req);
 				subflow_req->msk =3D NULL;
 				subflow_req->mp_join =3D 0;
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return;
 			}
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
 		}
 =

 		if (unlikely(req->syncookie) && subflow_req->msk) {
@@ -383,6 +385,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			pr_debug("synack inet_dport=3D%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
@@ -650,8 +653,11 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 				pr_debug("ack inet_sport=3D%d %d",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk))
+				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					goto out;
+				}
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
 			}
 		}
 	}
-- =

2.26.2

--===============8546085179103490601==--
