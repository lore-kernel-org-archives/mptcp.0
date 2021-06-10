Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197372
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=6zT/M
	z1sAX6Rsz64XN/sNYz2aHX2u+vdBLDGi3DZAjM=; b=CZRGaYaqgRknyKApZ2viL
	z3gFZkr3udtsib8IZo3uddBEimC3z3GvTcgd+zKp2teZugyPip1ZeukHUSB7Xe9y
	8aHOaPDvwE2OGCFlYa7W8oA2tBA0pl7ux1n4gQVo5zedU+Cb8Ym4I7qtus9KlME4
	+cgB55nxYyMLPzqu03uoos=
Received: from [192.168.16.78] (unknown [110.80.1.45])
	by smtp7 (Coremail) with SMTP id C8CowAAnN39U28FgKPX1hA--.6051S2;
	Thu, 10 Jun 2021 17:28:52 +0800 (CST)
To: mptcp@lists.linux.dev
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2 4/4] mptcp: avoid processing packet if a subflow reset
Message-ID: <2a904c11-f78d-a493-2e4c-c5d320961ce1@163.com>
Date: Thu, 10 Jun 2021 17:28:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:C8CowAAnN39U28FgKPX1hA--.6051S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyrKr1UKry3Xr4xCr1DAwb_yoWfCFX_Jw
	1kt3y8Jr4SyayUKFW7GrW5AFZ5Z3yDWay8G3s2ga4UJ3WUGw4vqrWDJF13GF18C390yFy5
	u3ZIya45KFn5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUectxPUUUUU==
X-Originating-IP: [110.80.1.45]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiBStkFaD-P057wAAsj

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

