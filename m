Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C822309B9
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172422; cv=none; b=bIy+NvUjXFTiTGsuWa7UfUqbnZPierSUX4emVnygby2ykO1RjN3GDyGt8dj4UfgQNATDviL1Pe7mfZBECOEP7qhFOeNNJGkaPeNMqCuc/+XTnkQKkIf6uyNZzjeW/6yYIPEDdd1NlzkLe8XHlLxQNT+esj95npxDKJotB4kVzsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172422; c=relaxed/simple;
	bh=+8ih1OeiChrKLHPnVCx/OhGqDAeh8VXQArMrP/N9i7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8RHVqiLSf0sb/pXohoBAQjUPJM+d7gKPPZbXZ0SzdUr/MU00cMklCZsJo9KS15ORCQEjslzy/pXxg8M3Zwa2cCWVoNUcD/fqpBSSLOVhm54HRRYMNbLxqLnxSFjIUgBIVMdG8/HfM1Ymjsb39UYMEE/th+E7Noec9XRWAHnPU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ToSuOuBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToSuOuBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604CEC4CEE2;
	Wed,  5 Mar 2025 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172422;
	bh=+8ih1OeiChrKLHPnVCx/OhGqDAeh8VXQArMrP/N9i7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToSuOuBJNizxhbo5nxNzEQlf0gijwVhh5MaznhK2aZd7Qfm2j8FdSeqK8eN+wC6C3
	 McJBWfnX09Wmxo/t4Kd8c4Ofx5TY7uS6TfpcmfpIi4dmkzUKHdoJLHIL0KENTXuyjF
	 0ZCVrNg1Xhe40atpqRTygWbdaFDoPPVh5C9mehdZre6bAKoOOIfz9D+UtbZHjM1M/5
	 PY64bA3bAflMPoVWnd7IVDbcXNsgTRWVYu3Mzz/zfwPOkxv4r0qUEQ3SaYA5xQbvzc
	 fSOtRHFi18xN2xk5KmSqKEzTBhzH21omTZB6pjnW905rZmkEum4hPbk4yVvjhAIlRX
	 MVQO4WfOkCcUA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 11/12] selftests: mptcp: pm_type to path_manager mapping tests
Date: Wed,  5 Mar 2025 18:59:52 +0800
Message-ID: <dd964dabf1235caf0ab99e6ece842aac99e61843.1741171898.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741171898.git.tanggeliang@kylinos.cn>
References: <cover.1741171898.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch checks if the newly added net.mptcp.path_manager is mapped
successfully from the old net.mptcp.pm_type inside "userspace pm address" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee..c55f5d526769 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3572,6 +3572,21 @@ userspace_tests()
 	if reset_with_events "userspace pm add & remove address" &&
 	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
+		if continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then
+			local pm1 pm2
+
+			pm1=$(ip netns exec ${ns1} sysctl -n net.mptcp.path_manager)
+			if [ "$pm1" != "userspace" ]; then
+				mptcp_lib_pr_fail "ns1 path_manager mapping fails"
+				return 1
+			fi
+
+			pm2=$(ip netns exec ${ns2} sysctl -n net.mptcp.path_manager)
+			if [ "$pm2" != "kernel" ]; then
+				mptcp_lib_pr_fail "ns2 path_manager mapping fails"
+				return 1
+			fi
+		fi
 		pm_nl_set_limits $ns2 2 2
 		{ speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
-- 
2.43.0

