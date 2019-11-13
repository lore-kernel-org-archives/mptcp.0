Content-Type: multipart/mixed; boundary="===============1972521549582107774=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/8] mptcp: Add IPv6 support for MPTCP socket stubs
Date: Tue, 12 Nov 2019 22:45:11 -0800
Message-ID: <20191113064518.4823-2-peter.krystad@linux.intel.com>
In-Reply-To: 20191113064518.4823-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2492

--===============1972521549582107774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

squashto: Add MPTCP socket stubs

Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
---
 include/net/mptcp.h  | 10 ++++++++++
 net/ipv6/tcp_ipv6.c  |  7 +++++++
 net/mptcp/protocol.c | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 535b27f6ba03..cc173e5f7900 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -146,4 +146,14 @@ static inline bool mptcp_sk_is_subflow(const struct so=
ck *sk)
 }
 =

 #endif /* CONFIG_MPTCP */
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+int mptcpv6_init(void);
+#elif IS_ENABLED(CONFIG_IPV6)
+static inline int mptcpv6_init(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* __NET_MPTCP_H */
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index bae175b57e0f..bcc3bb89938d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2108,9 +2108,16 @@ int __init tcpv6_init(void)
 	ret =3D register_pernet_subsys(&tcpv6_net_ops);
 	if (ret)
 		goto out_tcpv6_protosw;
+
+	ret =3D mptcpv6_init();
+	if (ret)
+		goto out_tcpv6_pernet_subsys;
+
 out:
 	return ret;
 =

+out_tcpv6_pernet_subsys:
+	unregister_pernet_subsys(&tcpv6_net_ops);
 out_tcpv6_protosw:
 	inet6_unregister_protosw(&tcpv6_protosw);
 out_tcpv6_protocol:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 42b33ed6b870..aa8444c2dd71 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -963,3 +963,22 @@ void mptcp_proto_init(void)
 =

 	inet_register_protosw(&mptcp_protosw);
 }
+
+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
+static struct inet_protosw mptcp_v6_protosw =3D {
+	.type		=3D SOCK_STREAM,
+	.protocol	=3D IPPROTO_MPTCP,
+	.prot		=3D &mptcp_prot,
+	.ops		=3D &inet6_stream_ops,
+	.flags		=3D INET_PROTOSW_ICSK,
+};
+
+int mptcpv6_init(void)
+{
+	int err;
+
+	err =3D inet6_register_protosw(&mptcp_v6_protosw);
+
+	return err;
+}
+#endif
-- =

2.17.2

--===============1972521549582107774==--
