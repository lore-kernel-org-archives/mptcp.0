Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2612FB3
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 08:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=5deExUksRhz+ynlf38
	oqAkXMoTdflt/vR9pMZk6sVRU=; b=GxPd7PIoG+bFmqaUIJiAgXrhH8YTr7r/Gu
	494+CW/1tYwlhTIMM6kgrW/HT+5IbiTSI5NdYIH3zAr8NqtsUsceJiBtvEiRp8SI
	Ef7l5v1swsT0HkgceQlTmQ6c1d7K/ldoSx8IBFV8300CgbVBdMNZK+EPhDaZup2R
	RoTkDCH+Q=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp14 (Coremail) with SMTP id EsCowAAnK+MXk9VgPJySrQ--.35196S7;
	Fri, 25 Jun 2021 16:26:06 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v7 5/5] selftests: mptcp: fix case multiple subflows limited by server
Date: Fri, 25 Jun 2021 16:25:59 +0800
Message-Id: <1624609559-6786-6-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EsCowAAnK+MXk9VgPJySrQ--.35196S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWDArW3Aw47Ww15Wr4UArb_yoWkKrgEgF
	4xtFyDArs8ZFyUtF18Cr15CrWrK3sxu397Kr10vw13Jw1jy3W5WFWkJF1Du3Z3G390934a
	gFs2yw1Yyw1jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0qg43UUUUU==
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSR68kFaD-BfesgAAsp
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

After patch "mptcp: fix syncookie process if mptcp can not_accept new subflow",
If subflow is limited, MP_JOIN SYN is dropped, and no SYN/ACK will be replied.
So in case "multiple subflows limited by server", the expected SYN/ACK number
should be 1.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9a191c1..f02f4de 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1409,7 +1409,7 @@ syncookies_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_join_nr "subflows limited by server w cookies" 2 2 1
+	chk_join_nr "subflows limited by server w cookies" 2 1 1
 
 	# test signal address with cookies
 	reset_with_cookies
-- 
1.8.3.1


