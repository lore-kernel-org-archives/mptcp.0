Content-Type: multipart/mixed; boundary="===============8740117509534525699=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] mptcp: do not orphan the ssk before tcp_close()
Date: Thu, 12 Dec 2019 18:57:44 +0100
Message-ID: <7a04a30700ceefe9dfb77646d203e9b2c6e4de23.1576173332.git.pabeni@redhat.com>
In-Reply-To: a4d28a295c187d20e3b6a9d345597eac474b6e59.1576164482.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2892

--===============8740117509534525699==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This close the following race

CPU 0				CPU 1
sock_orphan()
	// SOCK_DEAD
				tcp_done()
					inet_csk_destroy_sock()
						sock_put()

tcp_close()
	// UAF

Note that we can't acquire an additional ref to the
sock before sock_orphan() and releasing it after close,
such ref will be consumed by inet_csk_destroy_sock when
the race is triggered.

Squash-to: "mptcp: Handle MP_CAPABLE options for outgoing connections"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 v1 -> v2:
  - simply drop the sock_orphan() call - Florian
---
 net/mptcp/protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9506e04a2010..bfd7e8b9c3a8 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -179,7 +179,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct s=
ock *ssk,
 		sock_release(sock);
 	} else {
 		/* incoming subflow */
-		sock_orphan(ssk);
 		tcp_close(ssk, timeout);
 	}
 }
-- =

2.21.0

--===============8740117509534525699==--
