Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B18462
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764181883; cv=none; b=f88sKc10qdJf7M2EYgHjTh5KCxXEnDotY1mn/ogYBn4JqoX1l0BBTARyU+NzA6FcY2/HY9653JOVDIjHQPnaOXq42EVsW4z2pQkHWuqn3gZnvOhjoZx+RTTHSwuufB57wJiMEgMw/ic9bbuyoHvd7t2oMwXaa2Im2Hzn6Nx/yiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764181883; c=relaxed/simple;
	bh=RKg802UrWGO1TrRuZ4zDC6K5DgnN5d84/S5e9Jr0itg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kQNam7tmmd05tVIG1qzauw/ZUP3NwzKhFydkzo5ri9Et9MviHNTZOl3CyGNEZa1nWCEybZ8HpLhZE6sCknLbF6RLMKLbqRDmXKOqIwoS5EFWPzQ13fr3MIjGa/ZLtq6KKxHaBOohCP4pLya/ixmBB5hBDtq0c7Lm365JgfxYbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMk6ais6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMk6ais6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC24CC4CEF7;
	Wed, 26 Nov 2025 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764181883;
	bh=RKg802UrWGO1TrRuZ4zDC6K5DgnN5d84/S5e9Jr0itg=;
	h=From:Subject:Date:To:Cc:From;
	b=NMk6ais6+z6JdBD/okabI1Up/y1FQbyum783AJuoZm2rRw1xikXl/Y5REA6kU3QFC
	 96PxEVxGdsxmT4r+bmNuhXTgqJjrtQ/YPhwkwsK2N0vNLg9eDN3HYe5MTFSBhtH2al
	 Z+3J6jGJYFsnmpqxfmw1W2kLn0UwOBchSx9Ecz/ADtBElgg7P2Pdt7DGdJ3UWWeM4k
	 rX4y8SezoQE8sGRgAPMP2DSaRYvAxvm0Si72utZCNywodRnLrBF0O0jMHuojnWiPNc
	 6OYA9aZDJmNERFmdkl6IY7dDzz0Y4adHrk5gQSOSDAF4SLSMVocUfpY3OZKN6a6iu6
	 Wp7DuAWsg24RQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net 0/3] mptcp: pm: ignore unknown endpoint flags
Date: Wed, 26 Nov 2025 19:31:08 +0100
Message-Id: <20251126-mptcp-pm-kern-drop-unknown-flags-v1-0-d2e4c2ebce0c@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1HJ2kC/yWNzQqDMBAGX0X23AUTKkJfpfQgyRe7WDdhY39Af
 PeG9jiHmdmpwgSVLt1OhpdUydrAnToK90lnsMTG5Hs/OOcHXssWCpeVF5hytFz4qYvmt3J6THN
 lnBFGF1PvMVLLFEOSz29xpb+t2Oh2HF+boM/gfQAAAA==
X-Change-ID: 20251125-mptcp-pm-kern-drop-unknown-flags-e4ec71df02e7
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1429; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RKg802UrWGO1TrRuZ4zDC6K5DgnN5d84/S5e9Jr0itg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLV3csOFLQd4fx5Yrv2ww3vMra2Bk3klGfT3NHREPRsS
 b1I/znujlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkY7mdkeC2Qv7ijexf7z4DU
 ZZ9y/zwQk7e2aeH7sTjq3J7f1jsufmdkWMU68fdhK9sPRivPuvN+PHfoqXtKvLWQiGJeiZ3aQfd
 lHAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is just a simple fix to ignore unknown endpoint flags. Recently, a
new "laminar" flag has been added. It can be set on older kernel
versions without effects -- which is good -- but it is strange to report
it in the endpoints dumps if it is not supported.

  # uname -r
  6.17.9
  # ip mptcp endpoint add 1.2.3.4 laminar  # not supported on v6.17
  # ip mptcp endpoint
  1.2.3.4 id 1 laminar

Patch 1 fixes that, while Patch 2 validates that.

Patch 3 is for mptcp-next, to correctly follow the specs and accept u32
flags instead of u8. This doesn't change anything, but avoids
confusions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      mptcp: pm: ignore unknown endpoint flags
      selftests: mptcp: pm: ensure unknown flags are ignored
      mptcp: pm: align endpoint flags size with the NL specs

 include/uapi/linux/mptcp.h                      |  1 +
 net/mptcp/pm_netlink.c                          |  3 ++-
 net/mptcp/protocol.h                            |  4 ++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh |  4 ++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c   | 11 +++++++++++
 5 files changed, 20 insertions(+), 3 deletions(-)
---
base-commit: 690b1c68fd1e566ffa60fec98e09292cc9f04a3a
change-id: 20251125-mptcp-pm-kern-drop-unknown-flags-e4ec71df02e7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

