Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC35B30FC36
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831533; cv=none; b=rzkijneyqISO6JS6fDvQcst/WdMBhQAseb4YWR3S4nozAFgFJ/GVJ3mD9/C9wLe0L2j+lzTT746v+LaU9qa8lGGEp4FBfQOfoM/vu6QxbrQFFSPXlS1losy3R0B78TDAogIvOXSnSfq/MfVJpbNXptesvcjXcJbkeGlFSyZIOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831533; c=relaxed/simple;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgxlXKJh1mEHaSjeWfGQbegRcYloDTXaIz6Qb9JquzlHsFwE2HGuNsgqz4hfvyrpAOGb4AsI7PC4cdFxf0kKX2RZxxnSD6VluM8yWt5PTUQwIHsa2SgZlrYTrOZsVMmXDBdzrQRxR5KjR0/HhwSUoadQcBbUtHGtptM9qd8wVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFTK5PQS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFTK5PQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F45C19421;
	Fri, 10 Apr 2026 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831533;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TFTK5PQScCBoiP2/iKJCgK5wqbfzU+UKOSbcFl+nQAnJwJPXo7MCUz44HMcsRpYXc
	 Yxz91IiVd7obGqx8VdbtrKbpSPj+/B2AA2/yExGgiqr2ukSE0f1fYued0j5gIj7DhY
	 CfsbDPGQTd7UTyOp7m/uNrLweta495qESJKb6uNGdAjNDdiaxHThTIpDFTj+WILPEd
	 6VOei+laRnmdz0D02kHlroo6A1I+1WGnqVlfXOfbwYvmQWaOKonp4HSDx2vzbe/qrI
	 I0ipp6PWTZqQ7aoI6pY7hiINyJ25izbJ+Y/+tdGfS6ZrWxz+1VVSML/aBzuky0gF8r
	 Ns9ZXkaQ3AJuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:47 +0200
Subject: [PATCH mptcp-next v2 09/17] selftests: mptcp: pm: restrict
 'unknown' check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-9-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct5fbm8kyBXDJbnG/0KhbLHeg+S+X86Ldtxz+PdT7
 WX7LmXLjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlw8TAy7PNMmfPwwRKT4tZq
 cZ6N05yXyV97vU/Ncd7yQz0m1YKNOxn+ZzH+bPGX9RH56jadb/fdyjKGH+Kiyx9u+MxeFsQ+6eA
 sFgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When pm_netlink.sh is executed with '-i', 'ip mptcp' is used instead of
'pm_nl_ctl'. IPRoute2 doesn't support the 'unknown' flag, which has only
been added to 'pm_nl_ctl' for this specific check: to ensure that the
kernel ignores such unsupported flag.

No reason to add this flag to 'ip mptcp'. Then, this check should be
skipped when 'ip mptcp' is used.

Fixes: 29f4801e9c8d ("selftests: mptcp: pm: ensure unknown flags are ignored")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 123d9d7a0278..d844ee687a29 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -192,9 +192,13 @@ check "show_endpoints" \
 flush_endpoint
 check "show_endpoints" "" "flush addrs"
 
-add_endpoint 10.0.1.1 flags unknown
-check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" "ignore unknown flags"
-flush_endpoint
+# "unknown" flag is only supported by pm_nl_ctl
+if ! mptcp_lib_is_ip_mptcp; then
+	add_endpoint 10.0.1.1 flags unknown
+	check "show_endpoints" "$(format_endpoints "1,10.0.1.1")" \
+	      "ignore unknown flags"
+	flush_endpoint
+fi
 
 set_limits 9 1 2>/dev/null
 check "get_limits" "${default_limits}" "rcv addrs above hard limit"

-- 
2.53.0

