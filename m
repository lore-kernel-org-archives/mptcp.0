Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420F256C9E
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490138; cv=none; b=h6aAkKHiG1d7+Vj/yOPYTPl2K2fHjxlAxGYS/uLjD3eWBZF6GcLzx7Qq99jz61/wK4n3mf3jX7YuKAHAEADzlIRfL7uQBTo+6BLmSGwW1GvJSB8oFXMEas+en4Q960qY7h6+e6XFwXhny1RfFuVwuRdkSWcv4ACaYDLgpgVX/hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490138; c=relaxed/simple;
	bh=pRkqaDtyQE9YrFQQm/838zTvW3819fzEr5qMS8J7t/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9lkru+5R84Wi24gAMSmUG5EPit/exIyrqmqlx+hYmrM/K77xGOXor/w5vqcL7AztGUxAVo7Oo6rV30o++5D/vV525WUwMp+UPNvHQYOa89GX7a04Cx1cIjOVp2nkx7mfoOG+M+if7ARExRfqaS4BhaXotMIVNApWy7jBNRJG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbkQLgIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbkQLgIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50174C4CEF1;
	Wed,  6 Aug 2025 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754490134;
	bh=pRkqaDtyQE9YrFQQm/838zTvW3819fzEr5qMS8J7t/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hbkQLgIX4bhoevTHYv7LOR66rz17EQuOQ4wAM1K2pLIEShdtoMGMaVMbXCVkS5BI8
	 +ytyh2k8LIQ7mXu3kPNR4BoudL1R6JqNcKjzzYYCWonEbNCHpip3WinOYi8J4jjoH6
	 P0mZ3sxCz/zr8qeLH+r8WK22MwUxbk/NbGeF4N4oU8h/l8yXfhnwoezhEsjjsq9f0r
	 1WV7FLiMlPLbSV+3s/vNxCU7rakS6i+3OUM1LQ5PAHynounZ9q1HYzaNiMdnOHVK1s
	 KBA+5F3kOO2D2U7dSugeE5TEth1o7Gap3KtoUQAYaOec2PJ3GBK56b7hfs//O8nUwX
	 Bbr5fdZbIZJww==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Aug 2025 16:22:07 +0200
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: pm: check flush doesn't
 reset limits
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-mptcp-pm-flush-limit-v1-2-9f83699e0863@kernel.org>
References: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
In-Reply-To: <20250806-mptcp-pm-flush-limit-v1-0-9f83699e0863@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1297; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pRkqaDtyQE9YrFQQm/838zTvW3819fzEr5qMS8J7t/M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDImpwr//v8g0TD2wR7OxoRvznEZioqMJ0pPVvxZusmve
 tWT5ndzOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYiLcPIcF81Tqvteoni+jfP
 7BeJLK1IjbD/cPRKaMjhc5Psou796GRk2HCoZ3p3A8/ewypM9wS2hWaeuexlrV0W7brh5KJb81g
 DuAE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This modification is linked to the parent commit where the received
ADD_ADDR limit was accidentally reset when the endpoints were flushed.

To validate that, the test is now flushing endpoints after having set
new limits, and before checking them.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2e6648a2b2c0c6ea0e9f030c942077a0f483092f..ac7ec6f9402376a34602ef1ca6c4822e8dde0ded 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -198,6 +198,7 @@ set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits 8 8
+flush_endpoint  ## to make sure it doesn't affect the limits
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
 flush_endpoint

-- 
2.50.0

