Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914103EA7B
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715769519; cv=none; b=ntb1yd24dra+p2sI5edFU59pGNr3hb6CDw4jqXhbUDav4Qr668n9V+NzF0z3dK6/Jmyw0DFTx77/af3nvbS/BFRWLpGHPXfLCNx36QbbImzXFjQwpXuiaKF9ZWjHwayC3caZl0HeR8f/sNkkLakEIneZeTE8tZSqKfXNVPMS9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715769519; c=relaxed/simple;
	bh=ZA3nWNrMLAdPElQPcUCRg2YJtueUDkldRPpnM5YCXuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4c/gx2qJnRlBTnPMoIQTKp9gqWIDFmKB6he4YbZj0y8wcuotyGjGEEZNHw/ovk1lOyMoEj7NEEQj4OXiYowCOAkI+jA5kUMZtVpIj2GV2ZwduVpfU+FUdI6MGepiJOEyH7TOqk/3Tc7U1GknKol+GJJVK535iihkgdDQUmG6X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHG/fFI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHG/fFI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C3DC32781;
	Wed, 15 May 2024 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715769519;
	bh=ZA3nWNrMLAdPElQPcUCRg2YJtueUDkldRPpnM5YCXuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHG/fFI9Sew7/xIQjt+v9HEyv7T7QGdBPuYx6OLQmbelt/I/8AlKyEIyZrsXiXGJk
	 poSvzGcK+2p1oEmy1InvMmnF2cpniOZb4UfrqwNmqTGpL7rxrHg1EfyHvEsN4YTTvO
	 E2wgBBetiN2s8o4CQOLb5Y1DtaO3HLDhzA0BFQMHK3IsDnxjad0s46dQl4/1CW7vU8
	 Nxv7SGxeETfAvySOmJpnfykmwc5PB3ndyaC4SC2c2WzF+G1Vx89UXVhKigmnokKl8Q
	 BgVDeIWfozbj6oUw6YtQ0s44NaJkgCWRWMDFQ2EUr+2Mt1KvUjDSGjrxMQGRSSCeXU
	 JQ3lUkYtY7fgw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 1/2] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Wed, 15 May 2024 18:38:30 +0800
Message-ID: <a4e6adbefdd4b7948d02566c4b54325b44ca35b1.1715769419.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715769419.git.tanggeliang@kylinos.cn>
References: <cover.1715769419.git.tanggeliang@kylinos.cn>
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
 tools/testing/selftests/bpf/Makefile          | 3 ++-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 504def176aab..86cf39b2be13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15514,6 +15514,7 @@ F:	include/trace/events/mptcp.h
 F:	include/uapi/linux/mptcp*.h
 F:	net/mptcp/
 F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
+F:	tools/testing/selftests/bpf/*mptcp*.[ch]
 F:	tools/testing/selftests/net/mptcp/
 
 NETWORKING [TCP]
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e0b3887b3d2d..204269d0b5b8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -144,7 +144,7 @@ TEST_GEN_PROGS_EXTENDED = test_skb_cgroup_id_user \
 	flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
 	test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
 	xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
-	xdp_features bpf_test_no_cfi.ko
+	xdp_features bpf_test_no_cfi.ko mptcp_pm_nl_ctl
 
 TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
 
@@ -645,6 +645,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
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

