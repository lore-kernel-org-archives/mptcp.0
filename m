Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A370
	for <mptcp@lists.linux.dev>; Thu, 22 Apr 2021 07:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=Ac8mZ
	q8+K0nXzOQ/1a5JcV43J9uyaC3Nr6kapeW4nAE=; b=ZHl7K6dwqGfNrYTTpYB/e
	3H8lMX385lgfdrhR0swYHRVfY/9BxSHHqqhzA1g5+Qk9Jrx1lDtFsm7xGi2qu6/W
	tYfTgwrnGL2IYbWzzXF4YrNGzJp0G3OuQs1JEvKiezKYq1oVbYkMosoMtf0u1QEn
	GxSnOOsso66AdD72pHPCSc=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp14 (Coremail) with SMTP id EsCowACnnX3cH4FgXOj1fA--.2056S2;
	Thu, 22 Apr 2021 15:03:56 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: remove redundant couters reset in pm_nl_init_net()
Message-ID: <1fc15c8b-ba1c-a1d9-d204-8087d93b73e3@163.com>
Date: Thu, 22 Apr 2021 15:03:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:EsCowACnnX3cH4FgXOj1fA--.2056S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyxAw17ArWrWrW5ur4UArb_yoWfJrg_ur
	1Sqay8GF1UJr4Ykr43urn8XFySv3ykWFWkXws7G3y3K3s5Jw1UXrs5XF4fAr1xG34DA34k
	CF4xKryayryrKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYRT5tUUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB+BR8kF2MYm3WvAAAs0

From: Jianguo Wu <wujianguo@chinatelecom.cn>

Memory of struct pm_nl_pernet{} is allocated by kzalloc()
in setup_net()->ops_init(), so it's no need to reset counters
in pm_nl_init_net().

Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 6ba0408..99bb9be 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1913,7 +1913,6 @@ static int __net_init pm_nl_init_net(struct net *net)
 	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);

 	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
-	__reset_counters(pernet);
 	pernet->next_id = 1;
 	bitmap_zero(pernet->id_bitmap, MAX_ADDR_ID + 1);
 	spin_lock_init(&pernet->lock);
-- 
1.8.3.1

