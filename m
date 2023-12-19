Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3777B4695
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vdr6zGuJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702951514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mJpxnPVXYEAL/P/BTSM8dTslnhGpagr7emN3otlzGys=;
	b=Vdr6zGuJTMFoPrODUvr0A5a6P8MkH+8D31SvZr8hZVostMGgC5eqMSrLxEdmu0PuPmcFfQ
	3NRnKGMes+hDXfsq6/FEljPLwCUszKJDIwTGPgE/AMUWGbfYOtekMwAxUtueqtbC9IShcU
	GT8q/6fkE4iqptnHQfG0EWCBarONW1I=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v2 0/4] fixes for CURRESTAB
Date: Tue, 19 Dec 2023 10:03:52 +0800
Message-Id: <cover.1702951288.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2:
 - Address Paolo & Matt's comments for v1.

Geliang Tang (4):
  Squash to "mptcp: use mptcp_set_state" 1
  mptcp: move inet_sk_state_store under lock
  Squash to "mptcp: use mptcp_set_state" 2
  selftests: mptcp: diag: check CURRESTAB counters

 net/mptcp/pm_netlink.c                    |  5 +----
 tools/testing/selftests/net/mptcp/diag.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

-- 
2.35.3

