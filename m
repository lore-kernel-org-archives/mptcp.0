Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84943189903
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689508; cv=none; b=LzG/NbKcQFBKbSNS/NjX1m6kwQeHMHV+MTRjyv7mGSuCDRhYI6oYlMW4xF8/1cVLX3ofdxdr0EzrP9CwPs/U8/7OndugTKvyKtuXv9GMGBqU2AS3b3Rg9mT7OrhIkOGbIHGsCy7O/oS4XsSrFzSpEbQwBcf9oCvlqqC2KOGBxaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689508; c=relaxed/simple;
	bh=P+QRr4EilN8x1rhX4xw8EtCjQeXZ33m5tTjfYqlnPlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIW5CY2wqZxr6RHAzFx98un7QuEi9abpGFW2FvTCpeoQ8dO+l8QwChnHDr4jSPiC2d6y5QlSsM8ydsYLdgqais1fafyhvHGS5qpqD8tfNa2gZcgcDUxEut3sdu7+aSHMwkoCCzFgj6ajZ/hYcKaE/QTGm7DaIJZAVInEz2qIN0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAcMb4Kn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAcMb4Kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD80AC4CEC7;
	Mon, 30 Sep 2024 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727689508;
	bh=P+QRr4EilN8x1rhX4xw8EtCjQeXZ33m5tTjfYqlnPlg=;
	h=From:To:Cc:Subject:Date:From;
	b=KAcMb4KnMq4VAkegasIlQoQZOM8uaqt4vbAYIjH034mCsDtzs2PEKfMM9bgCdVoZI
	 bCO+LxHXTyxwwWsnfeGXPFtKBhsk1zfPkNeXLDMnfJiA7W8ux4gu7Za3BOZ94jHIJa
	 ivisGQ9IyLIIcdM2DOFuT9kWT/xHg3ywF5sBVrf8r0vJ4hF9oV7ZHod1APtEgUBREF
	 MbFuN7MVctxH7+tHugLehbBy6zSJ1JBbmJ+BEx+LXedFsy7PDXIN1n4kcJYhV4N1uv
	 A5rGjb9+ZCzt/tN207YHaPhdmodRpc89DZnDz8kF5JswF/cSZJwomd6EvuRa6ChI4p
	 CoXS15bSbOngQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/7] refactor PM interfaces
Date: Mon, 30 Sep 2024 17:44:55 +0800
Message-ID: <cover.1727689369.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In order to implement BPF path manager, this set refactors get_addr
and dump_addr interfaces of PM.

Depends on:
 - cleanups for PM interfaces

Geliang Tang (7):
  mptcp: add id parameter for get_addr
  mptcp: add addr parameter for get_addr
  mptcp: reuse sending nlmsg code in get_addr
  mptcp: change info of get_addr as const
  mptcp: refactor dump_addr with id bitmap
  mptcp: reuse sending nlmsg code in dump_addr
  mptcp: add loc and rem for set_flags

 net/mptcp/pm_netlink.c   | 153 +++++++++++++++++++++++----------------
 net/mptcp/pm_userspace.c | 121 +++++++++----------------------
 net/mptcp/protocol.h     |  11 ++-
 3 files changed, 132 insertions(+), 153 deletions(-)

-- 
2.43.0

