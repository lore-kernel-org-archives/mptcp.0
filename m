Content-Type: multipart/mixed; boundary="===============5481776519722336824=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2] mptcp: use list_first_entry_or_null
Date: Mon, 15 Jun 2020 16:34:28 +0800
Message-ID: <6cf9b609f1d77b389165448b9a9b38f6bee48f87.1592209896.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4673

--===============5481776519722336824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use list_first_entry_or_null to simplify the code.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 Changes in v2:
  - Add "net-next" tag in Subject.
---
 net/mptcp/protocol.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 70ed698bd206..db56535dfc29 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -232,10 +232,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(c=
onst struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

-	if (list_empty(&msk->rtx_queue))
-		return NULL;
-
-	return list_first_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
+	return list_first_entry_or_null(&msk->rtx_queue, struct mptcp_data_frag, =
list);
 }
 =

 struct mptcp_subflow_request_sock {
-- =

2.17.1

--===============5481776519722336824==--
