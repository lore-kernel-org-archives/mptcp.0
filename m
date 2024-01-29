Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF1DDDD
	for <mptcp@lists.linux.dev>; Mon, 29 Jan 2024 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706493909; cv=none; b=slRzH2amiMwLImuWmWe+y5TVzfZyqcKVDWdWHSXxXbEsh6NnzsZBXIw5cYHbJBmIMTs8z0+LDV0yhaPGcWxbbCejkqUVNdlXYMU6hSH/g9CSbnvayjUiuYFdYWT/q7ZMJQrhO5uXGQjpu71d85IdzVEc3h5v5RIPjkH7He7cUYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706493909; c=relaxed/simple;
	bh=GFPGrHmYicnsWhFGclLwFOPwbg8NBn+6+nYAuvzdf3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tHGMjNmCsagQ49kbDGIhJ+d0caHt06K0bUDsYRBOFWviUVgKAQIUBBvaLE0oVNjCc3aPzvIdr9qN5N3SM6mifWLbRMeZCBCsUcFkC2weNQAk9+uN9xwdQECpXmWtgCQQejWzc/0WbegFQ/KhCMx5CYKpLG7RJJojL+vuwNYY0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJzmrDrX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJzmrDrX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C82C433F1;
	Mon, 29 Jan 2024 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706493909;
	bh=GFPGrHmYicnsWhFGclLwFOPwbg8NBn+6+nYAuvzdf3U=;
	h=From:To:Cc:Subject:Date:From;
	b=vJzmrDrXl5VdNr6dsMrj2wrfkOGchOf+PkBnbb/9T2KaNDRcIyxQd9ck9uOJUmi19
	 OWantfLPVzAdw+jsmSQnuxK0tHsgTodF+BwO18Wcr0XV128agibaZE0GQ49Qy6TQeI
	 FEjFBWIPhpHBoZhW3NuLeYbM7ATeGGVpcun9hMxJvxVB7lMXqNet2e82bdgTYKPgKd
	 trfb5W7A2OrnFcFrIV6HrqnUP8Hyu/vRdOnwMrRc7rIq6z0DE4SwO5EVK9xQYJxzRA
	 eGw2kTUzWjdPIJk/Tq2VUbcr1JuagPwG1kljedsAwjPXT1dNhSpGPAWmkIz8Q+zmio
	 lq5ThCyrBCtKw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker v2] tests: add bpftests support
Date: Mon, 29 Jan 2024 10:05:03 +0800
Message-Id: <52e66b47f434090528dfbadd99b8098fbaace8ae.1706493739.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

./include/linux/if.h:28:10: fatal error: sys/socket.h: no such file or directory

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/406
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
v2:
 - drop links for 'test_progs, bpf_testmod.ko'.
 - rename bpf_selftest.sh to mptcp_progs.sh.
 - fix bugs in run_loop.
---
 Dockerfile    |  1 +
 entrypoint.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

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
index caddd5f..3fb3a5c 100755
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
@@ -416,6 +425,19 @@ build_selftests() {
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
@@ -503,6 +525,9 @@ prepare() { local mode no_tap=1
 	printinfo "Prepare the environment"
 
 	build_selftests
+	if [ "${mode}" = "btf" ]; then
+		build_bpftests
+	fi
 	build_packetdrill
 	prepare_hosts_file
 
@@ -760,11 +785,38 @@ run_packetdrill_all() { local pktd_dir rc=0
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
@@ -858,6 +910,11 @@ if [ -f "${VIRTME_EXEC_POST}" ]; then
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

