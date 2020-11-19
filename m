Content-Type: multipart/mixed; boundary="===============2056466019161331282=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: open code mptcp variant
 for lock_sock"
Date: Thu, 19 Nov 2020 22:56:29 +0100
Message-ID: <84985e126b6099383fd86edcc0b0f47ceba5df98.1605822960.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6850

--===============2056466019161331282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

deal with report from kernel test robot

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/net/sock.h   | 1 +
 net/mptcp/protocol.h | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1d29aeae74fd..86d074979ca0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1585,6 +1585,7 @@ static inline void lock_sock(struct sock *sk)
 	lock_sock_nested(sk, 0);
 }
 =

+void __lock_sock(struct sock *sk);
 void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 93aa60231632..1b50249138d2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -255,8 +255,6 @@ struct mptcp_sock {
 	} rcvq_space;
 };
 =

-void __lock_sock(struct sock *sk);
-
 #define mptcp_lock_sock(___sk, cb) do {					\
 	struct sock *__sk =3D (___sk); /* silence macro reuse warning */	\
 	might_sleep();							\
-- =

2.26.2

--===============2056466019161331282==--
