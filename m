Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263170
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 06:30:18 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:55010.1573724254
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-a15f32f43b5a488bbb11493e92e8ae50 (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id 522CB2800BA;
	Wed,  9 Jun 2021 14:23:06 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id a15f32f43b5a488bbb11493e92e8ae50 for mptcp@lists.linux.dev;
	Wed Jun  9 14:23:14 2021
X-Transaction-ID: a15f32f43b5a488bbb11493e92e8ae50
X-filter-score:  filter<0>
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.218
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matthieu.baerts@tessares.net,
	mathew.j.martineau@linux.intel.com,
	geliangtang@gmail.com,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH] selftests: mptcp: turn rp_filter off on every NIC
Date: Wed,  9 Jun 2021 14:22:51 +0800
Message-Id: <1623219771-40982-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

To turn rp_filter off we should:
echo 0 > /proc/sys/net/ipv4/conf/<device>/rp_filter
 and
echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3aeef3b..a29ffef 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -81,6 +81,8 @@ setup()
 	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
 	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
 	ip netns exec "$ns1" sysctl -q net.ipv4.conf.all.rp_filter=0
+	ip netns exec "$ns1" sysctl -q net.ipv4.conf.ns1eth1.rp_filter=0
+	ip netns exec "$ns1" sysctl -q net.ipv4.conf.ns1eth2.rp_filter=0
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-- 
1.8.3.1

