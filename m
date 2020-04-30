Content-Type: multipart/mixed; boundary="===============8640048750511517332=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 5/5] mptcp: initialize the data_fin field for
 mpc packets
Date: Thu, 30 Apr 2020 15:01:55 +0200
Message-ID: <0701d07b1b9b94052fbb8f32b870a037e0f7d3ac.1588243786.git.pabeni@redhat.com>
In-Reply-To: cover.1588243786.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4288

--===============8640048750511517332==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When parsing MPC+data packets we set the dss field, so
we must also initialize the data_fin, or we can find stray
value there.

Fixes: 9a19371bf029 ("mptcp: fix data_fin handing in RX path")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9486720c3256..45497af23906 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -858,6 +858,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 			mpext->subflow_seq =3D 1;
 			mpext->dsn64 =3D 1;
 			mpext->mpc_map =3D 1;
+			mpext->data_fin =3D 0;
 		} else {
 			mpext->data_seq =3D mp_opt.data_seq;
 			mpext->subflow_seq =3D mp_opt.subflow_seq;
-- =

2.21.1

--===============8640048750511517332==--
