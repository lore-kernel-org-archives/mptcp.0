Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15B81714B4
	for <mptcp@lists.linux.dev>; Thu, 17 Oct 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160196; cv=none; b=XYw3oz3xlvze6D0/VnXRXvbHPOfG8GmkQTpM4gdnZ5QmQZCZoU386thOW+pdLrLHfk4xinP7I7F7nyIhOrFS7oYjgS50v/lP8MPEu2fXwus6gNGHFCNVYwqsMlZL5I4DRhEJDnANFAd9vnkj8FREUScRUGsqmyUZScV3C2s45Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160196; c=relaxed/simple;
	bh=90qIgu09gbFzFSF8LAN3wC36hcytZOMMBobqtknUxcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnpnjH/dUiKt30Hzv+K44aGRn1AWmGTqth1bTkZZBd26pP0ugZDADxHcsp27VzZB5K7IAmz/1sY2GQvONyL0V4O8fHBfbFoE2YKMLI0uynLjO1zPVsYdr2nLUfV8gjDJwDs0LN25FvK3n0hL7O7Vmsjm6+7ChR8E/6l/vp31bcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcD3+lWQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcD3+lWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9087CC4CEC5;
	Thu, 17 Oct 2024 10:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729160196;
	bh=90qIgu09gbFzFSF8LAN3wC36hcytZOMMBobqtknUxcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pcD3+lWQyyS/0I4D9aj2diKQrvd0ujhoEP+9EH7sOW/jJspXFkmWRNFbNl2Fhewum
	 RTFFk1hXCHmUw/v55+U4hxgnd5+Va4HU4izehYBFWzSe1e+uw/2R2UobV4srdxWOsE
	 hdfi4YwiQQlcVafRasik4kF6aksVPtUqP7m1WDBVAQufrRKsD+y+Rti6h0dOtcHTqq
	 v6sJ42vllrlmOxx7miX/LDRr+h2qoCq1ER8JttI4nBNAaGd6WKws64i6UBH/irh2Pl
	 1LbvMJBNN0PG1Y1GegthmX8L3C4Ay19CrH8aHfZSGAOMC8Go/IIX1bpJewQtWPm+j5
	 oLaLOYIX+6IHQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 17 Oct 2024 12:16:25 +0200
Subject: [PATCH mptcp-net 1/2] mptcp: remove unneeded lock when listing
 scheds
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-mptcp-sched-avail-lock-v1-1-028ef592c6f4@kernel.org>
References: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
In-Reply-To: <20241017-mptcp-sched-avail-lock-v1-0-028ef592c6f4@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=90qIgu09gbFzFSF8LAN3wC36hcytZOMMBobqtknUxcA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnEOQBNpd6p0tZ/ZtBUu+vizI6xh3QzGWktCweC
 Km7AbuDbjiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZxDkAQAKCRD2t4JPQmmg
 c/GfEADh9Em158GtntSKOxtlaF48bdUtvEdD70eBBjoDTKKdiBmp0Gg94QCs8vG6vnEDO7QOhEe
 hv9VsIWb5GD4+Br2itnh4BPdLEAyLt93QbOeuVw3uWkLWFKdIdUyprksiYjQ7KuTlyDl8RwyxGA
 o1FTgSg09IdZjQfKrJWFwz1YoBUTisX21DOIMEtEHKvWQ1JvE+Ei1NntxitGRjkaEWl9Lmpbu7l
 +S5Kv26B5xJd64QcJIrMiEJk6ylntl7Jh1DxHxNYukzbUoUfPKhLOQZK7/P0mBZfcvXe6w3JEq3
 CisGy6KtMy3WdrIQDRtpH503e+wYCRFh/OPQm2ErI5aDF1JLZ/maO1leHyUWDrVr5VS+rIoB1HN
 v+eamJyRzsp5LZTcrA78aFHYI8aA+p2UVKRDMjnA1JrqhOH868366auM6GtlDoIHdCMqu1UNgyD
 mm9U9ONgu2HTIk4tbxu9I0ta8X/ZB/OVXM1kZjRTzzu5YuR2fOhd0+EIC7o33AKXVZaiNhbSUUv
 i7AP/Z0DU+xIC/DYkQepoiDzd3UZNdZdjJW7YHQgOma3BvaPcWXJswKvqa2YMimUryChK6046hT
 t9U9J6RmppUqtJCzxskIb09QOJ18zjIU2B9gQOAfr4kKz+iCYhBOHWopN7eSFrCiip5Q1RJcjVg
 xmLaMCer6t3NCxg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

mptcp_get_available_schedulers() needs to iterate over the schedulers'
list only to read the names: it doesn't modify anything there.

In this case, it is enough to hold the RCU read lock, no need to combine
this with the associated spin lock.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index 5257bc6c8cd6e8ca674c9beccaf7b27c989da76a..6da60e35932ffd8a92ad7a8b128e5eaf09219b82 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -60,7 +60,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	size_t offs = 0;
 
 	rcu_read_lock();
-	spin_lock(&mptcp_sched_list_lock);
 	list_for_each_entry_rcu(sched, &mptcp_sched_list, list) {
 		offs += snprintf(buf + offs, maxlen - offs,
 				 "%s%s",
@@ -69,7 +68,6 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 		if (WARN_ON_ONCE(offs >= maxlen))
 			break;
 	}
-	spin_unlock(&mptcp_sched_list_lock);
 	rcu_read_unlock();
 }
 

-- 
2.45.2

