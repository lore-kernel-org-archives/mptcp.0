Content-Type: multipart/mixed; boundary="===============3146285219566994587=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net] mptcp: fix race in msk status update
Date: Fri, 24 Apr 2020 13:15:21 +0200
Message-ID: <4d5e3c09ca38a0a3ec951fa4f5bfc65d5cd40129.1587725562.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4238

--===============3146285219566994587==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently subflow_finish_connect() changes unconditionally
any msk socket status other than TCP_ESTABLISHED.

If an unblocking connect() races with close(), we can end-up
triggering:

IPv4: Attempt to release TCP socket in state 1 00000000e32b8b7e

when the msk socket is disposed.

Be sure to enter the established status only from SYN_SENT.

Fixes: c3c123d16c0e ("net: mptcp: don't hang in mptcp_sendmsg() after TCP f=
allback")
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
Note: the issue is possibly older, but this fix applies only
on the mentioned commit
---
 net/mptcp/subflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 87c094702d63..2488e011048c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -225,7 +225,7 @@ static void subflow_finish_connect(struct sock *sk, con=
st struct sk_buff *skb)
 =

 	subflow->icsk_af_ops->sk_rx_dst_set(sk, skb);
 =

-	if (inet_sk_state_load(parent) !=3D TCP_ESTABLISHED) {
+	if (inet_sk_state_load(parent) =3D=3D TCP_SYN_SENT) {
 		inet_sk_state_store(parent, TCP_ESTABLISHED);
 		parent->sk_state_change(parent);
 	}
-- =

2.21.1

--===============3146285219566994587==--
