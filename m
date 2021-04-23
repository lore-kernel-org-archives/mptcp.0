Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 00D4471
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 10:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=uzRuZ
	WRVDvJYGI3nYcZdfQDh0z6xU18bNeLTvXowSfY=; b=DFNx7oh+iIySj69jIu7Bh
	dd9x/xsWm83dn5W7xGT2XASNs6ricKB1fEnWNn9QzXPdtumWKlLFVZBdZKyxR6hu
	9m37Hd0OwWHh3yx1TQyZSYNR22bGDtuVhyGE/Qjg8nbOEk4yXT/EvbRkLBXJKT4a
	xHM836LfyG/4v1/h9fUYh4=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowABXX297nYJgqLkLHQ--.12751S2;
	Fri, 23 Apr 2021 18:12:12 +0800 (CST)
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] mptcp: make sure flag signal is set when add addr with port
Message-ID: <0d970926-7dfa-d518-50ae-0d4ed4db9706@163.com>
Date: Fri, 23 Apr 2021 18:12:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DcCowABXX297nYJgqLkLHQ--.12751S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF15Aw4fJw4rAF1fKryrXrb_yoWkurg_XF
	Wjv345Ww43XFs8Cw4UC3yfJa4SvrWxWws7KF9ayFZrGw1DAFnFqr48tr97ZFnrC398uFyU
	Cwn09ryUCr1fKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYn_-DUUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxx9kF5u+GMf7AAAsO

From: Jianguo Wu <wujianguo@chinatelecom.cn>

When add address with port, it is mean to create a listening socket,
and send an ADD_ADDR to remote, so it must have flag signal set,
add this check in mptcp_pm_parse_addr().

Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
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

