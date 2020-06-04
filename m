Content-Type: multipart/mixed; boundary="===============4963300287625146631=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 3/4] mptcp: don't leak msk in token container
Date: Thu, 04 Jun 2020 19:40:05 +0200
Message-ID: <65f44ff773902fc1e7e2d03f8ae4b5632f1e2164.1591291903.git.pabeni@redhat.com>
In-Reply-To: cover.1591291903.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4589

--===============4963300287625146631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the left-over msk is freed by subflow_syn_recv_sock(),
we don't invoke the proto->destroy() method, to the socket
is not removed from the token container, leading to later
UaF.

Address the issue explicitly removing the token even in the
above error path.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
note:
 - the net patch will be slightly different, to cope with
   the token API changes introduced by the token refactor
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fcb9ca9a9dce..229ffff4b217 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -393,6 +393,7 @@ static void mptcp_sock_destruct(struct sock *sk)
 		sock_orphan(sk);
 	}
 =

+	mptcp_token_destroy(mptcp_sk(sk));
 	inet_sock_destruct(sk);
 }
 =

-- =

2.21.3

--===============4963300287625146631==--
