Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990D02FB2
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=iyRuS
	N4ZPsQ0Nb6yc5jhGaB5VFkg4g2CWpoz+5gGUlA=; b=FitqSmYYfKTIHK7t5ceux
	HvdbiE6NTA1eFXvzbXiah2JcssvwCHFg51IQSHF1moIP/yKL3t7aOMlW/s86RDFC
	9oavUiBgruQzVcIVkp4k6f6gbE87UPxq9n0AINlUkP05n0q5dl/G8EFsRUfLNsmO
	f+Jnw7SRCgoNEoMLCw3ric=
Received: from [192.168.16.78] (unknown [110.80.1.45])
	by smtp7 (Coremail) with SMTP id C8CowAA3Rn5P28FgD_P1hA--.24252S2;
	Thu, 10 Jun 2021 17:28:48 +0800 (CST)
To: mptcp@lists.linux.dev
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2 3/4] mptcp: fix syncookie process if mptcp can not_accept
 new subflow
Message-ID: <a8f8ebd3-51eb-b4c2-451b-6646639d0c20@163.com>
Date: Thu, 10 Jun 2021 17:28:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowAA3Rn5P28FgD_P1hA--.24252S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrJFW3Kr1rCFW5GF45Wrg_yoW5Ww13pr
	4UXrWxtr1fJFy3GF4ftr4DZw1UWFZYyrZxJa15K347Awn8Zws3Kry8KF1xKryxCFs7Ga45
	Xr4vq3WqvFnrCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jC5l8UUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+ACtkF2MZNDPXgAAsx

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

