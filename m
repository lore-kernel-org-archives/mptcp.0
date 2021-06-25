Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCD168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 02:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=Fan5bvOj/U4Uns4Pr/
	D65h4U8zqgSXIqNjDXwSsY5oI=; b=RJo3pbw8X2YXY7iRTfCBAPAm+EtKWPSx8g
	YDl7FCTke55IMz2utrJok6w5WtNgYqsJ62poVGuyKjtSqRtaXiiC5RlGxMvNPfQE
	EugyhH1rO6PSbxQmeXljBjZ3uGOgizmWYDv31q0oHwvttzJRD6qXhwiPmm96E+UI
	qwn78qawI=
Received: from localhost.localdomain (unknown [36.111.140.26])
	by smtp13 (Coremail) with SMTP id EcCowACntjoSRNVg6_a69Q--.41874S7;
	Fri, 25 Jun 2021 10:48:56 +0800 (CST)
From: wujianguo106@163.com
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com
Subject: [PATCH mptcp-net v6 5/5] selftests: mptcp: update case multiple subflows limited by server
Date: Fri, 25 Jun 2021 10:48:50 +0800
Message-Id: <1624589330-2579-6-git-send-email-wujianguo106@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
References: <1624589330-2579-1-git-send-email-wujianguo106@163.com>
X-CM-TRANSID:EcCowACntjoSRNVg6_a69Q--.41874S7
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWDArW5CF45tryruw45ZFb_yoWkCFgEgF
	4xtFyUCr4DZFyUtF18Cr15CrWrGr9xu397Kr1Fqw13J34jy3W5WFWkJFyv93Z3G39093sF
	gFs2yw1Yyw4jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0wiSDUUUUU==
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiNxi8kFWBk7Y+wgAAsO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

From: Jianguo Wu <wujianguo@chinatelecom.cn>

After patch "mptcp: fix syncookie process if mptcp can not_accept new subflow",
If a new subflow is limited, MP_JOIN SYN is dropped, and no SYN/ACK will be replied.
So in case "multiple subflows limited by server", the expected SYN/ACK number
should be 1.

Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 523c7797f30a..37b7da3cd5ca 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1398,7 +1398,7 @@ syncookies_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.2.2 flags subflow
 	run_tests $ns1 $ns2 10.0.1.1
-	chk_join_nr "subflows limited by server w cookies" 2 2 1
+	chk_join_nr "subflows limited by server w cookies" 2 1 1
 
 	# test signal address with cookies
 	reset_with_cookies
-- 
1.8.3.1


