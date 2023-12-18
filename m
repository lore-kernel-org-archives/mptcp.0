Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8767E107AD
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qD/XzWAc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5VCa8MyC6eT2krNf42MmfIbAxKBfhihS737xIg3aFhA=;
	b=qD/XzWAc9WvXW/yC16ZgNe5JQihgW9tZCE+mdOirBykCOR71HV4Efty4paQnDC+ytQy/gb
	gAAB7McGFRsqB7DCcdkcwmmihigWWqRSK6mQjlikMxEMFz7lbIkXC9qdLzMrnkpbm7qj01
	u/wwQjxkgwFRferKAqgxQkc3X0vK/t4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 0/5] fixes for CURRESTAB
Date: Mon, 18 Dec 2023 16:47:12 +0800
Message-Id: <cover.1702889134.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Address Matt & Paolo's comments for CURRESTAB series.

Geliang Tang (5):
  Squash to "mptcp: use mptcp_set_state" 1
  mptcp: move inet_sk_state_store under lock
  Squash to "mptcp: use mptcp_set_state" 2
  Squash to "selftests: mptcp: check CURRESTAB counters"
  selftests: mptcp: diag: check CURRESTAB counters

 net/mptcp/pm_netlink.c                        | 16 +++++-----
 tools/testing/selftests/net/mptcp/diag.sh     | 30 +++++++++++++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh |  5 ++--
 3 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.35.3

