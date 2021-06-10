Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.228])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949629CA
	for <mptcp@lists.linux.dev>; Thu, 10 Jun 2021 01:33:00 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.218:41186.1226760890
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9?logid-561e1d80e8424cf98bd9d19eb952c1bc (unknown [172.18.0.218])
	by chinatelecom.cn (HERMES) with SMTP id CB9E228011C;
	Thu, 10 Jun 2021 09:25:24 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.218])
	by app0025 with ESMTP id 561e1d80e8424cf98bd9d19eb952c1bc for mptcp@lists.linux.dev;
	Thu Jun 10 09:25:29 2021
X-Transaction-ID: 561e1d80e8424cf98bd9d19eb952c1bc
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
Subject: [PATCH v2] selftests: mptcp: turn rp_filter off on each NIC
Date: Thu, 10 Jun 2021 09:25:16 +0800
Message-Id: <1623288316-2771-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

To turn rp_filter off we should:
echo 0 > /proc/sys/net/ipv4/conf/default/rp_filter
 and
echo 0 > /proc/sys/net/ipv4/conf/all/rp_filter
before NIC created.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3aeef3b..6b6336d 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -60,6 +60,8 @@ setup()
 	for i in "$ns1" "$ns2" "$ns3";do
 		ip netns add $i || exit $ksft_skip
 		ip -net $i link set lo up
+		ip netns exec $1 sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec $1 sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
@@ -80,7 +82,6 @@ setup()
 
 	ip netns exec "$ns1" ./pm_nl_ctl limits 1 1
 	ip netns exec "$ns1" ./pm_nl_ctl add 10.0.2.1 dev ns1eth2 flags subflow
-	ip netns exec "$ns1" sysctl -q net.ipv4.conf.all.rp_filter=0
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-- 
1.8.3.1

