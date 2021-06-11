Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50055173
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=iyRuSN4ZPsQ0Nb6yc5
	jhGaB5VFkg4g2CWpoz+5gGUlA=; b=N/2UTCJbpqBb9nQUkZtmR6lIs7DNwXcDKd
	GtCf/Afy5DKCjr6uPii8FE0QxyveFzX7JI74cjtTG3QnN4H3HRhiuokB85pX6ubL
	ZMxv6lrPxb7MHsij3f7VYIMftoboch6av8A8B797JJko8Kay5mCgpsrg2R7KqY0r
	TSm/TkMHc=
Received: from localhost.localdomain (unknown [110.80.1.45])
	by smtp11 (Coremail) with SMTP id D8CowAD325gTEsNgpvWXAA--.80S5;
	Fri, 11 Jun 2021 15:34:54 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com
Subject: [PATCH 3/4] mptcp: fix syncookie process if mptcp can not_accept new subflow
Date: Fri, 11 Jun 2021 15:34:41 +0800
Message-Id: <1623396882-2748-4-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
References: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:D8CowAD325gTEsNgpvWXAA--.80S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrJFW3Kr1rCFW5GF45Wrg_yoW5Ww13pr
	4UXrWxtr1fJFy3GF4ftr4DZw1UWFZYyrZxJa15K347Awn8Zws3Kry8KF1xKryxCFs7Ga45
	Xr4vq3WqvFnrCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWT5dUUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9waukF2MZNtbQQAAs7
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side
when doing stress testing.

There are at least two cases may trigger this warning:
1.mptcp is in syncookie, and server recv MP_JOIN SYN request,
  in subflow_check_req(), the mptcp_can_accept_new_subflow()
  return false, so subflow_init_req_cookie_join_save() isn't
  called, i.e. not store the data present in the MP_JOIN syn
  request and the random nonce in hash table - join_entries[],
  but still send synack. When recv 3rd-ack,
  mptcp_token_join_cookie_init_state() will return false, and
  3rd-ack is dropped, then if mptcp conn is closed by client,
  client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN
  doesn't have MP_CAPABLE or MP_JOIN,
  so mptcp_subflow_init_cookie_req() will return 0, and pass
  the cookie check, MP_JOIN request is fallback to normal TCP.
  Server will send a TCP FIN if closed, in client side,
  when process TCP FIN, it will do reset, the code path is:
    tcp_data_queue()->mptcp_incoming_options()
      ->check_fully_established()->mptcp_subflow_reset().
  mptcp_subflow_reset() will set sock state to TCP_CLOSE,
  so tcp_fin will hit TCP_CLOSE, and print the warning.
2.mptcp is in syncookie, and server recv 3rd-ack, in
  mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
  return false, and subflow_req->mp_join is not set to 1,
  so in subflow_syn_recv_sock() will not reset the MP_JOIN
  subflow, but fallback to normal TCP, and then the same thing
  happens when server will send a TCP FIN if closed.

For case1, subflow_check_req() return -EPERM,
then tcp_conn_request() will drop MP_JOIN SYN.

For case2, let subflow_syn_recv_sock() call mptcp_can_accept_new_subflow(),
and do fatal fallback, send reset.

Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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

