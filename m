Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EB6D0E
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 23:54:40 +0000 (UTC)
IronPort-SDR: zT1ci3ZVjvkOrWjI3psZpTVfJVBCJQqGaCJ20gMxBjkXkTSa18HgyPoxhjiZlskcjttrX1jw0O
 yT8zTKQzRYEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="288450526"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="288450526"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:37 -0700
IronPort-SDR: f22sfi1egaHTR6B3xTSLz1ri23qMWeVim7VBIiZgx6pbQmKxUw8k3yH9z2y2lqWDF0elGy6a7X
 Qkiv+2i7Bu3g==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="443774257"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.84.136])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:54:36 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Jianguo Wu <wujianguo@chinatelecom.cn>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/7] mptcp: make sure flag signal is set when add addr with port
Date: Thu, 27 May 2021 16:54:28 -0700
Message-Id: <20210527235430.183465-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
References: <20210527235430.183465-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianguo Wu <wujianguo@chinatelecom.cn>

When add address with port, it is mean to create a listening socket,
and send an ADD_ADDR to remote, so it must have flag signal set,
add this check in mptcp_pm_parse_addr().

Fixes: a77e9179c7651 ("mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink")
Acked-by: Geliang Tang <geliangtang@gmail.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/pm_netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7dbc4f308dbe..09722598994d 100644
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
2.31.1

