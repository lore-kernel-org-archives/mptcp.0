Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F55107B0
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vrc/RILk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfCadnlpoYMKEKsxgrATtJaTuCAKT5GAJ0xvAx1sqMo=;
	b=Vrc/RILkduLo0/nzV/75AvRruKAUFVHYwFCi0FltWDEGAtaskSVtrQikZBgTV6TwvN0y0H
	H4CPCzuLnqT3ykfC0N8upBa9CKuoR/VBoirb+aE/D9H7byJ1rHlRlvbQWEjfRIRd88867I
	z8pKx4vTLe8ZTNVbX2nbXuc+g95SwcM=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 4/5] Squash to "selftests: mptcp: check CURRESTAB counters"
Date: Mon, 18 Dec 2023 16:47:16 +0800
Message-Id: <361f60bc545f2b190bbbb6fbfb05e13b1a73d7a8.1702889134.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702889134.git.geliang.tang@linux.dev>
References: <cover.1702889134.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a comment for check_cestab(), and use cestab_ns1/cestab_ns2 in it as
Matt suggested.

Please update the subject as:

'''
selftests: mptcp: join: check CURRESTAB counters
'''

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 3cd066e6e2b0..3a5b63026191 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -995,13 +995,14 @@ chk_cestab_nr()
 	fi
 }
 
+# $1 namespace 1, $2 namespace 2
 check_cestab()
 {
 	if [ -n "${cestab_ns1}" ]; then
-		chk_cestab_nr $1 1
+		chk_cestab_nr ${1} ${cestab_ns1}
 	fi
 	if [ -n "${cestab_ns2}" ]; then
-		chk_cestab_nr $2 1
+		chk_cestab_nr ${2} ${cestab_ns2}
 	fi
 }
 
-- 
2.35.3

