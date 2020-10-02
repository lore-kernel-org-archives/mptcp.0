Content-Type: multipart/mixed; boundary="===============2314256480471052903=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] tcp: fix syn cookied MPTCP request socket leak
Date: Fri, 02 Oct 2020 12:39:44 +0200
Message-ID: <867cc806e4dfeb200e84b37addff2e2847f44c0e.1601635086.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6164

--===============2314256480471052903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a syn-cookies request socket don't pass MPTCP-level
validation done in syn_recv_sock(), we need to release
it immediately, or it will be leaked.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/89
Fixes: 9466a1ccebbe ("mptcp: enable JOIN requests even if cookies are in us=
e")
Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/ipv4/syncookies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index f0794f0232ba..e03756631541 100644
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

--===============2314256480471052903==--
