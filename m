Content-Type: multipart/mixed; boundary="===============3004108355732205680=="
MIME-Version: 1.0
From: YueHaibing <yuehaibing at huawei.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: Remove set but not used variable
 'can_ack'
Date: Wed, 18 Mar 2020 02:01:57 +0000
Message-ID: <20200318020157.178956-1-yuehaibing@huawei.com>
X-Status: 
X-Keywords:                  
X-UID: 3974

--===============3004108355732205680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixes gcc '-Wunused-but-set-variable' warning:

net/mptcp/options.c: In function 'mptcp_established_options_dss':
net/mptcp/options.c:338:7: warning:
 variable 'can_ack' set but not used [-Wunused-but-set-variable]

commit dc093db5cc05 ("mptcp: drop unneeded checks")
leave behind this unused, remove it.

Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>
---
 net/mptcp/options.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 63c8ee49cef2..8ba34950241c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -335,7 +335,6 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	struct mptcp_sock *msk;
 	unsigned int ack_size;
 	bool ret =3D false;
-	bool can_ack;
 	u8 tcp_fin;
 =

 	if (skb) {
@@ -364,7 +363,6 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	/* passive sockets msk will set the 'can_ack' after accept(), even
 	 * if the first subflow may have the already the remote key handy
 	 */
-	can_ack =3D true;
 	opts->ext_copy.use_ack =3D 0;
 	msk =3D mptcp_sk(subflow->conn);
 	if (!READ_ONCE(msk->can_ack)) {



--===============3004108355732205680==--
