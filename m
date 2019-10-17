Content-Type: multipart/mixed; boundary="===============8593864311036544387=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 1/4] mptcp: clear data_avail flag if rtx queue is empty
Date: Thu, 17 Oct 2019 11:00:36 +0200
Message-ID: <335fc8447d2827cf117c7a59cf27a9abe234cfa0.1571258477.git.pabeni@redhat.com>
In-Reply-To: cover.1571258477.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2200

--===============8593864311036544387==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Otherwise we can end-up busy polling in recvmsg()

Squash-to: "mptcp: Implement MPTCP receive path"
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/subflow.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 98c39909a68d..ec0c269d07df 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -430,10 +430,8 @@ bool mptcp_subflow_data_available(struct sock *sk)
 	}
 =

 	skb =3D skb_peek(&sk->sk_receive_queue);
-	if (!skb)
-		return false;
-
-	subflow->data_avail =3D tcp_sk(sk)->copied_seq < TCP_SKB_CB(skb)->end_seq;
+	subflow->data_avail =3D skb &&
+		       before(tcp_sk(sk)->copied_seq, TCP_SKB_CB(skb)->end_seq);
 	return subflow->data_avail;
 }
 =

-- =

2.21.0

--===============8593864311036544387==--
