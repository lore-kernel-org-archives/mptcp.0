Content-Type: multipart/mixed; boundary="===============8546395387724799813=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: Initialize map_seq upon subflow
 establishment
Date: Mon, 11 May 2020 09:24:42 -0700
Message-ID: <20200511162442.78382-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 4370

--===============8546395387724799813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the other MPTCP-peer uses 32-bit data-sequence numbers, we rely on
map_seq to indicate how to expand to a 64-bit data-sequence number in
expand_seq() when receiving data.

For new subflows, this field is not initialized, thus results in an
"invalid" mapping being discarded.

Fix this by initializing map_seq upon subflow establishment time.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f23016ed3f..32ea8d35489a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1629,6 +1629,8 @@ bool mptcp_finish_join(struct sock *sk)
 =

 	ret =3D mptcp_pm_allow_new_subflow(msk);
 	if (ret) {
+		subflow->map_seq =3D msk->ack_seq;
+
 		/* active connections are already on conn_list */
 		spin_lock_bh(&msk->join_list_lock);
 		if (!WARN_ON_ONCE(!list_empty(&subflow->node)))
-- =

2.23.0

--===============8546395387724799813==--
