Content-Type: multipart/mixed; boundary="===============6405900873222214631=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 8/12] Squash-to: "mptcp: increment MIB counters in
 a few places"
Date: Thu, 05 Mar 2020 15:46:45 +0100
Message-ID: <40c76b96ceffa7226cd5b870b23a75bba4196984.1583418573.git.pabeni@redhat.com>
In-Reply-To: cover.1583418571.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3880

--===============6405900873222214631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

incremente the newly introduced counters

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 639f3d6ac9dc..201a695a792b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -252,6 +252,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 			goto do_reset;
 =

 		subflow->conn_finished =3D 1;
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 	} else {
 do_reset:
 		tcp_send_active_reset(sk, GFP_ATOMIC);
@@ -374,8 +375,10 @@ static struct sock *subflow_syn_recv_sock(const struct=
 sock *sk,
 		opt_rx.mptcp.mp_join =3D 0;
 		mptcp_get_options(skb, &opt_rx);
 		if (!opt_rx.mptcp.mp_join ||
-		    !subflow_hmac_valid(req, &opt_rx))
+		    !subflow_hmac_valid(req, &opt_rx)) {
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			return NULL;
+		}
 	}
 =

 create_child:
@@ -407,6 +410,8 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			ctx->conn =3D (struct sock *)owner;
 			if (!mptcp_finish_join(child))
 				goto close_child;
+
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
 		}
 	}
 =

-- =

2.21.1

--===============6405900873222214631==--
