Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D926FDBF
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546754; cv=none; b=Xvd3kE85TDEe+AKAe7f97GykJuDgGiGlrLZy1r4jhbKEe1+xcDpWoHWLdVQexs8JSQJXquRKX9LeuwYnPqIUgMOJqClqhIJ6y8M0rOmv2WZeBcnu6eq1pnfY7rBQ6o2tyCdpP5wbHTGBToQr9J/aa154X5xYdq5cyFlc/ywI8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546754; c=relaxed/simple;
	bh=qLyenjR21Wk3FlfQFU+nj1Bm+8HWWde/8LUA/K3QAfs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAQgMiZTnpDH9xUqUGOizphOncRXa204SkVZ7vyGEjIvJvi6J+H98keNmCYVZ4NTDtlHZkOqhgxg0zyessqPYdgnLLvIatxBqBvD/7phNW+my8AcDTb2OgWt0+ikDfRRPCEwoSJ+nTK8NPFdRu1LniSrwSo76EiJ2M8GdRrHV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t6Qb3m7O; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t6Qb3m7O"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=t7e9LlSquh3uUVyRxXrYcGZmH5anQtlMog54fRV/E7Y=;
	b=t6Qb3m7O8PJy4NoJvvDXjZcWxNOqeTY8DEsWUrUUKHMU0LN1+n65iqvBD5p7MbwDfke2keGWS
	8jf1toqnpknkj0ag+tMW7xj7KpTaih614If5X4RRiYTYaYlaxAkt+WC4evwnhJIHdcyphuUkxFT
	1xzY0/SlLzWupPNwbLYJ9H4=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4g5rbm3hqkzLlVq
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 18:52:36 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BA4640647
	for <mptcp@lists.linux.dev>; Thu, 30 Apr 2026 18:59:03 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Apr
 2026 18:59:02 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <mptcp@lists.linux.dev>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <xiasong.lee@gmail.com>
Subject: [PATCH mptcp-net v2 2/2] selftests: mptcp: join: cover ADD_ADDR tx drop and list progress
Date: Thu, 30 Apr 2026 19:20:26 +0800
Message-ID: <20260430112026.343691-3-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260430112026.343691-1-lixiasong1@huawei.com>
References: <20260430112026.343691-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Extend add_addr_ports_tests with IPv6 signaling cases that exercise
ADD_ADDR tx-space shortage when tcp_timestamps are enabled.

Add one case to verify ADD_ADDR tx drop accounting via
MPTcpExtAddAddrTxDrop, and another case to verify PM still progresses
to later signal endpoints after the first one is dropped.

This covers both failure accounting and the non-blocking behavior of
the announce list after a tx-space drop on pure ACK.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..59beddb487e3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1828,6 +1828,22 @@ chk_add_tx_nr()
 	fi
 }
 
+chk_add_drop_tx_nr()
+{
+	local add_drop_tx_nr=$1
+	local count
+
+	print_check "add addr tx drop"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$add_drop_tx_nr" ]; then
+		fail_test "got $count ADD_ADDR drop[s] TX, expected $add_drop_tx_nr"
+	else
+		print_ok
+	fi
+}
+
 chk_rm_nr()
 {
 	local rm_addr_nr=$1
@@ -3278,6 +3294,37 @@ add_addr_ports_tests()
 
 		chk_mpc_endp_attempt ${retl} 1
 	fi
+
+	# signal address with port IPv6: tx fails with tcp timestamp
+	if reset "signal address with port IPv6 tx drop"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
+		chk_add_nr 0 0 0
+		chk_add_drop_tx_nr 1
+	fi
+
+	# first signal address drops, second one still progresses
+	if reset "signal addr list progresses after tx drop"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 0
+		ip netns exec $ns1 sysctl -q net.ipv4.tcp_timestamps=1
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_timestamps=1
+
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 dead:beef:3::1 flags signal
+
+		speed=slow \
+			run_tests $ns1 $ns2 dead:beef:1::1
+
+		chk_add_drop_tx_nr 1
+		chk_add_tx_nr 1 1
+		chk_add_nr 1 1 0
+	fi
 }
 
 bind_tests()
-- 
2.34.1

