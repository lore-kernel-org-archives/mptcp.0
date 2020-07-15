Content-Type: multipart/mixed; boundary="===============1628247770724178308=="
MIME-Version: 1.0
From: YueHaibing <yuehaibing at huawei.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next] mptcp: Remove unused inline function
 mptcp_rcv_synsent()
Date: Wed, 15 Jul 2020 10:36:13 +0800
Message-ID: <20200715023613.9492-1-yuehaibing@huawei.com>
X-Status: 
X-Keywords:                  
X-UID: 5013

--===============1628247770724178308==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

commit 263e1201a2c3 ("mptcp: consolidate synack processing.")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing(a)huawei.com>
---
 include/net/mptcp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 46d0487d2b22..02158c257bd4 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -164,10 +164,6 @@ static inline bool mptcp_syn_options(struct sock *sk, =
const struct sk_buff *skb,
 	return false;
 }
 =

-static inline void mptcp_rcv_synsent(struct sock *sk)
-{
-}
-
 static inline bool mptcp_synack_options(const struct request_sock *req,
 					unsigned int *size,
 					struct mptcp_out_options *opts)
-- =

2.17.1


--===============1628247770724178308==--
