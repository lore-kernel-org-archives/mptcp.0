Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F444359
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153410; x=1676689410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XNSbF2ralo2Cs3IT9LvtSwn9jScnNXYztNFwwiSYUqQ=;
  b=lHXXpuildDfdsQtkGSEdiX0ArIwhaNWNKSqUbBgoBnKXRbZvFwwJagRZ
   zegzvz8gSKdK/Uty1IE8AVWCTb5LzgcTbcx9XaUvNRVCFP6UTRDDJxeT9
   uxd7dpoK6LQw9JiC8G1v0IP+Bq+Z7BIMGun4Nzv4K5UDbuMQfXRFvyClB
   Ugdcz+jAU4qEcG4fiJmlqboIY/qJeJFT7TJ1+T/vXzwKG4Zzt4qWnqZj3
   QOMX4fPDe2AgV46hg01fMaGa3S0moa9ufLNTrljO8AVaY95lM0/WdvvpR
   WWf+8Hvo+44DuPQAhuN99y48ypA156nqBvP8eoqXXPAww2jaB7yVnTYcv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021640"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021640"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431904"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:18 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 3/7] selftests: mptcp: join: exit after usage()
Date: Thu, 17 Feb 2022 19:03:07 -0800
Message-Id: <20220218030311.367536-4-mathew.j.martineau@linux.intel.com>
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

With an error if it is an unknown option.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index bbcacaaf81ce..1a881a21e7ef 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2077,8 +2077,14 @@ all_tests()
 	fullmesh_tests
 }
 
+# [$1: error message]
 usage()
 {
+	if [ -n "${1}" ]; then
+		echo "${1}"
+		ret=1
+	fi
+
 	echo "mptcp_join usage:"
 	echo "  -f subflows_tests"
 	echo "  -e subflows_error_tests"
@@ -2099,6 +2105,8 @@ usage()
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
 	echo "  -h help"
+
+	exit ${ret}
 }
 
 sin=$(mktemp)
@@ -2187,9 +2195,12 @@ while getopts 'fesltra64bpkdmchCSi' opt; do
 			;;
 		i)
 			;;
-		h | *)
+		h)
 			usage
 			;;
+		*)
+			usage "Unknown option: -${opt}"
+			;;
 	esac
 done
 
-- 
2.35.1

