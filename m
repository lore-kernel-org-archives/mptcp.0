Content-Type: multipart/mixed; boundary="===============2128958024706809627=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH mptcp-next] Squash to "mptcp: protect the rx
 path with the msk socket spinlock": a small cleanup
Date: Mon, 23 Nov 2020 11:13:40 +0800
Message-ID: <f34d3d0783b1daa26e3491ffb92a4b5096db76df.1606101185.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6890

--===============2128958024706809627==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since the local variable sk is defined, use it instead of open-coding.

Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e4bb41c02cc4..4a6e485dd22a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1869,7 +1869,7 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk,=
 unsigned int rcv)
 		mptcp_data_unlock(sk);
 	}
 	if (ret)
-		mptcp_check_data_fin((struct sock *)msk);
+		mptcp_check_data_fin(sk);
 	return !skb_queue_empty(&msk->receive_queue);
 }
 =

-- =

2.26.2

--===============2128958024706809627==--
