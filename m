Content-Type: multipart/mixed; boundary="===============2678396107050989843=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v9 mptcp-next 8/9] mptcp: add the mibs for
 ADD_ADDR with port
Date: Tue, 05 Jan 2021 13:33:29 +0800
Message-ID: <2a620d58ed316e8d29a76a7884e36b8cf65b368e.1609820648.git.geliangtang@gmail.com>
In-Reply-To: 4ad7bfb030a86e37f1e74bb27504abed2cef02c2.1609820648.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7264

--===============2678396107050989843==
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
index 8ca196489893..3780c29c321d 100644
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
 	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 63914a5ef6a5..72afbc135f8e 100644
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
 	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index c9643344a8d7..331d460d82fa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1024,6 +1024,10 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb)
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
index 37089702a697..3dae58cee7ce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -204,8 +204,10 @@ static int subflow_init_req(struct request_sock *req,
 				tcp_request_sock_ops.destructor(req);
 				subflow_req->msk =3D NULL;
 				subflow_req->mp_join =3D 0;
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTSYNRX);
 		}
 =

 		subflow_req_create_thmac(subflow_req);
@@ -427,6 +429,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			pr_debug("synack inet_dport=3D%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINPORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
@@ -695,8 +698,11 @@ static struct sock *subflow_syn_recv_sock(const struct=
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

2.29.2

--===============2678396107050989843==--
