Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505C3CCFB6
	for <mptcp@lists.linux.dev>; Mon, 13 Apr 2026 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089528; cv=none; b=c+Q+XaBgjiQbu/mAse7RTmqNoq1W7hvZH7H8Ml3+RV4IdB1qZLmZU/OwWowzZ4Wp4TUWPIVJmc4fvWg4EyjPD/vWkDUytQIsW5oH9GJbNAa8t9BIn2uXjfEbRy5CQKgkiNNUF5Ewyryk71PLNV9oD+FmcZNcKpbC65M/gszQYCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089528; c=relaxed/simple;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlSBzj8xxT84n5RIRPVLIXH+dg2O8x8veCXPcKUrHsh4o5hpNq6rde3Pr1Bhn/Wl+Qbur8E4As9zwkjDDfUAWhP5VBmWBVHfqr/sIe1Ax97DvzmFP20IjIRbpxQcvUjoub1/y/SD2WD0c5NAkMjXET7f309jvJ8xM/1e56f8Bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRT/pjxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRT/pjxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A43EC2BCB4;
	Mon, 13 Apr 2026 14:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089528;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gRT/pjxMWJc9yM74XWEyRQxy57ZVZiHTzQDSXSZAEvV7CSmp3AZp+KDkfBQR3UPRE
	 WazICCZdW67BvXvFgJKHersbEfSF/s/gyYzb+Gr81mc1hfirwgoz6Qx/pKp/wZLfs4
	 Uatfz3jFPnawnUUmpd2rD3uoxNWC9tslfYNDhPz91v1t/ma9qXuKib0W/+N10RpAwz
	 9cAxd8OWLZB4mMQoF32+q7KKCA6L6z7u18sn9f646fVFPvJI7I3uF5mr06w0On+vHm
	 6f42Adkf0Md85M4Fwhuowbl6/QoKUw8hhAf2IcOANUHy7hBhfuUGrbLMUXOyuiqn5d
	 hghq1hHQ6ffEA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Apr 2026 16:11:49 +0200
Subject: [PATCH mptcp-net v3 03/19] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-mptcp-inc-limits-v3-3-dd36c9360432@kernel.org>
References: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
In-Reply-To: <20260413-mptcp-inc-limits-v3-0-dd36c9360432@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLv/FxVZXzlz6XjwgbpqXklZY57lcyPM6zg+mVffmW9h
 dDfkAM+HaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMRL2Jk2HWoqPpe4sQVV1SZ
 jx4Ncpxb2bAtr5Nb/H2QinyhtqLAQ0aGGXJ3c2Un3AgrlFHL2fHasqX6ud6Or55PJOZd7HRknMr
 LAAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

ADD_ADDR can be sent for the ID 0, which corresponds to the local
address and port linked to the initial subflow.

Indeed, this address could be removed, and re-added later on, e.g. what
is done in the "delete re-add signal" MPTCP Join selftests. So no reason
to ignore it.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 43a11b65235f..6a75470dcf5e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,9 +337,6 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
-	if (!entry->addr.id)
-		return;
-
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */

-- 
2.53.0

