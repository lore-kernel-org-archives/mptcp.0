Content-Type: multipart/mixed; boundary="===============5725825676615302945=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2] tcp: fix syn cookied MPTCP request socket leak
Date: Thu, 01 Oct 2020 18:30:50 +0200
Message-ID: <3f4d9db3da99e2175cd2c071b53e4d380c8e9821.1601569789.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6143

--===============5725825676615302945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a syn-cookies request socket don't pass MPTCP-level
validation done in syn_recv_sock(), we need to release
it immediatelly, or it will be leaked.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in us=
e")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
--
Note: I still see some mptcp_join.sh self-tests failures, but
 I can observe them with and without this patch
v1 -> v2:
 - preserve rxhash/toffset
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index c375c126f436..6ac473b47f30 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -214,7 +214,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struc=
t sk_buff *skb,
 		sock_rps_save_rxhash(child, skb);
 =

 		if (rsk_drop_req(req)) {
-			refcount_set(&req->rsk_refcnt, 2);
+			reqsk_put(req);
 			return child;
 		}
 =

-- =

2.26.2

--===============5725825676615302945==--
