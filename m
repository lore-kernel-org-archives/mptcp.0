Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789C3B182
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759484; cv=none; b=p8XsMeUnE/A9WElJYJqVGVcsGqwOJVb/IZS/2sWm9u66FSFKg2L2RPY5g1pklJZnfwXZpyL5AOLbtXFPzqIq00ToZHJ+2r7uYiOtAKF3WJHZ+HMBJeNNEfZMtBeM7Z1fodtOSkp1FrKWanJD80vFXgI6NjjVDtztfAzhMNrvyOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759484; c=relaxed/simple;
	bh=tiLau+8JSTlhiA0yuu2edlR5eYgxhBfDvB34hC2piI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P0hpC/W9JL3EgoZkWkJNywfegb4hSt/57FRJf4UJVN2CRxyW0xOI/8/6hHYq6vFGB5DdNgBAh8cN9KKzDAA7bIdnVYdfiPJSb8V4p3XHlcwMzZKpVxdC5qNqLCMUqejQr9CzzR81sa1mN/MY/vHKJbAB6b59uGViDLe6AMOrtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh0XL4gI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh0XL4gI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D86C433C7;
	Thu,  1 Feb 2024 03:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706759484;
	bh=tiLau+8JSTlhiA0yuu2edlR5eYgxhBfDvB34hC2piI0=;
	h=From:To:Cc:Subject:Date:From;
	b=dh0XL4gIgk7N5ectV9JWKeaUKbYFqy/JhpyrXVNCUMkHCKE4Zatu1yFBDF8Qc7GhV
	 NoftOyirwPEZY/tIqpgbl7JikCNBEL2Z+xj6YVuz3F9i92XpTxRy1Q97PpQFIxk2Nm
	 flZU9jQpBzKLTJ6AH8uowEcIqrC+pbbdO6/whCARAD1prhiSjiDSz9CGbdDRgrzaZM
	 9afichAfpfO/HU59StjHBMSaHz1DE9F1vhqNvoyAa6otmFR0h5EQ+c3SlciZAcrna1
	 wyyn/OIer+1N/Xg1l4bD3kWssdp9EjZ88BLHL+g62OUSHB5QH5GG9pB5WkLnGQiGYK
	 JPQyoHKE7utkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 0/4] fixes for userspace PM
Date: Thu,  1 Feb 2024 11:51:14 +0800
Message-Id: <cover.1706759413.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Fixes for "create an ID 0 subflow" and "map v4 address to v6".

Geliang Tang (4):
  mptcp: add needs_id for userspace appending addr
  mptcp: add needs_id for netlink appending addr
  mptcp: map v4 address to v6 when destroying subflow
  selftests: mptcp: rm subflow with v4/v4mapped addr

 net/mptcp/pm_netlink.c                        | 24 +++++++++++++++----
 net/mptcp/pm_userspace.c                      | 23 +++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++---
 3 files changed, 44 insertions(+), 14 deletions(-)

-- 
2.40.1

