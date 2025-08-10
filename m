Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA3F38FA3
	for <mptcp@lists.linux.dev>; Sun, 10 Aug 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754838207; cv=none; b=iX1qr0k1cf17hvCxNJheyXSxjfwNChb1aPOzUeGqO7+G983nguSSNicbthaVwipxjEp6onN2FMx4lVi87KPdM2xJE3xiOIUqf4JaPzU3pfIFx+FJ1KI9TEdH08ACIf9O+PDRU9jB4/TJTNxGvA8WINClKYjEVg9Wz+8AWMguj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754838207; c=relaxed/simple;
	bh=FXaP8LmOWlsBaBWAwSKhBIGAEFBW94wcci3e8HWKcbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+WIrEBDTua9GxTrjSccyQEY8E11UsJ8GDyh9Qy3OMmyUC79Iz7OP2QMhrAKb9RM+lYh5bsOIvxLM3Hs+fWdywmZEgH4Z20Ut6CcmXqbBwkGl1JGAmKM5cQEvukYaBm+2d7MDO3pfJYRxe7f6ROLBVWwKcxy88+hTW0LW5R0i5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjPxAmdo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjPxAmdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB6AC4CEF6;
	Sun, 10 Aug 2025 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754838206;
	bh=FXaP8LmOWlsBaBWAwSKhBIGAEFBW94wcci3e8HWKcbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjPxAmdoQt9ohzHHhaqiI5UVAUGrKQ2saRsh7/XK6yY8jhLCE8QwMk/R7GXH4Pp+h
	 wrcN2MyVUqUkmKpH84BEGPP8aG7H0dQZ8uZOEfUFmLHuJskhdU6cwa9iPLwiUGao2k
	 PIre/4OLKKIWm+M7u+KlopftKvhspQgwpPlGOj/V1743f3e5M14GPOEP5lfb2ASTyx
	 symD//np0nYonjfaY1DkaQstR2FOCO7IUf9v5ZXGsBdOByj8daeLJIC+4B5LAGv0NU
	 PcdmfEtbBjwrIwBKFQiTSAPiyapwk4YerbVNzx4ohzLYfxynZfJFCcyfq6zm9vnSJU
	 vjFVQGQMzn3Yw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 8/8] selftests: mptcp: sockopt: add TCP_MD5SIG test cases
Date: Sun, 10 Aug 2025 23:02:27 +0800
Message-ID: <35a1318c6a7354507348168b194939b4c2060f76.1754837808.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1754837808.git.tanggeliang@kylinos.cn>
References: <cover.1754837808.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Implement automated tests for TCP_MD5SIG and TCP_MD5SIG_EXT:
1. Enable required kernel config options
2. Add test execution framework
3. Implement IPv4/IPv6 test cases
4. Add VRF interface handling for extended MD5 tests
5. Integrate tests into existing test suite

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/config      |  3 ++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 49 +++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 968d440c03fe..efb402d6c2c8 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -34,3 +34,6 @@ CONFIG_NET_ACT_PEDIT=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_CLS_FW=m
 CONFIG_NET_SCH_INGRESS=m
+CONFIG_TCP_MD5SIG=y
+CONFIG_NET_L3_MASTER_DEV=y
+CONFIG_NET_VRF=y
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 41201c5fa6af..969ad1e9cbf2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -348,6 +348,54 @@ do_tcpinq_tests()
 	return $?
 }
 
+do_tcpmd5_test()
+{
+	print_title "TCP_MD5 $*"
+	ip netns exec "$ns_sbox" ./mptcp_sockopt "$@"
+	local lret=$?
+	if [ $lret -ne 0 ];then
+		ret=$lret
+		mptcp_lib_pr_fail
+		mptcp_lib_result_fail "TCP_MD5: $*"
+		return $lret
+	fi
+
+	mptcp_lib_pr_ok
+	mptcp_lib_result_pass "TCP_MD5: $*"
+	return $lret
+}
+
+do_tcpmd5_tests()
+{
+	local lret=0
+
+	do_tcpmd5_test -m "md5,key=123456"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+	do_tcpmd5_test -6 -m "md5,key=123456"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		return $lret
+	fi
+
+	ip netns exec "$ns_sbox" ip link add vrf-test type vrf table 100
+	vrf=$(ip netns exec "$ns_sbox" ip link show vrf-test |
+				       awk -F':' '{print $1; exit}')
+	do_tcpmd5_test -m "md5ext,prefix=1,index=$vrf,key=654321"
+	lret=$?
+	if [ $lret -ne 0 ] ; then
+		ip netns exec "$ns_sbox" ip link del vrf-test
+		return $lret
+	fi
+	do_tcpmd5_test -6 -m "md5ext,prefix=1,index=$vrf,key=654321"
+	lret=$?
+
+	ip netns exec "$ns_sbox" ip link del vrf-test
+	return $lret
+}
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
@@ -363,6 +411,7 @@ run_tests $ns1 $ns2 dead:beef:1::1
 
 do_mptcp_sockopt_tests
 do_tcpinq_tests
+do_tcpmd5_tests
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.48.1

