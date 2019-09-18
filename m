Content-Type: multipart/mixed; boundary="===============4061052650070385778=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] mptcp: recvmsg() should really try to deliver
 'len' bytes to user-space
Date: Wed, 18 Sep 2019 11:35:24 +0200
Message-ID: <3eb62c7aabd4ab6a25e9b002218c3b5b1927a1dc.1568799121.git.pabeni@redhat.com>
In-Reply-To: cover.1568799121.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1877

--===============4061052650070385778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we break the recvmsg() main loop as soon as we have copied any
amount of data or the ssk is closed.

With reinjection we can receive duplicate data and reach the 'wait_for_data'
label with 'copied =3D=3D 0'.
The subflow sk could be already in closed status, if the local socket
has already received all the data from the peer (and the data is sitting
into the receive queue).

When we meet the above scenario, currently recvmsg() terminates with
return code '0' and the user space interpret that as EoF, even if
there is potentially a lot of data pending.

This change addresses the issue checking for pending data before
going through the 'wait_for_data' code path.

v1 -> v2:
 - fix type in comment

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
I'm ok with squashing to commit 786f07cf97f1 ("mptcp: Implement MPTCP recei=
ve path")
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dc59baeca0c7..19bbe16993e9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -713,6 +713,13 @@ static int mptcp_recvmsg(struct sock *sk, struct msghd=
r *msg, size_t len,
 		if (arg.msg)
 			copied +=3D bytes_read;
 =

+		/* The 'wait_for_data' code path can terminate the receive loop
+		 * in a number of scenarios: check if more data is pending
+		 * before giving up.
+		 */
+		if (!skb_queue_empty(&ssk->sk_receive_queue))
+			continue;
+
 wait_for_data:
 		if (copied)
 			break;
-- =

2.21.0


--===============4061052650070385778==--
