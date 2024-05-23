Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA312AAF0
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451747; cv=none; b=jWpgQeQ9u0sRYiLhh9GS+xZ1xSHN5DNJguZtWstlQ1YNR2eU9IFoofxpRzuE8Yw5/BSqonHVpA92gSSW8HBCmmk1kAGBSt6f78fK0GHOrbOnQob85hAPdQ/OwIOk5kJbwePqc87BZuWMCkGD4C4H0wbctW2mASsaHPoRgDhSdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451747; c=relaxed/simple;
	bh=OCrDmMiUjXfBPdy6d+Ijvrf5yzPbBwHpGW20F0hfZl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1XxxY7oNHJfaWNPbvYs5faIkwoSAWxEFh8NPtD3/NRVZNU4WvgmsSZhllJnqqME3IOybQWS2zZVT9le5NEpybSZp0KaUOoHyUUtYzOx1pa1gOq6i6+/Xf3SXMpEViYv3CUInTh7gWTBqiOSDJW4+PorELaUxKGKOocov9Iht1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWB6lPQs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWB6lPQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D7BC2BD10;
	Thu, 23 May 2024 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716451746;
	bh=OCrDmMiUjXfBPdy6d+Ijvrf5yzPbBwHpGW20F0hfZl8=;
	h=From:To:Cc:Subject:Date:From;
	b=XWB6lPQsHPy+yXKIDKJPJWig+bPuqyIqJYImovplw2gh4l8KA4AQzVCBXUepfopz6
	 ycEutUIuWcdhSayY4Grhxxzo/Eu3cceB9dPwl6gqnFu9FUBYKd/r1tXz+43g2T2/mS
	 eOsFoCkgzKK4W9ge1JxFujD9jDiavpc1KXbtgfUW8WRDNXanKVr8zmd/TUxdGlj8rn
	 Bd1PQAnmhLLza31rBoMGCRrMwrs66Mx/JaBHsissR2iNE5iW9MR28F0i/wjYsVglYO
	 O0y7Bw4IbY4yRSKVVDQ4SWNGULTd4o0bAxtcs8q0hFkpxzw1JR6DiEmW6agA1O1gF7
	 woKvR+oaV7KFQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] use helpers in lib.sh and net_helpers.sh
Date: Thu, 23 May 2024 16:08:56 +0800
Message-ID: <cover.1716451525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set uses the public helpers defined in net selftests to replace
helpers in mptcp_lib.sh.

v2:
 - only patch 3 updated, mptcp_join.sh, move cleanup_all_ns from
   cleanup_partial to cleanup, setup_ns will delete existing
   namespaces automaticly.
 - update commit logs.

Geliang Tang (4):
  selftests: mptcp: rename ns to ns1 in diag.sh
  selftests: mptcp: use setup_ns helper in lib.sh
  selftests: mptcp: use cleanup_all_ns helper in lib.sh
  selftests: mptcp: use wait_local_port_listen helper

 tools/testing/selftests/net/mptcp/diag.sh     | 58 +++++++++----------
 .../selftests/net/mptcp/mptcp_connect.sh      |  3 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  3 +-
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 43 +++-----------
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  2 +-
 .../testing/selftests/net/mptcp/pm_netlink.sh |  2 +-
 .../selftests/net/mptcp/simult_flows.sh       |  2 +-
 .../selftests/net/mptcp/userspace_pm.sh       |  2 +-
 8 files changed, 44 insertions(+), 71 deletions(-)

-- 
2.43.0

