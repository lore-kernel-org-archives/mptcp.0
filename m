Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF233B94A
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767938; cv=none; b=oxudVZNJovHDWjjY04BPLBEcnXRlM4VM5YoZUppfOUs9sD8rO3lTB3H2WpdHC1cbuOxh7BQD6B7PMwalEfWv2kjeUgDDCJHMq2mkSIYS5MGPe9E8IDx84+eMN1wUureboyfDFMoZMktKkAA0RAxUJhIvyTzJCNT6IQxH5gWQwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767938; c=relaxed/simple;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suvPYvWqlcMr1Q8gcuZNSyUAa+iPslEAYV9KnzE4YxxG9ZQ2u8sQ6QmVIwZSp7VIBPvlZ7bqK5qcXY+zzUhbh569ustCMaK6F+TRJ6jCfxVwUoENVJnjNDLMafqcZ5v9rb3Rpy50uRvxbFaSiOVjst5s4mzC1G9EyzTEWbcEbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic65mMPn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic65mMPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB44C19424;
	Thu,  9 Apr 2026 20:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767938;
	bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ic65mMPn/64wjcn3UZ+E5SWEV9LuhF5qCJGoa/gId0eoUKDZ0FIC7E/RsflCu1ZmW
	 nUVflpmT4FvJnXjOuzKEsFXt0gFMF6Pg5TfQojF5BtLmjtar7K/Y1jUk95jTN9fKoC
	 bkFjgcw0iiGez/0TpEeUa6g5tRYhdztEmkE3ty79q+YnDEE+FEKfbH+Byh28/Rii/+
	 6oAiMvr0VSvSAod/aUsmmjMmkRUt+QFHMN0tuEv/h1uBAgzK9x5dgQEgZLiCeFYJ/C
	 ZS6IeTRiE6eWdqIdP9gqx32hAspTmTuieOAjKP15kK3g8AIFtnbluOHCuF2JLHzSFi
	 6C9gl/Le/6oNw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:48 +0200
Subject: [PATCH mptcp-next 08/16] selftests: mptcp: pm: restrict 'unknown'
 check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-8-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=J/4TSLYnn4WswjEmdMv9hBM7YG3BsYv6rruqE5u/zDQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCJY+PDHbf8Vk3pnsXMEP9v+Zc8PV31U19z/XZD2xe
 9P4yzdP6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZiIljkjw5/9T63kEtV23nD+
 92rt76MZCx2MOLfHvNq6+iRTm6PsvnRGhofBa6efKr3y/Ognhb+y+6f8K5l72PyQx6R1XGIn1ha
 sfMoHAA==
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

