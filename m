Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3F1CEACB
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272914; cv=none; b=jPnJFGUZYwP+bW+PE5O3Cjc9/XFyOg1/g114SfNnc5UjC+nW4zcDK4SG7uN0pGxmG2i06i6sOctvAGoccbXnBFAlzkg6ZqYeogliTvD1E75KwHO/MbDjdCS3LZdiPtWXguG40rYIbTkn+LLGw3K92WDWlfS2R5IOvO2y9gDLfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272914; c=relaxed/simple;
	bh=wgilv0wCzR5ZxI3jtAhDN2UnNa1iMhe5XAQF4/wEGrc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ivJRGtzoWmiYPYkUii6IWmPHnx04hekCM+3C4MrnftEbQK5M0jpfp1MBVm5VNJs7qZtZuuNWDwhtO5Iv5EIsEuPpo0ajgBYubPyxYXI6Rq44lRmoy+b5ZxCXfX0C8uLSOXp6DVZjQiuc9pjp3pCoeLgbwqkkj67uzT6fdMP9w18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg4HLKxu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg4HLKxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E22C4CEF0;
	Fri, 19 Sep 2025 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758272914;
	bh=wgilv0wCzR5ZxI3jtAhDN2UnNa1iMhe5XAQF4/wEGrc=;
	h=From:Subject:Date:To:Cc:From;
	b=eg4HLKxuAxZ8ogIbCMSVe73ZQ15l+oCjq6XnI4M48d7e1EaQj2IYKg+WNOdftp011
	 A6ug4xbiR1LfX01v7PWrGT08Et4ZpsJaa0/JbvlY0cHHvQP2WV2UerPM+CBRDdazKX
	 Bz1TlHgEHEQxBws9AC3SWJBhjGvDmsripHGP3S8TNylTGca1fMhXhO4tTlJkkUzL2q
	 VKMe+RUtWMDIe6ddQW+mWSHXIDB35r1q3rk7UzxWPqFY1k+4m7mKOBFHSzUTr3q59/
	 uc4Dpvv7nYFTf6bhDRyaWKJS2tM9T5l/Rf8wi6RLkI/gKDSqAifC5Su3D7DU68SXSG
	 9sh5wyKz5ARhw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 00/10] mptcp: pm: a few cleanups
Date: Fri, 19 Sep 2025 11:08:06 +0200
Message-Id: <20250919-pm-kern-endp-add_addr-v2-0-1f8f04f01914@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHYdzWgC/3WNwQqDMBBEf0X23C1JilV78j+KlJBsNLTGsBGxi
 P/eVHrtYQ7DzLzZIBF7SnArNmBafPJTyEadCjCDDj2ht9mDEqoUjbxiHPFJHJCCjaitfWQxNqV
 xhjS5izOQt5HJ+fXg3mGMs4kYaJ2hy9ng0zzx+7hc5NH40es/9EWiQJKKyrqqhJay/ZbodZ64h
 27f9w/A+Xf6xwAAAA==
X-Change-ID: 20250916-pm-kern-endp-add_addr-95cfceaef3fc
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=wgilv0wCzR5ZxI3jtAhDN2UnNa1iMhe5XAQF4/wEGrc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOyjb8OWo10fj88nwH7xWsjDPjY21WzZ7vtWnJx/fei
 85XXJ8X1FHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR5dUM/6OWflug98tqfrPh
 RzNNN/tHb4Rjd5V/3/z1on+pgpfRnmuMDLffuZ3bUuhnE/f8vcZmo81ZEp/9QpkufroZpPPp2OQ
 5XIwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

I'm currently looking at adding ADD-ADDR endpoint type, see [1].

When working on this, I decided to do something we should have done from
a long time: renaming some variables with confusing names, and split
some functions.

Flushing this now, just to ease the reviews: this should be pure
refactoring, no functional changes intended in all these commits.

Based-on: <20250916-pm-c-flag-client-default-v2-0-3be2c5bc4d6a@kernel.org>
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/503
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- patch 1: move protocol.h modif from patch 2 (Geliang)
- patch 3: 'Reverse X-Mas Tree' order, and comments (Geliang)
- patches 4 & 7: avoid one line above 80 chars
- Link to v1: https://lore.kernel.org/r/20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org

---
Matthieu Baerts (NGI0) (10):
      Squash to "mptcp: pm: in-kernel: usable client side with C-flag"
      mptcp: pm: in-kernel: refactor fill_local_addresses_vec
      mptcp: pm: in-kernel: refactor fill_remote_addresses_vec
      mptcp: pm: rename 'subflows' to 'extra_subflows'
      mptcp: pm: in-kernel: rename 'subflows_max' to 'limit_extra_subflows'
      mptcp: pm: in-kernel: rename 'add_addr_signal_max' to 'endp_signal_max'
      mptcp: pm: in-kernel: rename 'add_addr_accept_max' to 'limit_add_addr_accepted'
      mptcp: pm: in-kernel: rename 'local_addr_max' to 'endp_subflow_max'
      mptcp: pm: in-kernel: rename 'local_addr_list' to 'endp_list'
      mptcp: pm: in-kernel: rename 'addrs' to 'endpoints'

 include/uapi/linux/mptcp.h                        |   5 +
 net/mptcp/pm.c                                    |  17 +-
 net/mptcp/pm_kernel.c                             | 458 ++++++++++++----------
 net/mptcp/pm_userspace.c                          |   2 +-
 net/mptcp/protocol.h                              |  15 +-
 net/mptcp/sockopt.c                               |  20 +-
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |   2 +-
 7 files changed, 292 insertions(+), 227 deletions(-)
---
base-commit: 32778f6dc930afb30f995997c12cd8b829ac1600
change-id: 20250916-pm-kern-endp-add_addr-95cfceaef3fc

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

