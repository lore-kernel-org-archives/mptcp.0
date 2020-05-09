Content-Type: multipart/mixed; boundary="===============4262339800418429770=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC net] mptcp: Initialize map_seq upon subflow establishment
Date: Sat, 09 May 2020 16:39:05 -0700
Message-ID: <20200509233905.72131-1-cpaasch@apple.com>
X-Status: 
X-Keywords:                  
X-UID: 4354

--===============4262339800418429770==
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
index e1f23016ed3f..86ed1e55a59b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1635,6 +1635,8 @@ bool mptcp_finish_join(struct sock *sk)
 			list_add_tail(&subflow->node, &msk->join_list);
 		spin_unlock_bh(&msk->join_list_lock);
 	}
+
+	subflow->map_seq =3D msk->ack_seq;
 	return ret;
 }
 =

-- =

2.23.0

--===============4262339800418429770==--
