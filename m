Content-Type: multipart/mixed; boundary="===============0921744920361677032=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: uniform the use of CONFIG_MPTCP_IPV6
Date: Tue, 21 Jan 2020 18:05:42 +0100
Message-ID: <20200121170542.2762865-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3449

--===============0921744920361677032==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We should not check CONFIG_IPV6 but CONFIG_MPTCP_IPV6.
And better to always use:

  #if IS_ENABLED(CONFIG_MPTCP_IPV6)

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Create SUBFLOW socket for incoming connection=
s"

 net/mptcp/protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7f1efe1aae5e..84799a5212a2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -227,7 +227,7 @@ static void mptcp_copy_inaddrs(struct sock *msk, const =
struct sock *ssk)
 	inet_sk(msk)->inet_saddr =3D inet_sk(ssk)->inet_saddr;
 	inet_sk(msk)->inet_rcv_saddr =3D inet_sk(ssk)->inet_rcv_saddr;
 =

-#if IS_ENABLED(CONFIG_IPV6)
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	msk->sk_v6_daddr =3D ssk->sk_v6_daddr;
 	msk->sk_v6_rcv_saddr =3D ssk->sk_v6_rcv_saddr;
 =

@@ -474,7 +474,7 @@ static int mptcp_listen(struct socket *sock, int backlo=
g)
 =

 static bool is_tcp_proto(const struct proto *p)
 {
-#ifdef CONFIG_MPTCP_IPV6
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	return p =3D=3D &tcp_prot || p =3D=3D &tcpv6_prot;
 #else
 	return p =3D=3D &tcp_prot;
-- =

2.24.0

--===============0921744920361677032==--
