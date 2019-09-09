Content-Type: multipart/mixed; boundary="===============1483264639519597522=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 4/6] mptcp: enable must_wake_parent helper
Date: Mon, 09 Sep 2019 17:53:16 +0200
Message-ID: <20190909155317.31119-5-fw@strlen.de>
In-Reply-To: 20190909155317.31119-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1803

--===============1483264639519597522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If task calls poll(), wait on mptcp wait queue before
the subflow wait lists.

Followup patch will remove subflow wait list placement entirely.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 071260f4f0b8..2a91fff1f385 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -406,6 +406,9 @@ bool mptcp_must_wake_parent(struct subflow_context *sub=
flow)
 	if (state !=3D TCP_ESTABLISHED)
 		return true;
 =

+	if (WARN_ON_ONCE(!tcp_sk(ssk)->is_mptcp))
+		return true;
+
 	sock_owned_by_me((const struct sock *)ssk);
 =

 	for (;;) {
@@ -458,6 +461,8 @@ bool mptcp_must_wake_parent(struct subflow_context *sub=
flow)
 		} else {
 			ack_seq =3D get_mapped_dsn(subflow);
 =

+			WARN_ON_ONCE(!subflow->map_valid);
+
 			if (before64(ack_seq, old_ack)) {
 				/* Mapping covers data already received,
 				 * discard data in the current mapping
@@ -1170,6 +1175,9 @@ static __poll_t mptcp_poll(struct file *file, struct =
socket *sock,
 		return ret;
 	}
 =

+	sock_owned_by_me((const struct sock *)msk);
+	sock_poll_wait(file, sock, wait);
+
 	mptcp_for_each_subflow(msk, subflow) {
 		struct socket *tcp_sock;
 =

-- =

2.21.0


--===============1483264639519597522==--
