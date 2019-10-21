Content-Type: multipart/mixed; boundary="===============5814067233779012708=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: Save address family when creating socket
Date: Mon, 21 Oct 2019 16:41:51 -0700
Message-ID: <20191021234152.3091-3-peter.krystad@linux.intel.com>
In-Reply-To: 20191021234152.3091-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2245

--===============5814067233779012708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For IPv6 the family will be needed when creating additional
subflow sockets.

squashto: mptcp: Associate MPTCP context with TCP socket

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c7755cde9810..e7b40987d1b6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1091,6 +1091,7 @@ static struct socket *mptcp_socket_create_get(struct =
mptcp_sock *msk)
 	}
 =

 	msk->subflow =3D ssock;
+	msk->family =3D ssock->sk->sk_family;
 	subflow =3D mptcp_subflow_ctx(msk->subflow->sk);
 	subflow->request_mptcp =3D 1; /* @@ if MPTCP enabled */
 	subflow->request_version =3D 0; /* currently only v0 supported */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 791f2c19cfb8..8fe5f9383d38 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -133,6 +133,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	u16		dport;
+	sa_family_t	family;
 	struct work_struct rtx_work;
 	struct list_head conn_list;
 	struct list_head rtx_queue;
-- =

2.17.2

--===============5814067233779012708==--
