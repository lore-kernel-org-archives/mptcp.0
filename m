Content-Type: multipart/mixed; boundary="===============3584300846823191083=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 5/6] mptcp: initialize data_fin field for mpc
 packets
Date: Tue, 28 Apr 2020 16:20:03 +0200
Message-ID: <e4c4277239d8332aae77b5866d4191e89848369d.1588082498.git.pabeni@redhat.com>
In-Reply-To: cover.1588082498.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4262

--===============3584300846823191083==
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

--===============3584300846823191083==--
