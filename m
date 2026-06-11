Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BE8408601
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197705; cv=none; b=IIaYiu2qJRhYOnqiMV/IP8aXi3aEOrAHElHxzhg4eyMZNeh4C/YBzvKCHnq5z1MGFvLmNE1Do1aFxb/oGqTgLGw3GkEXN7N8duyAjrIkQQEDSFuJq0t1NdnMq2nsmbTQAW2giYXsj/Lvi0IHxK2yqKF2arOzsRbC47j6YvgM0AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197705; c=relaxed/simple;
	bh=oRKVYKBryzZ5zlUd7njrlUYts4kqmrOAVyco8IqUI+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pdP5L6UVQQ/gVbs276HWyLdKMcclSJxgwJ7qyJgVPlveKHW6ngOxOKROyMHii6DqklU5I4BhUxJBeBxJeWZOV2J/TCJWANmQaJSXb3/oH2BAHuJaWnxyAEKjOSeCJdBruerlvABGOx0GCEtNmG6Nxx/mHaiSRHMVrWs6zxdecAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UxByWUZa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UxByWUZa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lYFIdf5PeCO/f6Oc4saKGIEJmztathP+Dm3/vVUzYcQ=;
	b=UxByWUZaIJZelRqUd4w56dIbqYHbe8khxaNPS3CevSJwWxNNzn/xBESQq7XBybsnGG/QUr
	MSZB1/JdNwGoqR7M9r00uBJ0M+FlTat2h0NbI3T5bDhFSDgrVKqlPqpfDGPTY/bUqchDuT
	vuV3WZwXjpXX02BkN2pVXdSqOiCtwYA=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 0/9] selftests: mptcp: skip the v6 subtests when CONFIG_MPTCP_IPV6=n
Date: Fri, 12 Jun 2026 01:07:50 +0800
Message-ID: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

Hi, Matt

This series is for make the selftest useful in the kernel which IPV6 is
compiled as a module.

The MPTCP selftests cover a wide functional surface: connection
establishment, subflow join/remove, ADD_ADDR / RM_ADDR signalling,
path-manager behaviour, nft-based tproxy, transfer of bulk data with
sane throughput and CPU usage, and so on. Together they are the
principal end-to-end suite product-validation teams run to certify
that MPTCP works on a candidate kernel. Kconfig, however, says:

      config MPTCP_IPV6
          depends on IPV6=y

so any distro or product kernel that ships with CONFIG_IPV6=m ends up
with CONFIG_MPTCP_IPV6=n. The corresponding MPTCP over IPv4 path is
built and works correctly; only the v6 subtests are unavailable.

So far, the selftests do not know about this configuration. They
unconditionally configure dead:beef:* endpoints, open AF_INET6
listeners, drive v6 ADD_ADDR / RM_ADDR / subflow commands and load
nft "table inet" chains, and they treat every one of those failures
as a test failure. On a CONFIG_IPV6=m kernel, every subtest
contaminated by a v6 step — including the v4-only ones in
mptcp_join.sh starting with "001 no JOIN" — comes back red. The
v4 functionality cannot be signed off even though it works.

Patch 1 is a DO-NOT-MERGE review aid (it flips the kselftest config
fragment to CONFIG_IPV6=m and adds CONFIG_NF_TABLES_IPV4=y so
docker-virtme can run the scripts in the target environment).
The remaining 8 patches are the real series.

Thanks
Gang

Gang Yan (9):
  DO-NOT-MERGE: mptcp: test IPV6=m in docker-virtme
  selftests: mptcp: mptcp_lib add runtime IPv6 availability detection
    helper
  selftests: mptcp: mptcp_connect.sh degrades to v4-only when MPTCP IPv6
    is missing
  selftests: mptcp: mptcp_connect.sh don't fail because of nft rules in
    IPV6-less kernel
  selftests: mptcp: mptcp_sockopt.sh skips v6 paths when MPTCP IPv6 is
    missing
  selftests: mptcp: simult_flows.sh skips v6 setup when MPTCP IPv6 is
    missing
  selftests: mptcp: mptcp_join.sh: pick v4 bind default when MPTCP IPv6
    is missing
  selftests: mptcp: mptcp_join.sh skips v6 subtests when MPTCP IPv6 is
    missing
  selftests: mptcp: userspace_pm.sh skips v6 paths when MPTCP IPv6 is
    missing

 tools/testing/selftests/net/mptcp/config      |   5 +-
 .../selftests/net/mptcp/mptcp_connect.sh      |  48 +++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 154 +++++++++---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  33 +++
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  81 ++++--
 .../selftests/net/mptcp/simult_flows.sh       |  30 ++-
 .../selftests/net/mptcp/userspace_pm.sh       | 237 ++++++++++--------
 7 files changed, 397 insertions(+), 191 deletions(-)

-- 
2.43.0

