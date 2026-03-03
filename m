Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE13C3BED;
	Tue,  3 Mar 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535388; cv=none; b=h4ePXOppLWY55Ppe/8Mt6YVTn8vou5rbJcAqPGvePnpA2TUqKb5BYuo/jQ+JTnSaUT1taNgTNBKyX83Sk8tc6rfYCPNVe2aY0+f5WtcgIuyYiAsRU1IKRK+KOFSTR6xg4waQaQTqJPHkzdrCJzs0ygQ8DjEjd7Z1Ty0P3vgBuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535388; c=relaxed/simple;
	bh=LFZNvXvLhgyDtOq7B0kKZOmxtxtzRGWj+pM+CU9ypZs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CKB38rMS2bgKTPjhxZmkLlY9ntKzU8MQD1gce2SKYRx1+NgivKNO2rkU/VYTBvfhk89YDgS+gLaW0JukcTkW+SKyLj8aKSOcQUQQ2bMngUXWUkpBmNcQ0EbEfLVGxV56i0PdBIdQql0HghQMcf7hWWrhDsHMKpzq7GjMs7N+mlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCMbWBxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCMbWBxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CF2C116C6;
	Tue,  3 Mar 2026 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772535387;
	bh=LFZNvXvLhgyDtOq7B0kKZOmxtxtzRGWj+pM+CU9ypZs=;
	h=From:Subject:Date:To:Cc:From;
	b=OCMbWBxl0uDoqUPsVgBHzjqCaHfQ5C3S5vPCeRkzA0O64Bj5FNClzNeCz4kUfFg7G
	 0Qo7Kv1n2oQwAqZ58IeSsQqlf8QdP11cEK5cnj69WhCjej00geIt6I1bIRhg2hrQRc
	 vAWaKUbSA8eOpgfz4GgUfQVS34QisalDlJnaIHWfC7NldZ/F/9tmYIG32OkAiwsly7
	 0Ix55N+1N+BRfr7LJj1ZqlHUBCFicKb5VUjNyCETSvZc9S2wEtUGbq3nafuZgamBMu
	 V2xBB9ATErUhou/t3VvBRRibTCorfiRG27qXfJ4PcgVHawqZvMnJbhGEWwodC7OLRP
	 L9g3CrlCbl0pA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: misc fixes for v7.0-rc2
Date: Tue, 03 Mar 2026 11:56:01 +0100
Message-Id: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEG+pmkC/x2MwQqDQAwFf0Vy7oN1xSr9ldLDNsaag+uykVIQ/
 73B48DMHGRSVYwezUFVvmq6ZYf21hAvKX8EOjlTDPEeuhCRZcdadi5Y1Riz/sQwIKByRD9Mc3q
 nrh15JF+UKpfghyd5Sa/z/ANgLW9dcwAAAA==
X-Change-ID: 20260302-net-mptcp-misc-fixes-7-0-rc2-57dfaba318c8
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Frank Lorenz <lorenz-frank@web.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LFZNvXvLhgyDtOq7B0kKZOmxtxtzRGWj+pM+CU9ypZs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKX7fNn3GT5pU4k5l7qs1Met1tYG+yPbBIIuWPF+tHtV
 2LrsflsHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNpZmFk+ML2suKvo4qh0wmz
 2QL7JgvfaPa9syllw5bJzrWcNdYhxowMew9++SK2Mnrmq5lWAYvyD1+Un/Fm2qzPqxNdk69dMBT
 xYwMA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various unrelated fixes:

- Patch 1: avoid bufferbloat in simult_flows selftest which can cause
  instabilities. A fix for v5.10.

- Patches 2-3: reduce RM_ADDR lost by not sending it over the same
  subflow as the one being removed, if possible. A fix for v5.13.

- Patches 4-5: avoid a WARN when using signal + subflow endpoints with a
  subflow limit of 0, and removing such endpoints during an active
  connection. A fix for v5.17.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: pm: avoid sending RM_ADDR over same subflow
      selftests: mptcp: join: check RM_ADDR not sent over same subflow
      mptcp: pm: in-kernel: always mark signal+subflow endp as used
      selftests: mptcp: join: check removing signal+subflow endp

Paolo Abeni (1):
      selftests: mptcp: more stable simult_flows tests

 net/mptcp/pm.c                                    | 55 ++++++++++++++++++-----
 net/mptcp/pm_kernel.c                             |  9 ++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 49 ++++++++++++++++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh | 11 +++--
 4 files changed, 108 insertions(+), 16 deletions(-)
---
base-commit: 9439a661c2e80485406ce2c90b107ca17858382d
change-id: 20260302-net-mptcp-misc-fixes-7-0-rc2-57dfaba318c8

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

