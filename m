Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAB78B6D
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706868610; cv=none; b=vF8hRtDq53CFSUMwaJ4EPVww67Hxeyqj3p/FHEzKuhmoQHj4AUUaqyg1wFGfe6BW59rN9Y8/7iJLq3Cd1EduPz+cDqLCeTHcAfO1E1pBSARXKzeUsiA/MmubJHudnJK2EKsrvgdNPK+13TL9pkBUk5nTdlT+5eksyCqUIEzRK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706868610; c=relaxed/simple;
	bh=vYAKw2oWVVr1WdZtzhSoAVqe5xoAME/Km8LuYsz+4lE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RcERTJMd3xDj+1at7fd4WxerBo4OqneI8Jxo5WevK2vkHOXtY5gktz1ymoQPShi5g1AGh2cQpcTOqVPrFvXAPc9aI8qm7hNsHf+nfG7bRJO8yKTXDnbENf9uCbEv/H9k2UdfDTyJ8fAfFHp0fAFoYFSuB9zCZ69cL9mqzYbjCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSX4Wd9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSX4Wd9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56349C433C7;
	Fri,  2 Feb 2024 10:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706868610;
	bh=vYAKw2oWVVr1WdZtzhSoAVqe5xoAME/Km8LuYsz+4lE=;
	h=From:To:Cc:Subject:Date:From;
	b=uSX4Wd9ZfX0Ss6MnAtG98UXcAFkyOlDZdy5v9+we3ttlhRIyE9UBKmfRH/8EJ4TC1
	 IMNaJccCK5F520+mHCdM4RJ6byHxneTpkemfVL+GM8zLFuw6rd6frHhe2njeLUdmbP
	 Xyqw3FEzq5iNLYm+OKSwydVOFhKk/QF0sOWX8ggcaMLR9JGb/ZniP6agLsBCgYNYQZ
	 gzRO4FPfRyxyvRe4yvTSp1lvPUBP1XliJ3yk6JWoBZ9gq0yx3GEfdRlTWfBqV1h5sy
	 HPybLzlZyerKBKQvCx5CQTuS6ikPrFtOmRqk6ITof7GoJ9GuvzytVptW0ZE4CCwsAR
	 9/OIrCaZDr3eg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH virtme-docker v3] tests: add bpftests support
Date: Fri,  2 Feb 2024 18:10:03 +0800
Message-Id: <1d4ca2189f29d605685f053f98892a31ea6b3e88.1706868446.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch builds bpf tests after building other mptcp selftests in btf
mode:

	cd tools/testing/selftests/bpf && make

And add run_bpftest_all to run bpftests:

	./test_progs -t mptcp
	./test_progs-no_alu32 -t mptcp

Now mptcp bpf selftests can be tested in this way:

	docker run ... auto-btf
	run_loop run_bpftest_all in .virtme-exec-run

Disable IA32_EMULATION config to fix this error:

	./include/linux/if.h:28:10: fatal
		error: sys/socket.h: no such file or directory

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/406
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v3:
 - depends on "bpf, btf: Add DEBUG_INFO_BTF checks for
   __register_bpf_struct_ops", which I sent to BPF ML.
 - cleanup.

v2:
 - drop links for 'test_progs, bpf_testmod.ko'.
 - rename bpf_selftest.sh to mptcp_progs.sh.
 - fix bugs in run_loop.
---
 entrypoint.sh | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/entrypoint.sh b/entrypoint.sh
index 95ff0f9..e8110b0 100755
--- a/entrypoint.sh
+++ b/entrypoint.sh
@@ -87,6 +87,8 @@ VIRTME_RUN_EXPECT="${VIRTME_SCRIPTS_DIR}/virtme.expect"
 
 SELFTESTS_DIR="${INPUT_SELFTESTS_DIR:-tools/testing/selftests/net/mptcp}"
 SELFTESTS_CONFIG="${SELFTESTS_DIR}/config"
+BPFTESTS_DIR="${INPUT_BPFTESTS_DIR:-tools/testing/selftests/bpf}"
+BPFTESTS_CONFIG="${BPFTESTS_DIR}/config"
 
 export CCACHE_MAXSIZE="${INPUT_CCACHE_MAXSIZE}"
 export CCACHE_DIR="${VIRTME_WORKDIR}/ccache"
@@ -316,6 +318,12 @@ gen_kconfig() { local mode kconfig=()
 	# We need more debug info but it is slow to generate
 	if [ "${mode}" = "btf" ]; then
 		kconfig+=(-e DEBUG_INFO_BTF)
+		# Extra options are needed for bpftests
+		./scripts/kconfig/merge_config.sh -m "${VIRTME_KCONFIG}" "${BPFTESTS_CONFIG}"
+		kconfig+=(-e DEBUG_INFO_BTF_MODULES -e MODULE_ALLOW_BTF_MISMATCH)
+		# Fix ./include/linux/if.h:28:10: fatal error:
+		# sys/socket.h: no such file or directory
+		kconfig+=(-d IA32_EMULATION)
 	elif is_ci || [ "${mode}" != "debsym" ]; then
 		kconfig+=(-e DEBUG_INFO_REDUCED -e DEBUG_INFO_SPLIT)
 	fi
@@ -428,6 +436,19 @@ build_selftests() {
 	_make_o KHDR_INCLUDES="-I${VIRTME_BUILD_DIR}/include" -C "${SELFTESTS_DIR}"
 }
 
+build_bpftests() {
+	if [ "${INPUT_BUILD_SKIP_BPFTESTS}" = 1 ]; then
+		printinfo "Skip bpftests build"
+		return 0
+	fi
+
+	_make KHDR_INCLUDES="-I${VIRTME_BUILD_DIR}/include" -C "${BPFTESTS_DIR}"
+
+	printf "#!/bin/sh\n\n./test_progs -t mptcp\n./test_progs-no_alu32 -t mptcp" \
+		> ${BPFTESTS_DIR}/mptcp_progs.sh
+	chmod +x ${BPFTESTS_DIR}/mptcp_progs.sh
+}
+
 build_packetdrill() { local old_pwd kversion kver_maj kver_min branch
 	if [ "${INPUT_BUILD_SKIP_PACKETDRILL}" = 1 ]; then
 		printinfo "Skip Packetdrill build"
@@ -515,6 +536,9 @@ prepare() { local mode no_tap=1
 	printinfo "Prepare the environment"
 
 	build_selftests
+	if [ "${mode}" = "btf" ]; then
+		build_bpftests
+	fi
 	build_packetdrill
 	prepare_hosts_file
 
@@ -772,11 +796,38 @@ run_packetdrill_all() { local pktd_dir rc=0
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
+	sf=${KERNEL_SRC}/${BPFTESTS_DIR}/mptcp_progs.sh
+	if [ -e "\${sf}" ]; then
+		run_bpftest_one "\${sf}" || rc=\${?}
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
@@ -870,6 +921,11 @@ if [ -f "${VIRTME_EXEC_POST}" ]; then
 	# e.g.: cat /sys/kernel/tracing/trace
 fi
 
+# Cleanup
+if [ -e "${KERNEL_SRC}/${BPFTESTS_DIR}/mptcp_progs.sh" ]; then
+	rm -rf "${KERNEL_SRC}/${BPFTESTS_DIR}/mptcp_progs.sh"
+fi
+
 # end
 echo "${VIRTME_SCRIPT_END}"
 EOF
-- 
2.40.1

