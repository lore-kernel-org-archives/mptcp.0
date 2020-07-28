Content-Type: multipart/mixed; boundary="===============5661465510990918598=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 03/12] mptcp: Remove outdated and incorrect
 comment
Date: Tue, 28 Jul 2020 15:12:01 -0700
Message-ID: <20200728221210.92841-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5346

--===============5661465510990918598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_close() acquires the msk lock, so it clearly should not be held
before the function is called.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index b3c3dbc89b3f..7d7e0fa17219 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1421,7 +1421,6 @@ static void mptcp_subflow_shutdown(struct sock *ssk, =
int how,
 	release_sock(ssk);
 }
 =

-/* Called with msk lock held, releases such lock before returning */
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
-- =

2.28.0

--===============5661465510990918598==--
