Received: from mail-m9763.mail.163.com (mail-m9763.mail.163.com [123.126.97.63])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A6570
	for <mptcp@lists.linux.dev>; Fri,  7 May 2021 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=4SFTd
	TWPbgsCBqK5UZfTp1lDoFeJS2zHdVxKADuD948=; b=R4+va4sP7xsbl7eoASAZe
	ujPYSQMFQHHeu5GfIB3P21ZYLL9ruX6uelfPpDxMkwTcqSzNs7Os5GpIsBoiVdHZ
	aCoQk6B6k2KwMly386kJsnEDfVaUhGkb9JnLgj5/TOIddMjRRHoKU+KyfjyfYQkt
	TtpbSDSrm9H2YI7W2VMeTQ=
Received: from [192.168.15.51] (unknown [110.87.83.139])
	by smtp8 (Coremail) with SMTP id DMCowADHFrsO9JRgBuf5Cg--.56046S2;
	Fri, 07 May 2021 16:02:22 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: generate subflow hmac after mptcp_finish_join()
Message-ID: <79d42988-47da-dc8b-8416-4d4e76510f08@163.com>
Date: Fri, 7 May 2021 16:02:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DMCowADHFrsO9JRgBuf5Cg--.56046S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF45tw48uFWDKF13uF4fGrg_yoWktrg_Gw
	1xJr9rXrW8Z342kr47XF13tasYk3ykX39rKrn3tF13Jw1rKa48XF1vyF1xuFnrCan8ur98
	Gan0y34UAr1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5GzuJUUUUU==
X-Originating-IP: [110.87.83.139]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiUQ+LkFWBTD1eHwAAsh

From: Jianguo Wu <wujianguo@chinatelecom.cn>

For outgoing subflow join, when recv SYNACK, in subflow_finish_connect(),
the mptcp_finish_join() may return false in some cases, and send a RESET
to remote, and no local hmac is required.
So generate subflow hmac after mptcp_finish_join().

Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests").
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/subflow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c896803..554e7cce 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -433,15 +433,15 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 			goto do_reset;
 		}

+		if (!mptcp_finish_join(sk))
+			goto do_reset;
+
 		subflow_generate_hmac(subflow->local_key, subflow->remote_key,
 				      subflow->local_nonce,
 				      subflow->remote_nonce,
 				      hmac);
 		memcpy(subflow->hmac, hmac, MPTCPOPT_HMAC_LEN);

-		if (!mptcp_finish_join(sk))
-			goto do_reset;
-
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);

-- 
1.8.3.1

