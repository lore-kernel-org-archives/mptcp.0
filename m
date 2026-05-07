Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931B31AA8F
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156805; cv=none; b=h+i00y2Oo4s0ux3C4dGQjOY6GwZSQ45bASxXBWlDgqBVtW1dYLRXS2lKwro89DgdYo3kUJDBTww1e9AGdLZxyVMKHcNFF2lirNsMiZN2NPNQKDkRbp9qdEzFAPhnGAQRen8FSwuR0P3DBeEle6QQjxgK191dJf9xPDi34MK35ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156805; c=relaxed/simple;
	bh=QQ8D1JZpQQMjOfIgBYlk2gLK9nkRvftK+ptNDNMXemY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uP9qF0SVMMAtJIPkWL/jeWszT0WvZ4ZZXr6+drFunh79VjiT0f7zre3LPogQLnxuYkMEHZyRQC8b1840teNX/EU8DI3old6iV0r18+iHWeKfzi93za4bCpv6OtwyUfGV14ThRbWxZXrj/xqweEjh7jvz6/eIZSvYjvh1lU6XViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=X3hn7HC/; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="X3hn7HC/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YXcX/3fRPBh5vW6oDfBLplj0huueVK1I6L/NkoC/KT8=;
	b=X3hn7HC/lwwHrH3xSJcI7n/noTMKhNNH7urONXw/M58EqDt8Mi3ebqh43dWxBqAFCs++B1uOy
	2CkbdL4OYbwPj7tX8A8tPWoy8w7BA4pX2TTsOYw6Sjm1aPPSFrA5d+aGo2bo9/CRuEZULy1mLzw
	P+btN+fZOxZeomtSleoFf9c=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gBBBG0F6vzRhQT
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 20:19:02 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 3965F40569
	for <mptcp@lists.linux.dev>; Thu,  7 May 2026 20:26:35 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 May
 2026 20:26:34 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: <mptcp@lists.linux.dev>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: join: cover ADD_ADDR tx drop and list progress
Date: Thu, 7 May 2026 20:52:24 +0800
Message-ID: <20260507125224.3536507-3-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507125224.3536507-1-lixiasong1@huawei.com>
References: <20260507125224.3536507-1-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500018.china.huawei.com (7.202.194.48)

Extend add_addr_ports_tests with IPv6 signaling cases that exercise
ADD_ADDR tx-space shortage when tcp_timestamps are enabled.

Add one case to verify PM still progresses to later signal endpoints
after the first one is dropped.

This covers both failure accounting and the non-blocking behavior of
the announce list after a tx-space drop on pure ACK.

Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..5acd12021e6e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1828,6 +1828,22 @@ chk_add_tx_nr()
 	fi
 }
 
+chk_add_drop_tx_nr()
+{
+	local drop_tx_nr=$1
+	local count
+
+	print_check "add addr tx drop"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtAddAddrTxDrop")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$drop_tx_nr" ]; then
+		fail_test "got $count ADD_ADDR drop[s] TX, expected $drop_tx_nr"
+	else
+		print_ok
+	fi
+}
+
 chk_rm_nr()
 {
 	local rm_addr_nr=$1
@@ -3278,6 +3294,21 @@ add_addr_ports_tests()
 
 		chk_mpc_endp_attempt ${retl} 1
 	fi
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
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_add_drop_tx_nr 1
+		chk_add_tx_nr 1 1
+		chk_add_nr 1 1 0
+	fi
 }
 
 bind_tests()
-- 
2.34.1

