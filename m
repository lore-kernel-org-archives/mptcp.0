Content-Type: multipart/mixed; boundary="===============1740059597983467616=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 2/5] subflow: explicitly check for plain tcp rsk
Date: Tue, 30 Jun 2020 13:12:05 +0200
Message-ID: <a47e81b13e247546d72de620c12c214b30abe210.1593515429.git.pabeni@redhat.com>
In-Reply-To: cover.1593515429.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4865

--===============1740059597983467616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When syncookie are in use, the TCP stack may feed into
subflow_syn_recv_sock() plain TCP request sockets. We can't
access mptcp_subflow_request_sock-specific fields on such
sockets. Explicitly check the rsk ops to do safe accesses.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: this fixes an slab-out-of-bounds on syncookied
MP_JOIN req, but handling of such req is still problematic:
we relay on the client closing the socket before the 3rd
ack, otherwise the client socket will be created as plain
TCP one - and again client will have to close it.
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 30e907690bc5..862997d5d9f3 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -397,7 +397,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 =

 	/* hopefully temporary handling for MP_JOIN+syncookie */
 	subflow_req =3D mptcp_subflow_rsk(req);
-	fallback_is_fatal =3D subflow_req->mp_join;
+	fallback_is_fatal =3D tcp_rsk(req)->is_mptcp && subflow_req->mp_join;
 	fallback =3D !tcp_rsk(req)->is_mptcp;
 	if (fallback)
 		goto create_child;
-- =

2.26.2

--===============1740059597983467616==--
