Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B4A71
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 10:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=qxJPj
	aoYSUoVtMrm2B2r8o/MSaoYDYknQG404N24PJc=; b=TQBoRape30ZG7BMasjpyz
	woWoPo/elffmGnse7eD1yzlSocjMytOY8RkxXVI2ktgERf1RqFbFhBhIR7KK6h+9
	X2cjR3QLmcSQJGbR+SYkDJ7Irud+G8X+haEX0+2ENhtVZnTEcHltSpjWEOto1clt
	ZlATNooYxhuHcBK7N7Wp3s=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp14 (Coremail) with SMTP id EsCowAC3tYXoTYFg9doPfQ--.4435S2;
	Thu, 22 Apr 2021 18:20:24 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2 RESEND] mptcp: remove redundant initialization in
 pm_nl_init_net()
Message-ID: <2462aa3f-f72b-e31e-7a58-346ddc5ac546@163.com>
Date: Thu, 22 Apr 2021 18:20:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowAC3tYXoTYFg9doPfQ--.4435S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyxAw17ArWrWrW5tr4xWFg_yoWDAFX_uw
	1Sqay8GF1UJw4Ykr47Cr15ZFyru3y8XFyvv397Kay3K3s5Jw1DXrs5GF4fAr4xG34kA34D
	Cr1Ikry3AryfKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5iB_UUUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBiAh8kFaD+pz6rwAAsK

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Memory of struct pm_nl_pernet{} is allocated by kzalloc()
in setup_net()->ops_init(), so it's no need to reset counters
and zero bitmap in pm_nl_init_net().

Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ba0408..becc32b 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1913,10 +1913,12 @@ static int __net_init pm_nl_init_net(struct net *net)
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);

 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
-	__reset_counters(pernet);
 	pernet->next_id = 1;
-	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_lock_init(&pernet->lock);
+
+	/* No need to initialize other flieds of pernet, as all fields
+	 * are already initialized to 0 at allocation time.
+	 */
 	return 0;
 }

-- 
1.8.3.1

