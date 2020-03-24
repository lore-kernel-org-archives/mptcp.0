Content-Type: multipart/mixed; boundary="===============5956244575335272894=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/3] mptcp: fix "fn parameter not described" warning
Date: Tue, 24 Mar 2020 17:57:07 +0100
Message-ID: <20200324165709.2024557-2-matthieu.baerts@tessares.net>
In-Reply-To: 20200324165709.2024557-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4055

--===============5956244575335272894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Obtained with:

  $ make W=3D1 net/mptcp/token.o
  net/mptcp/token.c:153: warning: Function parameter or member 'token' not =
described in 'mptcp_token_get_sock'

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Add handling of incoming MP_JOIN requests"

 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index d0e0585fb2ff..129a5ad1bc35 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -142,7 +142,7 @@ int mptcp_token_new_accept(u32 token, struct sock *conn)
 =

 /**
  * mptcp_token_get_sock - retrieve mptcp connection sock using its token
- * @token - token of the mptcp connection to retrieve
+ * @token: token of the mptcp connection to retrieve
  *
  * This function returns the mptcp connection structure with the given tok=
en.
  * A reference count on the mptcp socket returned is taken.
-- =

2.25.1

--===============5956244575335272894==--
