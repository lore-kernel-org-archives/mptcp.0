Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF8740BCA0
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005994; cv=none; b=A/6DY4cSwYoY+w0GrZkbN+rjnZwqUUA5WU1SBgtCa9Qj19qY2F63a8sMQsTBH14TcRqZNIVqxxQ58cj/P8i6fo5H9k3z9Pe/uDUT8BBpcV6C1my73CTIqI6n6NS0WtWHaKfVrrqnpcVbDY0EZxTw2JvTMRA25rSHLgokggY5Xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005994; c=relaxed/simple;
	bh=WmJNy5ZTm7vIvbOqqfvmFfGJ0JSE0UVrJeQIEdL+Iuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxHFDtsHHs5rp49ak8Bxv3cNwuMvXTYzUY+p+k+1Y6d+kDo4HrvYryGF1zoZyd3IaS4ldjrA1ONU3O10kM9Sm987xuzsLi27ss6SsLzM7XEYTPsikDF8veMXifs/tlt42fAcvReZ5iDG62atrtr6MwCWpIhLESv05AYEqCcmf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAOt4tGx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAOt4tGx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA221F00A3D;
	Thu,  6 Aug 2026 08:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005993;
	bh=W/0zVcLyv/v+LWUJTNpgjxsoiBumkOPpWFceJO+aHIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PAOt4tGx2HiG1WF7sLpVw86TBM+AggojH/51f3haj3wa4y6TbgFitlq0ecMPSuTFU
	 csbXGlg64cpbx9U9brgAh2nwuZOGSIs2VKbDhQxP+Y7OgQ2SrerUtqvk/on3QjgpJ/
	 raIY5W5F/kX4xm0IDLeBdl0aHcMP4+2Di0Fhb96KE/kD9yzYV93WwheIUYBE9+LdGt
	 vYqI2v+6H8WteNCQHEH9AlHsDQktKxlXd8NeDO76NreDlyGuQOn4x5/7zriBBrbZ4h
	 ObVmiJj3xz9aKg0CQbq+Exs6ARMFi109E23h+uXEuYaAExXHSZf3xM5T9G5zb2fED6
	 LBh8Hox0rvm5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Aug 2026 10:46:19 +0200
Subject: [PATCH mptcp-net v2 2/6] mptcp: pm: userspace: allow announcing
 ID0 addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-2-fea1808e1c57@kernel.org>
References: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
In-Reply-To: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WmJNy5ZTm7vIvbOqqfvmFfGJ0JSE0UVrJeQIEdL+Iuc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPB+y6z63aNv0oueGBP/msjzBzq97n9g4ckjMv/3py
 nO2vugLHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNRP8nwV3QDu8rDDdIXgo4n
 xnu+/HBTJ2X5z2e59XyxW8LPPJZwXMHIsHqhufo5TsmdzWt0Ve2nJ3ye8r2aZfo/NZXQ3oXz5oX
 qMwIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is valid to announce an address with the ID0, the in-kernel PM allows
to do that when re-announcing the initial IP address after having been
deleted.

So no need to have such exception. If the ID is set to 0, but the
address doesn't match with the existing one, an error will be returned
by mptcp_userspace_pm_append_new_local_addr().

Note that once removed, the ID0 entry could be replaced by another IP
address. The RFC8684 doesn't specify this specific case with ID0, but it
says [1]: "A host wishing to replace an existing Address ID MUST first
remove the existing one". In these unclear conditions, better to let the
responsibility to the userspace daemon to pick the same IP or another
one, similar to what was in place before.

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.4.1-13 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: Add note about re-using the ID0 with another address (Sashiko)
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index b15f8908d503..eaeaf6fe3b58 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -229,12 +229,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		goto announce_err;
 
-	if (addr_val.addr.id == 0) {
-		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr id");
-		err = -EINVAL;
-		goto announce_err;
-	}
-
 	if (!(addr_val.flags & MPTCP_PM_ADDR_FLAG_SIGNAL)) {
 		NL_SET_ERR_MSG_ATTR(info->extack, addr, "invalid addr flags");
 		err = -EINVAL;

-- 
2.53.0

