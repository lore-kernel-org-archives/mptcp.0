Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143D28E2
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109043; cv=none; b=ro8F8bPPrALdnc3KhwEng2CBMMQ87FwM0Pbd53NcoqbMAYcpOF/Hf9McB8cNK2kwKL6CpGEeSbqX7Gmz3VyJFJkjq4OJEvYQuhy3+nFQZnzDwqU+jucj7tNuxqJzY7rjSHZDmLFK+nG9cfdZWYvEk5z4m4624223tUW5ilxF0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109043; c=relaxed/simple;
	bh=rPiT6TUMcpXlEUtg89yWHqx8WYwtnTMOYH5E/bgJsMw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaz779K4tGhC0cmjiP4j4LeGB9y0U+DVoocLHtsj6pDPGnj3l37/4xXlR0j7zjyQZAYuzwf7v693MIodBoyuf9/Ezlv1w8CPGnROqlYunp4H1n8L/D5xg/ZXKf/z32ClLIxduC9bHMAwY4JTMW7gvN9+fesrgRY4Lw+lQvI1dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAdXQroy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAdXQroy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A3CC433C7;
	Wed, 28 Feb 2024 08:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709109043;
	bh=rPiT6TUMcpXlEUtg89yWHqx8WYwtnTMOYH5E/bgJsMw=;
	h=From:To:Cc:Subject:Date:From;
	b=tAdXQroy9XNAYJizBhjrgL+70adOcbr9s/0e9+2r2SKpNiKpQoUgnnlO+1NSJrcuY
	 aqB+yPIeoul7PuiYrSDQifXmW2wJPT5Mrprlxpn9iB+tMV6sGk3v3Y8Pk7YQOuxP/0
	 BVLjaswq7Nbr1q5mcdhnbkkLS4DhA87uJQdm+wk6g3GuvC9YCVXncM5LXeHq9hB/CD
	 OEhGMWaY3o4oP9ND//MjwjMrboyrhwsWPPWre6mKq9neSTqg8rcSiSImunaFs0iz8R
	 2mc7r7Gy6ef10qm+F+Id2r+jgMk9ex0WEfPe68WhhZyg/ruoUHgTkkCp4E7yPLDr0L
	 hClOqjJQwCzJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests: mptcp: connect: print out ping tests info"
Date: Wed, 28 Feb 2024 16:30:38 +0800
Message-Id: <ba4bd7e6339355667260e1d84962176b72b0bf88.1709109022.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

For v6.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index bb0c7bf5b368..7eb7c5537e37 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -844,6 +844,7 @@ check_mptcp_disabled
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
 mptcp_lib_pr_info "validating network environment with pings"
+print_title "ping tests" 69
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -866,7 +867,6 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
-print_title "ping tests" 69
 mptcp_lib_pr_ok
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
-- 
2.40.1

