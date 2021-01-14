Content-Type: multipart/mixed; boundary="===============4751766985078425463=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 5/7] mptcp: avoid lock_fast usage in accept path
Date: Thu, 14 Jan 2021 18:36:52 +0100
Message-ID: <20210114173654.7618-6-fw@strlen.de>
In-Reply-To: 20210114173654.7618-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7386

--===============4751766985078425463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Once event support is added this may need to allocate memory while msk
lock is held with softirqs disabled.

Not using lock_fast also allows to do the allocation with GFP_KERNEL.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 30986c4008c0..d31f92503abf 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3225,9 +3225,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 		struct mptcp_sock *msk =3D mptcp_sk(newsock->sk);
 		struct mptcp_subflow_context *subflow;
 		struct sock *newsk =3D newsock->sk;
-		bool slowpath;
 =

-		slowpath =3D lock_sock_fast(newsk);
+		lock_sock(newsk);
 =

 		/* PM/worker can now acquire the first subflow socket
 		 * lock without racing with listener queue cleanup,
@@ -3253,7 +3252,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
truct socket *newsock,
 			if (!ssk->sk_socket)
 				mptcp_sock_graft(ssk, newsock);
 		}
-		unlock_sock_fast(newsk, slowpath);
+		release_sock(newsk);
 	}
 =

 	if (inet_csk_listen_poll(ssock->sk))
-- =

2.26.2

--===============4751766985078425463==--
