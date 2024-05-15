Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8838FA3
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753927; cv=none; b=MBPNv2Q1xbXt7fuj5KOppiVFfMuriOLNrzUZLf+MLOr6csKiW4HVjTN1MPu3dATcrPWXKfxhZrLOLMX0xmqJ7ZoVkLI91riLBOMktMa6JqLRkYF5+w5Pv2Qso/gRsU50lzrN0fHVhyzZ/LhKXAHZevNfcOkmHb974w/zaevzrRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753927; c=relaxed/simple;
	bh=kvcQipHR1/lz3mcpPYPse7RhXTAUa9CAFsSB54Ymf2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlb9Bnxcn6xPvaqufAfn6RSRpMxMRyh3Dd+Wq6jA7LgpMB/hS/iIpfSdwGdiaMCkHsQDCyK+oj4XIjvciGLvubXwFa6jmsxfkZk24q06vtCfbpkVaODbsu6QUX9QCW34PPg/01sMAF3BI2PikwPdN2OqOvGYM3NkHkMSKB+Ix6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tV+LEaoC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tV+LEaoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9B3C116B1;
	Wed, 15 May 2024 06:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715753927;
	bh=kvcQipHR1/lz3mcpPYPse7RhXTAUa9CAFsSB54Ymf2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tV+LEaoCO0Wu0Wkl6bEv3nLic2Vk7EQJ6xzZK3wpnooJKdu99v7ivyaaPYyQca8Hj
	 sbcvcrGCFsIOcYkBSUAE9as12QVOPhv+BgL9dlPkHbMPaVw6X6lsuBYWUnbR+3JgSg
	 qp8qhEddPAQhLMx+tvs/RQuRi3XVbZB1EUo2of1AAQBsXAuGq8O6ziH56bh36IOW98
	 pHumeRelQQTFRh3zEfK7joKTKGyU00Y/dYGKRIBL/9y4Vl+8jFTH5vXC02XbUeXNMM
	 3WAY0pkc1NennP159WYGiFBARnE1hA8rZxY+7Q3jWThUAHhoAQfOhWFgoMDP8ceesG
	 aQO/exHoBserQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 1/2] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Wed, 15 May 2024 14:18:37 +0800
Message-ID: <d29baf6cd5f667d05511954024e1d089954972ff.1715753802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715753802.git.tanggeliang@kylinos.cn>
References: <cover.1715753802.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a link of mptcp pm_nl_ctl tool into bpf selftests, and
updates Makefile to compile it.

This is useful to run mptcp bpf selftests on a system with an old version
of IPRoite2 is installed. When 'ip mptcp' is not supported, this tool
pm_nl_ctl can be used instead.

MAINTAINERS needs to be updated since a new file is added.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 MAINTAINERS                                   | 1 +
 tools/testing/selftests/bpf/Makefile          | 2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b81b2be60b77..f973f1fb9e18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15510,6 +15510,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.c
+F:	tools/testing/selftests/bpf/*mptcp*.c
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b90c718218ae..6fe242275e14 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -131,7 +131,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
new file mode 120000
index 000000000000..5a08c255b278
--- /dev/null
+++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
@@ -0,0 +1 @@
+../net/mptcp/pm_nl_ctl.c
\ No newline at end of file
-- 
2.43.0

