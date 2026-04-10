Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493A3393DE9
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831529; cv=none; b=WDVbgtWMaW5uezsvfH7i2cZUGxEUamiXqg0qn+jLqbM0VCxZdcloAwJd9MS8ChDfABZSB+5KfLZCHMkTjqi20MIfaLxTipa2cnf+iJ9i4Uasl+waZvGASv+1XtKFaHZGFw6AxQKvG9zsU8HJwwUSqmEOl+BIMtZzBwcma0S+g0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831529; c=relaxed/simple;
	bh=O0zAVV1rKPv2mpUxrgUq7nEQ158FmfJ+Hxcp3VZTW2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUrF90r2TGiUDpSIoXWOiE+g+XimXb6SYhyDk160AEBlwKrdETB+D03R9DbAovb0tTbGci47cZKucFAXyfjVpmQn3nU399rkL3YRo0uYLTI5hndlwacOEkD8gkvc1+w5fGL1FrHJLiiA4IqB4GYSaymJ5oQO44CsXe93jR4Bz7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEtjw2m1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEtjw2m1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2708C19421;
	Fri, 10 Apr 2026 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831529;
	bh=O0zAVV1rKPv2mpUxrgUq7nEQ158FmfJ+Hxcp3VZTW2Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YEtjw2m1O21daCUAVq3ThRDQ7tpPO9bJv0zOVPvv+p+afuQU7rq64I4vnLx4/9HEV
	 2EtLFlsprgTj+TbKXGPNyT3l8AFHQ14awVp5q0yKND3gzUIu+KHwlVxK2PCH9xYbqx
	 o8H+B0Z18VWCKL4OwfEHIrZWQcsF2xlbnfvxvJrZy9l60mXf0APeLqo6ObvuRsO/Db
	 RcQVI/KoLBUi9NYi/PuyqT2dzYZWAtJnFIRwLQaelMrXgwO4UeL5+MIw0w5Xe0+jqF
	 1anluxJz0iiS2ygDGCFodd43jPRkVZMyHoU3ZWTUNClw/Do0WkUH8fmEwCGH83rfBh
	 MqP+KwL+Ba3zA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:41 +0200
Subject: [PATCH mptcp-next v2 03/17] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-3-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O0zAVV1rKPv2mpUxrgUq7nEQ158FmfJ+Hxcp3VZTW2Q=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvct6KmZ96Zd4BRgvjV0e9n80/qta7YXYvg6D6ERnpt
 TeXCyb4dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExEMYeR4cOfdZetTkeJPv1s
 ILD6YWbZgZsmDbsuqB369lz+hs7tVltGhu8zeEsrT5izt8zLkHjy4qO2Uexa7UM7H/TPkJ3RKO3
 oywYA
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
index 989d87e2dc13..0f35ea0e4f66 100644
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

