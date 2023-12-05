Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72915481
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X58KRIxG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abLVXG8yJrjwNnzaecmQYf68v6viwiXKcgX9jdZKWF8=;
	b=X58KRIxGlnMXlUcKQ8ojjwIWEfaRBdAvFQuPumIQIfXBgjoA2slNN1cY3IrxShPpomNUzY
	/MM9Ov2UHDFcUEikVFwz6KWNflSFaYkExLK7Ob+2OF29DFv8ZKqVl518pAggH8z7OjuOho
	/pj9gYXNwXo7VFrhvR5VqOf0PWRBzqk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v5 24/33] selftests: mptcp: userspace: print out test counter
Date: Tue,  5 Dec 2023 15:01:11 +0800
Message-Id: <8e948b229d5bff23e9936fa7dc86feab88218a80.1701759405.git.geliang.tang@linux.dev>
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

This patch prints out TEST_COUNT for every tests in script userspace_pm.sh.

The output looks like:

 INFO: Init
 01 Created network namespaces ns1, ns2                       [ OK ]
 INFO: Make connections
 02 Established IPv4 MPTCP Connection ns2 => ns1              [ OK ]
 03 Established IPv6 MPTCP Connection ns2 => ns1              [ OK ]
 INFO: Announce tests
 04 ADD_ADDR 10.0.2.2 (ns2) => ns1, invalid token             [ OK ]
 05 ADD_ADDR id:14 10.0.2.2 (ns2) => ns1, reuse port          [ OK ]

Having test counters helps to quickly identify issues when looking at a
long list of output logs and results.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 50eda314ec2e..66dbeaba1575 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -35,6 +35,7 @@ client_addr_id=${RANDOM:0:2}
 server_addr_id=${RANDOM:0:2}
 
 mptcp_lib_ns_init
+TEST_COUNT=0
 TEST_NAME=""
 
 _printf() {
@@ -50,8 +51,9 @@ print_title()
 print_test()
 {
 	TEST_NAME="${1}"
+	TEST_COUNT=$((TEST_COUNT+1))
 
-	_printf "%-63s" "${TEST_NAME}"
+	_printf "%02u %-63s" "${TEST_COUNT}" "${TEST_NAME}"
 }
 
 test_pass()
-- 
2.35.3

