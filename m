Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A09457
	for <mptcp@lists.linux.dev>; Fri, 23 Aug 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415586; cv=none; b=D+zZ+lPslDHAyxWNS+ft5kbvrrv223gtgL/4U+bQ93kxpkx75j7NOC5n56zjzSt1AJyyrONfSg8ojrQ2Jjgx8JdwPfDEm5youKY9eyFWkvoACnJuMtTgoGR84TtGDd1r5ZzIDua9iO17uZt1d04Gavefw5D8SQuQgn2TbfhqGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415586; c=relaxed/simple;
	bh=i+V2icp9VF17DdQYDWeY2Iy8o1zgfwixqoOhafR7UQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvbA5MTBRX2ebJmA5sQ2AA9h3MOkPZDBOlvqFcP8zITcwM/ZXShhDQ71iihnQvgwA7EXTVCuwFP8EXDRaEFRJThd7xHs/fkgF0Tn42jR6YVaqtz4LYFuNNkvM5c7enoIYKn+lWIogvCT22CdLT6P/iamLq9ZfzQERTRQz/8Y6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq9p/DuW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq9p/DuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBC9C32786;
	Fri, 23 Aug 2024 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724415586;
	bh=i+V2icp9VF17DdQYDWeY2Iy8o1zgfwixqoOhafR7UQc=;
	h=From:To:Cc:Subject:Date:From;
	b=Lq9p/DuW0rShy9hGcgGA+kOejs4Sa6Xz8USlVLm6w9FcG419nGN2LwvCy6uczqZMQ
	 ixz3a7GeMD8kGQgvu/Mz+anqHQcsu/v7GlJTjssUXHOAkLBZ//oQ261mY3LJnaOyMA
	 B+YCeTZh11OYJg00Oi92GF4L2guXRJjO7C+AAS4J/PtA2JFTN7SWsVQdtlBvvVbia1
	 jJDn8B7iOrKAd7fiiLcB4m+qY9oNPdQnHn1bh/2vFFviLEI5s5ir1GlC/yVPZbA6h7
	 u75OXl4bJxPIFzLofVOtZfX209UNqor9NKBj5QOOj93tMB8YqFw+KzBm6GEXXfoINP
	 hnG/xqlOa2hSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 0/3] fixes for "new MPTCP subflow subtest v4"
Date: Fri, 23 Aug 2024 20:19:38 +0800
Message-ID: <cover.1724415435.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - address Matt's comments in v3.

v3:
 - drop "ss_search" from subflow subtest
 - fix mptcp_for_each_subflow_safe
 - add cond_break in list_for_each_entry/_safe

Two fixes address Martin's comments in "new MPTCP subflow subtest" v4.
Patch 2 will conflict with "selftests/bpf: Add bpf_first scheduler & test".

Geliang Tang (3):
  Squash to "selftests/bpf: Add mptcp subflow example"
  selftests/bpf: Add getsockopt to inspect mptcp subflow
  Squash to "selftests/bpf: Add mptcp subflow subtest"

 .../testing/selftests/bpf/prog_tests/mptcp.c  | 57 +++++++++-------
 tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++
 .../selftests/bpf/progs/mptcp_subflow.c       | 66 ++++++++++++++++++-
 3 files changed, 135 insertions(+), 23 deletions(-)

-- 
2.43.0

