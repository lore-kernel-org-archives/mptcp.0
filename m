Content-Type: multipart/mixed; boundary="===============4622312017835927357=="
MIME-Version: 1.0
From: Chen Wandun <chenwandun at huawei.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH next] mptcp: make the symbol 'mptcp_sk_clone_lock'
 static
Date: Mon, 10 Feb 2020 16:27:59 +0800
Message-ID: <20200210082759.12157-1-chenwandun@huawei.com>
X-Status: 
X-Keywords:                  
X-UID: 3605

--===============4622312017835927357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix the following sparse warning:
net/mptcp/protocol.c:646:13: warning: symbol 'mptcp_sk_clone_lock' was not =
declared. Should it be static?

Fixes: b0519de8b3f1 ("mptcp: fix use-after-free for ipv6")
Signed-off-by: Chen Wandun <chenwandun(a)huawei.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 73780b4cb108..030dee668e0a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -643,7 +643,7 @@ static struct ipv6_pinfo *mptcp_inet6_sk(const struct s=
ock *sk)
 }
 #endif
 =

-struct sock *mptcp_sk_clone_lock(const struct sock *sk)
+static struct sock *mptcp_sk_clone_lock(const struct sock *sk)
 {
 	struct sock *nsk =3D sk_clone_lock(sk, GFP_ATOMIC);
 =

-- =

2.17.1

--===============4622312017835927357==--
