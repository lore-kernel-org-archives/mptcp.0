Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2821A262D
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551532; cv=none; b=cAaWGWoAu3BLt2HvpCNWQTBIWFPu+23E9idlWYXedZ8JDJszIeiwvI9l553nPPiPfxWhu2U0ZA0xAKk7damRPU9/LYi9uUKxs1Tqfxr2gipvi6dPjSlc96cR6N7mCnlNy9pleCY7ZPsaC2A6UaMYLk+ShwrzoDIMNDgcM7N/zhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551532; c=relaxed/simple;
	bh=5gDkJ+NZV6QCr84KrWhWLYB8vYmi9pFCygQiXZwtQmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxDnO3dzpDtxFZUo2N/vNrsaPxhtBoaJn0jQ0ubYEriwcC6IljYaobD1egtyBuL2nimb82G18ZGSR/xGhNxZ8cvzH8vRsHSr0awLfEdbGBYXDpm4jUo9koaBqyoV6kttUuXu+iCljJFAZOEYgFD6qUsaMBWY2J5Q9VV9pemkqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gpOwolbV; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gpOwolbV"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775551529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ktYcdr5VzISA32vuVY12srE5KkfypM2mb1Rh7oiIUVY=;
	b=gpOwolbVvfKWxa1ikhC2wHqfBK5THQJVz+PF2BgVqaEeW+JgW5+OdPad8SVIpSHV0G218K
	0PsB7IjKdTX9owZyDwugDPed8NXVt0p3P25pb4G5sT6QcXxzFmDvGSDQkz7RC1EPDAdeKF
	VO6qkePpfSrdRL28MrShpohCGXcOZFM=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-net v3 2/2] selftests: mptcp: add a check for sndbuf of S/C
Date: Tue,  7 Apr 2026 16:45:18 +0800
Message-ID: <7cbe2f7bd3191d191277825eebe69b6b5cb7d0be.1775551182.git.yangang@kylinos.cn>
In-Reply-To: <cover.1775551182.git.yangang@kylinos.cn>
References: <cover.1775551182.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Add a new chk_sndbuf() helper to diag.sh that extracts the sndbuf (the
'tb' field from 'ss -m' skmem output) for both server and client MPTCP
sockets, and verifies they are equal.

Without the previous patch, it will fails:

'''
05 all listen sockets                                [ OK ]
06 after MPC handshake                               [ OK ]
07 ....chk sndbuf server/client                      [FAIL] server sndbuf=20480 != client sndbuf=2630656
'''

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index d847ff1737c3..aa01a1dd0bdd 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -322,6 +322,31 @@ wait_connected()
 	done
 }
 
+chk_sndbuf()
+{
+	local server_sndbuf client_sndbuf msg
+	local port=${1}
+
+	msg="....chk sndbuf server/client"
+	server_sndbuf=$(ss -N "${ns}" -inmHM "sport" "${port}" | grep -oP 'tb\K\d+')
+	client_sndbuf=$(ss -N "${ns}" -inmHM "dport" "${port}" | grep -oP 'tb\K\d+')
+
+	mptcp_lib_print_title "${msg}"
+	if [ -z "${server_sndbuf}" ] || [ -z "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "server sndbuf=${server_sndbuf} client sndbuf=${client_sndbuf}"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	elif [ "${server_sndbuf}" != "${client_sndbuf}" ]; then
+		mptcp_lib_pr_fail "server sndbuf=${server_sndbuf} != client sndbuf=${client_sndbuf}"
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
 
@@ -341,6 +366,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake"
+chk_sndbuf 10000
 chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
-- 
2.43.0

