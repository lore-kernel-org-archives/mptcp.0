Content-Type: multipart/mixed; boundary="===============3955982306007775570=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 1/3] net: Make sock protocol value checks more
 specific
Date: Fri, 21 Jun 2019 16:55:32 -0700
Message-ID: <20190621235534.19690-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20190621235534.19690-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1441

--===============3955982306007775570==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SK_PROTOCOL_MAX is only used in two places, for DECNet and AX.25. The
limits have more to do with the those protocol definitions than they do
with the data type of sk_protocol, so remove SK_PROTOCOL_MAX and use
U8_MAX directly.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 include/net/sock.h     | 1 -
 net/ax25/af_ax25.c     | 2 +-
 net/decnet/af_decnet.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c6a0fc4151bc..fc6308773d18 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -459,7 +459,6 @@ struct sock {
 				sk_userlocks : 4,
 				sk_protocol  : 8,
 				sk_type      : 16;
-#define SK_PROTOCOL_MAX U8_MAX
 	u16			sk_gso_max_segs;
 	u8			sk_pacing_shift;
 	unsigned long	        sk_lingertime;
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index ca5207767dc2..d880e941f1a6 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -808,7 +808,7 @@ static int ax25_create(struct net *net, struct socket *=
sock, int protocol,
 	struct sock *sk;
 	ax25_cb *ax25;
 =

-	if (protocol < 0 || protocol > SK_PROTOCOL_MAX)
+	if (protocol < 0 || protocol > U8_MAX)
 		return -EINVAL;
 =

 	if (!net_eq(net, &init_net))
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index 0ea75286abf4..7c0c769a8b26 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -670,7 +670,7 @@ static int dn_create(struct net *net, struct socket *so=
ck, int protocol,
 {
 	struct sock *sk;
 =

-	if (protocol < 0 || protocol > SK_PROTOCOL_MAX)
+	if (protocol < 0 || protocol > U8_MAX)
 		return -EINVAL;
 =

 	if (!net_eq(net, &init_net))
-- =

2.22.0


--===============3955982306007775570==--
