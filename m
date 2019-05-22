Content-Type: multipart/mixed; boundary="===============0921777520571432841=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp] net: mptcp: don't leak 'slab' and 'slab_name'
 on exit
Date: Wed, 22 May 2019 22:47:57 +0200
Message-ID: <6d0d38d80ff98b971af747a51f69bbb7748cf8dd.1558555611.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1221

--===============0921777520571432841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix leak of subflows' slab and slab_name in the (rare) case where
proto_register(mptcp_prot, 1) returns -ENOBUFS.

Fixes: e203b1359cf77 ("mptcp: Associate MPTCP context with TCP socket")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 net/mptcp/subflow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bc8e1a0658ec..f93c6d4d7172 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -318,6 +318,8 @@ int subflow_init(void)
 void subflow_exit(void)
 {
 	tcp_unregister_ulp(&subflow_ulp_ops);
+	kmem_cache_destroy(subflow_request_sock_ops.slab);
+	kfree(subflow_request_sock_ops.slab_name);
 }
 =

 MODULE_LICENSE("GPL");
-- =

2.20.1


--===============0921777520571432841==--
