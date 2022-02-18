Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F603201
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153412; x=1676689412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A4UCyKVS+ECivE7dWa84k+oB0wXq0H5Wl3tdPlE5ETM=;
  b=n4B3ArsKeMxKl7evzp0RvCpN1Z17Md8OlxQlpxrzLdmPWpz4BC7KLipV
   mKpPQmqxTntCVtvRNQFNULV3fmsrsxE2ZwkEgKCipm3t8gE3OjS7ST4JZ
   EDiq/1P991reQAm01lvROMbRv34JPeYVFNFDMlFoJ0QJdCjSHq9am0Z+v
   WVcM3MjpWkuSdc/0YlA1csxVFcSCzIFNVhO1V3qODw9tx/3OtRHr90grf
   KUEErL1ihlo3A4FHNuvgywePdlgEz0HCtcvxBj2Ph0xinPkyhCGiU67Jy
   WjCyCeIrTsRczqriPP2Hq5b68o4ZmOB+vKou3CaS5alogtqwtbCfNGsdx
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021643"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021643"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431937"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:19 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 5/7] selftests: mptcp: join: create tmp files only if needed
Date: Thu, 17 Feb 2022 19:03:09 -0800
Message-Id: <20220218030311.367536-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

These tmp files will only be created when a test will be launched.

This avoid 'dd' output when '-h' is used for example.

While at it, also avoid creating netns that will be removed when
starting the first test.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++++++++++-------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c6379093f38a..63340bb76920 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -17,6 +17,7 @@ capture=0
 checksum=0
 ip_mptcp=0
 do_all_tests=1
+init=0
 
 TEST_COUNT=0
 
@@ -38,7 +39,7 @@ CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
 			       6 0 0 65535,
 			       6 0 0 0"
 
-init()
+init_partial()
 {
 	capout=$(mktemp)
 
@@ -98,6 +99,21 @@ cleanup_partial()
 	done
 }
 
+init() {
+	init=1
+
+	sin=$(mktemp)
+	sout=$(mktemp)
+	cin=$(mktemp)
+	cinsent=$(mktemp)
+	cout=$(mktemp)
+
+	trap cleanup EXIT
+
+	make_file "$cin" "client" 1
+	make_file "$sin" "server" 1
+}
+
 cleanup()
 {
 	rm -f "$cin" "$cout" "$sinfail"
@@ -107,8 +123,13 @@ cleanup()
 
 reset()
 {
-	cleanup_partial
-	init
+	if [ "${init}" != "1" ]; then
+		init
+	else
+		cleanup_partial
+	fi
+
+	init_partial
 }
 
 reset_with_cookies()
@@ -2106,16 +2127,6 @@ usage()
 	exit ${ret}
 }
 
-sin=$(mktemp)
-sout=$(mktemp)
-cin=$(mktemp)
-cinsent=$(mktemp)
-cout=$(mktemp)
-init
-make_file "$cin" "client" 1
-make_file "$sin" "server" 1
-trap cleanup EXIT
-
 for arg in "$@"; do
 	# check for "capture/checksum" args before launching tests
 	if [[ "${arg}" =~ ^"-"[0-9a-zA-Z]*"c"[0-9a-zA-Z]*$ ]]; then
-- 
2.35.1

