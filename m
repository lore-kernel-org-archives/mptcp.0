Content-Type: multipart/mixed; boundary="===============0572463179628485107=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v5 mptcp-next 09/10] mptcp: add the mibs for
 ADD_ADDR with port
Date: Thu, 19 Nov 2020 18:19:49 +0800
Message-ID: <90b437848f259eeb0d40383623ce1e523a8219bc.1605780306.git.geliangtang@gmail.com>
In-Reply-To: 2d35d20641b7907f78a94645eb4aebc3e8d28906.1605780306.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6820

--===============0572463179628485107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch added the mibs for ADD_ADDR with port:

MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
number. MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX,
for receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number
which is different from the msk's port number.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/mib.c     | 4 ++++
 net/mptcp/mib.h     | 4 ++++
 net/mptcp/options.c | 4 ++++
 net/mptcp/subflow.c | 3 +++
 4 files changed, 15 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 84d119436b22..5e8f7827cfe0 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -29,6 +29,10 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("DuplicateData", MPTCP_MIB_DUPDATA),
 	SNMP_MIB_ITEM("AddAddr", MPTCP_MIB_ADDADDR),
 	SNMP_MIB_ITEM("EchoAdd", MPTCP_MIB_ECHOADD),
+	SNMP_MIB_ITEM("PortAdd", MPTCP_MIB_PORTADD),
+	SNMP_MIB_ITEM("PortSynRx", MPTCP_MIB_PORTSYNRX),
+	SNMP_MIB_ITEM("PortSynAckRx", MPTCP_MIB_PORTSYNACKRX),
+	SNMP_MIB_ITEM("PortAckRx", MPTCP_MIB_PORTACKRX),
 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
 	SNMP_MIB_SENTINEL
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 47bcecce1106..b762941d492f 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -22,6 +22,10 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_DUPDATA,		/* Segments discarded due to duplicate DSS */
 	MPTCP_MIB_ADDADDR,		/* Received ADD_ADDR with echo-flag=3D0 */
 	MPTCP_MIB_ECHOADD,		/* Received ADD_ADDR with echo-flag=3D1 */
+	MPTCP_MIB_PORTADD,		/* Received ADD_ADDR with port */
+	MPTCP_MIB_PORTSYNRX,		/* Received a SYN + MP_JOIN with port */
+	MPTCP_MIB_PORTSYNACKRX,		/* Received a SYN/ACK + MP_JOIN with port */
+	MPTCP_MIB_PORTACKRX,		/* Received an ACK + MP_JOIN with port */
 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
 	__MPTCP_MIB_MAX
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 41b8e2667395..c24bb74608ea 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -956,6 +956,10 @@ void mptcp_incoming_options(struct sock *sk, struct sk=
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
index 4939b396847a..429e6e765c9e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -197,6 +197,7 @@ static void subflow_init_req(struct request_sock *req,
 				subflow_req->mp_join =3D 0;
 				return;
 			}
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_PORTSYNRX);
 		}
 	}
 }
@@ -375,6 +376,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			pr_debug("synack inet_dport=3D%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
 				 ntohs(inet_sk(parent)->inet_dport));
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTSYNACKRX);
 		}
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
@@ -645,6 +647,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
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

--===============0572463179628485107==--
