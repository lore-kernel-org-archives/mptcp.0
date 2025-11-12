Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A42311C3F
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964725; cv=none; b=BnTfACkCJWZZtP7/iIHeuTvkcbli2wyn0l/WffDD4ZwEL9HDEpzG+owijqkB7USLVIx0S7w9N7o2kM8CbT9xEUypnGhxy7D2KMTJ8L4/4d+ddOXJ9gFGZzgLp2Pj7NYBL/3fB/604pDzT6VRzMIMG4OhUQ2uWiF6cqRGO2/7Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964725; c=relaxed/simple;
	bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0vrY2sVPCvwoHHTi15ZBnWedcd4UHjhIaks1WYpBytle7lwFn3Mv3uYidM+z35He9wXv+N3ROYniDIZnujROf9OLgXTz6p1i1K0ZHztP6vF0NHF8XAJvwyaBu0I5fdt5bC23Caeo1tCjUvGkXie8X4Isb1koUj3oQCJFOjPMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGBNNCLT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGBNNCLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F88C113D0;
	Wed, 12 Nov 2025 16:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964725;
	bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KGBNNCLTAaONQ/sw9fsKR/x4JEnZ0XgvF8gVys69G2UpIENt7twCuIQ9NvnfhaMOP
	 UjrEie9mFYeJbiP9cZBxvPSEKX8oHn6VE9QIziro0KJ5AsFxC/f/HWrxcEE/RptvWT
	 oXDwLbPZvbiijUdeDw+gscrmA2TIu8jN9nwGVyf4j6Jqa/LU2Wl1B14gOd+dow64yq
	 rD7YXGCJspUapxTVVbIrduEZkcJmdW497S1h6PhK/4La3tebJYVGoMtOfAnyIO+mAU
	 CguQBZfbngGOmaFnFVOhr9NpPFaZ3b0jWeisbBXiFEY+Oovrg7zqA5BzJ8Tm4iWOxB
	 IkVttBcKMwdqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:49 +0100
Subject: [PATCH iproute-mptcp 6/6] mptcp: monitor: support 'server side' as
 a flag
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-6-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ijk5pe9mMQ9Z2WSXWd9d09O4dX0EBa2qbR1Hznf3iSQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtrw/8rBk16JLonumeMqZ7N/7TCv0x9uG52bxN0t/b
 ehtXSDW0FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRmXWMDFtrU6ZMYImNM9OS
 4We4/HmGyvPWt1F8Nof+7My6ph/2ZgnDf6dG0/VnfvO/ZXPeZfaBv+HYHd/GJCXxDbtn5KbIiD6
 wZgEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In the v6.18 kernel, the 'server side' attribute has been deprecated [1]
in favour of the 'server side' flag [2].

Support both: first checking the new flag, then the old attribute to
continue supporting older kernels.

Link: https://git.kernel.org/torvalds/c/c8bc168f5f3d [1]
Link: https://git.kernel.org/torvalds/c/3d7ae91107b8 [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 ip/ipmptcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 01f6906f..acd008f3 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -535,11 +535,14 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		printf(" reset_reason=%u", rta_getattr_u32(tb[MPTCP_ATTR_RESET_REASON]));
 	if (tb[MPTCP_ATTR_RESET_FLAGS])
 		printf(" reset_flags=0x%x", rta_getattr_u32(tb[MPTCP_ATTR_RESET_FLAGS]));
-	if (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))
-		printf(" server_side");
 
 	if (tb[MPTCP_ATTR_FLAGS])
 		flags = rta_getattr_u16(tb[MPTCP_ATTR_FLAGS]);
+	if ((flags & MPTCP_PM_EV_FLAG_SERVER_SIDE) ||
+	    (tb[MPTCP_ATTR_SERVER_SIDE] && rta_getattr_u8(tb[MPTCP_ATTR_SERVER_SIDE]))) {
+		flags &= ~MPTCP_PM_EV_FLAG_SERVER_SIDE;
+		printf(" server_side");
+	}
 	if (flags & MPTCP_PM_EV_FLAG_DENY_JOIN_ID0) {
 		flags &= ~MPTCP_PM_EV_FLAG_DENY_JOIN_ID0;
 		printf(" deny_join_id0");

-- 
2.51.0

