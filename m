Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8D1DE3B6
	for <mptcp@lists.linux.dev>; Fri,  7 Feb 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738924571; cv=none; b=Pk5ZhSs9qmIT9O5AKeAfwZI+bBXwa2O0smR9bmp0K+c3tzbeKax+BcYBldghb93L7KNgoqkPEQpv2n2hmPg+pSfkuAM2111zaWRUHgNzdKj09MffWMgS9ngjWmXXITvL9CLWmKEXUhiGO7m5Vs2fB9HnYbZza+bOQzYUzgwV9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738924571; c=relaxed/simple;
	bh=EEB3G632FIQ0aLrd1yz5DVaSz5vWuzdaCOFy2K1TMT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9DLNbpzYLLKOXUk/vthXxxQqJ5BLhFmrn3YYhCz7VTSPHd4OFwMvErT2RujBJ0uX4iOlPwyY/pjKlaZy5d5bRhXRiDBFNuljNUbqp4jFqcRyhBCPEQYJLfBjbN8l6SBVWTuzfRiSEtKYT/6EqTxone1K+yaZrjluW/ygB7Rc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/d5pgpt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/d5pgpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE65C4CED1;
	Fri,  7 Feb 2025 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738924570;
	bh=EEB3G632FIQ0aLrd1yz5DVaSz5vWuzdaCOFy2K1TMT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/d5pgpt5YX6Ud+uWE7TCjWMFIAhSN6wLIMGFiaKmkpggS+Abo5UyBzsnzhjvGYPx
	 EM+2nX1D9ZQLh70ZV3rIo55EKH7bqS5dqu6xNRlMH4V+NIkuepMi53+S93X6Z2tghc
	 kOZ1usnfYQgPp5RNE/MVaTr1Aaq5fIGeziJfIC6x83FQJwKmkzxKuotZgxzYWopMZJ
	 7LaRUszmaPv03xaAlqNbi4EkAZEVq3CMRMz+tAvSILH072IleeQOYCLGBzKh4kHcwm
	 TH0bViDggeiPK9ogaPz5uHo3xq6Mzqr3ItQ33T+NN/5oPVULRSNTq2denXGhPwJC9d
	 Q/sSAxpu+rr5w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 1/5] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Fri,  7 Feb 2025 18:35:58 +0800
Message-ID: <8cdb0df7316a6baa93df88b0fe78aaa710f3bb72.1738924354.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738924354.git.tanggeliang@kylinos.cn>
References: <cover.1738924354.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/Makefile          | 4 +++-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 873aa2cce4d7..8543bb0e6bc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16632,6 +16632,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
+F:	tools/testing/selftests/bpf/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 87551628e112..98a521db072a 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -138,7 +138,8 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdp_redirect_multi \
 	xdp_synproxy \
 	xdping \
-	xskxceiver
+	xskxceiver \
+	mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -719,6 +720,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read				\
 		       $(OUTPUT)/xdp_synproxy				\
 		       $(OUTPUT)/sign-file				\
 		       $(OUTPUT)/uprobe_multi				\
+		       $(OUTPUT)/mptcp_pm_nl_ctl			\
 		       $(TEST_KMOD_TARGETS)				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
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

