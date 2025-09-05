Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190323BCE7
	for <mptcp@lists.linux.dev>; Fri,  5 Sep 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757096356; cv=none; b=uSGbqz2pZJaKNC3XCUUUhUo6FHkRKCiqA2wR39SkavP/D9/XVKqP4giDEE8du+EV3ngHP3OFMkADwjPrG6mm3gfamposLKWniSrbBYHoN/LZxVLckCctv6M+WnicFNFxYYegl8+nkSqIlmDihU+fHoyrrcKDqAuAc5CLCR+JjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757096356; c=relaxed/simple;
	bh=Iihxuinu7ht5VuPhqiYuepxTuYMTXiFUefLxpFODc64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Uu4URIZUN/r6lgcBnZnddkFMSQMTZP1Hkj6q/DQA6157QK3iMvNogpIv7LQObBDk7EBFnIy3fsv+dLHIfeNQ9S0foeYqEqzP1tEFCXjHiPhpbEjOQGYjd8VV8aseP5z8LmZKzVC/tLhwhARnfrQSsH5vamxmZpIRf6p2l/78XPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax44pBTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax44pBTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F9C4CEF7;
	Fri,  5 Sep 2025 18:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757096355;
	bh=Iihxuinu7ht5VuPhqiYuepxTuYMTXiFUefLxpFODc64=;
	h=From:Subject:Date:To:Cc:From;
	b=Ax44pBTsioYxpkJkp34/PqjYdGwBJFGkFwiFK2zRRMqBrUxuYlLWtvXe6RmVJyjhp
	 Yza+gi9zeb07vRF1Nagam15KjXI4DWsk2GgFOFu8uLvUVoNJF1U+fuE/LlGgMrwcUv
	 6avGOIvU8TM4L5Z6GQA7kuXYiwOObUMXje6o2ctm6Lql8V0j1+0SXVMe99zOIVOlT1
	 Bw+zYbnf+o3Qedg6ubUGP5ZHaQi3ri3JTG93/GYGhyj+dPCskQDAH+JS8TIk0aw4lT
	 2ar9HXh0K8Mm8LvGbqRSTPwm75c4EA0q9TVbWg2BSF1Mp5brigOUxDy2uCv5z8ri17
	 KaUoB3iwlANdg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net v2 0/5] selftests: mptcp: avoid spurious errors
 on TCP disconnect
Date: Fri, 05 Sep 2025 20:18:49 +0200
Message-Id: <20250905-sft-mptcp-disc-err-v2-0-dfb3b6b4a877@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkpu2gC/22NwQ6CMBBEf4Xs2TVtCWA9+R+Gg20XaNTSbBuiI
 fy7DVw9TubNmxUSsacE12oFpsUnP4cS1KkCOz3CSOhdyaCEasRFtJiGjO+YbUTnk0VixrpuOtO
 12lhnoAwj0+A/u/QOBxsoQ1+qyac883e/W+QOHGap/5kXiQK1E3ZQujVW1rcncaDXeeYR+m3bf
 rcBUD7AAAAA
X-Change-ID: 20250806-sft-mptcp-disc-err-3357b769bcdb
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2660; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Iihxuinu7ht5VuPhqiYuepxTuYMTXiFUefLxpFODc64=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ2a85ruPyH8Z3zzguXbmz89eZjv1KU1tftp+OM/qRUX
 ttzLbdQrKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiU10Z/hn0nz3xVEtR3zf2
 N9dJ1Zm+arrz+6xWGEXJLlf/ICz06h7DL+Z5L5TV1jivNdSM3OxwsW4qSy9nd/9fjR7FmA0KbF4
 K/AA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This should fix the recent instabilities seen by MPTCP and NIPA CIs
where the 'mptcp_connect.sh' tests fail regularly when running the
'disconnect' subtests with "plain" TCP sockets, e.g.

  # INFO: disconnect
  # 63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   996ms) [ OK ]
  # 64 ns1 MPTCP -> ns1 (10.0.1.1:20002      ) TCP       (duration   851ms) [ OK ]
  # 65 ns1 TCP   -> ns1 (10.0.1.1:20003      ) MPTCP     Unexpected revents: POLLERR/POLLNVAL(19)
  # (duration   896ms) [FAIL] file received by server does not match (in, out):
  # -rw-r--r-- 1 root root 11112852 Aug 19 09:16 /tmp/tmp.hlJe5DoMoq.disconnect
  # Trailing bytes are:
  # /{ga 6@=#.8:-rw------- 1 root root 10085368 Aug 19 09:16 /tmp/tmp.blClunilxx
  # Trailing bytes are:
  # /{ga 6@=#.8:66 ns1 MPTCP -> ns1 (dead:beef:1::1:20004) MPTCP     (duration   987ms) [ OK ]
  # 67 ns1 MPTCP -> ns1 (dead:beef:1::1:20005) TCP       (duration   911ms) [ OK ]
  # 68 ns1 TCP   -> ns1 (dead:beef:1::1:20006) MPTCP     (duration   980ms) [ OK ]
  # [FAIL] Tests of the full disconnection have failed

Patch 3 fixes this issue, but a fix in MPTCP in patch 1 is also needed
to fix MPTCP behaviour, and simplify patch 3. Patches 2 and 4 improve
some errors reported by the selftests, and patch 5 helps with the
debugging. I guess all these patches can be sent to 'net'

Note: Patch 1 will cause errors in Packetdrill, that's normal, see [1].

Link: https://github.com/multipath-tcp/packetdrill/pull/171 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 1: new
- Patch 3: no more state filtering needed thanks to patch 1
- Patch 4: switch from hexdump to od (Mat)
- Patch 5: new
- Link to v1: https://lore.kernel.org/r/20250819-sft-mptcp-disc-err-v1-0-9d0cf296bc13@kernel.org

---
Matthieu Baerts (NGI0) (5):
      mptcp: propagate shutdown to subflows when possible
      selftests: mptcp: connect: catch IO errors on listen side
      selftests: mptcp: avoid spurious errors on TCP disconnect
      selftests: mptcp: print trailing bytes with od
      selftests: mptcp: connect: print pcap suffix

 net/mptcp/protocol.c                               | 16 ++++++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c  | 10 +++++++---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +++++-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     |  2 +-
 4 files changed, 29 insertions(+), 5 deletions(-)
---
base-commit: 9335a0684b0967cc704105e953f2a9d893fbcf57
change-id: 20250806-sft-mptcp-disc-err-3357b769bcdb

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

