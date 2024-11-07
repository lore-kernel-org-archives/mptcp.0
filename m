Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F10BA2D
	for <mptcp@lists.linux.dev>; Thu,  7 Nov 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953761; cv=none; b=Db7FBEOaJUowJNRxvGk2eV3WgDQ9QG5whJtHgsRmXtpXjYsL5ZGw66I9ArVzJEJquK3Drk6I2J/86ZtNB04RYPIF3HfMTZswZBBty9ViSb7a3ogSrkbEeg6KPFiODou2ebQtotcSagEsefbyKUKm1uTcVA3adJD2NsmH4MOfpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953761; c=relaxed/simple;
	bh=09RdaCTiv49TW2GFGfzTktARHICJTs4jmSlv0PoS7Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6CpvSqZv6N3iYaQJggp3Kn78PG515ZIDzXo0kQQgwh4oYra2glzi8Mb5iLObSVY3FBiJfaN9HI7/VHYeg9X71yh2+9BXGJiA26WjEGWTwpXV7iYWtfomrX4gJfGNpfEEZtqaCwYODg3kdy8slWU9DJgfb2iJf28hmBUTFqnShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTts4nqF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTts4nqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A91C4CED2;
	Thu,  7 Nov 2024 04:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730953761;
	bh=09RdaCTiv49TW2GFGfzTktARHICJTs4jmSlv0PoS7Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YTts4nqFTMg9TnAgfaEs3q1SL86Ujg7MEzHzMGx2ft5UnL03PIJa/ROTpbIygLjCy
	 z1cxm0eS0Ho9BU8u/uCeypv9uWl5FhsRgfuS4G2IaunYsvU3Ycue4tBrLBmm7uTQ9c
	 4DBF5oyYhVVlybls/KXsWcGw+ylQBCiCWulTe19ge1FE3O9nOyp9C6it3uhO5f7eqw
	 OurlbQ198hSTSObO1Y9jhaQFrYDa10a1r4zkL4ZeZ6exF90nuAduSRLtzrRK0I1LwC
	 XjxA1bGJN/WGRE6xCgrsAwVuMo0IFgCYn3SVZ1d+yPD0w2pJp3vnnUM148ErnjRCyI
	 BHiCUhUbyVCdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v3 1/5] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Thu,  7 Nov 2024 12:29:06 +0800
Message-ID: <2aee2d298df0e490293d8940017bbba0dd2b799e.1730953242.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1730953242.git.tanggeliang@kylinos.cn>
References: <cover.1730953242.git.tanggeliang@kylinos.cn>
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
index 58b49ad6657f..89ce2a480a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16211,6 +16211,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
+F:	tools/testing/selftests/bpf/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 5c1fba253b72..a963c298f034 100644
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
 
@@ -752,6 +753,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
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

