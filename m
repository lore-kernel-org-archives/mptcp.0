Content-Type: multipart/mixed; boundary="===============4425555901471251769=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 04/18] tcp: Pass sock to tcp_synack_options
Date: Tue, 03 Oct 2017 09:21:50 -0700
Message-ID: <20171003162204.17945-5-cpaasch@apple.com>
In-Reply-To: 20171003162204.17945-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 91

--===============4425555901471251769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Will be needed by TCP_MD5

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b1dd3fa17a63..964c4c6cd0a2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -611,7 +611,8 @@ static unsigned int tcp_syn_options(struct sock *sk, st=
ruct sk_buff *skb,
 }
 =

 /* Set up TCP options for SYN-ACKs. */
-static unsigned int tcp_synack_options(struct request_sock *req,
+static unsigned int tcp_synack_options(const struct sock *sk,
+				       struct request_sock *req,
 				       unsigned int mss, struct sk_buff *skb,
 				       struct tcp_out_options *opts,
 				       const struct tcp_md5sig_key *md5,
@@ -3165,7 +3166,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk=
, struct dst_entry *dst,
 	md5 =3D tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
 #endif
 	skb_set_hash(skb, tcp_rsk(req)->txhash, PKT_HASH_TYPE_L4);
-	tcp_header_size =3D tcp_synack_options(req, mss, skb, &opts, md5, foc) +
+	tcp_header_size =3D tcp_synack_options(sk, req, mss, skb, &opts, md5, foc=
) +
 			  sizeof(*th);
 =

 	skb_push(skb, tcp_header_size);
-- =

2.14.1


--===============4425555901471251769==--
