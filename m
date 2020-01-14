Content-Type: multipart/mixed; boundary="===============3661215448763393633=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] protocol: add comment to smb_mb__after_atomic
Date: Wed, 15 Jan 2020 00:28:00 +0100
Message-ID: <20200114232800.20658-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3357

--===============3661215448763393633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: mptcp: add subflow write space signalling and mptcp_poll

msk->flags and sock->flags depend one one another, we first need to
disable SEND_SPACE flag (no more wmem available for sending), then
enable the write_space callbacks in the tcp core.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6df4eb20916c..5dfca0aa7ce4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -547,6 +547,7 @@ static void ssk_check_wmem(struct mptcp_sock *msk, stru=
ct sock *ssk)
 	if (sock) {
 		clear_bit(MPTCP_SEND_SPACE, &msk->flags);
 		smp_mb__after_atomic();
+		/* set NOSPACE only after clearing SEND_SPACE flag */
 		set_bit(SOCK_NOSPACE, &sock->flags);
 	}
 }
-- =

2.24.1

--===============3661215448763393633==--
