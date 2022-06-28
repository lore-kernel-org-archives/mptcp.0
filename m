Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F84370
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 01:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656378175; x=1687914175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wi7F1z6CctRCQxoeHDKSVN4TBguQrYOW58cE0JPGs0U=;
  b=YY9f4xCZHC6YQD4i2QK5nhOTGSNQy8jWfqbl4tbZmlojhcaSGlaAsqF2
   8w5UdgzPIgGjJoErcAlJglbu6DqTk6nehVrg1XaKrvFwkKPDAmf8OdwsQ
   8VXFpMnqBxvjj2S42UYqSz2lm0v0AwKif2hnruOiPkWN7hPn3q6ZYDPmI
   IOpn2NUUNivPwejyW/ap5oDojPqljgNgi8/bYnlrVIdxpiT73BR0zyy+y
   ypgzx/1Mx6YrL2UnoaJdd3JZhJRi4mEmGakFtgB6VbhhB8d4Nn/c6CDKw
   m7LtgB6hUPcUfW+vewQpkIK+8Prrb/Y2Fv4AXSFdfJziVWOluE0Lu7ZoF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="270347729"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="270347729"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:52 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692867421"
Received: from cgarner-mobl1.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.0.217])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:02:52 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	geliang.tang@suse.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net 9/9] selftests: mptcp: Initialize variables to quiet gcc 12 warnings
Date: Mon, 27 Jun 2022 18:02:43 -0700
Message-Id: <20220628010243.166605-10-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
References: <20220628010243.166605-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few MPTCP selftest tools, gcc 12 complains that the 'sock' variable
might be used uninitialized. This is a false positive because the only
code path that could lead to uninitialized access is where getaddrinfo()
fails, but the local xgetaddrinfo() wrapper exits if such a failure
occurs.

Initialize the 'sock' variable anyway to allow the tools to build with
gcc 12.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 8628aa61b763..e2ea6c126c99 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -265,7 +265,7 @@ static void sock_test_tcpulp(int sock, int proto, unsigned int line)
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock = -1;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 29f75e2a1116..8672d898f8cd 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -88,7 +88,7 @@ static void xgetaddrinfo(const char *node, const char *service,
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock = -1;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ac9a4d9c1764..ae61f39556ca 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -136,7 +136,7 @@ static void xgetaddrinfo(const char *node, const char *service,
 static int sock_listen_mptcp(const char * const listenaddr,
 			     const char * const port)
 {
-	int sock;
+	int sock = -1;
 	struct addrinfo hints = {
 		.ai_protocol = IPPROTO_TCP,
 		.ai_socktype = SOCK_STREAM,
-- 
2.37.0

