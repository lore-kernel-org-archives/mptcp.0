Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D860868
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940620; cv=none; b=Xc22WZAYNsaLOcJHfpZQhr2bcHPmlVXT1kvt/t/DfdDk0oCfAyJpD/MDlVW8IpYWJB3NNBoR/MxxbyjxhQqZzvBwzrVSmXeswKtdIZVqi+8pwP0UFLq8VZbsGZqva4A8f/yLKS1jGx92YODQw8aDOHG7hl4MXLdCKSzEcws0LAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940620; c=relaxed/simple;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dl/pkhG24ZYmifzTE/Lhs+vC7pQcrlNy+h+p6anBmp1UwMpa0lWZXkO4uzrGAuDNjxOvlav4MSg21b/fPaxgEHWsQMtB28y+LANr4nRwwlnCg8h9ttnnDZregUSMa4Atq71Xe5slA7Z82TKE+jdVeW/H2iIOxe75GbXh6QQqTk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8aadkdw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8aadkdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9986C433F1;
	Mon, 26 Feb 2024 09:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940620;
	bh=YCRuwPv2m6CeZPP+NG6N29G4rt/80odeq0ZRthN18Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u8aadkdwprszS6PUQ+cgJqCle7+N2ZjaUhLqwj7rNS4ZbHHMyzjgugkQBxG3BiRfL
	 HHqX5oz56O08c29yS/GqEmqZccInSbtdNyhq6XApFQ8/jqRCilBJDVw43NNDM1lFyb
	 gnK2zfzdvmYRgRABKVs1TJc0Yp6i05sw2CpIT+VkFZqUDjaTOYtXf8keVKKCz+Kq11
	 lrL9Ylrex/6lN/mK4iSIb36DEJKfYOpmGTcxc0JS2CAOc/w/eBjA5EfrrVoXS4U74d
	 mel4ZEhTRX2MRvU1A2JrTZpwqo81ONuDynYyG/typZNitj3pOIKto0p4jESc8HOEeA
	 UrMRpntIqXY6A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 06/12] selftests: mptcp: connect: print out ping tests info
Date: Mon, 26 Feb 2024 17:43:17 +0800
Message-Id: <77c1b641cefdf9832b96759e2544e41330161a7c.1708939962.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708939962.git.tanggeliang@kylinos.cn>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
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

