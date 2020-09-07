Content-Type: multipart/mixed; boundary="===============1118903338488673154=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: add ADD_ADDR related mibs"
Date: Mon, 07 Sep 2020 11:37:36 +0200
Message-ID: <0a4053db6ce391392514c394f83386ed75efa050.1599470677.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5744

--===============1118903338488673154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mptcp_incoming_options() can be called with either BH enabled or
disabled, so we need to use the safer MIB accounting helper
version.

This fixes isssue#86

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0d1ff621613c..171039cbe9c4 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -891,9 +891,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_=
buff *skb,
 #endif
 		if (!mp_opt.echo) {
 			mptcp_pm_add_addr_received(msk, &addr);
-			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 		} else {
-			__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 		}
 		mp_opt.add_addr =3D 0;
 	}
-- =

2.26.2

--===============1118903338488673154==--
