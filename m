Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD2F36124
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583288; cv=none; b=TmFvHQG17k1YqYw99QtvLuCveK5vqIRgNzR23jb/fmEMMWtk8mBzAejtQDFNyK4V4mUCaNNoK34BHgU2k/lB7zv4G9PFAbO5Eb3XCJQY14bhXx/a6uI5uCJVrquyxBRCGWhmY3PkNC1ZFn3ZgYL1OrQEGO95wPkpAir0ZcPl4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583288; c=relaxed/simple;
	bh=XllIU5PP4KHCy/vHDfYzdS5QKTFdoSnoikvzIgm3/nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjDS0eENwPGgV4W+DzUPucyC25Lq7RDsUHCrJRBZgS3DSay66qPlCzm/EPh8mhkOVpUEzTOnrKxwhn9Mh65qly4XYBpmYDvQj7y6mD/oox6ivApFOJN7JPZGjAD60bi4tsmkPAOe4UoyuqC0MWv7LwzNoDDnYVhyVe3p2NJfTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLFRoETi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLFRoETi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B23C4CEC3;
	Tue, 22 Oct 2024 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583287;
	bh=XllIU5PP4KHCy/vHDfYzdS5QKTFdoSnoikvzIgm3/nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YLFRoETihmUN1fNJTP11IhkGXo7PqNLR1b/Dv00esHv4VBkWeCYEcQNIsngELnRcg
	 8EOEXiiWr467J6Utu/3sVPsp7V02YtEnJphWMlZ6lJMe5LSw222M57aXqu3DBgYma5
	 txg4aSc8pExEAQ0yB4P2HjyZSdo0i32KrKJB+vJpTMFvkfI3B1hOu/kRaGqrD+vLIK
	 vJ5ASkguWMlIBx+4sIU5pCQW6lu+dqQWVBHPl3hj2YftfQf4c2iIocgGHJrCOCiQ2M
	 KpN/TbtmkW1rsxHxOq3jZ0fe+BqNfCeO+k3yL51EHB3gVlyZfae9X8rlb6LmCEIhTH
	 hbCV3IhEJ3i3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 1/5] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Tue, 22 Oct 2024 15:47:56 +0800
Message-ID: <7e8ad4d681305c2df66040addbf0b21d1ed44c67.1729582332.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729582332.git.tanggeliang@kylinos.cn>
References: <cover.1729582332.git.tanggeliang@kylinos.cn>
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
index b21dbd7a7a26..f53d8820e233 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16298,6 +16298,7 @@ F:	include/trace/events/mptcp.h
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
2.45.2

