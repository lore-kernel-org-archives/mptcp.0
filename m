Content-Type: multipart/mixed; boundary="===============0640614773541879695=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: mptcp: move page frag allocation
 in mptcp_sendmsg()
Date: Mon, 05 Oct 2020 11:00:19 +0200
Message-ID: <6176a5b0d2a773b4b623e00e11c86fb784457756.1601888417.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6194

--===============0640614773541879695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This, as suggested by Florian, avoid probe coalescing, which
will hit a later WARN_ON_ONCE() and will cause stream corruption.

Additionally bail early when the MPTCP win is closed an no
probe.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 6b5a8f8d2175..29be694c1d94 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -985,7 +985,9 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct s=
ock *ssk,
 =

 	/* Zero window and all data acked? Probe. */
 	avail_size =3D mptcp_check_allowed_size(msk, data_seq, avail_size);
-	if (avail_size =3D=3D 0 && atomic64_read(&msk->snd_una) =3D=3D msk->snd_n=
xt) {
+	if (avail_size =3D=3D 0) {
+		if (skb || atomic64_read(&msk->snd_una) !=3D msk->snd_nxt)
+			return 0;
 		zero_window_probe =3D true;
 		data_seq =3D atomic64_read(&msk->snd_una) - 1;
 		avail_size =3D 1;
-- =

2.26.2

--===============0640614773541879695==--
