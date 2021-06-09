Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A67572
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 10:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=gr6UZ
	O8Kqq6v5bH9aldoGcR6P0c8vdvxDX2WzwHE6+Y=; b=LY+fRUU6uBrsYV0PimLe0
	th2W4PeZj6f5CIQ43xweu3yvMPQNFUc0bRKa21gMvEyRgD+ND7RfoUoY/4WtVq6V
	/PhPuspGuC1aVMgetvUm5mw7ZNg2r/CtF13RccmPmzYRxnbOHtrKTg338Xu9KTUt
	cHK2YvGxpMpADwR8WD71+Q=
Received: from [192.168.16.78] (unknown [110.86.5.93])
	by smtp8 (Coremail) with SMTP id DMCowAA3MPx9msBgLj+xIw--.5305S2;
	Wed, 09 Jun 2021 18:39:58 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH 3/3] mptcp: fix syncookie process if mptcp can not_accept new
 subflow
Message-ID: <1034de3d-5528-ea65-6deb-8a67955f1042@163.com>
Date: Wed, 9 Jun 2021 18:39:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DMCowAA3MPx9msBgLj+xIw--.5305S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrJFW3Kr1rCFW5GF45Wrg_yoW5tw1rpF
	4UJr4xtrn3AFyfGaySyF4DXr1agrZYyrZxJw4jk347Awn8ursagry8KF1IgFWxCFs3GFy5
	tr40qa1qvFnrCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b189_UUUUU=
X-Originating-IP: [110.86.5.93]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+BaskF2MZMPdtQAAsM

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side when doing stress testing.
There are at least two cases may trigger this warning:
1. mptcp is in syncookie, and server recv MP_JOIN SYN request, in subflow_check_req(),
   the mptcp_can_accept_new_subflow() return false, so subflow_init_req_cookie_join_save()
   isn't called, i.e. not store the data present in the MP_JOIN syn request and the random
   nonce in hash table - join_entries[], but still send synack. When recv 3rd-ack,
   mptcp_token_join_cookie_init_state() will return false, and 3rd-ack is dropped, then if mptcp
   conn is closed by client, client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN doesn't have
   MP_CAPABLE or MP_JOIN, so mptcp_subflow_init_cookie_req() will return 0, and pass the cookie check,
   MP_JOIN request is fallback to normal TCP. Server will send a TCP FIN if closed, in client side,
   when process TCP FIN, it will do reset, the code path is:
     tcp_data_queue()->mptcp_incoming_options()->check_fully_established()->mptcp_subflow_reset().
   mptcp_subflow_reset() will set sock state to TCP_CLOSE, so tcp_fin will hit TCP_CLOSE, and print the warning.
2. mptcp is in syncookie, and server recv 3rd-ack, in mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
   return false, and subflow_req->mp_join is not set to 1, so in subflow_syn_recv_sock() will not reset the MP_JOIN
   subflow, but fallback to normal TCP, and then the same thing happens when server will send a TCP FIN if closed.

For case1, subflow_check_req() return -EPERM, then tcp_conn_request() will drop MP_JOIN SYN.
For case2, let subflow_syn_recv_sock() do mptcp_can_accept_new_subflow() check, and do fatal fallback, send reset.
And do sanity check in tcp_data_queue().

Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/ipv4/tcp_input.c | 7 ++++++-
 net/mptcp/subflow.c  | 6 +++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7d5e59f..537f24a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4941,8 +4941,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 	int eaten;

-	if (sk_is_mptcp(sk))
+	if (sk_is_mptcp(sk)) {
 		mptcp_incoming_options(sk, skb);
+		if (sk->sk_state == TCP_CLOSE) {
+			__kfree_skb(skb);
+			return;
+		}
+	}

 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
 		__kfree_skb(skb);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 75ed530..6d98e19 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -224,6 +224,8 @@ static int subflow_check_req(struct request_sock *req,
 		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
+			else
+				return -EPERM;
 		}

 		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
@@ -263,9 +265,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 		if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
 			return -EINVAL;

-		if (mptcp_can_accept_new_subflow(subflow_req->msk))
-			subflow_req->mp_join = 1;
-
+		subflow_req->mp_join = 1;
 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq - 1;
 	}

-- 
1.8.3.1

