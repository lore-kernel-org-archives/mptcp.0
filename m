Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558F12B76
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXaEbfXQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGDIE5pnsPUYFSINy2WkEAcSMKFp/aRXa+aHFkzl2JM=;
	b=VXaEbfXQGHZ3bVo7OEQ8KhoLoPV812SYzl6eIn2+Z0neTYBdg3CnZJ68gerN7rOtlMSrlt
	rv34vGQmhpXkwn4apSxsEOPVXFOZJknH5uWtL+oHQBEyvm8UjI8ugAOVju8ONqG3U56/+4
	p9RDuVTBkN6aCa8IX2OFQrq8NfNGsoo=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 23/33] selftests: mptcp: netlink: print out test counter
Date: Tue,  5 Dec 2023 15:01:10 +0800
Message-Id: <55846b46027216782f02ea50926863724fb40807.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch prints out TEST_COUNT for every tests in script pm_netlink.sh.

The output looks like:

  1 defaults addr list                        [ OK ]
  2 simple add/get addr                       [ OK ]
  3 dump addrs                                [ OK ]
  4 simple del addr                           [ OK ]
  5 dump addrs after del                      [ OK ]
  6 duplicate addr                            [ OK ]
  7 id addr increment                         [ OK ]
  8 hard addr limit                           [ OK ]
  9 above hard addr limit                     [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index e8ecf292a38f..714f69de6fda 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -39,6 +39,9 @@ ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
+	TEST_COUNT=$((TEST_COUNT+1))
+
+	printf "%2u " "$TEST_COUNT"
 	# ${*} doesn't work here since there're spaces in some arguments.
 	mptcp_lib_check_output "${1}" "${2}" "${3}"
 	local rc=$?
-- 
2.35.3

