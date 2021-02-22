Content-Type: multipart/mixed; boundary="===============7741070561159125550=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 3/3] mptcp: remove unneeded check on first
 subflow
Date: Mon, 22 Feb 2021 18:07:18 +0100
Message-ID: <168942e6b1bfa72c9d772e03a231a11d74566533.1614013455.git.pabeni@redhat.com>
In-Reply-To: cover.1614013455.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7897

--===============7741070561159125550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently we explicitly check for the first subflow being
NULL in a couple of places, even if we don't need any
special actions in such scenario.

Just drop the unneeded checks, to avoid confusion.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c  | 2 +-
 net/mptcp/protocol.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index b252aadad3fc8..6a9bfc1b9d9c6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -950,7 +950,7 @@ bool mptcp_update_rcv_data_fin(struct mptcp_sock *msk, =
u64 data_fin_seq, bool us
 	 * should match. If they mismatch, the peer is misbehaving and
 	 * we will prefer the most recent information.
 	 */
-	if (READ_ONCE(msk->rcv_data_fin) || !READ_ONCE(msk->first))
+	if (READ_ONCE(msk->rcv_data_fin))
 		return false;
 =

 	WRITE_ONCE(msk->rcv_data_fin_seq,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 615fd81faa9a3..2d361c923a07d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -493,7 +493,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret =3D false;
 =

-	if (__mptcp_check_fallback(msk) || !msk->first)
+	if (__mptcp_check_fallback(msk))
 		return ret;
 =

 	/* Need to ack a DATA_FIN received from a peer while this side
-- =

2.26.2

--===============7741070561159125550==--
