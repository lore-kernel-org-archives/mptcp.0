Content-Type: multipart/mixed; boundary="===============2697921450773158322=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp:pm: use mptcp_pm_init
Date: Tue, 15 Oct 2019 16:06:30 +0200
Message-ID: <20191015140630.15863-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2143

--===============2697921450773158322==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since e3c637f02e45 (mptcp: Minor changes to path manager interface),
mptcp_pm_init() is no longer declared in protocol.h but still declared
as non static in pm.c. I would propose here to continue to use it but
declare mptcp_basic_init() in mptcp_pm_init() to limit the modified .c
files for 'basic' features to pm.c only.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Add path manager interface"

 net/mptcp/protocol.c | 1 +
 net/mptcp/protocol.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cef22193035..00ab1e7674eb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1033,6 +1033,7 @@ void __init mptcp_init(void)
 	mptcp_stream_ops.shutdown =3D mptcp_shutdown;
 =

 	mptcp_subflow_init();
+	mptcp_pm_init();
 =

 	if (proto_register(&mptcp_prot, 1) !=3D 0)
 		panic("Failed to register MPTCP proto.\n");
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b3cb54efe724..b0ee4010c0c0 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -203,6 +203,7 @@ static inline void mptcp_crypto_key_gen_sha1(u64 *key, =
u32 *token, u64 *idsn)
 void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
 			    u32 *hash_out);
 =

+void mptcp_pm_init(void);
 void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
 void mptcp_pm_fully_established(struct mptcp_sock *msk);
 void mptcp_pm_connection_closed(struct mptcp_sock *msk);
-- =

2.20.1

--===============2697921450773158322==--
