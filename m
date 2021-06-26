Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F53C6D00
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 09:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=mD97yaMOvV9ufafCWS
	zfkocaaSedpCOJd7JS5AND7A0=; b=OWGla9ZCsfS5MHz3yjqcIuQPo0nw06yypv
	M7gxEjVbFCrUh3OHpcKNRjeNlL9EjNMpFfj8Z5Sij725qALsDgiE1h1DCjs8HrA3
	GtHrIgRJGeqRu5jnxzdPTe1cpjUzYWEkP7PFeuYZ+Gz9YypsY3B6Zx6bXJhnTZ/J
	S1I3obChk=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAD3_dV38NZgettArg--.471S5;
	Sat, 26 Jun 2021 17:16:43 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v8 3/5] mptcp: fix syncookie process if mptcp can not_accept new subflow
Date: Sat, 26 Jun 2021 17:16:36 +0800
Message-Id: <1624698998-9029-4-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EsCowAD3_dV38NZgettArg--.471S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF43ur18GrW7XF18Kw43trb_yoW5Ar1rpr
	4UXrW7tr1fJFy3GFWftw4DZw1j9FZYyrZxJa15K347Awn8Zws3Kry8KFyI9ryxCFs7GFyY
	qrs2q3WqvFnrCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jWbytUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiBq9kFaD-bx+nQACsK
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side
when doing stress testing using wrk and webfsd.

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
index 3a849fb..f3f1358 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -225,6 +225,8 @@ static int subflow_check_req(struct request_sock *req,
 		if (unlikely(req->syncookie)) {
 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
 				subflow_init_req_cookie_join_save(subflow_req, skb);
+			else
+				return -EPERM;
 		}
 
 		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
@@ -264,9 +266,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
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


