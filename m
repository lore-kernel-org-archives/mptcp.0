Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44A36920C
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033714; cv=none; b=McpPw7g8JGBxeLYrYkpvPj9YBoev7Py2VlK83FSvUV/YLJ8RQJqbtr56lgDgPFwObT332e3lYF+frEwsjCUkSHMeCNNmmamvdlpyvOckyVQ9l1GZq+Jmxhgu4wJSyXPIzpbVdobp+8jWjKbjFkWc6G0L1IMXKpzPM/obyBOFRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033714; c=relaxed/simple;
	bh=fXxlmyA/6nZ2O16gmRKiZSSxCRpzkvbecLe2XsHViJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHAJ0+sZj+ZV/PfHnbiA3ELtiwj4Dcyf9+4SK6oilFyY7BfikjT6hXl/1uKc8gJ+WXIQeAK2i13ziuNfia8Yhk3qV+tY2f6vWl1pRthWwiLqpvGy75U4TppbmGj3UWCh0tUbOlGclUm8fHDLhCgqLIHxFhxjTAn8yPE7/u5H9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MV6x14oU; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MV6x14oU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775033710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph0Tha0QIPaxazIuIF/obvLVNneGGcCrida/hb7HyGQ=;
	b=MV6x14oU2uu9RGVjB8i0Q0CXpMdZHkG+Vvn65Cc0FF9OCyb2vFxfuFEFlGvXkblU9356CO
	N0pMusUKg3e1Kcw38W5TbMg7nKtlc4P6PKTJ+IQbGxzBs7y4750yWxKMpKi85fs+Upan2X
	6jdySe72smsAy6XfpgIj/G0cFbV0XRc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v5 5/5] selftests: mptcp: test transmission with small rcvbuf
Date: Wed,  1 Apr 2026 16:54:18 +0800
Message-ID: <ee3b64c8f16734f94cb19d2615563c47e688b784.1775033340.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775033340.git.yangang@kylinos.cn>
References: <cover.1775033340.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch adds a test for transmission with a limited receive buffer.

Without the fixes in this set, this test fails with errors:

 # 001 4 subflows with reduced rcvbuf
 # net.ipv4.tcp_rmem = 4096 4096 4096
 #       Info: Test file (size 1024 KB) for client
 #       Info: Test file (size 1024 KB) for server
 # copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
 # copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
 # [FAIL] client exit code 2, server 2
 # Server ns stats (ns2-qg1Hqo)

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
Notes:

Changelog:
v5:
  - Drop the unnecessary tcp_rmem restore.

---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..a21333424085 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4417,6 +4417,22 @@ endpoint_tests()
 	fi
 }
 
+rcvbuf_tests()
+{
+	if reset "4 subflows with reduced rcvbuf"; then
+		ip netns exec $ns2 sysctl -w net.ipv4.tcp_rmem="4096 4096 4096"
+
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 0 4
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		speed=fast test_linkfail=1024 \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 3 3 3
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -4467,6 +4483,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	R@rcvbuf_tests
 )
 
 all_tests_args=""
-- 
2.43.0

