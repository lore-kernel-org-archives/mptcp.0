Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC51C1F0C
	for <mptcp@lists.linux.dev>; Tue, 14 Jan 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736876274; cv=none; b=ZqsRD8ihf4WspTqXbQfugCd4BtGJAsjUIm9pLQY0CpIFlIVDelnkhKVYRfp3o3I50vwGuiWaiC/eSEs+ClvoOHAo4b0BApGuCeySybt2nSRsLSCxri5imHRUkxjdWbpZ9tzLX9uvAFy2+ydER7u2wu6oQhduRh2qZyEwqzZuF0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736876274; c=relaxed/simple;
	bh=wPVD4C2jCp/XpA5lE2mdnLHhmtEGYtbAJ7dRK4kpJAg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X9GpmAxAcnjnlV7FSssF8AZFN2WUXoYpfq4nqR7rP/Do9g1JqJyFJXION+PD9ii4iO4pTvmw4yrFfK7H+2w7C9xFk83wQG52yTWYx7C2b0Bn0vhCfB1cAUazBwLhgea5IG5WOEDUSd0pPVEdadg5AnpatkWA3KRlFTE4Oqr1ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy4TYE21; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy4TYE21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43E6C4CEE3;
	Tue, 14 Jan 2025 17:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736876273;
	bh=wPVD4C2jCp/XpA5lE2mdnLHhmtEGYtbAJ7dRK4kpJAg=;
	h=From:Subject:Date:To:Cc:From;
	b=Iy4TYE21+rQYS/IrJzmzNuTHDXcVhszh3t9c45vfFVTDcfpXNnQu4TFtryOoukcdQ
	 oo0u4RPEy596bZI7Rxua85aJAu0EaFFrI1Ytqz7fnyqOkNEDt+9wGwt8lgIiJHtuPK
	 UESNh6Y8P0Ssrn8kqmavw9lvxcU0XKsIMOA73hZHVkHc47duULAL/R55znpP5WFAkl
	 cnliJcA6o2gs1eladjJBAioi/JX0n+nybOJrtEGBTcHAFM8EIjwqrrWTOGeu4YkRH3
	 A/h9cPRBrvFs/vnt1Uakbo926XvqYmdrrp4JvQ/hd8F0qZbvdxOAsllayHP0dedR37
	 BXZfeYoJP+sIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/3] mptcp: blackhole: sysctl SYN retrans + fix
 conditions
Date: Tue, 14 Jan 2025 18:37:46 +0100
Message-Id: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqghmcC/x3MQQqAIBBA0avErBtQ0xZdJVqYTTVUKhoRRHdPW
 r7F/w9kSkwZuuqBRBdnDr5A1hW41fqFkKdiUEIZIaXGIzr0Acfdum0NO6FRrW0lWdE0GkoWE81
 8/8sejni6iJ7uE4b3/QBlk7CCbgAAAA==
X-Change-ID: 20250114-mpc-no-blackhole-526a61ea0334
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wPVD4C2jCp/XpA5lE2mdnLHhmtEGYtbAJ7dRK4kpJAg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqDw9x/44FxmyKPXAnJp8M7asRy6uPEvbjfSy
 ux5mvvOMsqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4ag8AAKCRD2t4JPQmmg
 cxtGEADjsBnLKzttUQHO0qHRpnJnVkZm2AoVpOO88Mw7uprAx0qdYK8BPHIlh09qFs4Tu8y2Axh
 0ERXbz/sStKu+D83k7eOmSbsR6pKTJ65qaIwF+ZsevbvJeQGQEqXxQ4ZtCwwghBDkTkqmUFU544
 GaGiWNFeqpT2IFD4WfRr0IvaPz14Qbqw8MwmkMEJ9q8Bgy4uLcxYwwgQIN6SfptyCCKpnkiHEQo
 w2MwoihwvHPAc2omb4HTAm4GyZRhk6I6CijvB8wr95fdXCEt3w8DF27BxhvN3/tU2OmCkp3NmPu
 9o0R5ykOrrtM1JkUJXYz8VkpxJRGK+FIJKE3Yp/2ZDM9X0XMy2lICCSLnmQFJmG8mf30kVcuAX4
 I3bOFjiaWKP89iyMOtFw+C0HrwbCsEEOXF/r10818Yd3YndYafuyFfglmWc5h7w8QGof6HjC9O+
 YiWD+Nx4agxV8iB1U+2FWqGNdpLdKfH70UzItDYsnu/ce1dc0lOae+Bal+xg8rdiZzHyk0wNg0b
 keulEjBhI5IQFkjC679fPLUPy7JXfkGovVlE6v/tTQvLGhAVgAvZSTLxYEQ/7jEdmXqWhjV6oSN
 1KZ007pAjLF3J1/uSBuGAbJrSChARhlIAcjl+LnfLK0WyO5xS4idOecTNj4g02BKSLQLLIALOyo
 /VkZrGWpAQeM7pw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, I found a network having weird behaviours with MPTCP packets:

- The first connection to a server had a successful 3WHS, then MPTCP
  options got stripped off.

- The next one had the first SYN (with or without MPTCP) and 5
  retransmissions dropped, before being apparently intercepted and
  proxied to the end server.

- (The next ones were sometimes intercepted, sometimes not, or dropped
   at the beginning. I'm trying to find out which kind of "optimiser" is
   causing this.)

The result of this was a blackhole being "wrongly" detected, and no ways
to force connections with quite a few SYN drops to finally use MPTCP at
the end.

In this series, we have:

- A small fix for the doc.

- A new sysctl to change the number of SYN retransmitted with MPTCP
  options before falling back to TCP. The modification looks simple
  enough to still be sent to netdev before the closure I think.

- A fix to only turn on the blackhole protection only when the first SYN
  retransmitted without MPTCP option is accepted, instead of any after.
  The blackhole feature was supposed to do that from the beginning, but
  a check was wrongly placed. I think we should consider this as a fix,
  even if there are also risks of not detecting a blackhole if the first
  SYN retransmitted without MPTCP is dropped by accident. But that seems
  more unlikely for an "MPTCP firewall blackhole", and I guess not all
  future MPTCP connections will behave exactly like that. It sounds then
  safer to reduce the possibilities of enabling the blackhole protection
  by accident, and apply this patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: sysctl: blackhole_timeout is per-netns
      mptcp: sysctl: add syn_retrans_before_tcp_fallback
      mptcp: blackhole only if 1st SYN retrans w/o MPC is accepted

 Documentation/networking/mptcp-sysctl.rst | 18 +++++++++++++++++-
 net/mptcp/ctrl.c                          | 25 +++++++++++++++++++------
 2 files changed, 36 insertions(+), 7 deletions(-)
---
base-commit: 9336324d1aec351496e048ec5b6bbda07944ad16
change-id: 20250114-mpc-no-blackhole-526a61ea0334

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

