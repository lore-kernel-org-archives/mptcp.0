Content-Type: multipart/mixed; boundary="===============6956044876035515699=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 4/4] poll: release lock before waiting
Date: Tue, 05 Nov 2019 18:05:31 +0100
Message-ID: <20191105170531.30407-5-fw@strlen.de>
In-Reply-To: 20191105170531.30407-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2397

--===============6956044876035515699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

else, this can block kworker thread forever -- it needs to lock the
mptcp socket, so we should not hold this lock when waiting for events.

squashto: mptcp: add mptcp_poll

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8cc9cc5675c2..53b1b015d9d4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1229,7 +1229,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 		return ret;
 	}
 =

+	release_sock(sk);
 	sock_poll_wait(file, sock, wait);
+	lock_sock(sk);
 =

 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_sock;
-- =

2.23.0

--===============6956044876035515699==--
