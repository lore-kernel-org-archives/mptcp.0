Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE14514269
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431377; cv=none; b=bG3SzN69T1NYmadoLFuC0CNPsJ3nLdkVmVbhwxoL6XyZchpouiUl3B8YsD4obvEnY2R0HZAvZ8X8dgRylyLAdAXmToIXQU4bWWTUw7YXxdXzkVhv+G9lG+eDdKF6Yl4r1/fxphq6tPxNIdkwiLdNmFJJ1Fz6x+ArlFRvjXjguFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431377; c=relaxed/simple;
	bh=7CppXmjsua9WD0UQHUOMxgmB5kI+QIRVOmlFKMpHiNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4mM4q0oPfw4ft/V++poov19vwS3ohvks+Uy+alcb5WKgS6lgFiRRAD+r8udUCox4yAvTZW8qPJcwfnTajyj30F7xcZtJqFMAsubHiydRbwiYoVAezR9kjhIv3Qr6EI2nVqH0wXPEkMyBiUKgfFYncsqm3TluxTndHB2hxqqeFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikIKKS+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikIKKS+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBCFC2BD10;
	Sat, 11 May 2024 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715431377;
	bh=7CppXmjsua9WD0UQHUOMxgmB5kI+QIRVOmlFKMpHiNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikIKKS+wNh3qTiQs3oJVaMmkpZBsZ+0GowBLo4YAXVcm+n3EUvXddd85Gu02TxqHm
	 pha4YnQHIHsVz0QtVQO9yGXRKLygSF7R4RqNCJyJf1hEMChDoAe+KRnx7HUnzVGYM0
	 3tkFdkfzG0wKPy0fD2UMXQJzfOrGFGzidmzHL0/xExx/IMFRAzR170FU3N15Z3gq7i
	 ovdBEp82mS1t+1h32YDww3WIlxBTK4y1Wy0NQT5XPdDRsfoOqqtlMVQ5RzZNISK4vP
	 fNnfusBJlLMSNbB39Kw1vbKC42WmpXeOdE9Q3cWSC/LCGciveZjhBxEAMKfdpDITJ1
	 bKaJ3ohN1njMA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 1/2] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Sat, 11 May 2024 20:42:05 +0800
Message-ID: <09e75e5622ae54bd6e160993ccf0a55b16139c71.1715431177.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715431177.git.tanggeliang@kylinos.cn>
References: <cover.1715431177.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/Makefile          | 2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

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

