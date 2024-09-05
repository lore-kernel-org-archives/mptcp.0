Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DEDDDBE
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546541; cv=none; b=oiAAAAFfGcegCWV1vF1R/2dA2QpNNLirjCcsorOOhbIteVjHsZjJSQMPrdp12g5LF6TB3C4Hja/nRy3Lz9h1DkXxSeoOgvz1ifC9eE/YdKJGxT+zpBsCtT+IlVep7p5HdTSHZ6VwuBTnPGXgmcf8auaXjWZj9CTkmkpkBZC8pcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546541; c=relaxed/simple;
	bh=rpYIrnqzM0WX271dJ0D1qWpXLHU0PHr8dObyTlibdw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSuy5eZNosF4Q8ipuNGn7V7kgRVJR5DAE6gbnWRoMH0doKaXYyHoThfLdrQ7eDvAv8+dUnVPwHYrSzzbSx3fFSAbMK5gnSvS6Ipzoaww3Cyey69Y8zcbLcfweAhHICwUAXAyXeSxLeggKHmLH7nnuxk8uY6j+/P23e0c7yy6cBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAOeEvXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAOeEvXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10076C4CEC5;
	Thu,  5 Sep 2024 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725546541;
	bh=rpYIrnqzM0WX271dJ0D1qWpXLHU0PHr8dObyTlibdw0=;
	h=From:To:Cc:Subject:Date:From;
	b=JAOeEvXcjTzsVKgiDK6D7/oK6g6toSKSuy2e+VjnInOQ0IkYQfnKS63SsLnMSwZpk
	 2M2uMQcZMblNoBRgaoOesHZgNquKJUBO6patZiKfihW+7Wcnv9J5h/2BdClR2Kle2G
	 KzrcZ+iQ9X6En0BmjijUiHxZo1IGppE6auenHW+exQYC0i2SOk588oXBj5xome+CMA
	 apCwiMlgXdD4+I0oTxEx8nm8Q0DW0GCILII7J4+2GKCHiexZ1bnqDkFuE3yWPImWXe
	 jnHN7IBqlH3j/IHq59+NvWf/tZCXkgYK4J+zbFU/OagQubQZrHsa6Ju1CmJ7yxom/d
	 qzdhu3AyIIe/w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/2] cleanups for bpf schedulers
Date: Thu,  5 Sep 2024 22:28:49 +0800
Message-ID: <cover.1725546472.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two cleanups for bpf schedulers.

Geliang Tang (2):
  Squash to "bpf: Add bpf_mptcp_sched_ops"
  Squash to "selftests/bpf: Add bpf_burst scheduler & test"

 net/mptcp/bpf.c                                     | 3 ---
 tools/testing/selftests/bpf/progs/mptcp_bpf_burst.c | 5 +++--
 2 files changed, 3 insertions(+), 5 deletions(-)

-- 
2.43.0

