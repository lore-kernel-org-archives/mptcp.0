Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC5217704
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247099; cv=none; b=m6SzTytrQuKc8su6SPpsBlI+kU2JspPJIl11RY9Npu+vGimS4jsIl3FrS+Ucf7froaBztALdz8y+9zRxl3ha9Hn/IbZqxkinHlRJKrt5E5dNvxUrlQHZ3viPrubQQBcV0cktTWC4jQYr6d/vH9CXcJ1Aum+Tl8NCM43oX2+rW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247099; c=relaxed/simple;
	bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VElUyVP5rJ3z9vt4i4ydOyZCjVwunLsYJ2dOep9h6WzNYmyqyRKaJ0eyLHL/sWVtoxN7PfV0Pgp31TSzDpQ455tCNP6T70iZtjG2t8FtNOiyIWiwQoeOhhSmqJ4afOhE7ICvQGkKykQKxrzi4XWJDqbPzBu8FNuwpres3V/r80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1gBQKzP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1gBQKzP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC973C2BCB8;
	Wed, 15 Apr 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247099;
	bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a1gBQKzPsaanHOvMwWdI9vfOoNeLZuPSlGuuA1Ie8wVpHQI0sW8Qage4oluJVXoTF
	 DNz0t9pivach51WOOMJxib81KmQPw+nzPNabo8QAz6MX99whYHYzxNdkzSmm+eRrRH
	 BmdV+an/B0wTbHyXZ2pNObt6rQ1A6T7djXvrBf8QJdevrLIxd7twGpChqHGaDxcZf3
	 FGf+IwjHYjZ/wrv9x0pB0jLRf29mYLTlsZzblS5dfmrufR+CM/H2YPkaI6v/4zQXKY
	 RgGqjda0pBQmGPR6oKCiTz8PSRA/G4POVMddTfEtPAN+IavBN+hbQNUUojf8fvWn+/
	 yrAIgKymP3skQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:59 +0200
Subject: [PATCH mptcp-net v5 11/20] selftests: mptcp: pm: restrict
 'unknown' check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-11-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ2ptXl7Etv68989vzve8g7NtGg5Pn77+6vPptv23O
 X1V2x2udZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzEU4/hf+mxzjXndz5nPeUj
 tH5mRe/HqyzVT5dI9anzLVlnG204SYvhv+Pa18e559x33i5ycJFP4hqjrJnK2a7/Zz5O1NHVirC
 8xAUA
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
index b69f30fcb91e..04594dfc22b1 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -194,9 +194,13 @@ check "show_endpoints" \
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

