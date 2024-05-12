Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA8BCA40
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715503344; cv=none; b=H9OFtwFOHh3EVsC0C4FVh0oqYH95Rr9ASWhoQc3vMX3VGATkNVUDi1nUO4ABedgTaJXzUmEYHRU0OgOyuKETaio+HBFl0bRp3HM1K+9wBROTW+8gYW0Q91U4d/OoMFtSBPYyZPv8/YsHauqmdldTRO8cpyCZVVhKAomCm4LMKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715503344; c=relaxed/simple;
	bh=kvcQipHR1/lz3mcpPYPse7RhXTAUa9CAFsSB54Ymf2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2eoqvGeNTje1m3gqge1bmzWWDh6Jxuk9zzr45m8UIcq1dOd580lrXAADRGrc+q/LKPNJdABybCpPdbYf56AEDCcyqg1bcRaOTjWQzScUbGSAZNfb5jiIB00/NrVFcS4v7l7ET1Iq0b3q4XEb1mv4pyaT8dz3uT78GL7ftW9un8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yt4v7Hqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt4v7Hqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A8EC116B1;
	Sun, 12 May 2024 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715503344;
	bh=kvcQipHR1/lz3mcpPYPse7RhXTAUa9CAFsSB54Ymf2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yt4v7HqegOuM3ngr9joAoMYDuSpGDqL2bSW5rlr5kYyQa1/RNXnKhEeM7JOOv3MnS
	 Pb7DjvjkiiNh2+NqtNf0tMTmbAug5sHYrMjp2MZnBHntrJTYTJbEkNSZSC1KZt4qGd
	 5cycZBSoOw0MDRFKiIxi1Pw6UgtkNPLmoea0l2ntW3vatCDXkSczcR/qTDgugRRUJV
	 OHPgvnQWQ2mbfNFglDY2fDtanLz2Upvd5PTZtvMxYQWArptPzuzzZRDiXOHdnkPahP
	 t4C9wsi1gejK2/WolIh8kBfiYjjg4E9atyjKEqmyQ7CAR6SNpSqLAq3+c1mGjgIvHe
	 x/WMEO6G4+tBA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 1/3] selftests/bpf: Add mptcp pm_nl_ctl link
Date: Sun, 12 May 2024 16:41:34 +0800
Message-ID: <43447e40206035723d86f4e06b0bbec0c8d4c37a.1715503185.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715503185.git.tanggeliang@kylinos.cn>
References: <cover.1715503185.git.tanggeliang@kylinos.cn>
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

