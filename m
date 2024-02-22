Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F3130E32
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619292; cv=none; b=Kt6Gl3fXQMyBju3YNln4IrSQCFX0A6l5jAxevz4hiyQgMY5y+bqAvwikra37k+tCOQ0Es5QtRbmzcCA3FK9wBCkZTRump8AHAFeiA+TNSdry9HUOr6Lvitlx75ooxwD06khQHZM/Swzlrozo1haTEgCi97rTejmlZwtKDcX4zYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619292; c=relaxed/simple;
	bh=ch3d4qE1pOtuyMtgo+vHhV0TD3CsAIz8LN8VnjAlsck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5CkgsbS1fvWPve8C7I0TwxR7T0UWSGwEYG3SKfnjV5ZtvVpNbDMjDZuDRYny5pBJ5xTRNHy9rJeICL+X/09TQ+9yMCixv3cM5sB16qIr+Vu6aG5oVimoUtssuyDykajl4vjpm93Ntxp90K1EvxRSvq+QTukf7IZE8wBPq5Pgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPMJq58b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPMJq58b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A9CC433C7;
	Thu, 22 Feb 2024 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708619291;
	bh=ch3d4qE1pOtuyMtgo+vHhV0TD3CsAIz8LN8VnjAlsck=;
	h=From:Subject:Date:To:Cc:From;
	b=gPMJq58bRCa7zAZ9Ma5u6dFwUJQMpdLqh5SooDfm3WgN4umkSGkVrUoEZ8S0yqQk/
	 peTMs4njYoOBBdh9Ca1mnwxDcWnpt52rujYp5GvO5zlqpdIRSahVUbZzb7zn6JxBQG
	 wXfoCiWYtV5CbA+uUcqvV5FIEKlO81Lnp5UDyx7JZu6Y9VHUpwCg75GL7zcCRMwuqe
	 P2v+kmH2tjVj4/I7tNQZ66dAjvJTX6tebiGr3xQQCr+AGo/AKb1IDN4rVHe+hmpGJy
	 K+KraPGuYt/5YEbMK5vm4j9Q8PoSyxeGrIZsynPNg0w8M6vPYhhBaRoZYLDulJe/f9
	 IaosO7svzf2AQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/6] selftests: mptcp: fix shellcheck warnings
Date: Thu, 22 Feb 2024 17:27:56 +0100
Message-Id: <20240222-selftests-mptcp-shellcheck-v1-0-fed8ba9e6ca6@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAx212UC/yXM0QrCMAxA0V8ZeTYQ0wnDXxEfRsxssNbSFBmM/
 bvFPR643A1cq6nDddig6tfcPrnjfBpA4pyfivboBiYeiZnRNS1NvTm+S5OCHjUliSovnCiEaaZ
 AJBfog1J1sfU/v8FRZ10b3Pf9B+Q9eMF4AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ch3d4qE1pOtuyMtgo+vHhV0TD3CsAIz8LN8VnjAlsck=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl13Yav1d0FWOK0Iky27MdNMJVzoE97Leekj4rL
 g0kGSP4bWCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdd2GgAKCRD2t4JPQmmg
 c1CgEADDw8qR7GsbEucleVY+ydJSGj/dG/9KbLotkPJj4VYi2lkofqmcQ0tDMDTbIu2H7Q3Z+OD
 Uu1XDuVUY21tUjRSaNEm5TfIcoodu9ZoDcBKDeT8S1hHYjUOE0Ew97Ao6OrLYSC+yFYntcQ+GId
 fjLXaJkLpUViS5qdekkOw1BJbuKdpz4s2CGF+LglwXF5IpQq343pIA6pfdRuRBuv5HBU5rDRtvE
 cI6RubT4kSBY9i+ty4ogQG4MCee4CnG7mkoba3wne6+wty3bMPJFulBu82U2oRcVyOxDnqkiKEk
 PMvGgldR+ijNN57tsG75rWd3od/LlJ4ogx3TNE5tFBeutUWg9A9oBD7BhlEDxdOzZab8Ql0odPc
 gEd36URhM1BRp/KddfMHK7c2ttTOMBCfJy36NyIwO24RX5QGUPqPhY7bS1+U3vu2aiuVpFJw1Jv
 Zm31Xu+9Qk5oRyfS1QiwJQt8Rid9YSNRMreep0lmS3lTb+s267a0waXYFL+9XNXOOVTcgCzkNJc
 8S5NsxK4lEVRFIJs+Fn7Ad93+mE9cH9P7590XYg9TLeBRswTaj/MXQWAfVLR9G3l7xHgAAaL8nn
 Qh/MJtL241XULI3pLW0cVXoYtTKeKn/kHu6de2h7q9jSWOFqvd4fujV9yeCLkD+EX+Rwh1MEjVr
 j9SzS+nnGe33ZSw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Note that 3 scripts were already compliant: mptcp_join.sh, mptcp_lib.sh,
and userspace_pm.sh. mptcp_lib.sh was compliant from the beginning.

The modifications are minor, mainly because SC2086 has been ignored:
Double quote to prevent globbing and word splitting. This is
recommended, but the current usage is correct and there is no need to do
all these modifications to be compliant with this rule. New files, like
mptcp-lib.sh, should not have that rule ideally. Ideally new code other
existing files should use double quotes when needed.

Once applied, I'm planning to add a check on the CI side to catch new
issues, not to have to check that manually and report issues when
applying patches, like I had to do a few times very recently.

The last patch is not related to shellcheck, but I found this while
looking at the scripts: in userspace_pm.sh, we launch 'pm_nl_ctl events'
once, then kill it, then relaunch it using the same temp files.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (6):
      selftests: mptcp: diag: fix shellcheck warnings
      selftests: mptcp: connect: fix shellcheck warnings
      selftests: mptcp: sockopt: fix shellcheck warnings
      selftests: mptcp: pm netlink: fix shellcheck warnings
      selftests: mptcp: simult flows: fix shellcheck warnings
      selftests: userspace pm: avoid relaunching pm events

 tools/testing/selftests/net/mptcp/diag.sh          | 14 ++--
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 76 +++++++++++++---------
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 14 ++--
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 14 ++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 10 ++-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 29 ++++-----
 6 files changed, 98 insertions(+), 59 deletions(-)
---
base-commit: 482712b4b5fc44b30dcd54409cbab4ec7e405294
change-id: 20240222-selftests-mptcp-shellcheck-80338a0300c5

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

