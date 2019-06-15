Content-Type: multipart/mixed; boundary="===============4443961973834582850=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 8/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:51 +0200
Message-ID: <20190615105259.15151-9-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1393

--===============4443961973834582850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - "foo* bar" should be "foo *bar" (2)
 - line over 80 characters

What has not been fixed:

 - /

Fixes: 4916eb951361 (mptcp: Write MPTCP DSS headers to outgoing data packet=
s)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/net/mptcp.h | 4 ++--
 net/mptcp/options.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 3cf81a34d41c..12f378e37e8d 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -69,7 +69,7 @@ bool mptcp_synack_options(const struct request_sock *req,=
 unsigned int *size,
 			  struct mptcp_out_options *opts);
 bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       unsigned int *size, unsigned int remaining,
-			       struct mptcp_out_options* opts);
+			       struct mptcp_out_options *opts);
 =

 static inline bool mptcp_skb_ext_exist(const struct sk_buff *skb)
 {
@@ -120,7 +120,7 @@ static inline bool mptcp_established_options(struct soc=
k *sk,
 					     struct sk_buff *skb,
 					     unsigned int *size,
 					     unsigned int remaining,
-					     struct mptcp_out_options* opts)
+					     struct mptcp_out_options *opts)
 {
 	return false;
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 249ecfe965a2..49c9de0bea91 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -242,7 +242,9 @@ static bool mptcp_established_options_dss(struct sock *=
sk, struct sk_buff *skb,
 	if (mpext && mpext->use_ack) {
 		ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
 =

-		/* Add kind/length/subtype/flag overhead if mapping not populated */
+		/* Add kind/lenght/subtype/flag overhead if mapping is not
+		 * populated
+		 */
 		if (dss_size =3D=3D 0)
 			ack_size +=3D TCPOLEN_MPTCP_DSS_BASE;
 =

-- =

2.20.1


--===============4443961973834582850==--
