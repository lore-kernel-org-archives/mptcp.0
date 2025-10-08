Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA934286883
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932018; cv=none; b=HQVp8f0tCAVm34zgU+mnqquiN4nXD7YrUjUxx1cy/KrtXCf6YDTfFJWZrr6lSjgLLh8Xj78ExFX4wq3Ko1i6nFMrU71yn3pYqgPRztf45PNeDJLvvONyO+BPcvCFRjxhVDNkOZWXg/TAAOoW9IUJ5VcRs0tHdYNrD3Fq0Cs/E54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932018; c=relaxed/simple;
	bh=k5gLjNAVz/tVu1kK9ZUbytd3ZDkQ6Y7Gv/CnpJw328U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8t3YSXNkIBKdyBDRl7VZ+oDoUBW5kZv81m+LZMRP0BhpraUKwOkl39ehsmejgid1g1G/9wmRnCTnrilRWNQw46jpfZK1tQE1GXb0PlRw2fqX0Cm4nG9gXAG51WXEaCv25wi7LaydK0JgvPmP38KYOaBeQMWLlkxOxOgTChtafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXJxjRqB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXJxjRqB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C687BC4CEF4;
	Wed,  8 Oct 2025 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932018;
	bh=k5gLjNAVz/tVu1kK9ZUbytd3ZDkQ6Y7Gv/CnpJw328U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tXJxjRqB5Dz8yUeO5xaYNEm+1fFIO68KPCvcZMXZfzbpffOlTzYo/HjmgOc4JkW37
	 /iqjdXDRpHWcBYvxe8AyC0Z/P8pGbvnmm6CBQEqoJLqqy7Fpo2FIGdFBBSpJTAExHk
	 5Oe/n8JaWt6WpXUEpv1e/JaxtUCo1Y7o+ZHSD6kPu7b2wCbK91lVQQvsDt+JFJxLE8
	 LT8kxxDNx8o3Z4rmv/R0M1gu1Hn2cEgibdygNkkKa0QRvahNSKaUX3ABZs47gKHLk/
	 qCt2h7U++X7YqiV0ug+YVLgApxJXfzWmtwoCTWIXIeEqxd7J1YyIowQl5D6YM2v/gZ
	 PTxTwuVdiEorg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 15:59:57 +0200
Subject: [PATCH mptcp-net 3/7] selftests: mptcp: join: mark 'delete re-add
 signal' as skipped if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-3-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k5gLjNAVz/tVu1kK9ZUbytd3ZDkQ6Y7Gv/CnpJw328U=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGjmbmnIxqY/aGLU0OsimRkGjxOAwHuzKa4XjvzMQkuV2lPG8
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmjmbmkACgkQfCLwwvNHCpfZuwD+NGh7
 V3O0w6CzSuVgLY9yqM3JlYgnsZ4yPwQ5Op0NpGsA/29P+U/rfJsFJ1hTfafM46yAuABiZhup1/O
 PczFvJy8M
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index deba21ca5a97..59983aed2591 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4040,7 +4040,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3

-- 
2.51.0

