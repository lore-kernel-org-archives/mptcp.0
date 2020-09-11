Content-Type: multipart/mixed; boundary="===============5808997006866521516=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] Squash-to: "mptcp: allow picking different
 xmit subflows"
Date: Fri, 11 Sep 2020 19:40:28 +0200
Message-ID: <5acfec9d91567f606a7cad10ef425a80d9cb05bc.1599846013.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5824

--===============5808997006866521516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

unbreak 32 bits build avoid unsing '/' on 64 bits arguments.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e5ef7227c914..d848ade67a4a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1082,8 +1082,9 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 	struct subflow_send_info send_info[2];
 	struct mptcp_subflow_context *subflow;
 	int i, nr_active =3D 0;
-	int64_t ratio, pace;
 	struct sock *ssk;
+	u64 ratio;
+	u32 pace;
 =

 	sock_owned_by_me((struct sock *)msk);
 =

@@ -1128,7 +1129,8 @@ static struct sock *mptcp_subflow_get_send(struct mpt=
cp_sock *msk,
 		if (!pace)
 			continue;
 =

-		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;
+		ratio =3D div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
+				pace);
 		if (ratio < send_info[subflow->backup].ratio) {
 			send_info[subflow->backup].ssk =3D ssk;
 			send_info[subflow->backup].ratio =3D ratio;
-- =

2.26.2

--===============5808997006866521516==--
