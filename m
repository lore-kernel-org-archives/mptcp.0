Content-Type: multipart/mixed; boundary="===============3235594251018869116=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: allow picking different
 xmit subflows"
Date: Fri, 11 Sep 2020 01:30:25 +0200
Message-ID: <5c2b7b0df753a7f8c9be71a513e2542f58f8d7c0.1599780534.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5793

--===============3235594251018869116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In case of fallback we still need to check for avail space
on the only subflow, or we will trigger issues/83.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note:
- I hope this also address issues/88, but it's just a wild guess
- the repro from issue/83 will block, as expected, but will now
  be responsive to signal
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2abfe998ed05..d271cac7a1fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1092,8 +1092,10 @@ static struct sock *mptcp_subflow_get_send(struct mp=
tcp_sock *msk,
 		return NULL;
 =

 	if (__mptcp_check_fallback(msk)) {
-		*sndbuf =3D msk->first ? msk->first->sk_sndbuf : 0;
-		return msk->first;
+		if (!msk->first)
+			return NULL;
+		*sndbuf =3D msk->first->sk_sndbuf;
+		return sk_stream_memory_free(msk->first) ? msk->first : NULL;
 	}
 =

 	/* re-use last subflow, if the burst allow that */
-- =

2.26.2

--===============3235594251018869116==--
