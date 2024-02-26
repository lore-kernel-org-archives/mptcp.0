Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8D1C6A0
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935495; cv=none; b=WdP+BTPgE1tekUCNk0qPHQWPExde6muzknhm0XzGPw+rYdgDY7kg0as96ay1CXzVMdQ1lAT8bqTzJoYPOViQALnQCPp5wtCm4fzuCeDqZGS8MmMU2bWLxAx6E3ZsiXXujYf0laZiAW18D1Ujuy0jEmi8Wwie06Ub0N6PO8k1sVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935495; c=relaxed/simple;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xtnx+UEAB7uFhCfqUx8SKLGEhzN4i7gFb6Z93JtnkhQ2gbHPLen+iRCffMfUWlOEU8y2BcXZliSSXbUrOWDl9XWj52151BvV/tifX+cefcNgGw/eW/woVuXz5RbhARx+MUnz/BKhgrPGqNKRtZn55u3P9vcH0UTh4xxPxQXRgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVqmQUeL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVqmQUeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A3FC433C7;
	Mon, 26 Feb 2024 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708935495;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVqmQUeLSVfxoh9ubumEZH9qluCXKPmczxMZarM1qctZz/Kk7e72B2sw6nP/hEKIA
	 jxpOvkB3fssmvPc2fztzRV4jgQfgskZAhg0nFwodvD8ppiJrHkgvXFK2jxWLL+Qjop
	 tMunnlWp8/uGtWwqZNANls3YnbV8CTHe1Bc041+a4yMfAx5S/36IugyQAt4YjyApP2
	 C5cBr0Rr7388//+BPvRFwTXaLboUsy++eF2UV8eTwPZfValFKEtPg0nna0mT/IVhS+
	 3YEnYLK75beTnhO72pbZU4ezuYjOjRuYCxEtbSeOA0omR3ufHj2TdJaL1ni2xOa7Dh
	 mqDb+Ok4PTU0A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 06/13] selftests: mptcp: connect: print out ping tests info
Date: Mon, 26 Feb 2024 16:17:51 +0800
Message-Id: <77c1b641cefdf9832b96759e2544e41330161a7c.1708935196.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708935196.git.tanggeliang@kylinos.cn>
References: <cover.1708935196.git.tanggeliang@kylinos.cn>
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

New MPTCP socket can be blocked via sysctl			   [ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.01% delay 30 ms reorder 94% 9% with delay 7ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration    79ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    49ms) [ OK ]

This patch fixes this by adding ping tests in test output.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 68073b255983..06e945914ace 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -861,6 +861,9 @@ mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
 
+echo -e "ping tests"
+mptcp_lib_print_ok "\t\t\t\t\t\t\t\t   [ OK ]"
+
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "
 test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
-- 
2.40.1

