Content-Type: multipart/mixed; boundary="===============2012038779878918118=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 1/4 1/1] mptcp: move mp_capable initialization at
 subflow_init_req() start
Date: Thu, 14 Nov 2019 19:15:49 +0100
Message-ID: <f4be8cf169b84a4170a9d67d5ac0c8a9fcfd6604.1573738652.git.pabeni@redhat.com>
In-Reply-To: cover.1573738652.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2545

--===============2012038779878918118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will avoid moving the code in later patch and makes disabling
with md5 easier

Squash-to: "mptcp: Create SUBFLOW socket for incoming connections"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 4a440420d9f2..c21a12600ab7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -31,6 +31,8 @@ static void subflow_init_req(struct request_sock *req,
 	memset(&rx_opt.mptcp, 0, sizeof(rx_opt.mptcp));
 	mptcp_get_options(skb, &rx_opt);
 =

+	subflow_req->mp_capable =3D 0;
+
 	if (rx_opt.mptcp.mp_capable && listener->request_mptcp) {
 		subflow_req->mp_capable =3D 1;
 		if (rx_opt.mptcp.version >=3D listener->request_version)
@@ -38,8 +40,6 @@ static void subflow_init_req(struct request_sock *req,
 		else
 			subflow_req->version =3D rx_opt.mptcp.version;
 		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
-	} else {
-		subflow_req->mp_capable =3D 0;
 	}
 }
 =

-- =

2.21.0

--===============2012038779878918118==--
