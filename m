Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB6173
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=2lEftx1f6zZRnabHis
	OW/+1xVPCYQBATtPKGQbN7Q4I=; b=MxCPygC9mIglCoRFtm9BTT2j1ctvTcytnk
	mFFA9WaJ1cdI4I7EydRUZCjvk9370zHiryA0RRi6I5PoEKmh4vkjLrBouB44/pbk
	tupr7Chtg3kTxq86s3sRfJJDRS1G1b/R8+0+8KS3f3Cq1PL/v8uOq0Eq58Sr8qPA
	460F7GAZA=
Received: from localhost.localdomain (unknown [110.80.1.45])
	by smtp11 (Coremail) with SMTP id D8CowAD325gTEsNgpvWXAA--.80S6;
	Fri, 11 Jun 2021 15:34:54 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com
Subject: [PATCH 4/4] mptcp: avoid processing packet if a subflow reset
Date: Fri, 11 Jun 2021 15:34:42 +0800
Message-Id: <1623396882-2748-5-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
References: <1623396882-2748-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:D8CowAD325gTEsNgpvWXAA--.80S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKr1UKry3Xr4xCr1DAwb_yoWDGFb_Jw
	n3t3y8Jr4SyayjkFW7GrW5AFZ5Z3yDGFWUGws2ga4UJw1UGa1vqrWDJF13Wr18C390ya45
	u3ZIka45KFn5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnzBTUUUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJx+ukF5u+r4UeAAAse
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

If check_fully_established() causes a subflow reset, it should not
continue to process the packet in tcp_data_queue().

setting:
	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;

so that the following check will drop the pkt in
tcp_data_queue():
  if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
	__kfree_skb(skb);
	return;
  }

Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1aec016..01a1bf6 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -926,6 +926,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	return true;
 
 reset:
+	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
+
 	mptcp_subflow_reset(ssk);
 	return false;
 }
-- 
1.8.3.1

