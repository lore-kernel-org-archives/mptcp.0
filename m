Content-Type: multipart/mixed; boundary="===============1871921651534657179=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: introduce
 mptcp_schedule_work"
Date: Tue, 20 Oct 2020 16:52:38 +0200
Message-ID: <9c3c3b39b1f5c0eb3f1788ca84267ad838c0c59a.1603205529.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6366

--===============1871921651534657179==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let's add some comment to clarify the reference management,
as it already raised a few questions upstream

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0bff3aa08270..a32c27fe525c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -731,6 +731,10 @@ bool mptcp_schedule_work(struct sock *sk)
 {
 	if (inet_sk_state_load(sk) !=3D TCP_CLOSE &&
 	    schedule_work(&mptcp_sk(sk)->work)) {
+		/* each subflow already holds a reference to the sk, and
+		 * and the workqueue is invoked by a subflow, so sk can't
+		 * go away here.
+		 */
 		sock_hold(sk);
 		return true;
 	}
-- =

2.26.2

--===============1871921651534657179==--
