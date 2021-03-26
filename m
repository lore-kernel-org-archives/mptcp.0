Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95272
	for <mptcp@lists.linux.dev>; Fri, 26 Mar 2021 18:27:35 +0000 (UTC)
IronPort-SDR: nrqXraHmXgjqlMwYmY9AVjWua64ifzm17flRDMTjA8CV328mWp/ilrIIR8qaqd+EvWYvIv/kK9
 6jY7n+TqXx2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="187916003"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="187916003"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:35 -0700
IronPort-SDR: adMJShzTimTlQB7RGh6FuCfJJAnKDiYpjF2ff99IQij6aNtxrO9KFnjivXQLhn+slrq2mb08+x
 iq6zIIFIuLdQ==
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="443456551"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.251.24.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 11:27:35 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 06/13] selftests: mptcp: add cfg_do_w for cfg_remove
Date: Fri, 26 Mar 2021 11:26:35 -0700
Message-Id: <20210326182642.136419-6-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
References: <20210326182307.136256-1-mathew.j.martineau@linux.intel.com>
 <20210326182642.136419-1-mathew.j.martineau@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

In some testcases, we need to slow down the transmitting process. This
patch added a new argument named cfg_do_w for cfg_remove to allow the
caller to pass an argument to cfg_remove.

In do_rnd_write, use this cfg_do_w to control the transmitting speed.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 77bb62feb872..69d89b5d666f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -55,6 +55,7 @@ static int cfg_sndbuf;
 static int cfg_rcvbuf;
 static bool cfg_join;
 static bool cfg_remove;
+static unsigned int cfg_do_w;
 static int cfg_wait;
 
 static void die_usage(void)
@@ -272,8 +273,8 @@ static size_t do_rnd_write(const int fd, char *buf, const size_t len)
 	if (cfg_join && first && do_w > 100)
 		do_w = 100;
 
-	if (cfg_remove && do_w > 50)
-		do_w = 50;
+	if (cfg_remove && do_w > cfg_do_w)
+		do_w = cfg_do_w;
 
 	bw = write(fd, buf, do_w);
 	if (bw < 0)
@@ -829,7 +830,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "6jrlp:s:hut:m:S:R:w:")) != -1) {
+	while ((c = getopt(argc, argv, "6jr:lp:s:hut:m:S:R:w:")) != -1) {
 		switch (c) {
 		case 'j':
 			cfg_join = true;
@@ -840,6 +841,9 @@ static void parse_opts(int argc, char **argv)
 			cfg_remove = true;
 			cfg_mode = CFG_MODE_POLL;
 			cfg_wait = 400000;
+			cfg_do_w = atoi(optarg);
+			if (cfg_do_w <= 0)
+				cfg_do_w = 50;
 			break;
 		case 'l':
 			listen_mode = true;
-- 
2.31.0

