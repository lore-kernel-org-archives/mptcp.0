Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96A433D2
	for <mptcp@lists.linux.dev>; Fri,  8 Jul 2022 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657300462; x=1688836462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=khkwPk/CnUj8fSk953hczeRged9KSBy6ZNMvRMBn4ng=;
  b=inhPm1dBRC3FAELYx4CT6Rpe1tT0SHXon74j7EscaNbx06jSwurGbQcp
   uI6gRzkR5M+NYooksQkeSefB+w9dteLn0/dpD9ulZguHt7lrvJXRjDxMl
   ZL/7/JFCBsS1/WdSwVMuI18p/LfBPqmKKQYazZXpEo6MUpqfVH1YR1Qlm
   NB65XkzydjeSgHC/c6t/FbRRvSOvsUGq8klHKo5JUKjwVClBhpWhFeywt
   HBLCDvcxKcNu3d+Bo4u7hVHtsZ5QRRcthyTRvSh79ar8P+v0Lkoct0Qay
   haYxSgnEqhRJ8Fwtt5C6S72CFSz2rjGnWfmrq79zPE7c7b5uNOyzTm+P6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="285069105"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="285069105"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="651641509"
Received: from aroras-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.1.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 10:14:19 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 6/6] selftests: mptcp: update pm_nl_ctl usage header
Date: Fri,  8 Jul 2022 10:14:13 -0700
Message-Id: <20220708171413.327112-7-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
References: <20220708171413.327112-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

The usage header of pm_nl_ctl command doesn't match with the context. So
this patch adds the missing userspace PM keywords 'ann', 'rem', 'csf',
'dsf', 'events' and 'listen' in it.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index cb79f0719e3b..abddf4c63e79 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -31,7 +31,7 @@
 
 static void syntax(char *argv[])
 {
-	fprintf(stderr, "%s add|get|set|del|flush|dump|accept [<args>]\n", argv[0]);
+	fprintf(stderr, "%s add|ann|rem|csf|dsf|get|set|del|flush|dump|events|listen|accept [<args>]\n", argv[0]);
 	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
 	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
 	fprintf(stderr, "\trem id <local-id> token <token>\n");
-- 
2.37.0

