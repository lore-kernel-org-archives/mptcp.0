Content-Type: multipart/mixed; boundary="===============7439315309124244279=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: don't leak msk in token container
Date: Wed, 10 Jun 2020 10:49:00 +0200
Message-ID: <f52cfae0ddacd91b37a804f19a6ffa2f79efe56f.1591778889.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4629

--===============7439315309124244279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a listening MPTCP socket has unaccepted sockets at close
time, the related msks are freed via mptcp_sock_destruct(),
which in turn does not invoke the proto->destroy() method
nor the mptcp_token_destroy() function.

Due to the above, the child msk socket is not removed from
the token container, leading to later UaF.

Address the issue explicitly removing the token even in the
above error path.

Fixes: 79c0949e9a09 ("mptcp: Add key generation and token tree")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 493b98a0825c..bf132575040d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -393,6 +393,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 =

+	mptcp_token_destroy(mptcp_sk(sk)->token);
 	inet_sock_destruct(sk);
 }
 =

-- =

2.21.3

--===============7439315309124244279==--
