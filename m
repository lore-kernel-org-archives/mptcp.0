Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74506F9C6
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869033; cv=none; b=fZi6rRKY8XB1qi1/JUV/GbYB3LWD13Q0RXlQ6VF7MBohs7Sv1/k9AulQhNPdJhwHL9WA1xeXYYqE13cz59LbvxkasuotfbJpBIzNLCvd+q5+1/WsEbrVkup1HJA0m47tBQmniUrzaIgErI2fUrN24aut3WQMYh8cwdTkg5e4Nec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869033; c=relaxed/simple;
	bh=gj7u+DzTV6Myhtr1009kfC0AbWTsMN5WwathYvX9Zt4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O1ejocWy/gkK0F/VlTG6tJSZW2gPMP7UxsMQ15ssfRLRSGwL8gdXd2wya6bUPNBMla0S5TsA476AWm9KDFVp9/tZ897wbjLwsPryE9eqywTM6NpqPSXn5WsiLi/krH8xYVS84apjwsHwz6KRiD80xF6b1HsnmNhDT9paqx+vebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6K4Un0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6K4Un0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC2C433F1;
	Fri,  2 Feb 2024 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706869032;
	bh=gj7u+DzTV6Myhtr1009kfC0AbWTsMN5WwathYvX9Zt4=;
	h=From:To:Cc:Subject:Date:From;
	b=j6K4Un0R92apoJ0cK03fhuFjTdrHIoM7mDW4OXOAUNTKrKbeJEBDlftANr4stp9O3
	 8Co+BK7M4DWPG2YaFTxwbI/3IxxMUALz9ELys3AKxDdNbthIlhw2VQDsH+xAFCakJ8
	 QkHS6sz4z+n+dAuUo4AeCX1NQ0ZEIWwRFfJZ4lJoki8Zg1g2AQnRIzX/Xje6Uu6nNu
	 mMUc14qN1ls451VMI62Ydt6JsP7d19/MtPSOpU4vpcxBlgh/CW0AeCZpsG5ni/C9mg
	 xtzp9vlqMFGsWOsljwj+Ux9+eKQSinDhrqD/rLqwRqFiNXOU+33BWub9ou5nLNmZse
	 GCi3HZvbcsQBw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [RESEND virtme-docker v3] tests: add bpftests support
Date: Fri,  2 Feb 2024 18:17:01 +0800
Message-Id: <8d82d9d1d8eddb660f2931edb4ef53e6ced68cfc.1706868832.git.geliang@kernel.org>
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

	./include/linux/if.h:28:10: fatal
		error: sys/socket.h: no such file or directory

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/406
Signed-off-by: Geliang Tang <geliang@kernel.org>
---
RESEND:
 - Update email only.

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

