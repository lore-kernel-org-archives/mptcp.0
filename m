Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE7170826
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504108; cv=none; b=A4rc+WFozR/yoxQZl0edzMWzNf+wZMyYsOuaca67ncT5lD0OFFD0C67udktUjlR0r4BrhUapirvHgnro/59F9G2j7MW9w3rjAbs3cOWkTJ7iu1rVvXtljbnKP3Jsmr3WjMOqgU3Tb5yShGaMrKSc7HAD5eu+pNnmoUK+413oy1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504108; c=relaxed/simple;
	bh=axC4W5AwpMnBwpt6MCV6hmPxEz12j9Axc/oFO5S3EUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVzxc/S6czrw4ymB9uGYzg4aC9ZpH1L4EpMbqE3LoONmvHXNyaZRHGvwxWXL0XG5Qikp5r2NvGcVMA/5WkOIGGqHlRvRdcNCeazN3plACzonOY/Aq/K1CQBCx/0JqNPqpNt67LZPzagSycuWXDHCRSPLtNOGBxRzIem9QHe8paU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6EiJjzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6EiJjzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B78C4AF0A;
	Thu,  1 Aug 2024 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504108;
	bh=axC4W5AwpMnBwpt6MCV6hmPxEz12j9Axc/oFO5S3EUc=;
	h=From:To:Cc:Subject:Date:From;
	b=t6EiJjzEXjRuYcgqPQx9BYOMZXezCRQsYS7EndnFi8w+E+VIAYxf91sQsJJ3/gqZL
	 LPV7FWBEUa8Ich9Zpt5GkCSFswDbBXIHtoYd/0QtqEUq0hKikAQ4nr9UTrpg9YBIyj
	 0UWfcdkfEDLiAToWUuFBq3a4l6J7LVxX1788NJg9AioJIlew73yi2zNIsJ/8r1yd4v
	 FchMdlIIuOh4LiKNifHOCihYTtlWdMVz8DI0Fns8IHd0ei0OAG7EkH+AAXH/qUG259
	 UdrWdOjmL2BbbWgNqzdCWSl1NdcS/iRkILYvI8pevLByviO98d0VPwbLb6vaPd/41w
	 nuQ1K+9yzKPlw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] add io thread mode tests
Date: Thu,  1 Aug 2024 17:21:38 +0800
Message-ID: <cover.1722502941.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Related to #487 (send() fails with EAGAIN in blocking IO mode). In the
comment of this issue, I added a test named mptcp_eagain_reproducer.c to
reproduce these EAGAIN errors. It uses the same thread mode to send and
receive data as MPTCP sched BPF selftests (in network_helpers.c).

It looks like this type of data transfer is not covered by MPTCP selftests,
so this patchset adds them. The code is all from mptcp_eagain_reproducer.c,
just added into mptcp_connect and mptcp_join.

It is helpful to reproduce and solve #487 issue, and can also provide MPTCP
stability testing in the future.

Geliang Tang (4):
  selftests: mptcp: add cfg_timeo for mptcp_connect
  selftests: mptcp: add io thread mode for mptcp_connect
  selftests: mptcp: enable io thread mode
  selftests: mptcp: join: add io thread tests

 .../selftests/net/mptcp/mptcp_connect.c       | 163 +++++++++++++++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  19 ++
 2 files changed, 177 insertions(+), 5 deletions(-)

-- 
2.43.0

