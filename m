Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9836AE7
	for <mptcp@lists.linux.dev>; Fri, 29 Mar 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711703232; cv=none; b=LOf3GvVjYEeqp8Vnl+EwOy9Uzye2VkQeNNFE4UyfedzUirS49j0t9BUawuievD9UyuB37bo5pgG55dw35OsAXRWrTqkEQZEdN6Tkcy1shE46kvCKQhm+2kqq3NyA+/5H96cauQIWHTU1EjNC2w7BRcUQCdmXf1sL+0dKN2EEWhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711703232; c=relaxed/simple;
	bh=2EFd5TVQtjeSbt5MVaSXYjWDR1iY+AA/afGKv2sJHBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aiTT4jilboQUDtarZFoA9rYxxotAa1Q1X1u5PwJ/dsNGbeqG3a2PkV2Vp75bHsWB9UKjRJpUBS5c7LehBBe4zWj4Mecd4SvPpGXsIiZp+XftwqJcKchiNiNEuzl7mOLrFoSQ8ZKKBozzDWDAD6f17Q6epr87sKRRf8lHhToUJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jtyq/Apy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jtyq/Apy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86210C433F1;
	Fri, 29 Mar 2024 09:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711703232;
	bh=2EFd5TVQtjeSbt5MVaSXYjWDR1iY+AA/afGKv2sJHBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jtyq/ApyiFgDTVw8EO0KiLCiCarcY7NqwQtoPX2YKl8bZDtNdvzXrHL9xmomxEZSU
	 eM4SFA2kuCmKMWPVgZ8Fc5Mo5EkeNY4tT2MnjXHahATdxktWtvZnon98ZX8Dci60bD
	 YL6ZTKHV8QIwRx6a65SOVEG7EkjYjKinOwU9ongXxIhqlC2Ey0PpLlyeGB6eAqi8bf
	 DNqs1OqaGbt4k9JxJTsGpoMJrScipLu2eqEhgGP4v/KLZWj1jb5UdlNXHP/ehVnKbu
	 nCBFoUwqtUUHfyRTuqEuouwBJLPXT3u/0Qot8UuQqeSwXmxxfA3ZDvdcH7uH50wpmV
	 NcdGiv2ewVRAA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 3/3] selftests: mptcp: add last time actions tests
Date: Fri, 29 Mar 2024 17:07:01 +0800
Message-Id: <5dd35f7df3332535dc938d1dfcc1c41ee7c717f0.1711702915.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711702915.git.tanggeliang@kylinos.cn>
References: <cover.1711702915.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper chk_msk_info() to show the counters in
mptcp_info of the given infos, and check that the timestamps move
forward. Use it to show newly added last_data_sent, last_data_recv
and last_ack_recv in mptcp_info in diag.sh.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/diag.sh | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc97ab33a00e..6e865f95f85e 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,27 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+chk_msk_info()
+{
+	local info
+
+	for info in "${@}"; do
+		local cnt1 cnt2 msg
+
+		cnt1=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")
+		cnt2=$(ss -N ${ns} -inmHM | mptcp_lib_get_info_value "$info" "$info")
+		msg="....chk ${info:0:15}=$cnt1:$cnt2"
+		mptcp_lib_print_title "${msg}"
+		if [ "${cnt1}" -lt "${cnt2}" ]; then
+			mptcp_lib_pr_ok
+			mptcp_lib_result_pass "${msg}"
+		else
+			mptcp_lib_pr_skip
+			mptcp_lib_result_skip "${msg}"
+		fi
+	done
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -237,6 +258,7 @@ chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
+chk_msk_info last_data_sent last_data_recv last_ack_recv
 flush_pids
 
 chk_msk_inuse 0 "2->0"
@@ -257,6 +279,7 @@ wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1
 chk_msk_cestab 1
+chk_msk_info last_data_sent last_data_recv last_ack_recv
 flush_pids
 
 chk_msk_inuse 0 "1->0"
@@ -283,6 +306,7 @@ done
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "many"
 chk_msk_cestab $((NR_CLIENTS*2)) "many"
+chk_msk_info last_data_sent last_data_recv last_ack_recv
 flush_pids
 
 chk_msk_inuse 0 "many->0"
-- 
2.40.1

