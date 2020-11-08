Content-Type: multipart/mixed; boundary="===============3378877195042284336=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next 3/4] Squash to "mptcp: add the mib
 for ADD_ADDR with port"
Date: Sun, 08 Nov 2020 22:43:46 +0800
Message-ID: <c4c3b3a3e29e34b67de137edb4b0783f730f190e.1604845519.git.geliangtang@gmail.com>
In-Reply-To: b3625b4816e4bd62a4a2a732d76f9eb4fb2ef8aa.1604845519.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6583

--===============3378877195042284336==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is the new commit message, please update it:
"""
Subject: mptcp: add the mibs for ADD_ADDR with port

This patch added the mibs for ADD_ADDR with port:

MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
number. MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX,
for receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number
which is different from the msk's port number.
"""

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 3 +++
 net/mptcp/mib.h     | 3 +++
 net/mptcp/subflow.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index a8744ad62087..5e8f7827cfe0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -30,6 +30,9 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
 	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
+	SNMP_MIB_ITEM("PortSynRx", MPTCP_MIB_PORTSYNRX),
+	SNMP_MIB_ITEM("PortSynAckRx", MPTCP_MIB_PORTSYNACKRX),
+	SNMP_MIB_ITEM("PortAckRx", MPTCP_MIB_PORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 1b07fc1ad1a0..b762941d492f 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -23,6 +23,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
 	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with port */
+	MPTCP_MIB_PORTSYNRX,		/* Received a SYN + MP_JOIN with port */
+	MPTCP_MIB_PORTSYNACKRX,		/* Received a SYN/ACK + MP_JOIN with port */
+	MPTCP_MIB_PORTACKRX,		/* Received an ACK + MP_JOIN with port */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 32e4be3a7d11..40a62f143217 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -196,6 +196,7 @@ static void subflow_init_req(struct request_sock *req,
 				subflow_req->mp_join =3D 0;
 				return;
 			}
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_PORTSYNRX);
 		}
 	}
 }
@@ -374,6 +375,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			pr_debug("synack inet_dport=3D%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
@@ -644,6 +646,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
 				if (!mptcp_pm_sport_in_anno_list(owner, sk))
 					goto out;
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_PORTACKRX);
 			}
 		}
 	}
-- =

2.26.2

--===============3378877195042284336==--
