Content-Type: multipart/mixed; boundary="===============6021247229410292764=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] squash-to: "mptcp: add subflow write space signalling
 and mptcp_poll"
Date: Fri, 13 Dec 2019 17:05:57 +0100
Message-ID: <509ec2d23608193d8f9958b9f3744d1d263de779.1576252967.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2949

--===============6021247229410292764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

checkpatch fixes

Signed-off-by: Davide Caratti<dcaratti(a)redhat.com>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 71a305f391c4..44e6f0d1070c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -817,7 +817,8 @@ static __poll_t mptcp_poll(struct file *file, struct so=
cket *sock,
 =

 	if (test_bit(MPTCP_DATA_READY, &msk->flags))
 		mask =3D EPOLLIN | EPOLLRDNORM;
-	if (sk_stream_is_writeable(sk) && test_bit(MPTCP_SEND_SPACE, &msk->flags))
+	if (sk_stream_is_writeable(sk) &&
+	    test_bit(MPTCP_SEND_SPACE, &msk->flags))
 		mask |=3D EPOLLOUT | EPOLLWRNORM;
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		mask |=3D EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
-- =

2.23.0

--===============6021247229410292764==--
