Content-Type: multipart/mixed; boundary="===============8911305352809455444=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] One approach to indirect call optimization
Date: Tue, 24 Apr 2018 16:35:26 -0700
Message-ID: <alpine.OSX.2.21.1804241612160.11767@jebishop-mobl1.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 549

--===============8911305352809455444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I noticed this patch on netdev to avoid an indirect call to md5_lookup, =

which was accepted. It is mitigating the cost of an existing indirect call =

rather than adding a new one, but shows how the maintainers are looking at =

the problem.

--
Mat Martineau
Intel OTC

---------- Forwarded message ----------
Date: Mon, 23 Apr 2018 14:46:25
From: Eric Dumazet <edumazet(a)google.com>
To: David S . Miller <davem(a)davemloft.net>
Cc: netdev <netdev(a)vger.kernel.org>, Eric Dumazet <edumazet(a)google.com>,
     Eric Dumazet <eric.dumazet(a)gmail.com>
Subject: [PATCH net-next] tcp: md5: only call tp->af_specific->md5_lookup()=
 for
     md5 sockets

RETPOLINE made calls to tp->af_specific->md5_lookup() quite expensive,
given they have no result.
We can omit the calls for sockets that have no md5 keys.

Signed-off-by: Eric Dumazet <edumazet(a)google.com>
---
  net/ipv4/tcp_output.c | 26 ++++++++++++++------------
  1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 383cac0ff0ec059ca7dbc1a6304cc7f8183e008d..95feffb6d53f8a9eadfb15a2fff=
eec498d6e993a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -585,14 +585,15 @@ static unsigned int tcp_syn_options(struct sock *sk, =
struct sk_buff *skb,
  	unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
  	struct tcp_fastopen_request *fastopen =3D tp->fastopen_req;

+	*md5 =3D NULL;
  #ifdef CONFIG_TCP_MD5SIG
-	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (*md5) {
-		opts->options |=3D OPTION_MD5;
-		remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
+	if (unlikely(rcu_access_pointer(tp->md5sig_info))) {
+		*md5 =3D tp->af_specific->md5_lookup(sk, sk);
+		if (*md5) {
+			opts->options |=3D OPTION_MD5;
+			remaining -=3D TCPOLEN_MD5SIG_ALIGNED;
+		}
  	}
-#else
-	*md5 =3D NULL;
  #endif

  	/* We always get an MSS option.  The option bytes which will be seen in
@@ -720,14 +721,15 @@ static unsigned int tcp_established_options(struct so=
ck *sk, struct sk_buff *skb

  	opts->options =3D 0;

+	*md5 =3D NULL;
  #ifdef CONFIG_TCP_MD5SIG
-	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
-	if (unlikely(*md5)) {
-		opts->options |=3D OPTION_MD5;
-		size +=3D TCPOLEN_MD5SIG_ALIGNED;
+	if (unlikely(rcu_access_pointer(tp->md5sig_info))) {
+		*md5 =3D tp->af_specific->md5_lookup(sk, sk);
+		if (*md5) {
+			opts->options |=3D OPTION_MD5;
+			size +=3D TCPOLEN_MD5SIG_ALIGNED;
+		}
  	}
-#else
-	*md5 =3D NULL;
  #endif

  	if (likely(tp->rx_opt.tstamp_ok)) {
-- =

2.17.0.484.g0c8726318c-goog


--===============8911305352809455444==--
