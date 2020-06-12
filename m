Content-Type: multipart/mixed; boundary="===============2316100953950330941=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: use list_first_entry_or_null
Date: Fri, 12 Jun 2020 14:05:34 +0800
Message-ID: <9958d3f15d2d181eb9d48ffe5bf3251ec900f27a.1591941826.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4658

--===============2316100953950330941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use list_first_entry_or_null to simplify the code.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 86d265500cf6..55c65abcad64 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -234,10 +234,7 @@ static inline struct mptcp_data_frag *mptcp_rtx_head(c=
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

--===============2316100953950330941==--
