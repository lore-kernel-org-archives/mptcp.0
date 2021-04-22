Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34AF2F81
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 10:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=gNR5X
	LWqvfVJIpenf4WPy7981MxY6Dx+Of32jfA18Bs=; b=pe9vJdgUuhxh64EjMcY/0
	0bco2ymEUxXS9gwStx/5wj8pNgzmtkJpvotg3PAVRKtEN5QkzL16Z+eOCo8QF0Fs
	qeKl01TxHbLNY4Z/dsVB5nW52qzUtdwqgKp4NaFvfMObzYqZZLUGurIaYC5IAw4q
	21ZFqy+iXTNNTZZR1mfiFI=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp14 (Coremail) with SMTP id EsCowAAnIoI3UIFgQTgRfQ--.4472S2;
	Thu, 22 Apr 2021 18:30:16 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: geliangtang@gmail.com
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: create listening socket only if signal flag is set on
Message-ID: <bbe531db-6d59-d341-16ed-f48b1fd43d2a@163.com>
Date: Thu, 22 Apr 2021 18:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowAAnIoI3UIFgQTgRfQ--.4472S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWkKFW3tryfJF1xArykuFg_yoWfCwc_uF
	W0y3y5Wr4UZrs8Cw4UCr1rXFySv345X3WvgFn3ta9xGas5GrZ0gr1kJa4xuF17G3yqg345
	CFn5Kry3K3WfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYqii3UUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+BB8kF2MYnAMhwAAsM

From: Jianguo Wu <wujianguo@chinatelecom.cn>

PM announces address to remote host when signal flag is set,
so create listening socket only if signal flag is set.

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index becc32b..dbd6910 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1025,7 +1025,7 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *info)
 	}

 	*entry = addr;
-	if (entry->addr.port) {
+	if (entry->addr.port && (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		ret = mptcp_pm_nl_create_listen_socket(skb->sk, entry);
 		if (ret) {
 			GENL_SET_ERR_MSG(info, "create listen socket error");
-- 
1.8.3.1

