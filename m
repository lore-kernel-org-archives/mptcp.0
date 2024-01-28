Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D679C4
	for <mptcp@lists.linux.dev>; Sun, 28 Jan 2024 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706422625; cv=none; b=VMeNyFXaSF4VaR1VhuI1RqjQwND0wvK8+6eC6Jnuf30EfbyS/EnSdSWR/Ss2OpIm9pOLO5GopXs+NffVHV2VnbGRy8s2Sbz6TzK/Tpq/GHVSER4VIyGVcNPYKNaxOgvpAYOMnrPvBzSrMh8ZtZhAEukXecalEZZzi1GfXlc+fwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706422625; c=relaxed/simple;
	bh=A/0GwukbZBKghfdjBoa3UB1juDL1PTaGbXIzbIm4YdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAIKzIQxrMnjhHP+ykyI+MvtF42WJdAWUektzQnlIvXl2XkvuAHOJgVv4v6u+fcybb5/8Ei/fMKQnwLBgM4gq05hxfnNfz/M5g2hWP8THYA3s67X6piRApAx1M/p5lSWb4qNLpBjMaw7XOzMPY3JCZ0CEJSSOQVkvB9WiHeIw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcZdVtqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcZdVtqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611EFC433F1;
	Sun, 28 Jan 2024 06:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706422624;
	bh=A/0GwukbZBKghfdjBoa3UB1juDL1PTaGbXIzbIm4YdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qcZdVtqe5rCoQd0XEKgOrKdcf05mlla/+oeAiURTeOd/jCBUSuSaTndtEmq/zYIay
	 WV48jmPKRBaW0TVfs/qX8z1EXox9GUiUkkpa+RzJgFmwniArGlF/G9S+XoRyqfojU8
	 6IX9zbMhTtR9OxE19sEqN+bJIiFbC87DsLYkfRvVqAYN/y+/hykgnxlcs+/SjP8VRD
	 AJERy9XT3Mg07nEI3TsL7+jOMRjinFj4pWVbxlR2BUZIgXWJQro9zJy/jXWtUMV2a2
	 0naFTub9u1YmiXYhAvs6EYqYwMY0TqNtG7o5sD32Eh1uNDViQiVjVwxSpxrB4n6CFz
	 s6itnc57UBRdw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker 3/3] bpf: add bpftests support
Date: Sun, 28 Jan 2024 14:16:03 +0800
Message-Id: <9dcddc425bd3aae5730f9c8d2c9bd39ef480e310.1706422466.git.geliang@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706422466.git.geliang@kernel.org>
References: <cover.1706422466.git.geliang@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch builds bpf tests after building other mptcp selftests in bft
mode. And add run_bpftest_all to run bpftests.

Disable IA32_EMULATION config to fix this error:

./include/linux/if.h:28:10: fatal error: sys/socket.h: no such file or directory

Signed-off-by: Geliang Tang <geliang@kernel.org>
---
 Dockerfile    |  1 +
 entrypoint.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Dockerfile b/Dockerfile
index cbc11f7..77d7423 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -26,6 +26,7 @@ RUN apt-get update && \
 		wget xz-utils lftp cpio u-boot-tools \
 		cscope \
 		bpftrace \
+		python3-docutils \
 		&& \
 	apt-get clean
 
diff --git a/entrypoint.sh b/entrypoint.sh
index caddd5f..c334cf6 100755
--- a/entrypoint.sh
+++ b/entrypoint.sh
@@ -87,6 +87,8 @@ VIRTME_RUN_EXPECT="${VIRTME_SCRIPTS_DIR}/virtme.expect"
 
 SELFTESTS_DIR="${INPUT_SELFTESTS_DIR:-tools/testing/selftests/net/mptcp}"
 SELFTESTS_CONFIG="${SELFTESTS_DIR}/config"
+BPFTESTS_DIR="${INPUT_BPFTESTS_DIR:-tools/testing/selftests/bpf}"
+BPFTESTS_CONFIG="${BPFTESTS_DIR}/config"
 
 export CCACHE_MAXSIZE="${INPUT_CCACHE_MAXSIZE}"
 export CCACHE_DIR="${VIRTME_WORKDIR}/ccache"
@@ -349,6 +351,13 @@ gen_kconfig() { local mode kconfig=()
 	# Extra options are needed for kselftests
 	./scripts/kconfig/merge_config.sh -m "${VIRTME_KCONFIG}" "${SELFTESTS_CONFIG}"
 
+	if [ "${mode}" = "btf" ]; then
+		# Extra options are needed for bpftests
+		./scripts/kconfig/merge_config.sh -m "${VIRTME_KCONFIG}" "${BPFTESTS_CONFIG}"
+		kconfig+=(-e DEBUG_INFO_BTF_MODULES -e MODULE_ALLOW_BTF_MISMATCH)
+		kconfig+=(-d IA32_EMULATION)
+	fi
+
 	./scripts/config --file "${VIRTME_KCONFIG}" "${kconfig[@]}"
 
 	_make_o olddefconfig
@@ -416,6 +425,21 @@ build_selftests() {
 	_make_o KHDR_INCLUDES="-I${VIRTME_BUILD_DIR}/include" -C "${SELFTESTS_DIR}"
 }
 
+build_bpftests() {
+	if [ "${INPUT_BUILD_SKIP_BPFTESTS}" = 1 ]; then
+		printinfo "Skip bpftests build"
+		return 0
+	fi
+
+	rm -rf ${BPFTESTS_DIR}/{test_progs,bpf_testmod.ko,test_progs-no_alu32,no_alu32}
+
+	_make_o KHDR_INCLUDES="-I${VIRTME_BUILD_DIR}/include" -C "${BPFTESTS_DIR}"
+
+	ln -s ${VIRTME_BUILD_DIR}/{test_progs,bpf_testmod.ko,test_progs-no_alu32,no_alu32} ${BPFTESTS_DIR}/
+	printf "#!/bin/sh\n\n./test_progs -t mptcp\n./test_progs-no_alu32 -t mptcp" > ${BPFTESTS_DIR}/bpf_selftest.sh
+	chmod +x ${BPFTESTS_DIR}/bpf_selftest.sh
+}
+
 build_packetdrill() { local old_pwd kversion kver_maj kver_min branch
 	if [ "${INPUT_BUILD_SKIP_PACKETDRILL}" = 1 ]; then
 		printinfo "Skip Packetdrill build"
@@ -503,6 +527,9 @@ prepare() { local mode no_tap=1
 	printinfo "Prepare the environment"
 
 	build_selftests
+	if [ "${mode}" = "btf" ]; then
+		build_bpftests
+	fi
 	build_packetdrill
 	prepare_hosts_file
 
@@ -760,11 +787,39 @@ run_packetdrill_all() { local pktd_dir rc=0
 	return \${rc}
 }
 
+# \$1: output tap file; rest: command to launch
+_run_bpftest_one_tap() {
+	cd "${KERNEL_SRC}/${BPFTESTS_DIR}"
+	_tap "\${@}"
+}
+
+# \$1: script file; rest: command to launch
+run_bpftest_one() { local sf tap
+	sf=\$(basename \${1})
+	tap=bpftest_\${sf:0:-3}
+	shift
+
+	_can_run "\${tap}" || return 0
+
+	_run_bpftest_one_tap "${RESULTS_DIR}/\${tap}" "./\${sf}" "\${@}"
+}
+
+run_bpftest_all() { local sf rc=0
+	sf=${KERNEL_SRC}/${BPFTESTS_DIR}/bpf_selftest.sh
+	if [ -e "\${sf}" ]; then
+		run_bpftest_one "\${sf}" || rc=\${?}
+		rm -rf "\${sf}"
+	fi
+
+	return \${rc}
+}
+
 run_all() {
 	run_kunit_all
 	run_selftest_all
 	run_mptcp_connect_mmap
 	run_packetdrill_all
+	run_bpftest_all
 }
 
 has_call_trace() {
-- 
2.40.1

