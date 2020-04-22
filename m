Content-Type: multipart/mixed; boundary="===============3731795603440116206=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix data_fin handing in RX path
Date: Wed, 22 Apr 2020 18:24:56 +0200
Message-ID: <97c9e399060f81ed71ebfd446d9cf89bbb534142.1587572315.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4230

--===============3731795603440116206==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The data fin flag is set only via a DSS option, but
mptcp_incoming_options() copies it unconditionally from the
provided RX options.

Since we do not clear all the mptcp sock RX options in a
socket free/alloc cycle, we can end-up with a stray data_fin
value while parsing e.g. MPC packets.

That would lead to mapping data corruption and will trigger
a few WARN_ON() in the RX path.

Instead of adding a costly memset(), fetch the data_fin flag
only for DSS packets - when we always explicitly initialize
such bit at option parsing time.

Fixes: 648ef4b88673 ("mptcp: Implement MPTCP receive path")
Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index faf57585b892..4a7c467b99db 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -876,12 +876,11 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
 			mpext->data_seq =3D mp_opt->data_seq;
 			mpext->subflow_seq =3D mp_opt->subflow_seq;
 			mpext->dsn64 =3D mp_opt->dsn64;
+			mpext->data_fin =3D mp_opt->data_fin;
 		}
 		mpext->data_len =3D mp_opt->data_len;
 		mpext->use_map =3D 1;
 	}
-
-	mpext->data_fin =3D mp_opt->data_fin;
 }
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts)
-- =

2.21.1

--===============3731795603440116206==--
