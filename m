Content-Type: multipart/mixed; boundary="===============6274545826055807462=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/6] Squash-to: "mptcp: rework mptcp_sendmsg_frag to
 accept optional dfrag"
Date: Fri, 27 Mar 2020 16:53:24 +0100
Message-ID: <20200327155327.605375-4-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4090

--===============6274545826055807462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove inline in foo.c files, let the compiler decide.

Request from David S. Miller.

Note that mptcp_skb_can_collapse_to() was not introduced in
"mptcp: rework mptcp_sendmsg_frag to accept optional dfrag" but this
commit modifies the first parameter of the function and that's the only
remaining "inline" one.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7bdf79f8787a..c4d15859ba2d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -316,9 +316,9 @@ static struct sock *mptcp_subflow_recv_lookup(const str=
uct mptcp_sock *msk)
 	return NULL;
 }
 =

-static inline bool mptcp_skb_can_collapse_to(u64 write_seq,
-					     const struct sk_buff *skb,
-					     const struct mptcp_ext *mpext)
+static bool mptcp_skb_can_collapse_to(u64 write_seq,
+				      const struct sk_buff *skb,
+				      const struct mptcp_ext *mpext)
 {
 	if (!tcp_skb_can_collapse_to(skb))
 		return false;
-- =

2.25.1

--===============6274545826055807462==--
