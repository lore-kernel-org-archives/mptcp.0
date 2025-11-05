Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED7F2FE071
	for <mptcp@lists.linux.dev>; Wed,  5 Nov 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334987; cv=none; b=ZOM87gWaYVC+nzxCQmwIJC4Sw2f9k+tnPDzskHU1qQb48vCjyQKtEz9TdFKVxBVWRQ28gc7lWJCWfGhTcH5uyxsZwFK6q3hh/dNdkINaYIn4gu3xn+WgMDiEAN52enxukOc0uF2Q40A9TJM2tSHZuIyaJTBwKJV8C1cjOffd/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334987; c=relaxed/simple;
	bh=DbGNanV8qRnBi1aTZ4kMJNNdGDkBgPO7ClDPcIcDGpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swweDnmdzBCDzuA3ajXzsP1lqWDzm6odWLhTqWV57OBpiKzINn7C36XCHtFNxnYscKNyzLNxvk3AIp2G+5ODbyiKQEckAZzMOeH7vQAZ7BY6kSd6BmbJ5gb9/s301NNm1g+8Bma61UVWMMfUTfl3+jnT4ET9FzsqQTIbgJuNVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRRVKqzC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRRVKqzC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4F4C4CEF8;
	Wed,  5 Nov 2025 09:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762334987;
	bh=DbGNanV8qRnBi1aTZ4kMJNNdGDkBgPO7ClDPcIcDGpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRRVKqzCW5v3M70qeSGwtk060cHvB8C2sJuiss69yk3RT52E25mx+LPJXPw4aNf5Z
	 m20yhW/N+9WP1zzTK3RLYK3zYqGBmNY1OQjSgiuhXbxjxPoNvfgimIgn8zEov7pYjU
	 6YrDonizhrDBYuWCRGzhQ33i2QhNrqNBnK4JYEswBRiTJjOPxyGpbyV5LJwPym9Oqo
	 romz70k0Om4OWgLdVynrXYGwpX4Siy40wjMPuaa/q1X2HA6AUP20RQpg5dqrNQY36Q
	 Lg+vDeEo8hIF/bRVqzd4MKmk+5Q0Spg/VvkPZ4FC20lIBQm3aURdW3PvRZNNN4bhiX
	 g75hwZfCvlbIA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 7/7] selftests: mptcp: sockopt: add TCP_MD5SIG test cases
Date: Wed,  5 Nov 2025 17:29:30 +0800
Message-ID: <4ba68f228cd04836ad8072a75074798083a1ea3b.1762334694.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762334694.git.tanggeliang@kylinos.cn>
References: <cover.1762334694.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Add self tests for TCP_MD5SIG and TCP_MD5SIG_EXT:
- IPv4/IPv6 test cases
- VRF interface handling for extended MD5 tests
- Integration into existing test suite

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  3 ++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 51 +++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 59051ee2a986..44e3523bc8c3 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,6 @@ CONFIG_NFT_SOCKET=m
 CONFIG_NFT_TPROXY=m
 CONFIG_SYN_COOKIES=y
 CONFIG_VETH=y
+CONFIG_TCP_MD5SIG=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index f01989be6e9b..dc58bfe88daa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -348,6 +348,56 @@ do_tcpinq_tests()
 	return $?
 }
 
+do_tcpmd5_test()
+{
+	print_title "TCP_MD5SIG $*" | head -c 53
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
+	local lret=$?
+	if [ $lret -ne 0 ];then
+		ret=$lret
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "TCP_MD5SIG: $*"
+		return $lret
+	fi
+
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "TCP_MD5SIG: $*"
+	return $lret
+}
+
+do_tcpmd5_tests()
+{
+	local lret=0
+
+	mptcp_lib_print_info "sockopt TCP_MD5SIG"
+
+	do_tcpmd5_test -m "md5,key=0123456789"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+	do_tcpmd5_test -6 -m "md5,key=0123456789"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+
+	ip netns exec "$ns_sbox" ip link add vrf-test type vrf table 100
+	vrf=$(ip netns exec "$ns_sbox" ip link show vrf-test |
+				       awk -F':' '{print $1; exit}')
+	do_tcpmd5_test -m "md5ext,prefixlen=1,ifindex=$vrf,key=0123456789"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		ip netns exec "$ns_sbox" ip link del vrf-test
+		return $lret
+	fi
+	do_tcpmd5_test -6 -m "md5ext,prefixlen=1,ifindex=$vrf,key=0123456789"
+	lret=$?
+
+	ip netns exec "$ns_sbox" ip link del vrf-test
+	return $lret
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -363,6 +413,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_tcpmd5_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0

