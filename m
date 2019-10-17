Content-Type: multipart/mixed; boundary="===============6714965754009328647=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] token: fix rcu ptr manipulatation.
Date: Thu, 17 Oct 2019 17:43:19 +0200
Message-ID: <73846495d8826b1b1ec820d6206dfaa1c2e5b9a0.1571326920.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2227

--===============6714965754009328647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

the radix tree slot manipulation needs some extra care to fit
the RCU annotation. Also replace raw *slot assignment with
the related radix tree helper - elsewhere sparse will lament there, too.

Squash-to: "mptcp: Add key generation and token tree"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/token.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index a0d8f6e323b2..aeb7059d19e1 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -161,8 +161,8 @@ void mptcp_token_update_accept(struct sock *sk, struct =
sock *conn)
 	slot =3D radix_tree_lookup_slot(&token_tree, subflow->token);
 	WARN_ON_ONCE(!slot);
 	if (slot) {
-		WARN_ON_ONCE(*slot !=3D &token_used);
-		*slot =3D conn;
+		WARN_ON_ONCE(rcu_access_pointer(*slot) !=3D &token_used);
+		radix_tree_replace_slot(&token_tree, slot, conn);
 	}
 	spin_unlock_bh(&token_tree_lock);
 }
-- =

2.21.0

--===============6714965754009328647==--
