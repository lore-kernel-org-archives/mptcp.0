Content-Type: multipart/mixed; boundary="===============0546513866419435607=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC final 10/14] tcp_md5: Check for TCP_MD5 after TCP
 Timestamps in tcp_established_options
Date: Sun, 17 Dec 2017 22:42:41 -0800
Message-ID: <20171218064245.94150-11-cpaasch@apple.com>
In-Reply-To: 20171218064245.94150-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 285

--===============0546513866419435607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It really does not matter, because we never use TCP timestamps when
TCP_MD5 is enabled (see tcp_syn_options).

Moving TCP_MD5 a bit lower allows for easier adoption of the
tcp_extra_option framework.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/ipv4/tcp_output.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 43849ed73b03..7ea65f70e5ec 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -662,6 +662,13 @@ static unsigned int tcp_established_options(struct soc=
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
 	opts->md5 =3D tp->af_specific->md5_lookup(sk, sk);
 	if (unlikely(opts->md5)) {
@@ -672,13 +679,6 @@ static unsigned int tcp_established_options(struct soc=
k *sk, struct sk_buff *skb
 	opts->md5 =3D NULL;
 #endif
 =

-	if (likely(tp->rx_opt.tstamp_ok)) {
-		opts->options |=3D OPTION_TS;
-		opts->tsval =3D skb ? tcp_skb_timestamp(skb) + tp->tsoffset : 0;
-		opts->tsecr =3D tp->rx_opt.ts_recent;
-		size +=3D TCPOLEN_TSTAMP_ALIGNED;
-	}
-
 	if (unlikely(!hlist_empty(&tp->tcp_option_list)))
 		size +=3D tcp_extopt_prepare(skb, 0, MAX_TCP_OPTION_SPACE - size,
 					   opts, tcp_to_sk(tp));
-- =

2.15.0


--===============0546513866419435607==--
