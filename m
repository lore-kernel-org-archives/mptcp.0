Content-Type: multipart/mixed; boundary="===============7619145272795687443=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/16] mptcp: fix checkpatch issues
Date: Sat, 15 Jun 2019 12:52:47 +0200
Message-ID: <20190615105259.15151-5-matthieu.baerts@tessares.net>
In-Reply-To: 20190615105259.15151-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1389

--===============7619145272795687443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

What has been fixed:

 - Alignment should match open parenthesis (2)
 - "foo* bar" should be "foo *bar" (3)

What has not been fixed:

 - /

Fixes: 56a31199744c (mptcp: Handle MP_CAPABLE options for outgoing connecti=
ons)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 include/net/mptcp.h | 6 +++---
 net/mptcp/options.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 0ca51497328b..5c511f52e8e6 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -33,10 +33,10 @@ static inline bool sk_is_mptcp(const struct sock *sk)
 void mptcp_parse_option(const unsigned char *ptr, int opsize,
 			struct tcp_options_received *opt_rx);
 bool mptcp_syn_options(struct sock *sk, unsigned int *size,
-			       struct mptcp_out_options* opts);
+		       struct mptcp_out_options *opts);
 void mptcp_rcv_synsent(struct sock *sk);
 bool mptcp_established_options(struct sock *sk, unsigned int *size,
-				       struct mptcp_out_options *opts);
+			       struct mptcp_out_options *opts);
 =

 void mptcp_write_options(__be32 *ptr, struct mptcp_out_options *opts);
 =

@@ -57,7 +57,7 @@ static inline void mptcp_parse_option(const unsigned char=
 *ptr, int opsize,
 }
 =

 static inline bool mptcp_syn_options(struct sock *sk, unsigned int *size,
-				     struct mptcp_out_options* opts)
+				     struct mptcp_out_optionsi *opts)
 {
 	return false;
 }
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2d3d1835183e..4ba908f1d9e8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -123,7 +123,7 @@ void mptcp_parse_option(const unsigned char *ptr, int o=
psize,
 }
 =

 bool mptcp_syn_options(struct sock *sk, unsigned int *size,
-		       struct mptcp_out_options* opts)
+		       struct mptcp_out_options *opts)
 {
 	struct subflow_context *subflow =3D subflow_ctx(sk);
 =

-- =

2.20.1


--===============7619145272795687443==--
