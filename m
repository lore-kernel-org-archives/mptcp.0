Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02237DEAA
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876050; cv=none; b=fBUS46RT3YcOnccLl09BW0bVRWnr5CPkpXqwtZJN2aYovH46L1lYlq+AqSQgUe7nU0qLLjl+iLwRbKflR9mZyLHTy9lk7xD27g/SCilmrBGuVQAQhaSGIaf8yY6guJn4ztcphb8DCXWxGFJ9kNGncdbW0MFo4RaQcKFMKeSxWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876050; c=relaxed/simple;
	bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECTBc5ueP0a/AOk6pCCaJL0F7rXYDJoFYyHoH/nJxWLXaKbkLjnIH4U4NMVFcwS3//ZMjp0WPnfwq5dB8weGZltJoKR8TP2Hi+Lz6hCFkNqqwLWCe3crwSzE5zSNn5R04xW4Ivoh/xAN1uCIm9oECF4cH6oUxXLrvs9nV/R4bDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8fW2zaj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8fW2zaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B32C19425;
	Wed, 22 Apr 2026 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876050;
	bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J8fW2zaj9pFo54RNmgEL0ERcRrj8pxqImRIH26mw5JapUO4M/iyhY695/q41zNJo+
	 1zAWXrYZ8i3arvgl4P8yqqpStl+BXMv4HiolSNUDYNUPfXxoeZFV18E2xzzfzan1Cs
	 Ti2LgaEkdb2ZU3b4oiOm4z0U0u6coCvNHlQHvDtwclegNPck16Rq3abSzycfyEwAyk
	 zWtDPbEP10FlGUgHiT2o7nWjEdTcxp8eLlOACjoeONH5Cf5Zn2lADrFNSopvfOVB9g
	 VgL1Hm0BJpVa8Gz2Fn5uvTOp2fu10tLKnHmSNmO0vuZ4IRHsXpo1s0TDTbIPriJcWZ
	 WLRnXg/CQxwPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Apr 2026 18:40:25 +0200
Subject: [PATCH mptcp-net v6 11/19] selftests: mptcp: pm: restrict
 'unknown' check to pm_nl_ctl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-mptcp-inc-limits-v6-11-903181771530@kernel.org>
References: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
In-Reply-To: <20260422-mptcp-inc-limits-v6-0-903181771530@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=+ZtDau8ZaxURdpqy1rQ9ybBeaerSVZO1gNen80NZM8E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJf/GKacO7EsVuH5ubNfh7xM+pjcsbbqAurww2mBotG7
 D5s+sVqZ0cpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEBG8wMrRrlu6fOK/4cNzM
 WQfvP/ixrVw6SKNC1ndt0eQcz/kbH5Yx/E/bssWwb8PTDgWHG40HUr6HFp33j3uw4eL/9yIf1Pb
 F/uMFAA==
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

