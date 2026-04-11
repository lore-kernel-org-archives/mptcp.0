Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9721E091
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775879391; cv=none; b=IH7QUwZjhQKa4IUPb1gUdwAj/f9KgP4PyyJcmd7pGPPXYqms5hJUeMC+zBEZnQnOEMzjGTZ9qrOeimwnQzdGmM73ASpx3VeauYSQtOUkfvZ75iBK04QX+gaHOiGYV6CYLVuQIrwy9Cm75Y8Qj42NbHsm4nfOh8pvDLb3wMRQDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775879391; c=relaxed/simple;
	bh=esv7ZeQ43ZEeJFfgZ29RQf0m+bFqbQezLTyrIcV2B9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CniPXQD7/6856JPLiLVArQ8/1SuV01aLvCseO/NP266d8AwZtwJqA5wl3TON0lUCiQpbZWB7IYnBSc0mZPkk9UBdgtAcd7+WucClFyKH5p4SV0ReOXFaHLoLWr0Hav6AfZmqUK/0DD0v3tc9Rwp1oHkVIQ3XCnY+xAoIXxAXTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a3V8VykB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3V8VykB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775879388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7G3rlNMUMHrWpCCGcLdF2LLnHkfXSbIyIpjlhqhjQSg=;
	b=a3V8VykBLRh2oTiMKZr6ZWMQNlgmnnt0lRPF6IRUrPnDagZZ/cf/t6exnZfcpzv0NeMhtv
	lT4OkbpzCUJ3oTOhiQ4yeyGN8xBOeooSohnB5qIX8k3tVIYct1RxHsg7iNlBfABlgUisbk
	ixFwmeYxaf+8Fw4334URzsJX33ZUgQE=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v4 2/2] selftests: mptcp: add a check for sndbuf of S/C
Date: Sat, 11 Apr 2026 11:49:00 +0800
Message-ID: <e3f6d29137bbb6885f5af8ea1f23a2404e31a952.1775878944.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775878944.git.yangang@kylinos.cn>
References: <cover.1775878944.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add a new chk_sndbuf() helper to diag.sh that extracts the sndbuf
(the 'tb' field from 'ss -m' skmem output) for both server and
client MPTCP sockets, and verifies they are equal.

Without the previous patch, it will fail:

'''
07 ....chk sndbuf server/client    [FAIL] sndbuf S=20480 != C=2630656
'''

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d847ff1737c3..27cbda68144e 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -322,6 +322,33 @@ wait_connected()
 	done
 }
 
+chk_sndbuf()
+{
+	local server_sndbuf client_sndbuf msg
+	local port=${1}
+
+	msg="....chk sndbuf server/client"
+	server_sndbuf=$(ss -N "${ns}" -inmHM "sport" "${port}" | \
+			sed -n 's/.*tb\([0-9]\+\).*/\1/p')
+	client_sndbuf=$(ss -N "${ns}" -inmHM "dport" "${port}" | \
+			sed -n 's/.*tb\([0-9]\+\).*/\1/p')
+
+	mptcp_lib_print_title "${msg}"
+	if [ -z "${server_sndbuf}" ] || [ -z "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "sndbuf S=${server_sndbuf} C=${client_sndbuf}"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	elif [ "${server_sndbuf}" != "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "sndbuf S=${server_sndbuf} != C=${client_sndbuf}"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	else
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	fi
+}
+
+
 trap cleanup EXIT
 mptcp_lib_ns_init ns
 
@@ -341,6 +368,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake"
+chk_sndbuf 10000
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
-- 
2.43.0

