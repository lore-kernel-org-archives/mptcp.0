Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEA71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=Rbrd9
	+ORKNIuKUjH4ZHaR89TkkIxRospn98Uk0yv+Cs=; b=Qfz3lvYEIdpae5Wn5I3n8
	6nevV0HtRRiggJveTMF6Sn6/GOXQkY4rAZWs5JRXCjcdE5a6ibIWyw+38512mIMi
	qqKLpqjGE3bgi53PiJBE+Uv3vOXMmb3rfkLRcAZO8SpCmojICbdgFx1kVXI++UtZ
	Q0gC+4q2MsQ6D1htRCMyWE=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowAB3YlKwoIJgLzMNHQ--.5053S2;
	Fri, 23 Apr 2021 18:25:52 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH v2] mptcp: make sure flag signal is set when add addr with
 port
Message-ID: <c388d556-530c-ee11-3ab1-a8019fb2eb6f@163.com>
Date: Fri, 23 Apr 2021 18:25:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DcCowAB3YlKwoIJgLzMNHQ--.5053S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF15Aw4fJw4rAFWfJFW3Awb_yoWktrc_XF
	Wqv3yrWw43Xrn8Cw4DC3yfJa4SvrWxGws7KFn3AFZ7Gw1DAFn2qr48trZ7ZFnrC398uFyU
	uwn09ryUCr1ftjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUY0eHDUUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxF9kF5u+GNFRQAAsw

From: Jianguo Wu <wujianguo@chinatelecom.cn>

When add address with port, it is mean to create a listening socket,
and send an ADD_ADDR to remote, so it must have flag signal set,
add this check in mptcp_pm_parse_addr().

Fixes: a77e9179c7651 ("mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 net/mptcp/pm_netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index becc32b..90bba32 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -971,8 +971,14 @@ static int mptcp_pm_parse_addr(struct nlattr *attr, struct genl_info *info,
 	if (tb[MPTCP_PM_ADDR_ATTR_FLAGS])
 		entry->flags = nla_get_u32(tb[MPTCP_PM_ADDR_ATTR_FLAGS]);

-	if (tb[MPTCP_PM_ADDR_ATTR_PORT])
+	if (tb[MPTCP_PM_ADDR_ATTR_PORT]) {
+		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
+			NL_SET_ERR_MSG_ATTR(info->extack, attr,
+					    "flags must have signal when using port");
+			return -EINVAL;
+		}
 		entry->addr.port = htons(nla_get_u16(tb[MPTCP_PM_ADDR_ATTR_PORT]));
+	}

 	return 0;
 }
-- 
1.8.3.1


