Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B0226861
	for <mptcp@lists.linux.dev>; Thu, 18 Sep 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217363; cv=none; b=DljC6FFFJm497ZbFQOUI559KWmy1vZZjHZexGBmi9xYShIF17wTga9rMIiOZlaPnnkAeJXAXD4Z1x/lGunnfONel0TEMr5TvIFSInYtvuHvjsa8/E/gVF4BeT+qDuFW+l28Mv9Kp0kTecq4tHzPZb6yJomodkGqye+Phn/CzO/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217363; c=relaxed/simple;
	bh=8JFnLRGFWceUFxj3kxBNiTvo0Nve7l7lF+NhB4lMHl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FQZktOYR0ea11Mhosj4S9weuD4KjB+9oAJ+bQ3T5BA4ZelJ+uWOYAt1mlnojvaRiemwSW65Y6LicE0jCUFY8zVZR2eFX2W2m53tOXfppHYTqI1j9YNEdcYB6F3vEiblJGq0NP2s8iVH90Lfv/pwi0jg8CgD6lwA8cEmnKzCgvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMo/1MBj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMo/1MBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D6CC4CEE7;
	Thu, 18 Sep 2025 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217363;
	bh=8JFnLRGFWceUFxj3kxBNiTvo0Nve7l7lF+NhB4lMHl8=;
	h=From:Subject:Date:To:Cc:From;
	b=HMo/1MBjTLapg0dD2ZnwCN72XcFvbBRpUmU2tzLRFsA6KEHJPknMYw9JAyDOZDXyJ
	 5MRpt/CCbLNKcaKKLJ0rjg9NE8I1YVMEjgcNLGjXj0M1S5HkzPVo+WQ9XgQzmaq56h
	 Zs0GCxePicZCUNeYHTtHyvyg6I+DBQAblDqLnfoGlmbcXVP1IHzTw0ZHJJSdDdBNbk
	 nZWq3z0bhbG7cfIwY1EoWh636Hfs1gPLImYYTrSHPVhpBAkKm3jEFzgHYwMUU5vngO
	 3ewLbsd9KR0k3FVI0kp11sw8LfAVeucZwJA/v5QGSUNb1nIbvZ4Psa4zznpXA19j+6
	 4HracdZB3jAtg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 00/10] mptcp: pm: a few cleanups
Date: Thu, 18 Sep 2025 19:42:16 +0200
Message-Id: <20250918-pm-kern-endp-add_addr-v1-0-e12e58770a11@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHhEzGgC/x2MwQrCQAwFf6XkbKCtVKi/IiJL9q0GaQzZIoXSf
 3fxMIc5zOxUEYpK126nwFerfqzJcOpIXsmeYM3NaezHqZ+HC/vCb4QxLDunnB+N4HmSIkgo5yL
 UWg8U3f7fGy2+irNhW+l+HD+xCA9zcwAAAA==
X-Change-ID: 20250916-pm-kern-endp-add_addr-95cfceaef3fc
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1990; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8JFnLRGFWceUFxj3kxBNiTvo0Nve7l7lF+NhB4lMHl8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLOuLT284qeU5OyljiUaLmrfXHBvY3ewjfqDrjNnKsma
 br1RfCWjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgInwaTH8L1DPj3xnUZyd7rts
 YYlx9oFalftJM08xtyW+1gm+znLrICPDh7NKpdm39ucufi1/3Lukz0pUhCkkQ9HhyoXa+t0Llms
 yAAA=
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
 net/mptcp/pm.c                                    |  16 +-
 net/mptcp/pm_kernel.c                             | 451 ++++++++++++----------
 net/mptcp/pm_userspace.c                          |   2 +-
 net/mptcp/protocol.h                              |  15 +-
 net/mptcp/sockopt.c                               |  20 +-
 tools/testing/selftests/bpf/progs/mptcp_subflow.c |   2 +-
 7 files changed, 284 insertions(+), 227 deletions(-)
---
base-commit: 32778f6dc930afb30f995997c12cd8b829ac1600
change-id: 20250916-pm-kern-endp-add_addr-95cfceaef3fc

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

