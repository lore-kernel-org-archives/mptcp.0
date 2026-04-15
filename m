Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498BA322B8B
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247093; cv=none; b=T06qIHLZCjvo9bHn9SD5eSvWg0QFz+SLGjtMEAznmGdc3XAfEW/ZsbRb6ErOEIdoJPC/FYb+fqzZZZ/enlhiaXHICJnCQXzTYHc8dt91OI19ZfL+kmGn1KkuEqgpmSAxAAX4xaNvdI5U5LnKuFqC6dpVwPm19X2WWv0Y/R/y6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247093; c=relaxed/simple;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEPYA7CdaAtJHku/gm3Lv2mH6wl/lT9c7PEnCJiaeq/f+I9U4oq/M7s1h1nEFndcnfwTet8FwXiIVkjdyJ9kDS5gAKRjWtXQPVZ/D8VuEwIG1MGtgd5ZCFNDmMujzhtrARYNRgEk6zXP2RLAFZXANoQ6jGrVsZa+ElJbOZjuyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+Ucgx1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+Ucgx1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D641C19424;
	Wed, 15 Apr 2026 09:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247093;
	bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k+Ucgx1CZTPYum9PbxAXirIU9J1t0Ql1BPfmMZzRuwT7F5oTjUKOgmnDkCwsvtlsU
	 h7gRzcw2TVzdBREk7kKa8OYmOVjtIfQCbQ6mP3FCJXjSuWd/x/Accx3WbC6lAzamke
	 lo61cK44oZuuU3wET+RgwxIBUVpmIGozRnzfZpw5luOg9A+3WG5JVUTTwGPi/9JN1R
	 17SrnQYwgHXy3Ke6sH5n6lnzHI5B/6EP/VM6DJ1nNDaAz+uK7ausf70VQ99W9vb84l
	 b2+x73LSfQx8JzmYXt/t1S+mA069RWG8VB04nSizzJyH1Oiuj+WcL+9O6f0gIcVzpx
	 P4tmy9/Oqt7Zg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:56:51 +0200
Subject: [PATCH mptcp-net v5 03/20] mptcp: pm: ADD_ADDR rtx: allow ID 0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-3-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RjhEZ4Y9dGN7dl5bP4at23CWIzyuoWHqJdbVn30LIas=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ6p0elx86LjvysIDHNLvv3D/W/lId3nvlSUK5gwMf
 gbPvVv2dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykVJDhf8zRZ9nBXH17dx1Z
 t6AsydJmycctW019W83n5Wx99PfYh0cMfwUvTs6zn1smPemuXelZx+RJvB2v3SYe3Pf0pr1zvNa
 xmQwA
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

