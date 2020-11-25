Content-Type: multipart/mixed; boundary="===============1322525854963042446=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/3] mptcp: hold mptcp socket before
 calling tcp_done
Date: Wed, 25 Nov 2020 18:49:54 +0100
Message-ID: <20201125174956.9222-2-fw@strlen.de>
In-Reply-To: 20201125174956.9222-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6932

--===============1322525854963042446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When processing options from tcp reset path its possible that
tcp_done(ssk) drops the last reference on the mptcp socket which
results in use-after-free.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/subflow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b6cd42649e5d..ca8db7ae51f0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -276,12 +276,17 @@ void mptcp_subflow_reset(struct sock *ssk)
 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
 	struct sock *sk =3D subflow->conn;
 =

+	/* must hold: tcp_done() could drop last reference on parent */
+	sock_hold(sk);
+
 	tcp_set_state(ssk, TCP_CLOSE);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
 	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+		return; /* worker will put sk for us */
+
+	sock_put(sk);
 }
 =

 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *=
skb)
-- =

2.26.2

--===============1322525854963042446==--
