Received: from out-196.mta0.migadu.com (out-196.mta0.migadu.com [91.218.175.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C17488
	for <mptcp@lists.linux.dev>; Tue, 17 Oct 2023 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcFQBw1/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697511774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYUsvWzO+8bD9hK+IH0MqCAE/E/HFN1tKDnag3i6Rm0=;
	b=FcFQBw1/vwc/GySUfasQMp/3WkK8OTpsbhoeeAbJPzpiJU57kIsE+DKMaEim5O4ZepQDfm
	4SNgzHixDuMERbSlvf02tizvIbAnTptfbAVbcHtfIdYMPeyulXizWuWHrdEGjTtxxAl761
	ib6e0g/eNuEYTFaHm0avlHEprebrioY=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next v17 5/9] Squash to "selftests: mptcp: add chk_subflows_total helper"
Date: Tue, 17 Oct 2023 11:00:24 +0800
Message-Id: <f74935469c25e68969b6dbb0ef2a37808f3c2902.1697511436.git.geliang.tang@suse.com>
In-Reply-To: <cover.1697511436.git.geliang.tang@suse.com>
References: <cover.1697511436.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Geliang Tang <geliang.tang@suse.com>

Please update the commit log too:

'''
            ss -ti | grep -c tcp-ulp-mptcp.
'''

->

'''
            ss -ti state state established state syn-sent state syn-recv
            | grep -c tcp-ulp-mptcp.
'''

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c5e30f4bfcda..6c2c47ce11ad 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1905,8 +1905,10 @@ chk_subflows_total()
 	print_check "$info $1:$2"
 
 	# if not, count the TCP connections that are in fact MPTCP subflows
-	cnt1=$(ss -N $ns1 -ti | grep -c tcp-ulp-mptcp)
-	cnt2=$(ss -N $ns2 -ti | grep -c tcp-ulp-mptcp)
+	cnt1=$(ss -N $ns1 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
+	cnt2=$(ss -N $ns2 -ti state established state syn-sent state syn-recv |
+	       grep -c tcp-ulp-mptcp)
 
 	if [ "$1" != "$cnt1" ] || [ "$2" != "$cnt2" ]; then
 		fail_test "got subflows $cnt1:$cnt2 expected $1:$2"
-- 
2.35.3

