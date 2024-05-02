Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933AD16D4C0
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670602; cv=none; b=NkCNAWaNf6mQrCZ7ahAWXHwuAVJ6c0g4vgdLXJLBa5XkTgGuQj71oeTC4Y5hQHH01U3KwmaVlH3wC2nPoV/wW2Ld6VLnnOV4mfpKlaFelSxp4gGszRjHcR/EDULsyYEuB5QXe7QM8FrVEfpqk1tLrmpb25yOOKP1rBrzJVloKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670602; c=relaxed/simple;
	bh=Pr5ut1WESNJZen6Dt6M0oQNjb4+oqdOMnUxX1VhHtOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIRTqlnf2Aav8qrDkslQSd9UuaA+2m9HM45014rUqNebJBQGpQTb5R0u0j1Ffm7yaP+9rEAQYCb9s7lsQ7bW78EDY0z3EPGmsO/voPK8wfTxjecS96+LVFbs7BNGG/e6b2yEkVibYntndOhmKB+4FMvc1hsx0B/NMGUKSteLEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdvgXlvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdvgXlvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930D9C113CC;
	Thu,  2 May 2024 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670602;
	bh=Pr5ut1WESNJZen6Dt6M0oQNjb4+oqdOMnUxX1VhHtOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PdvgXlvkXCzh8YbnzrzUY6rk2Ze9VX/nRmLYNb0e9Kd0QaF0aIDzER/EgefWsaxd1
	 pvRWsNu3AuyPzoql80xV6kgGxvQX5hoNEaj5ozIGJG5XQZzKOYrzIcvFP7dBkJF8GT
	 5tW0yu3Y+l5P6C8aLVhE0OTwPUwaxUrAplbaVhYUzdU1KnEgBlnrh3aJz0+Jip4bMq
	 P/DF9W1NL+CrXzVGrVzV8dE6jaUBEdFnzHKETKgTzaHbwOoM4msrd4et/9pT2jenBR
	 r9KfGhwKwZlF4di8aL6ApsvFr2Yr0Dv7Qa9zXin2CTnQi80browJXLpFZxs6TaoGlM
	 hbspRFIluWXxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 02 May 2024 19:23:07 +0200
Subject: [PATCH mptcp-next 4/4] mptcp: include inet_common in mib.h
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-mptcp-cleanup-clang-checkpatch-v1-4-a2b46c0a6bec@kernel.org>
References: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
In-Reply-To: <20240502-mptcp-cleanup-clang-checkpatch-v1-0-a2b46c0a6bec@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=585; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Pr5ut1WESNJZen6Dt6M0oQNjb4+oqdOMnUxX1VhHtOI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmM8wFtosGB9MLa6t1EG6yDa0wxKyfrxauvch7E
 +ePFwRuaTGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjPMBQAKCRD2t4JPQmmg
 c9FKD/0ay9gpdi8C6FJ/oI2S2Nc+h1+Yih+Kg6JawIpig7YbUQ4t9bZu7dmLI1BUKxnIiJwzSQL
 x/1mdF4Ah1j8Ju8fcDTj769bxJK7zz88R4oGNYaDZZapKwQ1HPK+dCRflTG1AGezNeyF8hMrKXw
 cG4I8k1TEnLDt45HcjQotGhUa3LrwmE94V5n/XH7q10Gycx/JGrfQVm9XQQqdZ4fTQxAPIcswhf
 DvpcD5MLUCDPW3XaDBqJJYRtFZLcpWvDzmKPAYhC3QedkLdfBEgdciogWR3dNsCDgXwJhav6Tpq
 gBcgpIuCFqmQCmJhD+URrmFBwnfCZd7C31huBdTxELhFFutQZVbOKJFmhh4kUKwjrtMd1lbsMKz
 4mylsM8V9tLz0FOhxNs9kigdpVcSSIxx8nE33+/v+MrGNKowOcBxX5LA9KsOX2i/khloWYV/cWC
 1A0H2KYha5q/m9fYt7hws3A/LAcDlQBcMkzsO7fEshV1vsrFV2tnNxspWhXmgu39qOhlkkkxsdr
 iRC2tKw98SQI/EadgdCAeaN2em1vhq8d5xyZZyB3iUERBwte1WNHhKxxmVlZ7yk5b+f2igFkg2/
 ny6IqU39BlXk1UTBgQ4jO4roBp5in2Q452pfnUVv2+yNxMLYXtGKUN9di1HdO2uK5lnPxARU/Vb
 ob8pfGBSUEx/hrA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

So this file is now self-contained: it can be compiled alone with
analytic tools.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index dd7fd1f246b5..2704afd0dfe4 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
+#include <net/inet_common.h>
+
 enum linux_mptcp_mib_field {
 	MPTCP_MIB_NUM = 0,
 	MPTCP_MIB_MPCAPABLEPASSIVE,	/* Received SYN with MP_CAPABLE */

-- 
2.43.0

