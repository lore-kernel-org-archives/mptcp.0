Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8524A35
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848809; cv=none; b=WhAfqS3pU314KPh9kFHUCoj0Rq9d0NbWPNOYOo6LPj/JkAVx+oF8o1Lx2sDaCA39SjQ6iU9u9qPPC8SiG7qAnlJO2DqmaP0P3m0rSe5ykqbAIg34QcniHSuxN77lKqeksr9MlOrCjmH7ITPIW9CvKWDCxlY7cDZnVSVfqNSY6Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848809; c=relaxed/simple;
	bh=1toBglHh+DM/POYRzkSe+/VV6/nJ5RL4JB2cyRv3vC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVCAkxddIm2wbRIh298Rr3UhVGcspwWXsf7RE2aRxZl5Eonr60lr1mIBd70QFYB3cs3ipRzIPpkgSELeC2RSxSXJiTlVe6xIP9ujpHGf5xpI1fgp78pGHh4ZlpB+xu1jKwGHJsCvhiQbVcp9TQNgaIHawX9+R50XCOFG8MCekAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m0HXoewX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m0HXoewX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774848805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29I4y3aQ/S/p+FtI1ofIbXh6U0HJWVxHb0WRsS/riMw=;
	b=m0HXoewXR/++sOOftUd74n4MRxdKUFfVdhJKbfUeLHdmHPy0MiHpQFzHo518JOB/cDocNI
	NvB+Dl9cj1XWmnYzkC94Jm5/ZbYViPbteJuqDrrEYK+HF8pYpJhGwE6fdnIkQgi0OEjBn2
	hMLyHFo5ff0TVIZVw0cPvihNJxvJTyA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-net v4 5/5] selftests: mptcp: test transmission with small rcvbuf
Date: Mon, 30 Mar 2026 13:33:00 +0800
Message-ID: <20260330053300.15717-6-gang.yan@linux.dev>
In-Reply-To: <20260330053300.15717-1-gang.yan@linux.dev>
References: <20260330053300.15717-1-gang.yan@linux.dev>
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
 .../testing/selftests/net/mptcp/mptcp_join.sh | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..6bf7ebedfbc8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4417,6 +4417,25 @@ endpoint_tests()
 	fi
 }
 
+rcvbuf_tests()
+{
+	if reset "4 subflows with reduced rcvbuf"; then
+		local tcp_rmem=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_rmem)
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
+
+		ip netns exec $ns2 sysctl -w net.ipv4.tcp_rmem="$tcp_rmem"
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -4467,6 +4486,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	R@rcvbuf_tests
 )
 
 all_tests_args=""
-- 
2.43.0

