Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615221DFD85
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736325505; cv=none; b=F+IWI8/Y7bB5VWwh5keUrSfYoA7VspLom7mFzI86bYdRVwS6I1F1nvDgOd1LIoHYW42n6yPIBvQL7m+huwFLFp6/muHoa+NUYBg1EqUSkmtajbuckrf1WpnR0i2/df3BrLMQfHPQa5Q0qjSybP3STQjNzvHKJuOUvwKd68YDFRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736325505; c=relaxed/simple;
	bh=I9Kkgsrmf+ucCl5JyvivsiSKOw4HnJd3RKFG0KEVVrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCdESm9dEPLsVcjMg0A5v2ai1zVFP4ZWnHiboiAbYVD3G1WQ5IpOe+XnPI/ntqOh+XceYjLto6DX+Wbe0IgpTIvONFcOdd4e5+DEucPslm6LrSzXHxmxjwFdnW5kWB4iztrCpXvU1FK9vUrX8vYoxZHldGevMcpsK9xw3DlDSXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUE/Jahg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUE/Jahg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A68C4CEE2;
	Wed,  8 Jan 2025 08:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736325505;
	bh=I9Kkgsrmf+ucCl5JyvivsiSKOw4HnJd3RKFG0KEVVrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUE/JahgJIfh94yPUYdSVWr5mNCuSTSG2d0ObTRhRo4Ne0HazQX6JQvm61JCujmL6
	 4TJdUAHZI+3KxQvNr3Kdwha1rvk+4UedDA9nm3tjyHZQWKUoa/WrAsA6/O4vBtVZVH
	 sl8jNuFMPr58TmlyG2iLklHOW2e4SK0NPWjdc2V8DpUpEzwTb0TGgN1ZI91toQTIWm
	 iXMbVFCKdVp/BABNcdaKfKbwmpNyFXhYPQOFbVV7ld7ChGGAUek2xbf2SPQwL9yXI8
	 xww3qd1GXnaugoWb+ixSgV9QQNr+eJ1Tb4qR7lMyeaj4AmF9JLX4IUPMljGJT/SSVf
	 9rI8MBGXHMiAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v4 1/5] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Wed,  8 Jan 2025 16:38:08 +0800
Message-ID: <76a98d9ce8e1b2829dda64e22a2bb2c6ac7695a1.1736325184.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736325184.git.tanggeliang@kylinos.cn>
References: <cover.1736325184.git.tanggeliang@kylinos.cn>
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
index a685c551faf0..3aae91daf9ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16480,6 +16480,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
+F:	tools/testing/selftests/bpf/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 0a016cd71cba..a9a6dc1a806c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -168,7 +168,8 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdp_redirect_multi \
 	xdp_synproxy \
 	xdping \
-	xskxceiver
+	xskxceiver \
+	mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -767,6 +768,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
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

