Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23C513550;
	Tue, 13 Oct 2026 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914219; cv=none; b=O6D+V7I9a1H4qrCL0g+RJpXGKr8XRfCUTqk+65F3rR6gtfAM3e+6kZBy6cjJiv5VsaVJXKubyPwZ6LblVwA0QDbgg1x+703d5AJgIbzoWBUbVMKFmezSgq1L2krq3IqTZJJDDJs1iJVjgrXEqDu/G1j7M08IRi27W7upSlg3eyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914219; c=relaxed/simple;
	bh=HHNrM8N88GiZSo/o2R2o2Cp3l5dQUKejHWINk8wME3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PDmIg6me/oyCpB/wlq5pVm2koH3rwOt/h05NuUppcxmZYUTTQ1eca8UxW1ShpEo3kmF/Q4infsn8ve4bonXeEa6yhB2ShyO+u6ax1xZYoLA0QeMtfcGYhHvdc4CdE6njpoRPMMnlWyIMixgFZTs8QN4daKkiiUYP8a3EyLvCk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMQC5mRs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMQC5mRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C9F1F000FF;
	Tue, 13 Oct 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791914217;
	bh=hexCFrqj1R7xL2R+of3UaYujoNgio4AbRWP8wGyu7AQ=;
	h=From:Subject:Date:To:Cc;
	b=SMQC5mRs6gs5Qsjun6QJrN2hsKmrwuy7doahdGN2JOQMZcBUFmTCObI8HhSFm1spg
	 oS4aqoMhl10oUpJmSw5YKhJkvlY5fLM7y4cnQKGtwEUPbjMgNn1eGHVQS0PAZ0GLa0
	 amKFwSSSbucFjtIPz5/Dstr0mHBlkHY6w5wj2Y0TLnpw3lXyKsxJSKRrshhRD8A2NP
	 DUmkr0ONw+giT1GRLTK5EovlA3kCRs4ibUmjDzAphduFxkuxDqKceqUJyr/gWY6/Sa
	 BQewZ6DwQ2MZ1n/Q90lVgkAgu+9o4xVQhxT/GFX24X+7UbR+kN5OoqSjue9thS71ur
	 L3jwmcfvAIjIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/4] mptcp: misc improvements for v7.4
Date: Tue, 13 Oct 2026 19:56:37 +0200
Message-Id: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zWNwQrCMBBEf6Xs2YXs0ir6K+Ihxo2u0BiSrRRK/
 91Y8TCHxzDzFqhSVCqcugWKvLXqKzWgXQfh4dNdUG+NgR3vyRFjEmuZDcdsIeOoNWAUb3jAHrM
 vxsjUe3eMnhwP0I5ykajzJjnDfw+XX1On61OCfR2wrh/wYxFzkAAAAA==
X-Change-ID: 20261012-net-next-mptcp-misc-feat-7-4-part2-214a09fa1025
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Hangbin Liu <liuhangbin@kylinos.cn>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HHNrM8N88GiZSo/o2R2o2Cp3l5dQUKejHWINk8wME3k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLOFTzuusgpUjcr42jwPIcujswdKrarjhfJ3u1QZd/O4
 /ZsfdGWjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlMmcPwz8xuIo9ovcnSuDcW
 Gx3/zlgboPts+R2lm5tZ6mbls6+zeM/wz4bB9M48sfDURcp7XsXOn3uz/Mpp718H10c+OCnFpnP
 sJhcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are some unrelated improvements for MPTCP and its selftests:

- Patches 1-2: avoid printing (pr_debug) uninitialised data. These are
  non-urgent fixes that can be backported to silence errors or if it
  helps with other backports.

- Patches 3-4: convert IPTables to NFTables in MPTCP selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Note: patches 3-4 have been previously sent as part of another series:

  https://lore.kernel.org/20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406@kernel.org

---
Hangbin Liu (2):
      selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
      selftests: mptcp: convert iptables to nftables for mptcp_join.sh

Matthieu Baerts (NGI0) (2):
      mptcp: options: mpc: avoid printing uninit data
      mptcp: options: dss: avoid printing uninit csum

 net/mptcp/options.c                                |   9 +-
 tools/testing/selftests/net/mptcp/config           |  15 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 158 +++++++++------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |   9 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh |  53 +++----
 5 files changed, 113 insertions(+), 131 deletions(-)
---
base-commit: d7804253678eb18d2be950e0542364b50be096a9
change-id: 20261012-net-next-mptcp-misc-feat-7-4-part2-214a09fa1025

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

