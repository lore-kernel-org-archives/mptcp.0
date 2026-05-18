Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000A36E48B
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109155; cv=none; b=TA/AYT+i7dAfr3BPDgc7T96fBbXrKOQnQNcIvJlXe4/joY2Xpw2UFo2EOV4ZWHlSlclX+zX7HDvdzWiAPHb4hP8yNLO/aXoh1Cmb7DN2q1CBQLJhO9toITI/PyDVDSdObZkv99NXpvT0xifmUFTIg1qg9Bu4n5wZyAS6mzf/3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109155; c=relaxed/simple;
	bh=rGgPN/38Jri6i0caXcu4jB+3pGlaZRRl+Vq2A5rxWws=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r+X2xB0YLBIluzZWzbiPHmcavppMQINrivJvxQEYmapG2vFc7K2fr+l9PoPCnKe9EIUIpWnbkdRzpsniUZ32N+dueNCyvI7IlLrd04FoNqYUweP5UqliHoWCQ72j7Q0rmm88omHfyAr4AdJVIOGy4JSsEhvTanpcIKmna5cuFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE5wRz/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE5wRz/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8BEC2BCB8;
	Mon, 18 May 2026 12:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109154;
	bh=rGgPN/38Jri6i0caXcu4jB+3pGlaZRRl+Vq2A5rxWws=;
	h=From:Subject:Date:To:Cc:From;
	b=pE5wRz/sAPvXtD0RC0ARMWhDdusEWTgXflxT/UmVOT1Wz1dOVmr0QbPycBJMCt6Qq
	 PtMNFrZsJhK8I9ArsfNiisVCDAmndGMp4ZY4NQCGSBi+AkyIXDBcdhMF6VDS9gYc7x
	 hHcPoWSguEGvlWXzS0sFxS1iYXWvrGTFbcscvZS7S1hhgQm0mFDRFEg3LHBo4RND2o
	 7Z4vxMzu70/nj8jwaP18AyS2OCE4OhN95flyLnkzCn0CufekwppTja6+kckWvBWL1q
	 lr4bcUgxj6GRHwU4fegx0MYjViHV3bsgoNUiGWubtntwo3HCJ17jG+LuosPrBuWHXf
	 CDNfnakuYUDYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 00/12] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Date: Mon, 18 May 2026 22:59:04 +1000
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKz7kA0NZVepbjQZGxTaAwz0yKId
 zfWxV88Pu+tIMSRBO7VCky/KHFOBepLBf41pCdhDIWhMY0zrenwk9VnHEI4xg7zzIoqaG+1ay2
 ZqbtaKHZmmuLyLz/glBItCv35yXd8k9cjDdu2A7ovZe+HAAAA
X-Change-ID: 20260508-mptcp-add-addr6-port-ts-371653e0f843
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2465; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=rGgPN/38Jri6i0caXcu4jB+3pGlaZRRl+Vq2A5rxWws=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0g/6qaIKBibZMNepOpq3dg0AeParkJlWv9X
 JXpoocSe36JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIAAKCRD2t4JPQmmg
 c3KyEAC0wXiTdY+yJtyxQcvghAjEOf+lCahMmBr1JbJ6h2+aKiNXaoa0ctuvNOeZVriAkFNm2ED
 56r593NXJ0XlIX7Dj4WsjPR9HWS+FEUd0yPLNAutKqe0w1m1CmeDaDnsKPRNU6nnUzB/cvollKK
 I8u2BS4ZfHayEej/5UxfZTfvKYkYoPkjL2yA5xqDRW158KE1g3W6BmZIYyGq96fxz3XXOQEh5+3
 T3RoUVOR6GUV2Kg8KOER7vnYJNjMFpe3JzHTIiHJb2z1CZpIGacWaJNit1l9AG62/KPjHw1+sLv
 DOXq+3TK/6kQVur3Aqyz3KQymMvXm9QoK6tqrj5eT2OfcjpX5dfOQVhc4MzSRkEBRuPOAzYE+i4
 UVNmZF5wopCRITCoLMMzR0YPFv9e06a77SPzz2mr8uwLH+tqwEB8Fg/aySVo8fjvcCEb7sJuOET
 axT1nwjEOpfptKYUEOo//qsin6DBgfa09El345wzrWf5YvVCasq5YRaR5Emf0a0DQ3ooYe/yP+9
 0qs96tu+5v9NJFUvn1OnB6CaTp47HBD5NRrsGJkxSHp3SMfajEY6dJ/pBgZ8k1fQuyC4UJz7mDa
 0C+wy5fH5WuwNIIJ9WbbG9vjKoNvErf9S3x2/dz1YN/x5OSQqYtPmw9gW8AghxeWVV5HwNa1iZ3
 X+PVlxfS7WHClIg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Currently, it is possible to add a "signal" MPTCP endpoint with a v6
address and a port, or to directly request to send an ADD_ADDR with a v6
address and a port, but such signalling option cannot be sent when TCP
timestamps is used due to a lack of option space. Instead of simply
dropping such ADD_ADDR, the TCP timestamps can be dropped only for this
packet.

- Patches 1-2: small cleanups to avoid computing ADD/RM_ADDR twice.

- Patches 3-4: the new feature, controlled by a new sysctl knob.

- Patch 5: extra checks in the selftests.

- Patches 6-12: refactoring/cleanups: some of them were part of a
  previous patch: "mptcp: pm: clearer ADD_ADDR related helpers names"
  [1].

Link: https://lore.kernel.org/20260415-mptcp-inc-limits-v5-20-e54c3bf80e4e@kernel.org [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (12):
      mptcp: pm: avoid computing rm_addr size twice
      mptcp: pm: avoid computing add_addr size twice
      mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
      selftests: mptcp: validate ADD_ADDRv6 + TS + port
      selftests: mptcp: always check sent/dropped ADD_ADDRs
      mptcp: pm: use for_each_subflow helper
      mptcp: pm: rename add_entry structure to add_addr
      mptcp: pm: uniform announced addresses helpers
      mptcp: pm: remove add_ prefix from timer
      mptcp: pm: make mptcp_pm_add_addr_send_ack static
      mptcp: pm: avoid using del_timer directly
      mptcp: pm: avoid confusing check_id in del_timer

 Documentation/networking/mptcp-sysctl.rst       |  13 ++
 include/net/mptcp.h                             |   3 +-
 net/ipv4/tcp_output.c                           |   6 +-
 net/mptcp/ctrl.c                                |  18 ++-
 net/mptcp/options.c                             |  33 ++---
 net/mptcp/pm.c                                  | 180 +++++++++++++++---------
 net/mptcp/pm_kernel.c                           |  22 +--
 net/mptcp/pm_userspace.c                        |   6 +-
 net/mptcp/protocol.h                            |  45 ++----
 net/mptcp/subflow.c                             |   4 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh |  83 +++++------
 11 files changed, 223 insertions(+), 190 deletions(-)
---
base-commit: 23350e342bf2604e09d89ef91d000aef684f593b
change-id: 20260508-mptcp-add-addr6-port-ts-371653e0f843

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>

