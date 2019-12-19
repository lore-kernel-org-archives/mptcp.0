Content-Type: multipart/mixed; boundary="===============4883388071796911557=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v4 01/11] net: Make sock protocol value
 checks more specific
Date: Thu, 19 Dec 2019 14:05:47 -0800
Message-ID: <20191219220557.17823-2-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20191219220557.17823-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3186

--===============4883388071796911557==
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
index 87d54ef57f00..81dc811aad2e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -458,7 +458,6 @@ struct sock {
 				sk_userlocks : 4,
 				sk_protocol  : 8,
 				sk_type      : 16;
-#define SK_PROTOCOL_MAX U8_MAX
 	u16			sk_gso_max_segs;
 	u8			sk_pacing_shift;
 	unsigned long	        sk_lingertime;
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 324306d6fde0..ff57ea89c27e 100644
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
index e19a92a62e14..0a46ea3bddd5 100644
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

2.24.1

--===============4883388071796911557==--
