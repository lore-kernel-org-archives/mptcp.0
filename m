Content-Type: multipart/mixed; boundary="===============3368940769919458882=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-net-next 04/14] mptcp: Use mptcp_can_new_subflow
 where possible
Date: Thu, 03 May 2018 14:04:48 -0700
Message-ID: <20180503210458.21524-5-cpaasch@apple.com>
In-Reply-To: 20180503210458.21524-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 616

--===============3368940769919458882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let's reuse the function instead of implementing the same checks again.

Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 068ba20e4137fc430004d740efda4978f8e26150)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/mptcp/mptcp_input.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
index f3a4dbe45bc6..ba9e3fe62824 100644
--- a/net/mptcp/mptcp_input.c
+++ b/net/mptcp/mptcp_input.c
@@ -1171,7 +1171,7 @@ int mptcp_lookup_join(struct sk_buff *skb, struct ine=
t_timewait_sock *tw)
 	}
 =

 	mpcb =3D tcp_sk(meta_sk)->mpcb;
-	if (mpcb->infinite_mapping_rcv || mpcb->send_infinite_mapping) {
+	if (!mptcp_can_new_subflow(meta_sk)) {
 		/* We are in fallback-mode on the reception-side -
 		 * no new subflows!
 		 */
@@ -1255,9 +1255,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
 	 * And the send-reset will try to take yet another one (ip_send_reply).
 	 * Thus, we propagate the reset up to tcp_rcv_state_process.
 	 */
-	if (tcp_sk(meta_sk)->mpcb->infinite_mapping_rcv ||
-	    tcp_sk(meta_sk)->mpcb->send_infinite_mapping ||
-	    meta_sk->sk_state =3D=3D TCP_CLOSE || !tcp_sk(meta_sk)->inside_tk_tab=
le) {
+	if (!mptcp_can_new_subflow(meta_sk)) {
 		MPTCP_INC_STATS(sock_net(meta_sk), MPTCP_MIB_JOINFALLBACK);
 		bh_unlock_sock(meta_sk);
 		sock_put(meta_sk); /* Taken by mptcp_hash_find */
-- =

2.16.2


--===============3368940769919458882==--
