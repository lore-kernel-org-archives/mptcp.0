Content-Type: multipart/mixed; boundary="===============3273631969668591500=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: add MPTCP socket diag interface"
Date: Tue, 07 Jul 2020 19:13:27 +0200
Message-ID: <20200707171327.180346-1-pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4936

--===============3273631969668591500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Davide reported build issues when compiling without
CONFIG_MPTCP_KUNIT_TESTS. We need to always export
mptcp_token_get_sock(), for diag's sake.

The following text should be inserted into the squash to
commit:
"""
Additionally export mptcp_token_get_sock(), as it
also will be used by the diag module.
"""

just before:
"""
It will be used by the next patch, but keep the API generic,
as we plan to use this later for PM's sake.
"""

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/token.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index 6d4fe70f7d30..7d8106026081 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -238,6 +238,7 @@ struct mptcp_sock *mptcp_token_get_sock(u32 token)
 	rcu_read_unlock();
 	return msk;
 }
+EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
 =

 /**
  * mptcp_token_iter_next - iterate over the token container from given pos
@@ -371,7 +372,6 @@ void __init mptcp_token_init(void)
 EXPORT_SYMBOL_GPL(mptcp_token_new_request);
 EXPORT_SYMBOL_GPL(mptcp_token_new_connect);
 EXPORT_SYMBOL_GPL(mptcp_token_accept);
-EXPORT_SYMBOL_GPL(mptcp_token_get_sock);
 EXPORT_SYMBOL_GPL(mptcp_token_destroy_request);
 EXPORT_SYMBOL_GPL(mptcp_token_destroy);
 #endif
-- =

2.18.1

--===============3273631969668591500==--
