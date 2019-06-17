Content-Type: multipart/mixed; boundary="===============8178332693841566305=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3] mptcp: proto_ops cannot be const
Date: Mon, 17 Jun 2019 15:02:24 +0200
Message-ID: <20190617130224.21141-1-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-4-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1412

--===============8178332693841566305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This partially reverts 2cb651944bde (mptcp: fix checkpatch issues).

The proto_ops cannot be const as recommended by checkpatch because we
start from inet_stream_ops and we modify only what we need to modify.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f3bb7646ac07..ce2374ea7871 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -158,7 +158,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
 }
 =

-static const struct proto_ops mptcp_stream_ops;
+static struct proto_ops mptcp_stream_ops;
 =

 static struct inet_protosw mptcp_protosw =3D {
 	.type		=3D SOCK_STREAM,
-- =

2.20.1


--===============8178332693841566305==--
