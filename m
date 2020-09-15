Content-Type: multipart/mixed; boundary="===============3178043361225647843=="
MIME-Version: 1.0
From: Colin King <colin.king at canonical.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH][next] mptcp: fix spelling mistake "colesced" ->
 "coalesced"
Date: Tue, 15 Sep 2020 09:44:05 +0100
Message-ID: <20200915084405.7361-1-colin.king@canonical.com>
X-Status: 
X-Keywords:                  
X-UID: 5875

--===============3178043361225647843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Colin Ian King <colin.king(a)canonical.com>

There is a spelling mistake a pr_debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ef0dd2f23482..8f53323c6335 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -128,7 +128,7 @@ static bool mptcp_try_coalesce(struct sock *sk, struct =
sk_buff *to,
 	    !skb_try_coalesce(to, from, &fragstolen, &delta))
 		return false;
 =

-	pr_debug("colesced seq %llx into %llx new len %d new end seq %llx",
+	pr_debug("coalesced seq %llx into %llx new len %d new end seq %llx",
 		 MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
 		 to->len, MPTCP_SKB_CB(from)->end_seq);
 	MPTCP_SKB_CB(to)->end_seq =3D MPTCP_SKB_CB(from)->end_seq;
-- =

2.27.0

--===============3178043361225647843==--
