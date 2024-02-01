Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD73C469
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764763; cv=none; b=j6nYkhln4P7j0bdYMd0qtU/hQGQ7rCbtczlFJzZRv9muytTsGZOJBxZuRrjnujhwMIQv4s6eC3N2wwT+292EIzjlNuezaxw9/wm2Zd2KS/zj4LBTGm6Eq0t5BvcfqrZqY6e0BFhXyF1FllGseEfgbziujzxOQlMFLbBgAFfOD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764763; c=relaxed/simple;
	bh=mtqs5IpuBANNDDSqQf3Qc6fOl3fb6zOnrAvLKiz/7HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OwiHPEDUJdvXL8NDw+4THaeayDK284s5PiSceBoHiDyOq2e/50TII7sx0cDPI5lrY+AmWcZv0Lt0MvGKx5/itIRnRzhg+0dwmlOqlSBBZ2MW5bIUaVGibFv8O0VM1g4Seb36k/t1EeXJFPK8vF1gRcesjDEDpIoBQOgmvEEuUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csqRuH0t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csqRuH0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51004C433F1;
	Thu,  1 Feb 2024 05:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764763;
	bh=mtqs5IpuBANNDDSqQf3Qc6fOl3fb6zOnrAvLKiz/7HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=csqRuH0teF1+4uw28SA/Y9PEDxsJkM4Qs1Dy55oBFIVAHXRlRj1rtR1UKlaLlj/+U
	 TLBmydBd3vXX5NQbu9J7znG3nlHD3vuDrhvsbSWAA5+/8V6N1cfHRkC+lX/K8Xolck
	 lKEDtVFHgdJiKa1lbcGMLlQXxVdbcFYYMVgxgdN5WsFT8JOnC7ucem5b9XdHFhefma
	 C0jTJm63Q+Hssqyd0N5lZXaeU0xLDT7ywfrmisTmD9WVTbHfTg9TIpd9OlDxh8dCYc
	 Vw1L8M26uutMSoYHkvcOi+aK2pve2RJ6m6eLEGhqveVnzorLXnS8sUPyosR+RGI52a
	 LMPF0Zq8XOcYQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 08/15] selftests: mptcp: add check_output helper
Date: Thu,  1 Feb 2024 13:18:58 +0800
Message-Id: <79e54d9e96ebea76e5ba8bb185ab0d75debdc28b.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to check() in pm_netlink.sh, add a new helper check_output()
in mptcp_join.sh to check the output of the given commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a3bdbc896c6f..fa5c4e3f7c23 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,6 +21,7 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
+check_output_err=""
 capout=""
 ns1=""
 ns2=""
@@ -186,6 +187,7 @@ init() {
 	cout=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
+	check_output_err=$(mktemp)
 
 	trap cleanup EXIT
 
@@ -199,6 +201,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f $check_output_err
 	cleanup_partial
 }
 
@@ -3351,6 +3354,30 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+check_output()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local out=`$cmd 2>$check_output_err`
+	local cmd_ret=$?
+
+	printf "%-42s" "$msg"
+	if [ $cmd_ret -ne 0 ]; then
+		mptcp_lib_print_err "[ FAIL ] command execution '$cmd' stderr "
+		cat $check_output_err
+		ret=${KSFT_FAIL}
+		return $cmd_ret
+	elif [ "$out" = "$expected" ]; then
+		mptcp_lib_print_ok "[ OK ]"
+		return 0
+	else
+		mptcp_lib_print_err "[ FAIL ] expected '$expected' got '$out'"
+		ret=${KSFT_FAIL}
+		return 1
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-- 
2.40.1

