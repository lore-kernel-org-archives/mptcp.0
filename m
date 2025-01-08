Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEE20127D
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361653; cv=none; b=QSlIlWKTHEqUEH/L1To6+WEVDGNYOXMw7MSohF1Iz6eC91VL841fFeKf5uD7OJ8mOYlaMMRbskEcC+I1muYG4UkpNqVsF6k7tWafplWlLR5f8/F9ndoukH6iYKVs7obKqAo8zGAmWoceyyaXDjg511Ic4gklax79t88tBF8bhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361653; c=relaxed/simple;
	bh=jZkqChmu9ePLM1fa7rNUJvFCnQbqLD0cF/N/c0hN6/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCVVk10OpV8AtDxbH2ci4Np/JFwPe+t+f6/gagYF1dIeLpbfyI/j8kXLgZc0mHxCrHn1eBWz2bEXR4BJM82D63r8qMOdF/QS5ocTXFGYRPVPfUYjeNq34YsZgO0xXD9W0ddfjsza3HpAar7TD9IMzW25mKvzo8OG9Zosr6Qya+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEI1HyIb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEI1HyIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7016C4CEE2;
	Wed,  8 Jan 2025 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361652;
	bh=jZkqChmu9ePLM1fa7rNUJvFCnQbqLD0cF/N/c0hN6/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kEI1HyIbgdeK5HIjVKQomaAT8uJaS0m/QdHNp/jbywd0odIkWdwrTFMEiX346s71X
	 sgcW42/2vRKufhmv47V+WEwB2f5s6PVhULvwzd7clog7yvmscJCqC+1tF+9uGOhNFC
	 GEWSFe7QxSlDI4Msw2B5g6akoSudkpdMJLUN/4q86xsrlmOrJCTrUTkGZR4jtM1vNR
	 b0I3vN6wdnd3FQfIJImxBgARenvTsYjNdeIfcFoOHt6oVnS8decH9JcIgBRbeEt1t4
	 fotTuJ066om0tS7sTeUWT+v23QVCjqLxJmBIrM6ZPdubivID5yVXGll8J9l2qVJVj8
	 Y+nkxTBSdTm0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 19:40:39 +0100
Subject: [PATCH mptcp-next 3/5] selftests: mptcp: add -m with ss in case of
 errors
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-3-bdfbdba48a1f@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1316; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jZkqChmu9ePLM1fa7rNUJvFCnQbqLD0cF/N/c0hN6/s=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsaweR3g8RC6yESsjGYd9MmyN8MkDl7XjaSTo
 T5Y16xwgnaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 c7RdEACTnixNS6o+nkckkVdYoknrTPV0DjWrE4AmhGMCTKMklJKTiFLV7YiRtDu5VAazbBAEEPb
 EG5/3/nSwGJm6hT/BBDMTwSRA0kwYdkZAgyF4t9Jb/kBuZ/DWzr+qZD666+na5W2L86ueVjpHM6
 /lhDdDZ1XljGGleMILONP3LSEpbKLaluwy9G+Y96MBuYNBZCWKOeHAAR5e77RplPBBzJkl7izOb
 KaH6EmFFgfZLqpXzqRD/ZeCghU7oqTVAqx+H4nQSV8PiN9XTgzl3+0gjyHtwmo4HoE8OfGee/Fd
 2xR2czj8rC5YuEXPCEnaqhY5PtLUA9h7TOJWPROoKGn9zAsa8pvAjTftRJxeHJNsgh/uCCY4KEb
 6r3scqacwu2GR4balFp9D4XGeoHZFZs2tNstbpWA/+5ZLHHPUF7++aLBKgSgRGqIOAMwk914jyx
 I+1x8MVWKrRwDy7t4I5di9FC0eZMkmHuSn9Xv5FdLQ6cqSUtEmhNGuzfomVp48MLA9x/R+UJQo/
 kUP7PVzacAAo1YEOP0zGCUjBnV0VHZ7uEigbA0yWXMSxBy2fVt/Nr4wDutlyDFATcZrFnkg6uW2
 BeLQRYlvSOcKvW/KMPu6yAWR/QH3SCOxTrtgR7mW353vjlMAj0pgMZffbS8mYmygNAI09qwTWCl
 nsiQ5E9XA2/W3Cw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, we had an issue where getting info about the memory would have
helped better understanding what went wrong.

Let add it just in case for later.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 50ca64357053b14cd4989e6647d825337978fdba..1f797d5f5156ebc99e5e0be5ea27483bc9cb4c65 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -118,11 +118,11 @@ mptcp_lib_pr_err_stats() {
 	echo -en "${MPTCP_LIB_COLOR_RED}"
 	{
 		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
-		ip netns exec "${lns}" ss -Menita -o "sport = :${port}"
+		ip netns exec "${lns}" ss -Menitam -o "sport = :${port}"
 		[ -s "${lstat}" ] && cat "${lstat}"
 
 		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
-		ip netns exec "${cns}" ss -Menita -o "dport = :${port}"
+		ip netns exec "${cns}" ss -Menitam -o "dport = :${port}"
 		[ "${lstat}" != "${cstat}" ] && [ -s "${cstat}" ] && cat "${cstat}"
 	} 1>&2
 	echo -en "${MPTCP_LIB_COLOR_RESET}"

-- 
2.47.1

