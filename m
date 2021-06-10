Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBEA72
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=YFxUK
	P5fEEmYWeV0Hcy6CGbOw+jLSo/aT6C2UWA5cMA=; b=gf4og5x5byRqgKevs2P78
	dXedaCSAiGQMlzF2EZy0i5No0nlHf9OXyq/tBCjXFr/D8O/43B/ShwdBDDrw49Ag
	GSIfyxiQR1pxsCPXA9P1xxcWW+sAGemFAWxS2EABU+lxWwdFjGItfOH1txjg14vR
	/RtrSguhTTDyKXmicJPna8=
Received: from [192.168.16.78] (unknown [110.86.5.93])
	by smtp7 (Coremail) with SMTP id C8CowAAXA4tL28FgBPH1hA--.23962S2;
	Thu, 10 Jun 2021 17:28:43 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2 2/4] mptcp: remove redundant req destruct in
 subflow_check_req()
Message-ID: <cb701eba-c825-2861-d4d2-a8ac5a120eaf@163.com>
Date: Thu, 10 Jun 2021 17:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowAAXA4tL28FgBPH1hA--.23962S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8Gryfpr
	sxXw1YyrZxZFyakF4rJF4DZrn0gayFvFn8GFyY93sxJr4qqws3KF1UWr48uFy3Aa1kKay7
	GFsxtFnxX3ZF9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j_db8UUUUU=
X-Originating-IP: [110.86.5.93]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQGtkFWBTQ8RgAABsr

From: Jianguo Wu <wujianguo@chinatelecom.cn>

In subflow_check_req(), if subflow sport is mismatch, will put msk,
destroy token, and destruct req, then return -EPERM, which can be
done by subflow_req_destructor() via:
  tcp_conn_request()
    |--__reqsk_free()
      |--subflow_req_destructor()
So we should remove these redundant code, otherwise will call tcp_v4_reqsk_destructor()
twice, and may double free inet_rsk(req)->ireq_opt.

Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/subflow.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 6b1cd42..75ed530 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -213,11 +213,6 @@ static int subflow_check_req(struct request_sock *req,
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
 			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
-				sock_put((struct sock *)subflow_req->msk);
-				mptcp_token_destroy_request(req);
-				tcp_request_sock_ops.destructor(req);
-				subflow_req->msk = NULL;
-				subflow_req->mp_join = 0;
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				return -EPERM;
 			}
-- 
1.8.3.1

