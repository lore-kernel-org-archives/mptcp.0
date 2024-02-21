Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB939FE9
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499191; cv=none; b=rDaHpjNDh7Pxy2CyC1dPn7l9D61jvPnI+NbFEU61C6NOc0WnIhfTaXK9m8C10wEKeU/OYdhv5eeP7uelNGKQ4QXRLRJyzmD2qeb06Ouw7exou1YIg7b5bP6taCKMaEMmlWTBmQc7DOiNbArLH6ofX20tBdbbuNshx7tAZh+6/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499191; c=relaxed/simple;
	bh=MrC8n/GOSkJk76+zLrt3+ry4t+gmcyMmBKHLtI8bneY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IYQVJxzZlHCecXll3cSEPW1k1e3k6bXYCPzIPQSAh9igkoraxydaHK2l3YYTzrUODHQig6kZ7XV8MlqgqZWejiGQ9UBKN0B+c9T+UnEM3aLdIJe409ZbSBhLQTRoflIgFa7KGBgT8pkoKoqusXypJ60FDyqVgHyUWsFBMHu2PvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZwxyHHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZwxyHHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07CBC433F1;
	Wed, 21 Feb 2024 07:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708499190;
	bh=MrC8n/GOSkJk76+zLrt3+ry4t+gmcyMmBKHLtI8bneY=;
	h=From:To:Cc:Subject:Date:From;
	b=gZwxyHHnzZprU3Zvh4tkUneyjHG5En5CProihj9FXOsKunR7xt4BEZSB8+kOwzTus
	 /FzXQ6xd9fiOnJwNjLmcWxzeh1YZs8prpaF6IHXE5FEPpTAlmQnlKVfeCwUYlhpiIv
	 ptoVVd4gV/S6dNmUZ2ixqE1LLjJ8WM88NYwxhxxfFFfsqw0QbWedcQq7CXR51Fb+T7
	 TL9Sv40NbNYBGdWkDQgT/0201fXWz4pzuqVBiq9EwgIhVQTOv0tF2A2LH6KEUGxeKB
	 8YdUEnb3+cX+cOrmpJQvXQ6Z2arWBm4VCRSK1HaBOv8XPk5AFRyfKaMPZIEuGcMABb
	 PxxjBFGuyxGpQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/3] add helpers and vars in mptcp_lib.sh, part 2
Date: Wed, 21 Feb 2024 15:06:19 +0800
Message-Id: <cover.1708499011.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - patch #2, drop this line in mptcp_lib_ns_exit():
	rm -f /tmp/"$netns".{nstat,out}

Depends on:
 - dump for userspace pm, v14

Geliang Tang (3):
  selftests: mptcp: connect: add local variable rndh
  selftests: mptcp: add mptcp_lib_ns_* helpers
  selftests: mptcp: add mptcp_lib_evts_* helpers

 tools/testing/selftests/net/mptcp/diag.sh     |  9 +--
 .../selftests/net/mptcp/mptcp_connect.sh      | 25 +++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 27 ++-----
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 78 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 ++--
 .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +--
 .../selftests/net/mptcp/simult_flows.sh       | 16 ++--
 .../selftests/net/mptcp/userspace_pm.sh       | 42 +++-------
 8 files changed, 122 insertions(+), 100 deletions(-)

-- 
2.40.1

