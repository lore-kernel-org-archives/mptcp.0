Content-Type: multipart/mixed; boundary="===============8003879543539012445=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/6] Squash-to: "mptcp: queue data for mptcp level
 retransmission"
Date: Fri, 27 Mar 2020 16:53:22 +0100
Message-ID: <20200327155327.605375-2-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4087

--===============8003879543539012445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove inline in foo.c files, let the compiler decide.

Request from David S. Miller.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index dae5d3152da4..812a646c349a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -285,9 +285,9 @@ static inline bool mptcp_skb_can_collapse_to(const stru=
ct mptcp_sock *msk,
 	return mpext && mpext->data_seq + mpext->data_len =3D=3D msk->write_seq;
 }
 =

-static inline bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
-					      const struct page_frag *pfrag,
-					      const struct mptcp_data_frag *df)
+static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
+				       const struct page_frag *pfrag,
+				       const struct mptcp_data_frag *df)
 {
 	return df && pfrag->page =3D=3D df->page &&
 		df->data_seq + df->data_len =3D=3D msk->write_seq;
@@ -327,7 +327,7 @@ static bool mptcp_page_frag_refill(struct sock *sk, str=
uct page_frag *pfrag)
 	return false;
 }
 =

-static inline struct mptcp_data_frag *
+static struct mptcp_data_frag *
 mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfra=
g,
 		      int orig_offset)
 {
-- =

2.25.1

--===============8003879543539012445==--
