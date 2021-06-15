Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6216D0F
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 03:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=VG0BY/E1lK8HpG+FXe
	reCNy97cpYe1S90xEEBp3PDyA=; b=Jfq1AgdcE1hCzzGb+v5DYTiXt1gWPgUOYX
	xNqtOEsfhe5DK7b55HogHkD+ngCbmRTWMsUpc4mz87DptWNPFnc8ROKuvmV5QC7V
	Vw8r5BJk7z3iYXOHaDDrxKLrqYn7KyyGFLyZbrIkL0Fa3wUrmeKrI0C+rb50xVih
	ja79jczB0=
Received: from localhost.localdomain.localdomain (unknown [110.80.1.45])
	by smtp10 (Coremail) with SMTP id DsCowAC3_2NMGMhgphfqOw--.24172S6;
	Tue, 15 Jun 2021 11:02:38 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v4 4/4] mptcp: avoid processing packet if a subflow reset
Date: Tue, 15 Jun 2021 11:02:26 +0800
Message-Id: <1623726146-5911-5-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
References: <1623726146-5911-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:DsCowAC3_2NMGMhgphfqOw--.24172S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKr1UKry3Xr4xCr1DAwb_yoWDXFb_Jw
	n3t3y8Xr4SyayjkFW7GrW5AFZ5Z3yDGayUGws2gay7Jw1UGa1vqrWkJF13WF18C390ka45
	u3ZIka45KFn5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0BBT5UUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9w6ykF2MZQbyIAABs6
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
index 1aec01686c1a..01a1bf60b187 100644
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

