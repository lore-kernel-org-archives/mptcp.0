Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA632FB8
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=c/hCVgBOvIQfNVAKDP
	4lvnA3f4Imf9aWnlkAZ8XFl68=; b=nKo7c0UxwClJncaO2wpdRi17mHNUzKOO16
	0x3hu98UZnt5D3FWQYDKaIi96und4UqAsvhNyrHOnoUKgaPMgriZDDIzbahSlPmt
	OP1PFy7BWR4028esBV5zsvrxyk1IFAL0KCyZznLr2uXq2Lg6lTa8x5fWJEdjfS9s
	D1DbrdUkY=
Received: from localhost.localdomain (unknown [110.80.1.45])
	by smtp11 (Coremail) with SMTP id D8CowAD325gTEsNgpvWXAA--.80S4;
	Fri, 11 Jun 2021 15:34:54 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com
Subject: [PATCH 2/4] mptcp: remove redundant req destruct in subflow_check_req()
Date: Fri, 11 Jun 2021 15:34:40 +0800
Message-Id: <1623396882-2748-3-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
References: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:D8CowAD325gTEsNgpvWXAA--.80S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4Dtw47WFWrtryktF4ktFb_yoW8Gryfpr
	sxXw1YyrZxZFyakF4rJF4DZrn0gayFvFn8GFyY93sxJr4qqws3KF1UWr48uFy3Aa1kKay7
	GFsxtFnxX3ZF9aUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqFALUUUUU=
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNx6ukFWBkxL-pQAAsY
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

