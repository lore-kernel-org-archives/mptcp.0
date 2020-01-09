Content-Type: multipart/mixed; boundary="===============5661257497236300526=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] protocol: fix list corruption
Date: Thu, 09 Jan 2020 15:31:14 +0100
Message-ID: <20200109143114.7716-2-fw@strlen.de>
In-Reply-To: 20200109143114.7716-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3310

--===============5661257497236300526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: subflow: place further subflows on new 'join_list'

plugs:
 inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
 kworker/u8:1/31 [HC0[0]:SC1[1]:HE1:SE0] takes:
 ffff88810c43d520 (&(&msk->join_list_lock)->rlock){+.?.}, at: mptcp_finish_=
join+0x30f/0x4d0

and a list corruption, we need to re-init the join list head, else next
list_empty() test will splice this a second time, resulting in a
corrupted conn list.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a33c4c58de78..6df4eb20916c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -153,7 +153,7 @@ static void __mptcp_flush_join_list(struct mptcp_sock *=
msk)
 		return;
 =

 	spin_lock_bh(&msk->join_list_lock);
-	list_splice_tail(&msk->join_list, &msk->conn_list);
+	list_splice_tail_init(&msk->join_list, &msk->conn_list);
 	spin_unlock_bh(&msk->join_list_lock);
 }
 =

@@ -1420,9 +1420,9 @@ bool mptcp_finish_join(struct sock *sk)
 =

 		/* active connections are already on conn_list */
 		if (list_empty(&subflow->node)) {
-			spin_lock(&msk->join_list_lock);
+			spin_lock_bh(&msk->join_list_lock);
 			list_add_tail(&subflow->node, &msk->join_list);
-			spin_unlock(&msk->join_list_lock);
+			spin_unlock_bh(&msk->join_list_lock);
 		}
 	}
 	return true;
-- =

2.24.1

--===============5661257497236300526==--
