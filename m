Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A25D171640
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676971; cv=none; b=JTbKiNNGadakXjt6/pRsyV/AJA99DWzFTXknH5aaGRX4efVVyUav7yZDtn5Dksq6GB8oiH3o3zIRTzPOFX765BQ1TwybmDvkratxUR8FPf8F4USB+pN+g2f0AbOI9sarBYo7jinZfgKlSuT3ZfkP5b8rpYwm2m6Go6Wbb2Kz+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676971; c=relaxed/simple;
	bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AVloxza2Y+GJPQ7Q7dtVY0j1uhcKv56zrJCxJRMgkX7xSfE6pJrpFKpVaNt3NupPPG0HxwZFA880rdkGawg/ZJTfr/eiGFvEqNQLi0Q9csrG2A5UxbsXGQrr/F8+Bf0pUlSDfmiRbjg7RkgoW+wOLDdDvaX4xV8yVeV+8nUuH5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjqZX0AN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjqZX0AN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBE1C32782;
	Mon, 22 Jul 2024 19:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676970;
	bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tjqZX0ANRV+Zhvp4JVO0kKvxetDFMb+II6ljs76rfM2uxWN4jgB3xe0B0+T61fl5q
	 z91DtSgkJAJbubLLkt2jeXNfCQmhJFW5D0edIjLAiQkjEGzz2DKBVU65W8Wz6E6ZzH
	 JCGDD4Lao+I7JHqAwsVnZk2Jr7+5mqFtCM+qx5elWzQOdveNx+plU7Kp63RqAXSEBr
	 Kk8jwhU0N9BqSe9v00CEIiPjYueTL98T6loSu+UDJXH5Rz7/E0RhdzHzvVMDPMu3wH
	 xrnWqK1Sl4wLGuPJbYXT55/WFY8n8sCPLknLUS5kvSfuFJrHXKnRPGdCRDWlwJ9Dq/
	 85DjadGwMatCw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:54 +0200
Subject: [PATCH mptcp-net v4 16/23] mptcp: pm: only decrement
 add_addr_accepted for MPJ req
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-16-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1961; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=DeLnnNqaKgMl/0xcB+x46WxsWT6jNX6wQUj5lqlSQtY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSXLsxdUmsMdn2FM6/z2Do79poWfedTtpquf
 kfW8kwdIKKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lwAKCRD2t4JPQmmg
 c4hmD/wLtUNuvPEhXnb9i5ryq6eXaEecnUbh4lMXpWDdhgY7+QubXzy3g2Re4Ns97Cla1f+PIqA
 +Gqiq+jZEhsAQoQuQG2uIbsNLD/YuXJiSX0XhpDkE+kK/O3CNc1G6322aRG7eQY7S69j2SU5zrw
 zsHjosoUzp28PaCcku/QV5bLLnANYYaiTd14aznMmIF3IM9gaLlX7jdpTIfuU2t0r8LM5ccwOjd
 ikgErOokomp9V5DIs9o7pHkjHuGymzXTNthu7JGrQ7/3+BV59w+iHodZsrj5gPqWDZRtlmU1NrS
 hPpo5+DWNsESDI/nP0/lkNmLfD+3otNzLKvtJWYwSIp38olkwy72E+XjkpFMdFFNztl4+vJQD4w
 4pTieNnuJkDGla6/+sf8EiwsH4cN6J2s3BNui84yOuj/LGNaXe5L9txrN4k8KpcbhMeG+ymbZYl
 tK+VjRDeDcrlmzE/FH4sqFdJ5jNcxrYOoZU/dqYR75UlPKuJLoI3SRmaPto9MHiuOYIX24PXffs
 oZ1xrLsGVahDAQnHAZePktefLsFYQxaxG1ca/KtJU5esVEQrAW5KOJHoLqmang+NkTWPMmZI3x6
 04Bta49RSyrfKPGAFnQCmT7EMq1aGUdOElkLTzxgtjAT89yU17cjOwcUYpWrBXJ6hbdp8l/Expd
 s0L3tcRZFA4KisQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Adding the following warning ...

  WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)

... before decrementing the add_addr_accepted counter helped to find a
bug when running the "remove single subflow" subtest from the
mptcp_join.sh selftest.

Removing a 'subflow' endpoint will first trigger a RM_ADDR, then the
subflow closure. Before this patch, and upon the reception of the
RM_ADDR, the other peer will then try to decrement this
add_addr_accepted. That's not correct because the attached subflows have
not been created upon the reception of an ADD_ADDR.

A way to solve that is to decrement the counter only if the attached
subflow was an MP_JOIN to a remote id that was not 0, and initiated by
the host receiving the RM_ADDR.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea942c9f998f..d040cf8af412 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -830,7 +830,7 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			mptcp_close_ssk(sk, ssk, subflow);
 			spin_lock_bh(&msk->pm.lock);
 
-			removed = true;
+			removed |= subflow->request_join;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW)
 				__MPTCP_INC_STATS(sock_net(sk), rm_type);
 		}
@@ -844,7 +844,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 		if (!mptcp_pm_is_kernel(msk))
 			continue;
 
-		if (rm_type == MPTCP_MIB_RMADDR) {
+		if (rm_type == MPTCP_MIB_RMADDR && rm_id &&
+		    !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+			/* Note: if the subflow has been closed before, this
+			 * add_addr_accepted counter will not be decremented.
+			 */
 			msk->pm.add_addr_accepted--;
 			WRITE_ONCE(msk->pm.accept_addr, true);
 		}

-- 
2.45.2

