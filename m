Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2D1E009A
	for <mptcp@lists.linux.dev>; Fri,  8 Nov 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731055867; cv=none; b=t1hhlPyn4BveGnTZ40+kwOj9bI7OQ90KB6V0GNtJVAA9W5WByXMy2wWbGkE+uQgdgrGkNE6A9ddu+/RlqzAKBta02kkkuSmVwJR2glj2XtOng4MHeGvqrnUrWM4oeOk1wnqIRHpsOEiP0sntqnSvZ/6sQi6tABCDutp9FZU4HwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731055867; c=relaxed/simple;
	bh=4Jq4pZ91ojrDsmTo24l4CGb4iUHxb4a0KNb+2Cgu+5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEBErfjvScw0q9L5rJ86VlBXqgrV94oMS/hAlZ4hLdjGKZx+7jmqJKsW/8I9powbyyruYhGdChTkJybQAtYIWUMRx3eFRdGr1c8TKu5DVp/ljK4Bsqc13KMMocRKaz16pIzosZT3t38lIV+8BnLYjOUZF1MRWRxrCbBvxbv9mS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCOqwuyS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCOqwuyS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1898C4CED2;
	Fri,  8 Nov 2024 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731055867;
	bh=4Jq4pZ91ojrDsmTo24l4CGb4iUHxb4a0KNb+2Cgu+5I=;
	h=From:To:Cc:Subject:Date:From;
	b=gCOqwuyScWTN58T0s4gCOsp5RKN1a9uH+VhkAgUKC1P0XMpLhEDf7eHLspmSFTFfs
	 1Jhc5moiJlfdiKei1KcdeH3sj5y1avWJRYCHhvnqEWWwiUw2ajjEQB6rm5Ioo0A7hq
	 UUZj8DgPbMql8+1pabulaTskyM+jq5p52hCtJCjQfG9lab3Wf1RGR3iNyMTALNdsW0
	 pAxMuqgf6FFxkVaixlR34RxxETOPbNjpF8PV0r2Xb1CmeyCDS6GjrBKRaFFQR9O8mS
	 cxJIP8v2xZUCcDn0dkYPvzaRqVRTPeTVmaEE8TgzSrUjWOLZkP264XSoaYLZIWTlVy
	 Atad3cEb8hNZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp_userspace_pm_addr bpf_iter subtest"
Date: Fri,  8 Nov 2024 16:51:01 +0800
Message-ID: <aeca45ea8522298327715230f45d718338906732.1731055793.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Enable CONFIG_MPTCP_IPV6 in bpf config.

Based-on: <cover.1730953242.git.tanggeliang@kylinos.cn>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 4ca84c8d9116..278d62c4a16b 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -58,6 +58,7 @@ CONFIG_MPLS=y
 CONFIG_MPLS_IPTUNNEL=y
 CONFIG_MPLS_ROUTING=y
 CONFIG_MPTCP=y
+CONFIG_MPTCP_IPV6=y
 CONFIG_NET_ACT_SKBMOD=y
 CONFIG_NET_CLS=y
 CONFIG_NET_CLS_ACT=y
-- 
2.45.2

