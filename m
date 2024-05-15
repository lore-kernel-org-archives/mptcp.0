Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43438FA3
	for <mptcp@lists.linux.dev>; Wed, 15 May 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715753925; cv=none; b=g9/ZevWBa7eSMWidbJAqzXxILaguHhN5MIJZPoRKvACEOfxRygFKZkQWXOSLx2eYM6KvQiOfR03pwJQFwYUSdUHYN+ociHocjkMaSmmd0I6gM99Y65EglS92BUuT2X6PRRY72EWI1G2rP54FDOjTAa2O6WZQdJe8W3unchTeAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715753925; c=relaxed/simple;
	bh=mxEtix+swXKsTYhrnG5rGmYV2NzTLfyeEC3TkUqUC5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4IWzsqHpJCY6Gz1ArDM2+47ITpxVjxYsmlyIoIUeakk/kKrnDb3d3vxLlO9YxKTSwnhOCTPsbtfi2TnrltGZIpuy0A4Duadq4SpWzL5H4rSTd4nM6cwK2/M4Sh6HNOwh1MClzqgHboC1VQOwiAUl+ON8cpYoVbNeAtCp89lynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ew35dwMH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ew35dwMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E69C116B1;
	Wed, 15 May 2024 06:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715753925;
	bh=mxEtix+swXKsTYhrnG5rGmYV2NzTLfyeEC3TkUqUC5U=;
	h=From:To:Cc:Subject:Date:From;
	b=Ew35dwMHkOVpQ5yTXKfUMc3V5CF2uXKtiSLYcWcl7MdDNpbUPPtQFwAyUop6rJ75X
	 k+vh4CV4AYgZytZ+FTlyj+YhpTZ0wlNb5nH+6jn4/RHdcfkXtVjA9+OL8WComQQBRb
	 pG4wrLfb0L23jyDPRTnO9bofGzPgYZc/KwsbRzqN3ExpZo/3+EFxAlCqk0Ocr89rI0
	 BqoJt819/eE6esWFSnyaJjOdYYeF6BNfN69uDpRzBA9DBU50/Xa/8mpJn6IuQChCAD
	 vrxOlUr5W+n8S3k0v8gvEPSKa4+LOsVkMEQAPegAIWiXuCR5B1F1xXqTm2AKWBxqlm
	 YdqscPeNlY0tA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 0/2] patches for new MPTCP subflow subtest
Date: Wed, 15 May 2024 14:18:36 +0800
Message-ID: <cover.1715753802.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - move checkpatch.pl fix out of this set.
 - update patch 2 as Matt suggested.

v4:
 - "{*/,}" can't be used in MAINTAINERS, fix it.
 - fix checkpatch too.

v3:
 - update MAINTAINERS.
 - drop '-M' in _ss_search() as Matt suggested.

v2:
 - rename pm_nl_ctl to mptcp_pm_nl_ctl.

Geliang Tang (2):
  selftests/bpf: Add mptcp pm_nl_ctl link
  Squash to "selftests/bpf: Add mptcp subflow subtest"

 MAINTAINERS                                    |  1 +
 tools/testing/selftests/bpf/Makefile           |  2 +-
 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c  |  1 +
 tools/testing/selftests/bpf/prog_tests/mptcp.c | 17 ++++++-----------
 4 files changed, 9 insertions(+), 12 deletions(-)
 create mode 120000 tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c

-- 
2.43.0

