Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B771
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 10:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=9dHj5
	HTJ6jZpvBNzyT8li72FMy75jHwe9ZF/gxkOmXE=; b=BwaD2qq5WJuaQIxFEalcL
	YTGQU1ZTSlv5crntx6i/uH2CuuDX3FsQOkSwIuw4eV29X4NDZykWwIzgEtXFWuZd
	WcUsR3FSgM53j2tOCVMz+6Gf3c37cgkddh8rbNrQ4eJkAza5z1XdrvzzXdxzihIE
	wds5VICccwdTOZPi1EqbSM=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp14 (Coremail) with SMTP id EsCowABHTdUUTYFgqmAPfQ--.4380S2;
	Thu, 22 Apr 2021 18:16:53 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2] mptcp: remove redundant initialization in pm_nl_init_net()
Message-ID: <a35a4608-00bf-1aee-2449-b4dc65e68382@163.com>
Date: Thu, 22 Apr 2021 18:16:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowABHTdUUTYFgqmAPfQ--.4380S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyxAw17ArWrWrW5tr4xWFg_yoWDAFX_uw
	1Sqay8GF1UJw4Ykr47Cr15ZFyru3y8XFWvyrZ7Kay3Kr95Jw1UXrn5WFWfAr4xG34kA34D
	Cr1Ikry3JryfKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5Rmh7UUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+AV8kF2MYm-jeQAAsX

From: wujianguo <wujianguo@chinatelecom.cn>

Memory of struct pm_nl_pernet{} is allocated by kzalloc()
in setup_net()->ops_init(), so it's no need to reset counters
and zero bitmap in pm_nl_init_net().

Signed-off-by: wujianguo <wujianguo@chinatelecom.cn>
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

