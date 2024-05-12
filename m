Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFCC193
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715472501; cv=none; b=EIJTmbbHwGjuNSiOxh55ClgFfICrw/iPWkvzuTwMX7fdL0MISPH1b1tgzMALpRlmIB0G9jpzjZCmfr9XOYXbCuGhXHOm56CAhsfM5DtWZSIqbtO7INcA38JwQNCugNz8wIre0E1lVvvTsxcuabX5z4IZrgvbySnVYafhZAn9RuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715472501; c=relaxed/simple;
	bh=xdtbc4OonQxRxH/9pQzZ4gqq+PWfdAmXu0eUVMDTupk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vl9nYMEik/Ep6ix+ff0SDRf8IQskRwxCFe+pLuVQFAUVY4oJyPt/zwDGTjbV4Yy4o89I1h3tIvdJUkohuf2s5SMqYLqu2fYF3hAcMJ2AB5pnyXuzGvz8PGwXSL/Pp5z3ExpOVsS66PK9k1qzvqjZddmCoSdbuaQqFlAabD4kqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0DYgR8m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0DYgR8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAC5C2BBFC;
	Sun, 12 May 2024 00:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715472500;
	bh=xdtbc4OonQxRxH/9pQzZ4gqq+PWfdAmXu0eUVMDTupk=;
	h=From:To:Cc:Subject:Date:From;
	b=e0DYgR8mqGJi6jvcoJEFKH8KsUaWsSPlkhHkrkK/fU1GsTrAw1qZgAHUUK7O4SZ/v
	 wsf7zLZcPhust/rktUOBCkEiUI9aPhW1YrOxZrMlFKrL4gdW/WAvKy4vUTtSfHQyDU
	 SCJL8u6rK7X60uAfXDEBk3EiWOZ8oiosLGNyD1xNnnAIZx9Qkw2rVrBFuRw6OyuccN
	 8MoG18B4s3S2SVYWaWOfWEzeAb05RYjj7Yi4MkS5FUJiw+Djp53YUB31wAnYlOf8T7
	 cn7gml+1Ja3mScaNsCCHFc9G6VM46Z/nvjh3B0pUiBF+FNKjGV0II448P+aqeleFkv
	 obMGaTffplNkg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] patches for new MPTCP subflow subtest
Date: Sun, 12 May 2024 08:07:30 +0800
Message-ID: <cover.1715472312.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - update MAINTAINERS.
 - drop '-M' in _ss_search() as Matt suggested.

v2:
 - rename pm_nl_ctl to mptcp_pm_nl_ctl.


Geliang Tang (2):
  selftests/bpf: Add mptcp pm_nl_ctl link
  Squash to "selftests/bpf: Add mptcp subflow subtest"

 MAINTAINERS                                    |  2 +-
 tools/testing/selftests/bpf/Makefile           |  2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 4 files changed, 9 insertions(+), 13 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

