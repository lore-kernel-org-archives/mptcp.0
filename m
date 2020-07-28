Content-Type: multipart/mixed; boundary="===============7728699298945079586=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 11/12] mptcp: Safely read sequence number
 when lock isn't held
Date: Tue, 28 Jul 2020 15:12:09 -0700
Message-ID: <20200728221210.92841-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200728221210.92841-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5354

--===============7728699298945079586==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The MPTCP socket's write_seq member should be read with READ_ONCE() when
the msk lock is not held.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f264ea15e081..f2455a68d231 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1269,7 +1269,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq) {
+	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->write_seq)) {
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
-- =

2.28.0

--===============7728699298945079586==--
