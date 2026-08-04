Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0F43EC824
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810261; cv=none; b=Od8TcnJ6tkQ0UXxjrFZ6CYzjybBhpV6RKh9cOEnHLDj9i99Xau7LfYJbvbBi8kZJ1bEs+oOJg0mlhCom4yh+KsxCGGTRzQQYYkdEseDDxCq6tMz+RycdZSm+rWIKphHGdzCtKiMXdadmzygZ5PXk1q04xmA3ryssuKEKVYYTASY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810261; c=relaxed/simple;
	bh=bUl8q9P04oP9MIfJfn7DhAIJYL6/87yTWMRFsYLo2MM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHpwPNmcnFflpreVtqXZ161uqQASp4yp8AvQLG3vBwK+rFJUNg1SVty3FYLL89b3A8kVY55c6wjlXFNcOgAOc9EglKDowCVWzsy72Dap7iYhu4mQTIkqVpLTEFL+dVghTPCjS6MtRRXuutjanHxhLtNgTa6BuwJ6DJV8lzxmKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WwnDOngw; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WwnDOngw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4U
	tTpZIpkwOO/83se/zETkGsr3p8/gqobaeCgkkE9WY=; b=WwnDOngwS8RlHT+pDt
	i/hPl31bGT73nB46IqJ8YBkdnzJxtIeAbBsObuFBL4be/5JiMvauxeMc8juHivG7
	F/mMNOvVlXAur1AIGOZzatl30tx5vxxYjRQ3XNATYNFgZcG3c3C+ef6mVGuPbUhC
	E0B9rMnyxRTF9brtfXWxPZALs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHX6U2TXFqCeVfJA--.27903S3;
	Tue, 04 Aug 2026 10:23:52 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: l1138897701@163.com
Cc: davem@davemloft.net,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH MPTCH-next] selftests: add test for userspace PM address ID overflow
Date: Tue,  4 Aug 2026 10:23:50 +0800
Message-Id: <20260804022350.181323-2-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260804022350.181323-1-l1138897701@163.com>
References: <20260714080356.805839-1-l1138897701@163.com>
 <20260804022350.181323-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHX6U2TXFqCeVfJA--.27903S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF4kJFyfXw43uF4fAw13Jwb_yoW7Xryrp3
	yfC3ZxJFy8JF17XwnrKr4j9FyfuanIyFWDKw42kr9rZF4DGFn2qw1rKayjgrnruFZ2qa90
	va42vF45WF1kuaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zZg44PUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+hhYnGpxTTjEpgAA3q

From: Qing Luo <luoqing@kylinos.cn>

Add a test that verifies the userspace PM correctly returns an error
when all address IDs (1-255) are exhausted, instead of overflowing.

The test first announces 255 unique addresses (IDs 1-255) to fill the
ID bitmap. It then attempts to create a subflow (CSF) without specifying
a local ID, which triggers auto-allocation via
mptcp_userspace_pm_get_local_id(). With all IDs in use, the allocation
should fail with -ENOSPC.

Also modify pm_nl_ctl to make the 'lid' parameter optional for the CSF
command. When omitted, the kernel auto-allocates a local ID.

MPTCP_PM_MAX_ADDR_ID has been 255 since the userspace PM was introduced,
so no version-dependent limit adjustment is needed (unlike pm_netlink.sh).

Assisted-by: LLM # code
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  8 +--
 .../selftests/net/mptcp/userspace_pm.sh       | 63 +++++++++++++++++++
 2 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index 78180da1efcc..a9dd650805a9 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -32,7 +32,7 @@ static void syntax(char *argv[])
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
-	fprintf(stderr, "\tcsf lip <local-ip> lid <local-id> rip <remote-ip> rport <remote-port> token <token>\n");
+	fprintf(stderr, "\tcsf lip <local-ip> [lid <local-id>] rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
 	fprintf(stderr, "\tdel <id> [<ip>]\n");
 	fprintf(stderr, "\tget <id>\n");
@@ -481,7 +481,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_CREATE,
 			    MPTCP_PM_VER);
 
-	if (argc < 12)
+	if (argc < 10)
 		syntax(argv);
 
 	/* Params recorded in this order:
@@ -557,9 +557,9 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 			off += NLMSG_ALIGN(rta->rta_len);
 		}
 
-		if (arg == 0) {
+		if (arg == 0 && params[1]) {
 			/* id */
-			id = atoi(params[arg + 1]);
+			id = atoi(params[1]);
 			rta = (void *)(data + off);
 			rta->rta_type = MPTCP_PM_ADDR_ATTR_ID;
 			rta->rta_len = RTA_LENGTH(1);
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 30a809752d1b..45b040a8c0e5 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -847,6 +847,68 @@ test_subflows_v4_v6_mix()
 	sleep 0.5
 }
 
+test_addr_id_overflow()
+{
+	print_title "Address ID overflow tests"
+
+	local i announced=0
+
+	:>"$server_evts"
+
+	# Clear leftover addresses from previous tests
+	for i in $(seq 0 255); do
+		ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id "$i" > /dev/null 2>&1
+	done
+
+	# Announce 255 addresses (IDs 1-255) to exhaust all available IDs
+	for i in $(seq 1 255); do
+		if ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.3."${i}" token "$client4_token" id \
+			"$i" dev ns2eth1 > /dev/null 2>&1; then
+			announced=$((announced + 1))
+		fi
+	done
+
+	print_test "ADD_ADDR with all IDs 1-255 exhausted"
+	sleep 1
+	if [ -s "$server_evts" ]; then
+		test_pass
+	else
+		test_fail "No events generated"
+		return
+	fi
+
+	# Start listener to ensure subflow creation doesn't fail on connectivity
+	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.1.1 "$app4_port" >/dev/null 2>&1 &
+	local listener_pid=$!
+	sleep 0.5
+
+	# Try to create a subflow without specifying a local ID.
+	# With all IDs exhausted, this should fail with -ENOSPC.
+	print_test "CSF without local ID after all IDs exhausted - expect failure"
+	local out
+	if out=$(ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.1.2 \
+		rip 10.0.1.1 rport "$app4_port" token "$client4_token" 2>&1); then
+		test_fail "Expected failure but CSF succeeded"
+	else
+		# pm_nl_ctl prints the kernel error as "netlink error -28 (No space
+		# left on device)" for -ENOSPC. Match either form.
+		if echo "$out" | grep -qE "netlink error -?28|No space left on device"; then
+			test_pass
+		else
+			test_fail "CSF failed, but not with the expected ENOSPC: ${out}"
+		fi
+	fi
+
+	# Delete the listener from the server ns, if one was created
+	mptcp_lib_kill_wait $listener_pid
+
+	# Cleanup: remove all announced addresses
+	for i in $(seq 1 255); do
+		ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id "$i" > /dev/null 2>&1
+	done
+	sleep 1
+}
+
 test_prio()
 {
 	print_title "Prio tests"
@@ -940,6 +1002,7 @@ test_subflows
 test_subflows_v4_v6_mix
 test_prio
 test_listener
+test_addr_id_overflow
 
 mptcp_lib_result_print_all_tap
 exit ${ret}
-- 
2.25.1

