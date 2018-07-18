Content-Type: multipart/mixed; boundary="===============4332292274894832902=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:fullmesh: fix compilation warning if no IPv6
Date: Wed, 18 Jul 2018 11:37:50 -0400
Message-ID: <20180718153750.3822-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 681

--===============4332292274894832902==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>

if_idx would be seen as an unitialized variable even if it should never
happen in case of !CONFIG_IPV6. But let makes the compiler happy!

Fixes: 9e763119cccc6 (mptcp: Check interface index in fullmesh pm)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
(cherry picked from commit e2b2f250f15fe9c4442483c1263af83cf8d8a0d5)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_fullmesh.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/mptcp_fullmesh.c b/net/mptcp/mptcp_fullmesh.c
index cbeea9b83910..1e12af79a1b8 100644
--- a/net/mptcp/mptcp_fullmesh.c
+++ b/net/mptcp/mptcp_fullmesh.c
@@ -1301,9 +1301,9 @@ static void full_mesh_new_session(const struct sock *=
meta_sk)
 	struct fullmesh_priv *fmp =3D fullmesh_get_priv(mpcb);
 	const struct mptcp_fm_ns *fm_ns =3D fm_get_ns(sock_net(meta_sk));
 	struct tcp_sock *master_tp =3D tcp_sk(mpcb->master_sk);
-	int i, index, if_idx;
+	int i, index, if_idx =3D 0;
 	union inet_addr saddr, daddr;
-	sa_family_t family;
+	sa_family_t family =3D AF_INET;
 	bool meta_v4 =3D meta_sk->sk_family =3D=3D AF_INET;
 =

 	/* Init local variables necessary for the rest */
-- =

2.16.2


--===============4332292274894832902==--
