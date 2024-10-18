Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A320262C
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248728; cv=none; b=Ut8i50nzUXFpXjRNaKOXkttrbRnHsJvGo9n4qIF4D6Cz0gwPGrmFAp1X0Ow6wMigEnIszNAmSAnDckg3e0OBX2Tv2of2sISa5ohvB0fSHIn34jfCVwCYqQveaN4Lp5GQJlO8Wzi9fMqS+316WaujjD8yHwoHjeL0wiiUN1Bgshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248728; c=relaxed/simple;
	bh=rRzqr3wY62rjS/C8qthJ5Nu/aL3fmuLtnvCutyE6NqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgi0RAWc8jXsKblY3e/FXrayoWIsskg5z6yspNyWjJwOktgCykqQ8/FxNdhfiuTE9JQz702rt6gz5Sg4CSEOT/KbntxytMstNXr6ryS70PEe6jwVdtQeMy+K3asW3r1nZYtZ/am2HURYiBVKgiyn1TcESjJEWdaQjwMcD8bHLjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsgID2iW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsgID2iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4E0C4CED2;
	Fri, 18 Oct 2024 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729248727;
	bh=rRzqr3wY62rjS/C8qthJ5Nu/aL3fmuLtnvCutyE6NqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AsgID2iWwn2PconDiWFDrImceFAsiW1/XoXV0CELpWi9TxeqtT4hcGHeGmjeZL8bp
	 RqVkbId+VagtKFDveLaQo8Vo3pZzTRMd5knooUjqvBkwByEWmq9mX1ByiX7ISWDGan
	 kc5xnMfibhIeNeqtjx0odmUor+wh1T+2TZXx/uE0CWVw6CEQRjO9ZZZrgIDAqj2Cs0
	 zWPt41zehn7cXuZTd8+wOGU4YLIit08Nc+4rAUZu6PyTAKJjRItNpivuLa4XLfzIkF
	 7HzeaC6CWJhGcJMgYVcNtK1tyTSZlDN9kTn8Ugmmp8L0FkHtDGhQ8GL5ZppRB5eTWj
	 +SkrmmJOorkZA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next 1/6] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Fri, 18 Oct 2024 18:51:53 +0800
Message-ID: <9ca197c4d95a73d6fda8ab8f6f6c3a33dd23f0bc.1729248083.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729248083.git.tanggeliang@kylinos.cn>
References: <cover.1729248083.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a symlink to MPTCP's pm_nl_ctl tool into bpf selftests,
and updates Makefile to compile it.

This is useful to run MPTCP BPF selftests on systems with an old version
of IPRoute2. This tool can be used as an alternative to 'ip mptcp'.

In addition, this tool is used as userspace path manager. "csf" and "dsf"
commands of pm_nl_ctl for creating and destroying subflows, and "ann" and
"rem" commands for signaling ADD_ADDR and RM_ADDR. These commands are not
currently supported in 'ip mptcp' yet.

MAINTAINERS needs to be updated since a new file is added in a non
covered place.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 MAINTAINERS                                   | 1 +
 tools/testing/selftests/bpf/Makefile          | 3 ++-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7a86efbfee1..07baea76e3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16302,6 +16302,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
+F:	tools/testing/selftests/bpf/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f04af11df8eb..662825f55f99 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -157,7 +157,7 @@ TEST_GEN_PROGS_EXTENDED = \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -726,6 +726,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(OUTPUT)/mptcp_pm_nl_ctl			\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
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

