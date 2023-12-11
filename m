Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23B320DC6
	for <mptcp@lists.linux.dev>; Mon, 11 Dec 2023 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V6Wb8LIv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702282497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o6TnUO/BC9EbP2M/JzxkntoSb5HSHOAMkn3uR+MJ2cI=;
	b=V6Wb8LIv+bBMCiMQ0mOJtNHft1MRKF7hTIGW7AS3My50xmv9KRkcnAVEgM2wqOmz92kH3B
	pK1QyizqwTsKnrzkMO3vVcVSPgJRijSZ461VS+sPXGCcvqdfgJ3GUU2hUUBrmjc/kItk9m
	tEEDOByl/VWdGO7mXHYMg1SSCH3sPNM=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 00/12] dump for userspace pm
Date: Mon, 11 Dec 2023 16:15:22 +0800
Message-Id: <cover.1702282411.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Address Mat's comments in "userspace pm enhancements" v14.

Geliang Tang (12):
  mptcp: add mptcp_pm_nl_put_entry_msg helper
  mptcp: implement mptcp_userspace_pm_dump_addr
  mptcp: dump addrs in userspace pm list
  mptcp: check userspace pm subflow flag
  selftests: mptcp: add userspace pm subflow flag
  selftests: mptcp: dump userspace addrs list
  mptcp: add userspace_pm_lookup_addr_by_id helper
  mptcp: add mptcp_pm_nl_put_entry_info helper
  mptcp: implement mptcp_userspace_pm_get_addr
  mptcp: get addr in userspace pm list
  selftests: mptcp: add token for get_addr
  selftests: mptcp: userspace pm get addr tests

 net/mptcp/mptcp_pm_gen.c                      |  5 +-
 net/mptcp/mptcp_pm_gen.h                      |  2 +-
 net/mptcp/pm_netlink.c                        | 94 +++++++++++++------
 net/mptcp/pm_userspace.c                      | 94 +++++++++++++++----
 net/mptcp/protocol.h                          |  9 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 91 ++++++++++++++++++
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 22 ++++-
 7 files changed, 266 insertions(+), 51 deletions(-)

-- 
2.35.3

