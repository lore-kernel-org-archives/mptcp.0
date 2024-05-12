Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60887634
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 00:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715472502; cv=none; b=KFYBYEpsRW+xFzBtQHBFSA7t05a1AODA67EbhLrMxWJleAszKEuw+CSjQ+hYesSsPHtKNC/LY5nY9EACJgwGngfsoPI7Sl67zdgzdnwnBE54k+Z1dDk5Yqt6fWqrUq1D2FqFsCIwJKSAmCl1lrqYR4bgDWLZENlOFv5NnTbXAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715472502; c=relaxed/simple;
	bh=DONqTA/CraJ+D80HwKnW86cZUNxIdDhzYHjOFia6Vgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2OdLti6AEMi3cPj0r+6SsYsIkxnp6Jun51KuXYcEWRFnTWW7ilHRSC7Z6lP8Evsg5X8+c4SgSLMyiclG8HOU9jQ2i1ev/4UDaXDq2d5lU672ml8SeSVWM3VumYwAIeRsIS7ILpRQT1zwwzgvTPI8YM/7YElj2tjD04tg8lET+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9pc7SBa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9pc7SBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29466C32781;
	Sun, 12 May 2024 00:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715472501;
	bh=DONqTA/CraJ+D80HwKnW86cZUNxIdDhzYHjOFia6Vgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U9pc7SBaYnP2UGxgAWIHxTnQYPA/07pPT7m9yQjjSekAO3nkRwkc7RlYosUHMPF/g
	 pWcfTIvYSc1iMDDcRbO7QLjBRzfyFOCe++TGF20kMvjR2G7OKZ+ijQpps7L4YpUTA7
	 OkrG+Ha0/KCNSILEScM7OW35fpZPCmjQNR3BKfgPOO4/xZZG1mtUBponmmgY3gUK95
	 rxnFg8NO/GpHVb2KiTpHrMlqwNT4bLz3gyOUHF6WxI9jiEo/i1NUW3o8C+YBHOronJ
	 YSKZoT1e57v3IkQvGbEatqT26BHsMLjX0oJtmnQ0sdnoTve4X+OcvF7qjmUt+sLZuC
	 K2OFEBz4ysGag==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/2] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Sun, 12 May 2024 08:07:31 +0800
Message-ID: <dcd8d80fab23f5c934ed7d4c6129cc517e1c504c.1715472312.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715472312.git.tanggeliang@kylinos.cn>
References: <cover.1715472312.git.tanggeliang@kylinos.cn>
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

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 MAINTAINERS                                   | 2 +-
 tools/testing/selftests/bpf/Makefile          | 2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b81b2be60b77..c5b5c6db6011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15509,7 +15509,7 @@ F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
-F:	tools/testing/selftests/bpf/*/*mptcp*.c
+F:	tools/testing/selftests/bpf/{*/,}*mptcp*.c
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

