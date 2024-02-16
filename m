Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4BB22EED
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077046; cv=none; b=cUEisMw78wY/yiN2z0vz0MPCro9rxTnRD7AOmykEdobeg/HjSot+wPRMpcoUGs+ylaN6NLXMdOmw/C5qbo7rJrX90hpoHJ+djs4eABI9Kheqf0tZbUiXUjJJt1t5CpFvwtqw2wSInKZ9xG7oxqHJNIzUt8NXc4qeAsbjdcy4hx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077046; c=relaxed/simple;
	bh=iH/qpS1+WtfriFBNqxUWtLO2ddlqhbryChL9gHb399s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CO5+WpXF3OH8L5Es3c9WFGRa7p8T7+xNXmw7t450ttkIeheioNT35R3J+oVXwqFr2setf8njXavX8l9uvR4T2gdT+U9oJ8xFFA0MQ45awAx4CyFpn/3Fe9qEubBBjW/zd/L6IMnvkikBbzy7lXQgbM9jl/8CwtkObqOYmZHuID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQRp9OM4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQRp9OM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E4EC433C7;
	Fri, 16 Feb 2024 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077046;
	bh=iH/qpS1+WtfriFBNqxUWtLO2ddlqhbryChL9gHb399s=;
	h=From:To:Cc:Subject:Date:From;
	b=dQRp9OM4zhmdloMaH4mHtXUdOBbfRN2iT3fvj5elPAnAGGdX0Cwhg2AbULBP2LQcX
	 ImhgvO2mlyEEZ+NgY7T7hYrnLl1j27mEMqIb/TiCpKFdIjcRao+pvy71p4uiFhdgF+
	 PjIaL8f/5TXc22Kknm9SPczBrhBni2Q7si2USGFf9P261ICol8TsElZ0ZbSsSFRpR9
	 FbZyXXFtew9HlyjrEBa348EW/rr2pnUDuPKYLXFFEdIxfsc980T+nTRqmcBmT2BXtS
	 PPTsXimRx2S1FeaPgTZlgxaccuKpAH8iX5tHRBz+bZyPt89dG6A7h9EJACuh1lRcdo
	 ZYWWVyC4hVlZQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/7] add helpers and vars in mptcp_lib.sh, part 1
Date: Fri, 16 Feb 2024 17:50:28 +0800
Message-Id: <cover.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - address Matt's comments in v1.
 - all for -next, not -net.
 - add two more patches.

Part 1 of "add helpers and vars in mptcp_lib.sh", some fixes.

Geliang Tang (7):
  selftests: mptcp: netlink: drop duplicate var ret
  selftests: mptcp: simult flows: define missing vars
  selftests: mptcp: join: change capture/checksum as bool
  selftests: mptcp: diag: change timeout_poll to 30
  selftests: mptcp: drop iptables/ip6tables vars
  selftests: mptcp: add ss mptcp support checks
  selftests: mptcp: add mptcp_lib_check_tools helper

 tools/testing/selftests/net/mptcp/diag.sh     | 15 +----
 .../selftests/net/mptcp/mptcp_connect.sh      |  9 +--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 55 ++++++-------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 29 ++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 25 ++-------
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +--
 .../selftests/net/mptcp/simult_flows.sh       | 14 ++---
 .../selftests/net/mptcp/userspace_pm.sh       |  8 +--
 8 files changed, 62 insertions(+), 102 deletions(-)

-- 
2.40.1

