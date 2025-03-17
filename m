Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59461FAA
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182177; cv=none; b=ulOhuf/eJpw1HeibwhhHDDIO173IbR4QSpqMMzh5hNWPqZKyTT9sHae5tgGNaxCOJ5G+nwLEW3dY4vRI2yhwuNjuwIstI02N0d7TIRgy7Dc+K9y4lVOIZhamveeqdjtfPi4/3AGte3GwIWCzKiF87o2fgU/4TmoTolYDAb5bcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182177; c=relaxed/simple;
	bh=Lt858BUpLLEX4xMgKQlsbhsv5xMPjLWIQgfsoLRHw9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aOXPKp9kUqNOxQED8W4ifqMkExk1z08eC42ZwUzVqC5hsKPzyL7QhBxM+9XK7FD1WhKY83oc+6HgJyxHw6xxSGTC5HYV9p7j7RHwWUt48RHVbnqyX60aOE0WLPs8GjLWJnHxCmu3hnZGQ0e48OhiUBZWiuKJczsL13qTzOKB0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3b5DSJV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3b5DSJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556C3C4CEEC;
	Mon, 17 Mar 2025 03:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742182177;
	bh=Lt858BUpLLEX4xMgKQlsbhsv5xMPjLWIQgfsoLRHw9Q=;
	h=From:To:Cc:Subject:Date:From;
	b=d3b5DSJV7ngCfMdrkkqjp7ZcFujviw8XzMGidPh43tggkti8ISA/G8u24mq7iBYqf
	 l+vUf2LUvGWl1kfMXvseCZ10WPHSbEtuKlvdTTkbioR5P9H5qUClDUpGAdOEUE33FB
	 +2G2q5YFDeYniYeYYz2gxSC1YWfzPYOZzLQB49dkcveU7waPXFN2KUoQi+wcE/xbd4
	 9+QGFMxk4M+KASwrDwTTR41KOsGvzdVBqkTnB0mtrWa+bPP0kndQobQtQv+FxQz5w4
	 le7VN9TmBwkYyLztFUeHL43RlvymMims7s/sYt6pPNzMcqhgt6XKs8AlY1HX0IMz7I
	 KfmGBpG6qdRtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 0/3] bugfixes for "BPF path manager, part 6, v2"
Date: Mon, 17 Mar 2025 11:29:26 +0800
Message-ID: <cover.1742181977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Bugfixes for "BPF path manager, part 6, v2".

Based-on: <cover.1741919893.git.tanggeliang@kylinos.cn>

Geliang Tang (3):
  Squash to "mptcp: pm: add subflow_established() interface"
  Squash to "mptcp: pm: add established() interface"
  Squash to "mptcp: pm: add rm_addr_received() interface"

 net/mptcp/pm.c        | 6 +++++-
 net/mptcp/pm_kernel.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.43.0

