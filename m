Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CAA405C57
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197713; cv=none; b=dPO1w7pafo7WjGAUaNfFzCi0cEeyfqFiO7CyktkrRkQRCYwG/BhIhyQ1HEAcyXFbW/BkvHJSOjyDA1R8DPEZPV0JHMSXI5zJqzNdbxrvvW5uPInlVrkRKhHnCLlbJw4GFGaOiaFLTKcqEIdIU9wmre8d/1k2fhLdB4fQ3BdEsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197713; c=relaxed/simple;
	bh=nIZOxv7aMd3GvX1Gx2noNVaHAgeuvEEqORFXAH2UkxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZLTHtBbdLOs4W8qZfIimryNbbmaqFvL+8YJ93sQLEy9+xt8c+5wymYqLhkZVg1EJ1imu3kDYGkcaaG+RhaJw9sPVol2NsowDWtYqWr02Cl9vsUpiuaWF/FWHT15CwPw+n3Ep2bY3IhG2woXYeDlWEDN8Unm65RUpfEPi/MEdzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o+7Wwvt5; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o+7Wwvt5"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mG/dysvFDBbTMV7Ke1Y8Emr+FlrohO2qrbgjTf0UELY=;
	b=o+7Wwvt54Ye8k50vK4zBVHE0TEFJrUum0JPRgww4pZFNS9tiNIIxevhoq+5JNi7VS+MbQP
	43zNBneiCqYL89RSw/Mzp8AC3ZCEa3SMuFM1+Mq29YUED3TFS5k8QB4dxITnr2h0JkR/Z4
	xwN3OaVUkefhJ0EvlPYl1KZHR2H0r4Y=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 6/9] selftests: mptcp: simult_flows.sh skips v6 setup when MPTCP IPv6 is missing
Date: Fri, 12 Jun 2026 01:07:56 +0800
Message-ID: <c4fb14855ac77955a2407799f86f6afc8856d088.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

On a CONFIG_IPV6=m kernel (which forces
CONFIG_MPTCP_IPV6=n) every v6 setup step errors out, setup() exits
non-zero and all subtests report spurious failures.

Call mptcp_lib_check_ipv6() at script init, then collect the entire
v6 setup into a single "if mptcp_lib_is_v6_enabled; then ... fi"
block at the end of setup(). v4 topology and run_test invocations
are untouched; in a full-featured kernel the block is always taken
and the script runs as before.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../selftests/net/mptcp/simult_flows.sh       | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 3ea3d1efe32e..7f9c6a343aaa 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -48,6 +48,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_tools ip tc
+mptcp_lib_check_ipv6
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1
@@ -81,39 +82,48 @@ setup()
 	ip link add ns2eth3 netns "$ns2" type veth peer name ns3eth1 netns "$ns3"
 
 	ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth1
-	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth1 nodad
 	ip -net "$ns1" link set ns1eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.1.2
-	ip -net "$ns1" route add default via dead:beef:1::2
 
 	ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
-	ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
 	ip -net "$ns1" link set ns1eth2 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
-	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
 	mptcp_lib_pm_nl_set_limits "${ns1}" 1 1
 	mptcp_lib_pm_nl_add_endpoint "${ns1}" 10.0.2.1 dev ns1eth2 flags subflow
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
-	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
 	ip -net "$ns2" link set ns2eth1 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth2
-	ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth2 nodad
 	ip -net "$ns2" link set ns2eth2 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.3.2/24 dev ns2eth3
-	ip -net "$ns2" addr add dead:beef:3::2/64 dev ns2eth3 nodad
 	ip -net "$ns2" link set ns2eth3 up mtu 1500 gso_max_segs 0
 	ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=1
-	ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
 
 	ip -net "$ns3" addr add 10.0.3.3/24 dev ns3eth1
-	ip -net "$ns3" addr add dead:beef:3::3/64 dev ns3eth1 nodad
 	ip -net "$ns3" link set ns3eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns3" route add default via 10.0.3.2
-	ip -net "$ns3" route add default via dead:beef:3::2
+
+	# IPv6 topology: only configured if MPTCP IPv6 is supported by the
+	# running kernel (CONFIG_MPTCP_IPV6=y). On a kernel without it,
+	# "ip -6 addr add", "ip -6 route add" and the v6 forwarding sysctl
+	# would fail and abort setup(), taking the v4 tests down with them.
+	if mptcp_lib_is_v6_enabled; then
+		ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth1 nodad
+		ip -net "$ns1" route add default via dead:beef:1::2
+		ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
+		ip -net "$ns1" route add default via dead:beef:2::2 metric 101
+
+		ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
+		ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth2 nodad
+		ip -net "$ns2" addr add dead:beef:3::2/64 dev ns2eth3 nodad
+		ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
+
+		ip -net "$ns3" addr add dead:beef:3::3/64 dev ns3eth1 nodad
+		ip -net "$ns3" route add default via dead:beef:3::2
+	fi
 
 	mptcp_lib_pm_nl_set_limits "${ns3}" 1 1
 
-- 
2.43.0

