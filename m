Content-Type: multipart/mixed; boundary="===============7992947843540507388=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:46 +0200
Message-ID: <20190615105259.15151-4-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1388

--===============7992947843540507388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - code indent should use tabs where possible
 - struct proto_ops should normally be const
 - missing a blank line after declarations
 - line over 80 characters
 - networking block comments don't use an empty /* line, use /*
   Comment...

What has not been fixed:

 - added, moved or deleted file(s), does MAINTAINERS need updating?
   > TBD later

Fixes: f34ac55969b5 (mptcp: Associate MPTCP context with TCP socket)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 4 +++-
 net/mptcp/subflow.c  | 3 +--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 06970e6ec282..73baff1675e4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -132,9 +132,9 @@ static int mptcp_bind(struct socket *sock, struct socka=
ddr *uaddr, int addr_len)
 		return err;
 =

 	if (!msk->subflow) {
-	        err =3D mptcp_subflow_create(sock->sk);
-	        if (err)
-	                return err;
+		err =3D mptcp_subflow_create(sock->sk);
+		if (err)
+			return err;
 	}
 	return inet_bind(msk->subflow, uaddr, addr_len);
 }
@@ -159,7 +159,7 @@ static int mptcp_stream_connect(struct socket *sock, st=
ruct sockaddr *uaddr,
 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
 }
 =

-static struct proto_ops mptcp_stream_ops;
+static const struct proto_ops mptcp_stream_ops;
 =

 static struct inet_protosw mptcp_protosw =3D {
 	.type		=3D SOCK_STREAM,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 8b6588f65146..1b695a503d83 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -54,10 +54,12 @@ struct subflow_context {
 static inline struct subflow_context *subflow_ctx(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk =3D inet_csk(sk);
+
 	return (struct subflow_context *)icsk->icsk_ulp_data;
 }
 =

-static inline struct socket *mptcp_subflow_tcp_socket(const struct subflow=
_context *subflow)
+static inline struct socket *
+mptcp_subflow_tcp_socket(const struct subflow_context *subflow)
 {
 	return subflow->tcp_sock;
 }
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 91ab2673fadd..8d13713ee159 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Multipath TCP
+/* Multipath TCP
  *
  * Copyright (c) 2017 - 2019, Intel Corporation.
  */
-- =

2.20.1


--===============7992947843540507388==--
