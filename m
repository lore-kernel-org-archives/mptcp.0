Content-Type: multipart/mixed; boundary="===============8032479409154363368=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/3] mptcp: fix "fn parameter not described" warnings
Date: Tue, 24 Mar 2020 17:57:08 +0100
Message-ID: <20200324165709.2024557-3-matthieu.baerts@tessares.net>
In-Reply-To: 20200324165709.2024557-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4057

--===============8032479409154363368==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Obtained with:

  $ make W=3D1 net/mptcp/token.o
  net/mptcp/token.c:53: warning: Function parameter or member 'req' not des=
cribed in 'mptcp_token_new_request'
  net/mptcp/token.c:98: warning: Function parameter or member 'sk' not desc=
ribed in 'mptcp_token_new_connect'
  net/mptcp/token.c:178: warning: Function parameter or member 'token' not =
described in 'mptcp_token_destroy_request'
  net/mptcp/token.c:191: warning: Function parameter or member 'token' not =
described in 'mptcp_token_destroy'

Fixes: 79c0949e9a09 (mptcp: Add key generation and token tree)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 net/mptcp/token.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 129a5ad1bc35..ed7dc73c80eb 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -40,7 +40,7 @@ static int token_used __read_mostly;
 =

 /**
  * mptcp_token_new_request - create new key/idsn/token for subflow_request
- * @req - the request socket
+ * @req: the request socket
  *
  * This function is called when a new mptcp connection is coming in.
  *
@@ -80,7 +80,7 @@ int mptcp_token_new_request(struct request_sock *req)
 =

 /**
  * mptcp_token_new_connect - create new key/idsn/token for subflow
- * @sk - the socket that will initiate a connection
+ * @sk: the socket that will initiate a connection
  *
  * This function is called when a new outgoing mptcp connection is
  * initiated.
@@ -169,7 +169,7 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 =

 /**
  * mptcp_token_destroy_request - remove mptcp connection/token
- * @token - token of mptcp connection to remove
+ * @token: token of mptcp connection to remove
  *
  * Remove not-yet-fully-established incoming connection identified
  * by @token.
@@ -183,7 +183,7 @@ void mptcp_token_destroy_request(u32 token)
 =

 /**
  * mptcp_token_destroy - remove mptcp connection/token
- * @token - token of mptcp connection to remove
+ * @token: token of mptcp connection to remove
  *
  * Remove the connection identified by @token.
  */
-- =

2.25.1

--===============8032479409154363368==--
