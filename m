Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A87C128
	for <mptcp@lists.linux.dev>; Sun,  4 Feb 2024 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707033688; cv=none; b=mzsxQh5iQl6Twxmwpzoy+pXw53fBk0GgKlHT0W6xGu5pnnFsDUpPcRMr3gir1cM1RyPBMhrI9wt/8p1MwHLjf7BuLzjVVRCW3TENKS63xgqYXLdYgfiWSrxjqRYdmk4i4w0oNSQhHgPq5GQkolw9c01I6MPhM1JKyA6FTRmirpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707033688; c=relaxed/simple;
	bh=Ug0beqErKkWwKr/x7sGgJxP0jfkWtlmZS6aEFl+zFXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LAhN5BfU6cpESOP3FG/88J5AwUUMPNG7eZQ40v13XQSjx0O96WHs2VNfVPLUf8VFGLoDdjLrb+iYBu0IDMBDBCeWAZ75cjXmDJj6Q6cdyzCsKKXzQ4suWV3BCH0EcJY5upVOk8yOMbodztV0sW5cbcWUwPe79i5+HaVPF9Sjtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnKwwGkr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnKwwGkr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78534C433F1;
	Sun,  4 Feb 2024 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707033688;
	bh=Ug0beqErKkWwKr/x7sGgJxP0jfkWtlmZS6aEFl+zFXA=;
	h=From:To:Cc:Subject:Date:From;
	b=dnKwwGkr1KIy0Dpks8p0X8/0WZYLhq4QlpG7pO/vQoqYai7T3vWp/muCa5OvEU7Ad
	 0mgKOKxzsPA3omNX/3CZfbTYt0KhngTojovFYDmPQEyg3x0GRcqIBopzYl2bEbIH/5
	 ZV8zyTf+DVUvwJk3lUhVW3HjYZPetr7Ik/UZnImd7nhHgQJnuWuelTabCkrpWD5NBO
	 CfTIveWaa7mj3w+Dqe1URobFjqBsivDWZFDW7Tvqs/Y0+Ag106V1rJK5Kqk0yzoIW+
	 EAcYurLw3bx+AWnfHYOia2t8jGJwGM11pTPqECgj7Kh3Jdhr13RaoH/22KCsX4jP4y
	 OVJuoqetYgqAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>
Subject: [PATCH virtme-docker v4] tests: add bpftests support
Date: Sun,  4 Feb 2024 16:01:23 +0800
Message-Id: <d06fa9d096d8082675079f68d0eb213f5314fe15.1707033594.git.tanggeliang@kylinos.cn>
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
v4:
 - test mode in run_bpftest_all

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
 entrypoint.sh | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/entrypoint.sh b/entrypoint.sh
index 95ff0f9..ae3d295 100755
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
+		#		sys/socket.h: no such file or directory
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
 
@@ -772,11 +796,44 @@ run_packetdrill_all() { local pktd_dir rc=0
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
+run_bpftest_all() {
+	if [ "${mode}" = "btf" ]; then
+		local sf rc=0
+
+		sf=${KERNEL_SRC}/${BPFTESTS_DIR}/mptcp_progs.sh
+		if [ -x "\${sf}" ]; then
+			run_bpftest_one "\${sf}" || rc=\${?}
+		fi
+
+		return \${rc}
+	else
+		echo "skip bpftest, only run it in btf mode"
+	fi
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

