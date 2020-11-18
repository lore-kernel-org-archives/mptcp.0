Content-Type: multipart/mixed; boundary="===============5994930031424161558=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: update rtx timeout only if required.
Date: Wed, 18 Nov 2020 23:05:34 +0100
Message-ID: <1a72039f112cae048c44d398ffa14e0a1432db3d.1605737083.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6795

--===============5994930031424161558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We must start the retransmission timer only there are
pending data in the rtx queue.
Otherwise we can hit a WARN_ON in mptcp_reset_timer(),
as syzbot demonstrated.

Reported-and-tested-by: syzbot+42aa53dafb66a07e5a24(a)syzkaller.appspotmail=
.com
Fixes: d9ca1de8c0cd ("mptcp: move page frag allocation in mptcp_sendmsg()")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8df013daea88..aeda4357de9a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1261,11 +1261,12 @@ static void mptcp_push_pending(struct sock *sk, uns=
igned int flags)
 		mptcp_push_release(sk, ssk, &info);
 =

 out:
-	/* start the timer, if it's not pending */
-	if (!mptcp_timer_pending(sk))
-		mptcp_reset_timer(sk);
-	if (copied)
+	if (copied) {
+		/* start the timer, if it's not pending */
+		if (!mptcp_timer_pending(sk))
+			mptcp_reset_timer(sk);
 		__mptcp_check_send_data_fin(sk);
+	}
 }
 =

 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
-- =

2.26.2

--===============5994930031424161558==--
