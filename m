Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AA71
	for <mptcp@lists.linux.dev>; Fri, 23 Apr 2021 10:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Message-ID:Date:MIME-Version; bh=hMSco
	Sc2xZJcH1iewGr5fwLPxpCzOba5NZSJk7J1L+0=; b=OjqysXP3R8+eE0NAwSIdH
	yU5hb2K2Tvu/VLf/rXDjhePllnJZoSeeq5KjIqcyuN5+TNY9cnE2oiw6gVja1zAq
	SsjvgljsNM035YTwWmRurIYE7hjfgYgdWLGqM0wenC0W0gynPzOYHpcApU1X6IbF
	OviNPt+FIIeFMDKmNFuT7Q=
Received: from [192.168.15.51] (unknown [120.36.226.89])
	by smtp9 (Coremail) with SMTP id DcCowAAnnYlxoIJg_wgNHQ--.5066S2;
	Fri, 23 Apr 2021 18:24:50 +0800 (CST)
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, dsahern@kernel.org
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH iproute2] mptcp: make sure flag signal is set when add addr
 with port
Message-ID: <ea7d8eb1-5484-09dc-aa53-cf839b93bc73@163.com>
Date: Fri, 23 Apr 2021 18:24:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:DcCowAAnnYlxoIJg_wgNHQ--.5066S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF18Cr1fCrWDXrW3Zw1fWFg_yoW3uFbEka
	y29w4vgrZxuw17Cr1jkr1rWryFvryxXw40gwnavF9xCwnYy3y7XF4DJas7WwnFka9IgF45
	WwnFyrnayr18KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYgSdDUUUUU==
X-Originating-IP: [120.36.226.89]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbB9wJ9kF2MYnuyGwAAs5

From: Jianguo Wu <wujianguo@chinatelecom.cn>

When add address with port, it is mean to send an ADD_ADDR to remote,
so it must have flag signal set.

Fixes: 42fbca91cd61 ("mptcp: add support for port based endpoint")
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 ip/ipmptcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 5f490f0..44af723 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -143,6 +143,9 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
 	if (!id_set && !adding)
 		missarg("ID");

+	if (port && !(flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
+		invarg("flags must have signal when using port", "port");
+
 	attr_addr = addattr_nest(n, MPTCP_BUFLEN,
 				 MPTCP_PM_ATTR_ADDR | NLA_F_NESTED);
 	if (id_set)
-- 
1.8.3.1

