Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A036D0F
	for <mptcp@lists.linux.dev>; Sat, 26 Jun 2021 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=oVwxxQqg9LgPACKg5H
	RT/dVdDa8LWQi6BWHlU87hNPY=; b=VtcOzVv2Vsb1s3ZdXV5aOG8eSpl8qKhqd0
	LvHpIasWTHxUkBEeIfxLg6tW2a76S88mwfBRQpuNwTqdCSDKoEgPAxdCfLfJRaR8
	g/rMFyDiDqTTHA5NRtGKBpFRF9yBoI5xgRy6Ic86zkBRdRQQcr1b+vkJnEhO9lcl
	RO/8YtLpE=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAD3_dV38NZgettArg--.471S4;
	Sat, 26 Jun 2021 17:16:42 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v8 2/5] mptcp: remove redundant req destruct in subflow_check_req()
Date: Sat, 26 Jun 2021 17:16:35 +0800
Message-Id: <1624698998-9029-3-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EsCowAD3_dV38NZgettArg--.471S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8Gryfpr
	sxXw1FyrZxZFyakF4rJr4DZrn0gayFvFn5GFyY9asxJr4qqws3KF1UWr4UuFy3Aa1kKay7
	GF43tFnxX3Wq9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jIlksUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiBq9kFaD-bx+nQABsJ
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

In subflow_check_req(), if subflow sport is mismatch, will put msk,
destroy token, and destruct req, then return -EPERM, which can be
done by subflow_req_destructor() via:
  tcp_conn_request()
    |--__reqsk_free()
      |--subflow_req_destructor()
So we should remove these redundant code, otherwise will call
tcp_v4_reqsk_destructor() twice, and may double free inet_rsk(req)->ireq_opt.

Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/subflow.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0b5d4a3..3a849fb 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -214,11 +214,6 @@ static int subflow_check_req(struct request_sock *req,
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


