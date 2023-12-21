Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800CD4F60D
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tk6aMZdZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6yL9obqx35BdkMOKYEZEpJNxJntR0+zZrkDKLPmkCvI=;
	b=tk6aMZdZrTIgTU+08Q/KxvIgFEnfIaT7YG4jTOJORMx0QPqsOW0LXHPX54lTsm0m0qITYN
	RkMXpqHZi2SeVjF66oBIFW33RU2Ql0/HJZrM7l7Q7A+/mZz7qBlqoFjcUgx2koc7Jgmlji
	R1BqfZB/e13hp81PmLXXKVLnyBzz0Ug=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 05/15] selftests: mptcp: netlink: drop duplicate var ret
Date: Thu, 21 Dec 2023 19:31:08 +0800
Message-Id: <4728959ee0799c446d156f17f7ceed3e9c4e531f.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The variable 'ret' are defined twice in pm_netlink.sh. This patch drops
this duplicate one.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 8f4ff123a7eb..ed1e8380838a 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -28,7 +28,6 @@ sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns1="ns1-$rndh"
 err=$(mktemp)
-ret=0
 
 cleanup()
 {
-- 
2.35.3

