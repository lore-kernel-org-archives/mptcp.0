Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD138D
	for <mptcp@lists.linux.dev>; Wed,  6 Aug 2025 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449912; cv=none; b=FBYtgL0FxxWhB74KKwPk9lCCYCuY4VaBvC6XHaXtrGVamwh5ZjZDD3MjlhNn+0vtNlZEr/62r9wiFhq1ZasHP6sBZYJuJLl+1ilO5cjTSW0cki9OkBTQI7ToQf/pU+oAhArvkbEkzPu53HJZ6hp1TuI5HG29yoP3ch7FfjbUyz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449912; c=relaxed/simple;
	bh=VzArgkZjwfJS+o2WB+x+c0OfKjSITXX2KVVFpit3fJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/kCvM0WfDSl3NPsMqFLyJoJXvU4SVoy17p0AyVtUJMaZrmZ/KtFhY1zMw2pnh4vZIpfnDooetvHIiNssHCwZQ07WL0hKOB1dWiuazNBN7FE6eSZ6Y6xHcJLkdYozydvNvUFFvKTsAAh05gW6tul8K9OfS31ITeNTOhWOlz6Di0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHxwINQn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHxwINQn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D670C4CEF0;
	Wed,  6 Aug 2025 03:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754449911;
	bh=VzArgkZjwfJS+o2WB+x+c0OfKjSITXX2KVVFpit3fJI=;
	h=From:To:Cc:Subject:Date:From;
	b=SHxwINQnpXnrIpDdNr3sA+oh4DB36qPc0iIXN4Fcg7S+9PDHOmk9woJkWgPy36/Rr
	 9aK0LWXWq9Wdm7Fzd4KLNb1z5tlkbFSwaukG4JU/nwmq/dm5FBAJT7U9b1aMkgtEgQ
	 t5uXgqW2ixBDtSt9DeYs/UqPzpiBfv6OxSLHF4ferUr7x9Xz+CPEfzJxYUh9WR81/y
	 rSSCup3EDYYh8B2yI0E+0t4iNlPvRWWn2bYIP9u7o5oSQriw+LYs+HHAOh4hGSk/r7
	 N4Oa4zrbAAyhjS9XCB87EStDebUnBb5KoeKFwo0cXuyjbwkg/8vE8vRqvQd9ihv9mz
	 8O/84DhXUZkow==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net 0/2] mptcp: disable add_addr retrans
Date: Wed,  6 Aug 2025 11:11:42 +0800
Message-ID: <cover.1754449726.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series enhances MPTCP's ADD_ADDR retransmission mechanism by:

1. Adding support for disabling retransmissions when add_addr_timeout
is set to 0
2. Modifying the self-tests to leverage this new capability

The first patch implements the core functionality change in the MPTCP
subsystem, while the second patch updates the selftests to use this
feature for stabilizing a specific test case.

These changes provide more control over ADD_ADDR behavior and improve
test reliability by eliminating race conditions caused by unexpected
retransmissions.

Patch 1: When add_addr_timeout is 0, skip retransmission entirely
Patch 2: Disable retransmissions in "delete re-add signal" test

Geliang Tang (2):
  mptcp: disable add_addr retransmission when timeout is 0
  selftests: mptcp: disable add_addr retrans in re-add test

 Documentation/networking/mptcp-sysctl.rst       | 2 ++
 net/mptcp/pm.c                                  | 7 ++++++-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.48.1

