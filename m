Content-Type: multipart/mixed; boundary="===============5987481449793918035=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 2/3] mptcp: add active MPC mibs
Date: Mon, 22 Feb 2021 18:07:17 +0100
Message-ID: <7b990b32c829ffb4190ea5bcc5a22f4dbaca0c21.1614013455.git.pabeni@redhat.com>
In-Reply-To: cover.1614013455.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7896

--===============5987481449793918035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We are not currently tracking the active MPTCP connection
attempts. Let's add the related counters.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/mib.c      | 2 ++
 net/mptcp/mib.h      | 2 ++
 net/mptcp/protocol.c | 2 ++
 net/mptcp/subflow.c  | 1 +
 4 files changed, 7 insertions(+)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b0429aca4f76c..eb2dc6dbe212b 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -10,6 +10,8 @@
 =

 static const struct snmp_mib mptcp_snmp_list[] =3D {
 	SNMP_MIB_ITEM("MPCapableSYNRX", MPTCP_MIB_MPCAPABLEPASSIVE),
+	SNMP_MIB_ITEM("MPCapableSYNTX", MPTCP_MIB_MPCAPABLEACTIVE),
+	SNMP_MIB_ITEM("MPCapableSYNACKRX", MPTCP_MIB_MPCAPABLEACTIVEACK),
 	SNMP_MIB_ITEM("MPCapableACKRX", MPTCP_MIB_MPCAPABLEPASSIVEACK),
 	SNMP_MIB_ITEM("MPCapableFallbackACK", MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK),
 	SNMP_MIB_ITEM("MPCapableFallbackSYNACK", MPTCP_MIB_MPCAPABLEACTIVEFALLBAC=
K),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 50e1668c9a01c..f0da4f060fe1a 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -3,6 +3,8 @@
 enum linux_mptcp_mib_field {
 	MPTCP_MIB_NUM =3D 0,
 	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVE,	/* Sent SYN with MP_CAPABLE */
+	MPTCP_MIB_MPCAPABLEACTIVEACK,	/* Received SYN/ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEACK,	/* Received third ACK with MP_CAPABLE */
 	MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK,/* Server-side fallback during 3-way h=
andshake */
 	MPTCP_MIB_MPCAPABLEACTIVEFALLBACK, /* Client-side fallback during 3-way h=
andshake */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 920f577daecd6..615fd81faa9a3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3222,6 +3222,8 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 		MPTCP_INC_STATS(sock_net(ssock->sk), MPTCP_MIB_TOKENFALLBACKINIT);
 		mptcp_subflow_early_fallback(msk, subflow);
 	}
+	if (likely(!__mptcp_check_fallback(msk)))
+		MPTCP_INC_STATS(sock_net(sock->sk), MPTCP_MIB_MPCAPABLEACTIVE);
 =

 do_connect:
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 63f8b2f0e6a7d..3cad8aa0c2d67 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -395,6 +395,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 		subflow->remote_key =3D mp_opt.sndr_key;
 		pr_debug("subflow=3D%p, remote_key=3D%llu", subflow,
 			 subflow->remote_key);
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPCAPABLEACTIVEACK);
 		mptcp_finish_connect(sk);
 	} else if (subflow->request_join) {
 		u8 hmac[SHA256_DIGEST_SIZE];
-- =

2.26.2

--===============5987481449793918035==--
