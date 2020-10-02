Content-Type: multipart/mixed; boundary="===============7862281466761456508=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 02/13] mptcp: don't skip needed ack
Date: Fri, 02 Oct 2020 11:26:12 +0200
Message-ID: <7027f57f57255819a65e10054afdf2d8a784cc0b.1601630384.git.pabeni@redhat.com>
In-Reply-To: cover.1601630384.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6152

--===============7862281466761456508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we skip calling tcp_cleanup_rbuf() when packets
are moved into the OoO queue or simply dropped. In both
cases we still increment tp->copied_seq, and we should
ask the TCP stack to check for ack.

Fixes: c76c6956566f ("mptcp: call tcp_cleanup_rbuf on subflows")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 31e8d7f1e612..4501e91d53dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -454,6 +454,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	unsigned int moved =3D 0;
 	bool more_data_avail;
 	struct tcp_sock *tp;
+	u32 old_copied_seq;
 	bool done =3D false;
 	int sk_rbuf;
 =

@@ -470,6 +471,7 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 =

 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
 	tp =3D tcp_sk(ssk);
+	old_copied_seq =3D tp->copied_seq;
 	do {
 		u32 map_remaining, offset;
 		u32 seq =3D tp->copied_seq;
@@ -528,8 +530,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 	} while (more_data_avail);
 =

 	*bytes +=3D moved;
-	if (moved)
-		tcp_cleanup_rbuf(ssk, moved);
+	if (tp->copied_seq !=3D old_copied_seq)
+		tcp_cleanup_rbuf(ssk, 1);
 =

 	return done;
 }
-- =

2.26.2

--===============7862281466761456508==--
