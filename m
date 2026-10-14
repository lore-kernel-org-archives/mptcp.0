Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FBB38E8A1
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988442; cv=none; b=ASB3oufrKRrxIyDQrMmKRdmlC3A0hYYsPcZPz7navsA1iPN8chELSmTYLNHPrQL1nLfEqpPYMSIMumbLJp2tsW2RfU5yos9QJDwuZGhFWDGtf6T/nqmmC7m1n3gmpO3FVpZ8ukHGUwGm9La7WbyEmzJ7KNY50ifnehPZJ1FauBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988442; c=relaxed/simple;
	bh=noAVtA+7uv++mf4e6CUtE7thOGqYcvwmez50yioeelE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fKqCy9x86nzWdyiTTmSvXR5USPLToGJG4iK+tiDgqEblkPX36pM4fkceHhWV1WgbM4DH16kb9JuKCf9GuahlNvZLeUJ/XtfcQRgviaclEx+8GJGh19oi9ANLVJbvm921afOuE8UDfvYE4yf6U1uioD9dRDBLp5LzXhnBKpQGZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm/Dz4eH; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm/Dz4eH"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35b2c599f43so5127854eec.0
        for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791988440; x=1792593240; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F8Kb4zP7iCujVb4rPtJclw5x7/s5folut5hqnEE0P3Y=;
        b=dm/Dz4eHjlDFkL/6diamJamDXLK2+NeRk8yjr2QD//HAhkjwn+Edl8mXlPKUYJ7ak4
         AM58nBIS8aewV8I7yzIcsuybEW4tY57Tnc3+xkx4TWtQhKbrA2Drbw7RQc6kFeSo4EJY
         QGzep+ApAagNJ/E5sBNU0UbrqKC1vtL5GUuvnYf6dkHodJHOjQ5ibrats1bcYFilc+41
         Ko3+Bf8fVHVVfwp7RxasWmpapqcMM7z7yKpGYNxMA2EsJpgRblUkcqWKuPWYDXLKoTZ0
         2ftziwpoMjMiDgpjzmj8U4Wb718IOIZRH7emn8PvQLvfwdtGsBWrFlbpqSLoIJ91mF0h
         c5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988440; x=1792593240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F8Kb4zP7iCujVb4rPtJclw5x7/s5folut5hqnEE0P3Y=;
        b=vB68hRYNFQonE+QbqGfaRMPRXEf5F8x9P9fSfWgKFZdtfclwcJK3tOX8PQwqU7BIgE
         QM1ltOyVFn3xxiRYRYMlZ5pmpd05Lav5rFmC1vaUT9gs/pGJR9FQOyPpNammhO53Q9Jy
         4frPj2VURXRMDGwpiGYynbdgyBda9V0pMQ36siR64Vh+/Dh0mXBbTORxZRYu8oSbV56W
         pMjKSId6ApvZb8ynULU3W7rXEQvkYS5AJoj8N4QbjVSCxpuBq4/gO5kEwWgG43yAMY27
         UcYjYKGC6nrZbegM18sJ9clHQFzlDD2rVF1F+bLbdD2A3XLxOkrx3qU/WGl5B1tyxCw7
         pVMg==
X-Gm-Message-State: AFq9FYLUDurTXMUGEemH24vy2SlDr3CD7wTIr14Efx1L6mVQnN+WFZ2x
	E6+Mz8gel5hZNrhNsPX8xIg7sFfAJSVM40Q07nzp8xbLwHqV3Aga/AwP+6xMKg==
X-Gm-Gg: AYBFou2m+UL1x4fMQNfoUsDtltYgsqKQHithqAXVTfbJtrh+9jNDr5xprd/DAoGjMeB
	EC9VuSS9phM9aUkL5A0jn2kqRWmfu/KeOeqawUJohXIcwzKEufGT+oSzfTa59CKR1dhDCH6QRsB
	FQcMoRP/dmwpRsf/XuHuUswml3vuH0GFrP4uObvezqts+s27sSIwK/DCCOpcSpjPOTyW1y4NPkm
	WNHiUSPpxHf6n59lMhOpawNwSoAJAD1zWXPzqm/Btd/4lM530G3WUTY8ZKdC+pyh27tIM/aK0HA
	KnUNjQhks6h0/Ya/bbEPhJsX/c7wRr9H2N/G6WQbU0DGJIskQD8LOoZHa0yHuG2DjYqLgUgJQez
	CfRI+JHBzFdQOHO7CbgyiHuiRWi+6rN8AIe+T4Jv+lzhBnadkDZuArSn9k103QTlTCKDW6kXdIN
	bBKGtHfrP2HZvv6HntljMZYUzF8W3wblxAOi5hlhJfO6WkQaIgtWrDxs3FXpFUEEPyA/p/u61uy
	U2wPg8xCJ+AmmJHP0mMv+FQL7hd1ZIOfbRKgYKyQFcthqvwu8WYXOMfIortef+/8aSrvOzVHiHh
	P8r713DFbXD7bz5/dCmwH0yJnzTfYI+WqAL3CDSIjx2vuzgLMRO0YA==
X-Received: by 2002:a05:7300:2216:b0:351:28d9:4908 with SMTP id 5a478bee46e88-3537db99e8amr29992722eec.0.1791988439564;
        Wed, 14 Oct 2026 07:33:59 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353810403e9sm54997609eec.2.2026.10.14.07.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 07:33:59 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [RFC PATCH mptcp-next v3 3/3] selftests: mptcp: join: validate subflow retry after link failure
Date: Wed, 14 Oct 2026 14:33:49 +0000
Message-Id: <20261014143349.768138-4-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
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
comes back, from the same address. Then do the same with the initial
subflow.

Assisted-by: LLM
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index f4d8afaeda4f..1048c9cfceb7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2151,6 +2151,76 @@ wait_attempt_fail()
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
+		fail_test "got ${count} retry[s] expected at least ${retry_min}"
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
+
+	print_check "subflow from ${1}"
+	if ip netns exec $ns2 ss -tnH state established src "${1}" |
+	   grep -q .; then
+		print_ok
+	else
+		fail_test "no established subflow from ${1}"
+	fi
+}
+
 set_userspace_pm()
 {
 	local ns=$1
@@ -2585,6 +2655,42 @@ link_failure_tests()
 		chk_stale_nr $ns2 1 -1 2
 		chk_link_usage $ns2 ns2eth3 $cinsent 50
 	fi
+
+	# subflows closed after a silent link failure, then re-created: the
+	# additional one, then the initial one, with an MPJ using ID 0
+	if reset "subflow retry after link failure" &&
+	   continue_if mptcp_lib_has_file \
+			'/proc/sys/net/mptcp/subflow_retries'; then
+		init_nftables
+		init_shapers
+		ip netns exec $ns2 sysctl -q net.mptcp.subflow_retries=15
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_syn_retries=1
+		pm_nl_set_limits $ns1 0 4
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
+		# created here, not in the background job, for cleanup()
+		if [ -z "$cinfail" ]; then
+			cinfail=$(mktemp)
+		fi
+		if [ -z "$sinfail" ]; then
+			sinfail=$(mktemp)
+		fi
+		{ timeout_test=120 test_linkfail=131072 \
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

