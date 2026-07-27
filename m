Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D642CB1F
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172934; cv=none; b=Mx34eqUbhiAnJt9ykihUqU96mRmi8tHVYqREVMHgtjIWG5dAzrVeGDiL+JJBtvS3XOWittv1VkRcmQIdoPu2eP4LWq7aC0ozq8/57+4O5mNK4UDAZlTEKI8ThFnvu3I8a9n8aaLenbLOiuB6imvXRM52YuO35zYwaTRG4la3jZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172934; c=relaxed/simple;
	bh=cbY+tw0KHJcAFg1rOHJ4xMRDbksFvQiqwDFczVBeaRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkjfe1GV1je3jj7/8LHWu6nlX1BPMPRqFZircvWfCzujJHO2otO+ztV563Bw1Ngt4xel4S10MP8HhGTZQpV2PU1lQkX6im+7EGriYQ/GoIRsfVPUegzdPf5udsM82wJiHu+mzAyI+fYsmyJKtmHfuO2+t95xORBFjwq6v2XSCe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWMVh4Kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWMVh4Kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BBF1F00A3A;
	Mon, 27 Jul 2026 17:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172931;
	bh=awGRv67NcViXC7sGP+VTuIr1AnexhXsuIFT4h/2zPHY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jWMVh4KkcNhvn0q98Bl0zsQp93fTFwItCuIDqHGpE8zwFFG/Zu0TWRvWRfMbEFXU8
	 gfM3Xd8U2JK/vvmXecqpQ9mcy/NclNHqON4rVr0NaI5L8W5yMAkZPINmDlkk+3O0G3
	 Q936eYXA8zLfejp2h6f7FxDPuqHZn8qxJkh9IxYuF1eNlnTHg2VnuMhocAQjruHKkO
	 ERiJ6O/1WyAE/ZyJYuklDRQLcukRKnQSMuIhXO+WBiaHpbQYZFwbPT/Ty+lA0JE6m7
	 0lryvrePQSpeI3YMyaR/YnAPkj3FxhZ3mFTAwcRA34B1vOMzVMt8lcmUUBfP9lwB8y
	 2QR6Zu4Y/8t3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Jul 2026 19:21:51 +0200
Subject: [PATCH mptcp-net 2/6] mptcp: pm: userspace: allow announcing ID0
 addr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-mptcp-pm-userspace-id0-case-v1-2-9877f02a9bae@kernel.org>
References: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
In-Reply-To: <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cbY+tw0KHJcAFg1rOHJ4xMRDbksFvQiqwDFczVBeaRs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLSJ+9MNp/m2G2UvNXtr7LpAb77YcEPJk71Zzdq2Fx0s
 3hCGf/fjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImEGTP8d/8x0bL3i9f7YqXA
 uAsfNzv0JCWnscx+JilufjLh7DHbUIbfbD+OZT5nqZqt/twwT4Pf7c27Grk/jzcff+5y49CeAqs
 HnAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is valid to announce an address with the ID0, the in-kernel PM allows
to do that when re-announcing the initial IP address after having been
deleted.

So no need to have such exception. If the ID is set to 0, but the
address doesn't match with the existing one, an error will be returned
by mptcp_userspace_pm_append_new_local_addr().

Fixes: 9ab4807c84a4 ("mptcp: netlink: Add MPTCP_PM_CMD_ANNOUNCE")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 6e6eeda91ade..4c96433590e3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -212,12 +212,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
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

