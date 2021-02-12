Content-Type: multipart/mixed; boundary="===============3315377981823062953=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 6/8] mptcp: avoid lock_fast usage in accept
 path
Date: Fri, 12 Feb 2021 15:59:59 -0800
Message-ID: <20210213000001.379332-7-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20210213000001.379332-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7789

--===============3315377981823062953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>

Once event support is added this may need to allocate memory while msk
lock is held with softirqs disabled.

Not using lock_fast also allows to do the allocation with GFP_KERNEL.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 56240b87d464..fe6da1b77723 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3260,9 +3260,8 @@ static int mptcp_stream_accept(struct socket *sock, s=
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
@@ -3288,7 +3287,7 @@ static int mptcp_stream_accept(struct socket *sock, s=
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

2.30.1

--===============3315377981823062953==--
