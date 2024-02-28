Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98B24B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106245; cv=none; b=qRMXXDPTKso2AxTFEEu6FXsIIsJs4tViFenC2v/BHuHWTbKs/x3yd1vi+2M2WoXRB3WkfJCtOW7HbEpgmfrkWrDRptWAbaeQ8hHmgFovXWeHo+1a03J1PmcBor1zlwhM2mv8R9oE+GQ+CsoJhbQeVIbX++HDanc4kx5sY/TD1fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106245; c=relaxed/simple;
	bh=886+e47bbUyaw/189SA11DaJFfcoFQ4xadXS3gs+tzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N28n2NPhxI0RgkYo5K5UYmn9fhbM0X5gUkdwkqQv9XSzzapjIdSf03/QHnVCRQZkUcoSktz3Mp3gx3x4DFVZYxSPVrwHy2fgT++dyTwR7cLNu/flsBrPbs1ZWSbxpAA97FHxQkTWfqG1/igTx8u3xhOAM2sioC0wh66MDC+7ZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKFJMaKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKFJMaKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC459C433F1;
	Wed, 28 Feb 2024 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106245;
	bh=886+e47bbUyaw/189SA11DaJFfcoFQ4xadXS3gs+tzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKFJMaKwf0dC6XkxyVc5GKC/HmIG5cjICVAF8Ugr3pQ2yRpXoREK5Vk/omtM7W+gL
	 9hzlPWvPUsd/xEyfdFGqEv9z98aXdp9QJuSPBYHqTcgg4iUriTOcWLvk5RcDZyIvns
	 GLRSXc7JFnTvXYQ47UdmsRxrYAwXapZ/mKsxTE4CW0H1J6LiftHkkFgTSHqbxcvwn+
	 9AeNc3Tsn2tea1LpllOXLs6yP2CThjsvExwDfImx7KMGX8WE6svoCGyahWOGhJs/EE
	 7Z/3p+ZqoMfmVBoq8Ux18Q9Ay2X2YbmM1JlCnnYrtxFKW5pCOds7QxHA71BW+KteJR
	 JVxqPGilRAGmg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 6/9] selftests: mptcp: connect: print out ping tests info
Date: Wed, 28 Feb 2024 15:43:44 +0800
Message-Id: <e15cd3404da3211183979a3fa5e700cc97d2b770.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

'ping tests' shows in the test results of mptcp_connect.sh:

1..68
ok 1 - mptcp_connect: New MPTCP socket can be blocked via sysctl
ok 2 - mptcp_connect: ping tests
ok 3 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10000) MPTCP
ok 4 - mptcp_connect: loopback v4: ns1 MPTCP -> ns1 (10.0.1.1:10001) TCP

But not in the test output of this script:

New MPTCP socket can be blocked via sysctl                         [ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.01% delay 30 ms reorder 94% 9% with delay 7ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration    79ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    49ms) [ OK ]

This patch fixes this by adding ping tests in test output:

New MPTCP socket can be blocked via sysctl                         [ OK ]
INFO: validating network environment with pings
ping tests                                                         [ OK ]
INFO: Using loss of 0.55%
delay 36 ms reorder 97% 43% with delay 9ms on ns3eth4
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration    34ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    20ms) [ OK ]

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7a53c8fb1783..bb0c7bf5b368 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -866,6 +866,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
+print_title "ping tests" 69
+mptcp_lib_pr_ok
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 mptcp_lib_pr_info "Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
-- 
2.40.1

