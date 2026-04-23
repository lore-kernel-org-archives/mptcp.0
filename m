Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233E35E936
	for <mptcp@lists.linux.dev>; Thu, 23 Apr 2026 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960302; cv=none; b=P32DTLmBJ7IBE9Z4r0lN1f5r4yn67W4lw6l7hBtcudkjqQqF4Hs3bSx1YqXAq9y5UbrrmzaOfB4Nkqex4UXH/QAjRUDOw/eEDjrtzZXyuqqItLB0+7URHifDGDursS4uxJnNnGNkB/JhQyUShyvzRY0IX0Tc9nZ5BGNbAh0vJmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960302; c=relaxed/simple;
	bh=uSH7Jvt0g4gnvlXUiI93M89Wncwuv1HeacSaVwk/R/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XbGXE9MgdqVawp5xXK9bur1P+8Y0KzGSObuhPR/5hVasg1TjB7EaOYiSRMTsGh8oKr9HCePkwmFMByphpZdjSaJ/BSgeTlE9qSWeN7KcR+CpP2XMNHF4ncfi8Te/bjH8sGrNa2xxMqlh4vtn0L636SWGc8qqul1PNZ/v+BaxA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkAXRFwh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkAXRFwh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A52C2BCAF;
	Thu, 23 Apr 2026 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776960302;
	bh=uSH7Jvt0g4gnvlXUiI93M89Wncwuv1HeacSaVwk/R/k=;
	h=From:Date:Subject:To:Cc:From;
	b=FkAXRFwhRRzYAlvBGxCL6/MWAcCytLC4h+CJEbI9IdW9H8IesUkGGLrubwWV0NOfu
	 f9h0e3/AKCZhSwFOgIQNsKrfCq2m7+ztTskN6c2i7HtUfpTF0zrXoWC08+ZojSltJX
	 eKfcmkbm2o3d0TMW/t6DIHw1MTe/mI2Lj2uS+XZVX+Ra/CGWG0nN3iz5dP3altYULt
	 zsMydmyXiipQ4ukscb1GcdPr5YArT4Nc1YV8roRRI7Q3UvQ2TugX4YsYHBcAOxNB0T
	 XL5Z/4fa8rFMaheQ9B2GzeKPMeJC1BkleUPqLeHhYFp0ZdwAaCsUBdYMW2GYsydVjz
	 PMDW81uuPVU6w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 23 Apr 2026 18:04:48 +0200
Subject: [PATCH mptcp-net] mptcp: pm: kernel: reset fullmesh counter after
 flush
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQqDMBQFryJ/3UCSVhe9SikS40tNMWnIjyKId
 29al8PjzezEyB5M92anjNWz/8QK6tKQnUx8QfixMmmpO3nTVxFSsUmkIDIYRSCOqXfLPAfw1Ae
 zCSi0nWnV4KSiqkkZzm//xIPOd0Sh5znxMrxhyy9Bx/EFjrerqI8AAAA=
X-Change-ID: 20260423-mptcp-pm-reset-endp_fullmesh_max-e1e56a51bf01
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Sashiko <sashiko-bot@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uSH7Jvt0g4gnvlXUiI93M89Wncwuv1HeacSaVwk/R/k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJfOetek06x62SJ+Hmww/T8nXdsSyfPDVr7Wzw00oH9P
 9f0I5YTO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbC7cXwv3bWJFl9xV9/93k0
 T94zl91XO2tdW7aVeuP89nnaP9t31jL8j6q5G3hexrTu+9XYg7NOZFlE3FcoX2m1YO39G6JLM2a
 tYwcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This variable counts how many MPTCP endpoints have a 'fullmesh' flag
set. After having flushed all MPTCP endpoints, it is then needed to
reset this counter.

Without this reset, this counter exposed to the userspace is wrong, but
also non-fullmesh endpoints added after the flush will not be taken into
account to create subflows in reaction to ADD_ADDRs.

Fixes: f88191c7f361 ("mptcp: pm: in-kernel: record fullmesh endp nb")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260422-mptcp-inc-limits-v6-0-903181771530%40kernel.org?part=15
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 7895fb5f982e..382893f22f6a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1279,6 +1279,7 @@ static void __reset_counters(struct pm_nl_pernet *pernet)
 	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->endp_subflow_max, 0);
 	WRITE_ONCE(pernet->endp_laminar_max, 0);
+	WRITE_ONCE(pernet->endp_fullmesh_max, 0);
 	pernet->endpoints = 0;
 }
 

---
base-commit: 94ca4b024f14c6f7ce32ca0c274f5b19c82f634a
change-id: 20260423-mptcp-pm-reset-endp_fullmesh_max-e1e56a51bf01

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

