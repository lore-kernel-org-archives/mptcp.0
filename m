Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBD146D5A
	for <mptcp@lists.linux.dev>; Tue, 14 Apr 2026 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173654; cv=none; b=qLg1tVdbyjTKXoAi05e6MoXpJwU5aHhjwkPtnxWraJKLC0dn/oNdb/qXKYXaJqOgHk2DZ9dTjEftFBoOo14rIhM1c7abjHNTF4XGPdGnvjAPOvjOhWYylO0WratDiNDwmp1y5Q5jk6fn+VyHtvUPLdhcmy127/1FfQn04MW71CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173654; c=relaxed/simple;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNmxBai6sacGLXOxs/AR+mP5gG/MljkD7hxpv0sIlh3xtFYa3q+JaSMLdlJHd9bF7bngCmpM9XccB7ZF+dsJkL9ncFvwPwU/DzWPSFvSvRx3S3E7keX1hv9dHD2eLSaZ9n+f/XGgzr7w5WKi0GutUw445CN6R9r0g9zqD73KTQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZXoEUS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZXoEUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A2CC2BCB0;
	Tue, 14 Apr 2026 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776173654;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JIZXoEUSXql/jWBrDJr3RrSkJ6cAQgtxHsV+lKvHgM0FEq+XByPQ5oJiFbCMmeDS2
	 N+Fd0xOJfmVyvtXDQwBvavalnmw7dT4N6BvFg53dordCmuqM2jaIXZNZrbRhMQjIzx
	 fOGOYAaxXFNyk5Mewq5DuRmf5wqvmvOMWyBOX9bdy7PZzocOsQJwCTZxlbEYR+dLmE
	 H3e0V6kP5uIJ36RNGUz0+DI1AyjK7Q8KRBQTgrzdrlMe153Ybf7z3sI9uN2Hm83TnK
	 kIbg9j4acYWfJF3PkpOmPe16aVNG//tZjSlpRyy95dLUOFx9fyt3G6I/QhkHY6kVGB
	 EhocmfsKDk+7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Apr 2026 15:33:56 +0200
Subject: [PATCH mptcp-net v4 03/20] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-mptcp-inc-limits-v4-3-78274edda5dd@kernel.org>
References: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
In-Reply-To: <20260414-mptcp-inc-limits-v4-0-78274edda5dd@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvOXll8n5wSJaeu+z6tcd7DRKOc1Rxyy6NMXYJflyx/
 slL31cGHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO5/4mR4cAVu307D6535tae
 0qvWeKv3EP/tnnvpHN2R+/pTF1Qp1DP8j/XhrnnOo5ZnJuF8Ma7t7xORpHkmPmEaTTONf8XfClj
 FBQA=
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

