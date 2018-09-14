Content-Type: multipart/mixed; boundary="===============6622561876341441214=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 16/20] mptcp: Reset sk_it to NULL as we keep on
 iterating
Date: Fri, 14 Sep 2018 10:25:20 -0700
Message-ID: <20180914172524.67961-19-cpaasch@apple.com>
In-Reply-To: 20180914172524.67961-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 740

--===============6622561876341441214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The loop relies on ending with sk_it set to NULL to decide whether or
not to send a RST.

As we changed the loop-iteration with commit 7a662b690069 ("mptcp: Make sub=
flow-list an RCU-list")
to rather loop on the mptcp_tcp_sock, we need to make sure that at each
iteration sk_it is set back to NULL.

Fixes: 7a662b690069 ("mptcp: Make subflow-list an RCU-list")
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 1696c1873d544ad4dab494bc7a380b30b1a64c44)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index 8a3f8dd764e6..45d7c9273bbe 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -371,6 +371,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
 			if (sk_it !=3D sk &&
 			    tcp_sk(sk_it)->mptcp->fully_established)
 				break;
+
+			sk_it =3D NULL;
 		}
 =

 		if (sk_it) {
-- =

2.16.2


--===============6622561876341441214==--
