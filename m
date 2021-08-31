Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7F472
	for <mptcp@lists.linux.dev>; Tue, 31 Aug 2021 17:19:57 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205751466"
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="205751466"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 10:19:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,366,1620716400"; 
   d="scan'208";a="690094692"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.180.246])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 10:19:33 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	davem@davemloft.net,
	kuba@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net v2 2/2] selftests: mptcp: clean tmp files in simult_flows
Date: Tue, 31 Aug 2021 10:19:26 -0700
Message-Id: <20210831171926.80920-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
References: <20210831171926.80920-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthieu Baerts <matthieu.baerts@tessares.net>

'$cin' and '$sin' variables are local to a function: they are then not
available from the cleanup trap.

Instead, we need to use '$large' and '$small' that are not local and
defined just before setting the trap.

Without this patch, running this script in a loop might cause a:

  write: No space left on device

issue.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index fd63ebfe9a2b..910d8126af8f 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -22,8 +22,8 @@ usage() {
 
 cleanup()
 {
-	rm -f "$cin" "$cout"
-	rm -f "$sin" "$sout"
+	rm -f "$cout" "$sout"
+	rm -f "$large" "$small"
 	rm -f "$capout"
 
 	local netns
-- 
2.33.0

