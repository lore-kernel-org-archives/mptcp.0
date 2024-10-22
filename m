Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390281547F5
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588494; cv=none; b=FhDrErhcw9uBxjVWycJNRdYntNutONgWy6RmEWWJLfcbfPNiWyQ6AigGhNanWLe2y19ijUdLK+dy5wZILz8i2HpsIQx7UB87SFyE2b+pmkr7wP5FoWM/H1Q9nRcJrLNJEnU77LPUhFC14fKZoKeMshDCAbPN/k4++3YntyHOEdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588494; c=relaxed/simple;
	bh=aoY1lOCXezDcJ+6b9ZlXpH7rgZBC3uVPmaTCZUAh04A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbGZGY37+5yh26nqfps7dYe1tiiqyx0vquCG/iGIpcht+7SHd7HcbZ5Qj57X2TKaxp4OXQ4ym0UIucHC6JdTZRPTbJV1DBu32TKtOfUV2Rthm3201tCl/SV9IY5G1xvpRB0hpO2DbbbK15VmjQ42xRHrGw3enVcQ9MFIF+IjtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAEQYjud; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAEQYjud"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A061EC4CEC3;
	Tue, 22 Oct 2024 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729588493;
	bh=aoY1lOCXezDcJ+6b9ZlXpH7rgZBC3uVPmaTCZUAh04A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAEQYjudaTMRC8hGptGA/eKJQUn3omUW/qBLZ4RZmoGnEzOIYPiDUoqaZefGslDu1
	 OqzvLzIkGKz3n5xrHp81ffZodrFmYuySMr7/fTXlbbPPnbpC0BQicSz1zDz6KTEV56
	 5SY6jvPXjvsevF3VwDsEsCvBI0JtWKA+c372dYqxlKyUjEGhPGhWZsxjn2THdR67SM
	 0Xkj28kTMpj+dYfo5DiwqY4pSZqVn2xIPTT8wMKLmON0cXfuXAon9N+gsGO3gXFyze
	 YD1ISVLbRMjunOR9GPBmr5WdI53QlurMxbvtViuEC3DeBx34cUjduhArAdoqqFT23l
	 k29diym7u7rAQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 01/36] mptcp: drop else in mptcp_pm_addr_families_match
Date: Tue, 22 Oct 2024 17:14:09 +0800
Message-ID: <2274e7768f2534184f675b86b61c2f434290f98a.1729588019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1729588019.git.tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper mptcp_pm_addr_families_match() uses "if-else" to handle IPv6
and IPv4 addresses separately. But the last line of "if" code block is
a "return" statement. In this case, no need to use an "else" statement.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16c336c51940..f3d354a72c94 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -495,9 +495,8 @@ bool mptcp_pm_addr_families_match(const struct sock *sk,
 		return !loc_is_v4 && !rem_is_v4;
 
 	return loc_is_v4 == rem_is_v4;
-#else
-	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
 #endif
+	return mptcp_is_v4 && loc->family == AF_INET && rem->family == AF_INET;
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
-- 
2.45.2

