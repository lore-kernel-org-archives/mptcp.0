Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36EF2FAE
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 10:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=NlxZ4LjKhbE6K+Zwzy
	+Du1mrx+RNqn9miuRvV8pYLDI=; b=nsZFCJzna5SspahstZhpDgB7rwZe87EmiW
	CXW3Gi76GokYL3cRzvSTVXyBKwhDvRfLfHdC+PUR8hHEDe+m+uncYWI/whyqz0D7
	lNQ4Xiq/kNnwzUC7UcbB0sL0DFsqGVQdueIpHvlSABx7Av6jIkbDrgjQ51tCSWlr
	B1GBgNNVY=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp11 (Coremail) with SMTP id D8CowAB33vY718lgxTs1AA--.106S6;
	Wed, 16 Jun 2021 18:50:35 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	fw@strlen.de
Subject: [PATCH v5 4/4] mptcp: avoid processing packet if a subflow reset
Date: Wed, 16 Jun 2021 18:49:30 +0800
Message-Id: <1623840570-42004-5-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:D8CowAB33vY718lgxTs1AA--.106S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKr1UKry3Xr4xCr1DAwb_yoWkuFc_Jw
	n3t3y8XFsayayUKFWUGrW5AFWrW39rGFyUWwnFga47t34UGa1vqrWkJF13uF18C390yFy5
	u3Z0ka45tFn5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnjQ6JUUUUU==
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNxuzkFWBk1APngAAsJ
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
 net/mptcp/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1aec01686c1a..be435c5421cd 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -926,6 +926,12 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	return true;
 
 reset:
+	/* If a subflow is reset, the packet should not continue to be
+	 * processed in tcp_data_queue(), so setting: end_seq = seq,
+	 * then tcp_data_queue() will drop the packet.
+	 */
+	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;
+
 	mptcp_subflow_reset(ssk);
 	return false;
 }
-- 
1.8.3.1

