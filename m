Content-Type: multipart/mixed; boundary="===============7212620417488327944=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: fix compilation warning without IPV6
Date: Thu, 19 Mar 2020 10:05:02 +0100
Message-ID: <20200319090502.2275907-2-matthieu.baerts@tessares.net>
In-Reply-To: 20200319090502.2275907-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3989

--===============7212620417488327944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

  net/mptcp/options.c:553:12: warning: =E2=80=98add_addr6_generate_hmac=E2=
=80=99 defined but not used [-Wunused-function]
    553 | static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
        |            ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 86d51566ce39 (mptcp: v1 ADD_ADDR changes: options and parsing)
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: Add ADD_ADDR handling"

 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 919f727cc7de..2cd61267133e 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -550,6 +550,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2, u=
8 addr_id,
 	return get_unaligned_be64(hmac);
 }
 =

+#if IS_ENABLED(CONFIG_MPTCP_IPV6)
 static u64 add_addr6_generate_hmac(u64 key1, u64 key2, u8 addr_id,
 				   struct in6_addr *addr)
 {
@@ -565,6 +566,7 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2, =
u8 addr_id,
 =

 	return get_unaligned_be64(hmac);
 }
+#endif
 =

 static bool mptcp_established_options_addr(struct sock *sk,
 					   unsigned int *size,
-- =

2.25.1

--===============7212620417488327944==--
