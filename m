Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B289A47142E
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791860227; cv=none; b=oWuOdxyWZ0OlafEWTfCryr2Jq7n8dGV/SxmEFWtBQVtiZ1Br9awN9YG1rD1w+YEnSQOft8aoWuLGFbKBts4ctTIr6N/OvHkO5ni9vTe1vgqDt41jSMDk/XPRDnujSFy3tw3MHHavOhGK2OlnSDDeTFmiVQIA3/Ctl+dZNbeF2Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791860227; c=relaxed/simple;
	bh=P2eJhOKhDcIlHpULdszDfO8cZXvQuCe2SpqCQHFVH5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hbRnmpjUtELGUhkNFROVuYdQmeG96djPF2E1n1mfPRynNEcKoEawvjTTtbs63r95/GMSskHTCBDC0hhVkGrJTuNbQMroIwq1AAygP0MHBrbKUIOs2DieZ6tPp3ArCuwYp9QXXMIsGOdfsa7mmeFKGk42ctENQi2d+0sPismJEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSarAwiK; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSarAwiK"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35834f72d94so4401174eec.0
        for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791860225; x=1792465025; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBU8hbUS6qfRwknqOFOVdYm2Tk7lCg4s0gQHHg8xU0c=;
        b=RSarAwiKF1YM2fDlVS+HGXBJbide+QMEYN9yUjiUFCeAoM3OxM73Bj081MZKYvgiex
         jceZIxFrOIvO2Zvc2lGS/qcMxX3MnHebCcvZ5qmIo1q5QFe2wMd5VVd8DzvJFJ/zB+bh
         aiuUSgjAjFd4He64/lIcNHh6CgGQ5HN+Sp76WvOnmGK/kcAVz9ciGPdVAFq77jF84EVS
         EglT94WEL/+59WlbjOrw3nmIzkcZuYM9LY4MO8lx7EG0L3RD9Stej7JXZLag7MSWWM2T
         7W1kAJZbVBPzta3Hz71tQK9wJJ9UJg+ICyh1lZ3BeNSU4nMxSboTkqBA9gbfCynB7sju
         lFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791860225; x=1792465025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBU8hbUS6qfRwknqOFOVdYm2Tk7lCg4s0gQHHg8xU0c=;
        b=Bwb1SUseKIUFvYQwYXQ75qaWFtxrtpaHqHU94uNYoq7Pv6pX4ueVwSD8jaTg80sDR7
         uKWrBZ0U7sP/bahEO3vJNod1t59J1/HJaq9E+YsPpoR8U3dDI2JAuVofAo4mKWJ8W+f/
         C7Hv2fRlvey4hZ77c5aZ74BY+4+VG2/TWGVpoiPO/g3+PuT3i2gUI2BIJoRtaPiod8PY
         iCVcp78H6TAY/F/ApaOTjmEiCxnAi6unlX40ruTeYxcn/610nV8emjqQb7QIpHXLHpge
         ZjRbBh0V3RGI/8DJWqDX6R01AkIS0vduU/IKLbJYOwO2krov+F9J14l4VyO7auWLtSWH
         GHAQ==
X-Gm-Message-State: AFq9FYLNJg6GxL7dLxtWHP3bAZqj3NLuvhXfTvVoso0RT7fK6dVMkw7Y
	rWsCplVzRzHOzdjc9pd6OBUQ+BJD5qUj1b4EqT8SOjRQTziEwhsTbc49v0eZYw==
X-Gm-Gg: AYBFou2uKSUbL62B9eq5DIOV2K4kJABRgCf6gxs1VaIFL2h39ecjIweM/59QWiLU4mC
	tBfgbcLhiDIuv4Jk79ZmAGIi3aqyyLFRiiWRxZJMMz3D4/iptWp28J9wCW6OQ5HDoV5HF6onmFj
	nYQRVrMqahH4AqrakrdlpYupF1MNZfZj3e1PJzAQUogFAE2Ktt3PDEhwOdIHPGYvCG/aMoaIBkq
	Hp0uaLtOOuM+/QDzvzOsEUtt3TsLK7LQQU4t3Lssy2BpOKaU/Fy1l269anrSY9t/VSEMN6xnAd9
	bmVXw6009nST05o836bAaUXGqAV5ExAVHYNF+N0aHVgcLFILh4VDEY0gyQNT2bEzCE3Tx7PFy2/
	rJDdGjRbCe22zcRomcNDx/0zqVYOC2fi2a7LKP/oW8N0jO/PFTkHzVngiMD1bzBN6PmHkF26tyP
	sfFp7BqI1vqMppiRVzN7MI3vdyrVzA5l5mP3mJ1yOk2gexn4j0sFxm2Hl1IqTam4Yzlk2BKMwHc
	AMiceHR7ZnE+vOVDvXJcluYYDxdT2BCRBhakCfdgPhJ00qpFhYL5VPuFiQr7VYRFmD3WF1Mrd2R
	IQgwHBvgseJSM2TE+i178HbGu4QoctKb6uL0IAsEw5A=
X-Received: by 2002:a05:7301:3f07:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-3588f02e0f2mr15127894eec.9.1791860224475;
        Mon, 12 Oct 2026 19:57:04 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb2954bsm39890217eec.26.2026.10.12.19.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:57:04 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v2 3/3] selftests: mptcp: join: validate subflow retry after link failure
Date: Tue, 13 Oct 2026 02:56:53 +0000
Message-Id: <20261013025653.523755-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
References: <20261013025653.523755-1-anilkaushikwireless@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the new sysctl with a long connection in the background: drop the
packets the client sends from the additional subflow address with
netfilter, without bringing the link down, until the subflow is closed
and a retry happens. Then let them through again, and check the subflow
comes back. Then do the same with the initial subflow.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..10c431304d78 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,68 @@ wait_attempt_fail()
 	return 1
 }
 
+# $1: ns ; $2: minimum number of retries
+wait_sf_retry()
+{
+	local ns="${1}"
+	local retry_min="${2}"
+	local cnt
+
+	for _ in $(seq $((timeout_poll * 10))); do
+		cnt=$(mptcp_lib_get_counter "${ns}" "MPTcpExtSubflowRetry")
+		[ "${cnt:-0}" -ge "${retry_min}" ] && return 0
+		sleep 0.1
+	done
+
+	return 1
+}
+
+# $1: expected number of MPJ ACK received by the server
+wait_mpj_ack()
+{
+	local exp_cnt="${1}"
+	local cnt
+
+	for _ in $(seq $((timeout_poll * 10))); do
+		cnt=$(mptcp_lib_get_counter "${ns1}" "MPTcpExtMPJoinAckRx")
+		[ "${cnt:-0}" -ge "${exp_cnt}" ] && return 0
+		sleep 0.1
+	done
+
+	return 1
+}
+
+# $1: ns ; $2: minimum number of retries
+chk_sf_retry_nr()
+{
+	local ns="${1}"
+	local retry_min="${2}"
+	local count
+
+	print_check "subflow retry"
+	count=$(mptcp_lib_get_counter "${ns}" "MPTcpExtSubflowRetry")
+	if [ -z "${count}" ]; then
+		print_skip
+	elif [ "${count}" -lt "${retry_min}" ]; then
+		fail_test "got ${count} subflow retry[s] expected at least ${retry_min}"
+	else
+		print_ok
+	fi
+}
+
+# $1: client address to block ; $2: retries ; $3: MPJ, expected after it
+#
+# The link stays up, but the client packets from this address are dropped:
+# the subflow using it is closed after a few retransmissions, then re-created
+# once the packets go through again.
+sf_retry_after_block()
+{
+	ip netns exec $ns2 nft add rule ip filter OUTPUT ip saddr "${1}" drop
+	wait_sf_retry $ns2 "${2}"
+	ip netns exec $ns2 nft flush chain ip filter OUTPUT
+	wait_mpj_ack "${3}"
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2647,34 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one, with an MPJ using ID 0
+	if reset "subflow retry after link failure" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/subflow_retries'; then
+		init_nftables
+		init_shapers
+		ip netns exec $ns2 sysctl -q net.mptcp.subflow_retries=15
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		{ timeout_test=120 test_linkfail=65536 \
+			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
+		local tests_pid=$!
+
+		wait_mpj_ack 1
+		sf_retry_after_block 10.0.3.2 2 2
+		sf_retry_after_block 10.0.1.2 3 3
+		mptcp_lib_kill_group_wait $tests_pid
+
+		local retry_nr
+		retry_nr=$(mptcp_lib_get_counter $ns2 "MPTcpExtSubflowRetry")
+		join_syn_tx=$((1 + ${retry_nr:-0})) \
+			chk_join_nr 3 3 3
+		chk_sf_retry_nr $ns2 3
+	fi
 }
 
 add_addr_timeout_tests()
-- 
2.25.1

