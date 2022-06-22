Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DADA52
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655857131; x=1687393131;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mLHOTebsTSrgxUmTOUjrMKtwnFO40+Lg320nyhPkMcs=;
  b=SbAVgRmJpyOR1vEzCq3Gyes+YbgcasAfRBxTQLKwaIQwWxHC2StcaefR
   J4HftYeVQ+vHz+uvG7TMlj1GqhWQz5j57FMLIIJAW5mNfgtvyFFFrLMdG
   4MwKoQX/wq8fqO/pNRJN8F7IcvGz2qax158cjOwU/PwEsK23h4K5oWudO
   nCQ1cXv865+dfRuui/gcIu+Pr4sxOGDeQ3YnCGrpsfBlB1CsYQlOgpr9U
   RCNm8caeYq/voWutOvwIEm9anp+Nu4FiMNka2AyHFQVwwrhb9SJVqinND
   XUWjVLfAGemm1/+sWj0jIzYqhLJs/QdXFfPae9EWAyopTkRO72OkkmsXa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305721448"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="305721448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:18:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="833825995"
Received: from kingsum-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.204.100])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 17:18:50 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-next] selftests: mptcp: Initialize variables to quiet gcc 12 warnings
Date: Tue, 21 Jun 2022 17:18:46 -0700
Message-Id: <20220622001846.172735-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.36.1
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
2.36.1

