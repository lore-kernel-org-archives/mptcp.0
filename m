Content-Type: multipart/mixed; boundary="===============9218188791181904973=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 11/12] mptcp: Safely read sequence number
 when lock isn't held
Date: Wed, 15 Jul 2020 17:20:35 -0700
Message-ID: <20200716002036.705306-12-mathew.j.martineau@linux.intel.com>
In-Reply-To: 20200716002036.705306-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5035

--===============9218188791181904973==
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
index d19e7ba5163c..30c5810771dd 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1273,7 +1273,7 @@ static void mptcp_retransmit_handler(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (atomic64_read(&msk->snd_una) =3D=3D msk->write_seq) {
+	if (atomic64_read(&msk->snd_una) =3D=3D READ_ONCE(msk->write_seq)) {
 		mptcp_stop_timer(sk);
 	} else {
 		set_bit(MPTCP_WORK_RTX, &msk->flags);
-- =

2.27.0

--===============9218188791181904973==--
