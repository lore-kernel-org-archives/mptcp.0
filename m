Content-Type: multipart/mixed; boundary="===============3999547280206380303=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 14/18] tcp_md5: Check for TCP_MD5 after TCP Timestamps
 in tcp_established_options
Date: Tue, 03 Oct 2017 09:22:00 -0700
Message-ID: <20171003162204.17945-15-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 98

--===============3999547280206380303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It really does not matter, because we never use TCP timestamps when
TCP_MD5 is enabled (see tcp_syn_options).

Moving TCP_MD5 a bit lower allows for easier adoption of the
tcp_extra_option framework.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 1eb00e93c895..67a3779294ad 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -683,6 +683,13 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 =

 	opts->options =3D 0;
 =

+	if (likely(tp->rx_opt.tstamp_ok)) {
+		opts->options |=3D OPTION_TS;
+		opts->tsval =3D skb ? tcp_skb_timestamp(skb) + tp->tsoffset : 0;
+		opts->tsecr =3D tp->rx_opt.ts_recent;
+		size +=3D TCPOLEN_TSTAMP_ALIGNED;
+	}
+
 #ifdef CONFIG_TCP_MD5SIG
 	*md5 =3D tp->af_specific->md5_lookup(sk, sk);
 	if (unlikely(*md5)) {
@@ -693,13 +700,6 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 	*md5 =3D NULL;
 #endif
 =

-	if (likely(tp->rx_opt.tstamp_ok)) {
-		opts->options |=3D OPTION_TS;
-		opts->tsval =3D skb ? tcp_skb_timestamp(skb) + tp->tsoffset : 0;
-		opts->tsecr =3D tp->rx_opt.ts_recent;
-		size +=3D TCPOLEN_TSTAMP_ALIGNED;
-	}
-
 	if (static_branch_unlikely(&tcp_extra_options_enabled))
 		size +=3D tcp_extra_options_prepare(skb, 0,
 						  MAX_TCP_OPTION_SPACE - size,
-- =

2.14.1


--===============3999547280206380303==--
