Content-Type: multipart/mixed; boundary="===============7076106525841632125=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] mptcp: add mib for token creation
 fallback
Date: Mon, 22 Feb 2021 18:07:16 +0100
Message-ID: <4cb2b3fcd9b44856a12324f9700dba1335c858df.1614013455.git.pabeni@redhat.com>
In-Reply-To: cover.1614013455.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7895

--===============7076106525841632125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the MPTCP protocol is unable to create a new token,
the socket fallback to plain TCP, let's keep track
of such events via a specific MIB.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/subflow.c  | 3 +++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 3780c29c321d1..b0429aca4f76c 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -13,6 +13,7 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
+	SNMP_MIB_ITEM("MPFallbackTokenInit", MPTCP_MIB_TOKENFALLBACKINIT),
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 72afbc135f8e7..50e1668c9a01c 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -6,6 +6,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
+	MPTCP_MIB_TOKENFALLBACKINIT,	/* Could not init/allocate token */
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cc0145fac1e90..920f577daecd6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3218,8 +3218,10 @@ static int mptcp_stream_connect(struct socket *sock,=
 struct sockaddr *uaddr,
 	if (rcu_access_pointer(tcp_sk(ssock->sk)->md5sig_info))
 		mptcp_subflow_early_fallback(msk, subflow);
 #endif
-	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk))
+	if (subflow->request_mptcp && mptcp_token_new_connect(ssock->sk)) {
+		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
+	}
 =

 do_connect:
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1fbcab257e6d..63f8b2f0e6a7d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -165,6 +165,7 @@ static int subflow_check_req(struct request_sock *req,
 			if (mptcp_token_exists(subflow_req->token)) {
 				if (retries-- > 0)
 					goto again;
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
 			} else {
 				subflow_req->mp_capable =3D 1;
 			}
@@ -176,6 +177,8 @@ static int subflow_check_req(struct request_sock *req,
 			subflow_req->mp_capable =3D 1;
 		else if (retries-- > 0)
 			goto again;
+		else
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_TOKENFALLBACKINIT);
 =

 	} else if (mp_opt.mp_join && listener->request_mptcp) {
 		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
-- =

2.26.2

--===============7076106525841632125==--
