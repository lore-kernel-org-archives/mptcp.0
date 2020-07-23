Content-Type: multipart/mixed; boundary="===============5819558955246112371=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v3 03/12] mptcp: Remove outdated and
 incorrect comment
Date: Thu, 23 Jul 2020 10:43:07 -0700
Message-ID: <20200723174316.131049-4-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200723174316.131049-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5258

--===============5819558955246112371==
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
index 9e812011c635..84087982367f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1424,7 +1424,6 @@ static void mptcp_subflow_shutdown(struct sock *ssk, =
int how,
 	release_sock(ssk);
 }
 =

-/* Called with msk lock held, releases such lock before returning */
 static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow, *tmp;
-- =

2.27.0

--===============5819558955246112371==--
