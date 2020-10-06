Content-Type: multipart/mixed; boundary="===============2744031207679284956=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: fix infinite loop on
 recvmsg()/worker() race.
Date: Tue, 06 Oct 2020 08:27:34 +0200
Message-ID: <5a2464d778499bdc2ced43b56569008030b470bc.1601965539.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6209

--===============2744031207679284956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If recvmsg() and the workqueue race to dequeue the data
pending on some subflow, the current mapping for such
subflow covers several skbs and some of them have not
reached yet the received, either the worker or recvmsg()
can find a subflow with the data_avail flag set - since
the current mapping is valid and in sequence - but no
skbs in the receive queue - since the other entity just
processed them.

The above will lead to an unbounded loop in __mptcp_move_skbs()
and a subsequent hang of any task trying to acquiring the msk
socket lock.

This change addresses the issue stopping the __mptcp_move_skbs()
loop as soon as we detect the above race (empty receive queue
with data_avail set).

Reported-and-tested-by: syzbot+fcf8ca5817d6e92c6567(a)syzkaller.appspotmail=
.com
Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f483eab0081a..42928db28351 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -471,8 +471,15 @@ static bool __mptcp_move_skbs_from_subflow(struct mptc=
p_sock *msk,
 				mptcp_subflow_get_map_offset(subflow);
 =

 		skb =3D skb_peek(&ssk->sk_receive_queue);
-		if (!skb)
+		if (!skb) {
+			/* if no data is found, a racing workqueue/recvmsg
+			 * already processed the new data, stop here or we
+			 * can enter an infinite loop
+			 */
+			if (!moved)
+				done =3D true;
 			break;
+		}
 =

 		if (__mptcp_check_fallback(msk)) {
 			/* if we are running under the workqueue, TCP could have
-- =

2.26.2

--===============2744031207679284956==--
