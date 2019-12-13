Content-Type: multipart/mixed; boundary="===============6866106524150994097=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "mptcp: recvmsg() can drain data from
 multiple subflows"
Date: Fri, 13 Dec 2019 17:05:59 +0100
Message-ID: <6d836e5d6b44489f59f9dedfe7743c4b2b6f08d5.1576252967.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2948

--===============6866106524150994097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b9eed120913f..fd89075bd1c9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -359,7 +359,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len,
 			desc.count =3D min_t(size_t, len - copied, map_remaining);
 			pr_debug("reading %zu bytes, copied %d", desc.count,
 				 copied);
-			bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
+			bytes_read =3D tcp_read_sock(ssk, &desc,
+						   mptcp_read_actor);
 			if (bytes_read < 0) {
 				if (!copied)
 					copied =3D bytes_read;
-- =

2.23.0

--===============6866106524150994097==--
