Content-Type: multipart/mixed; boundary="===============1136441011010060043=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/4] mptcp: account unsupported DSS mapping
Date: Thu, 17 Oct 2019 11:00:39 +0200
Message-ID: <39bbe13e34e7698e2ecde72fbf3649f18cfd330b.1571258526.git.pabeni@redhat.com>
In-Reply-To: cover.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2203

--===============1136441011010060043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

abusing existing MIB definition instead of defying a new one.
Note that due to change introduced by the previous patches
"mptcp: increment MIB counters in a few places" will conflict
on rebase.

Squash-to: mptcp: increment MIB counters in a few places
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ae89e4fc6033..ed29e9e2bbef 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -438,8 +438,10 @@ static enum mapping_status get_mapping_status(struct s=
ock *ssk)
 		/* If this skb data are fully covered by the current mapping,
 		 * the new map would need caching, which is not supported
 		 */
-		if (skb_is_fully_mapped(ssk, skb))
+		if (skb_is_fully_mapped(ssk, skb)) {
+			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
 			return MAPPING_INVALID;
+		}
 =

 		/* will validate the next map after consuming the current one */
 		return MAPPING_OK;
-- =

2.21.0

--===============1136441011010060043==--
