Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EA1FA1
	for <mptcp@lists.linux.dev>; Wed, 16 Feb 2022 02:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644977509; x=1676513509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VAHQXvGMLjW0BhKz1BGe0ArSmPku8NRPTQCN9f9zBLs=;
  b=NyX5qzAP+fUh7sUYN3yYjgjEYCKzyvXDnezoFQnWV8zE5NGOgpRKCQsc
   wkP8qWWAOLxkRFYYcHiPLAvkeJASERCsUW5KM34rGPbYyBPm3/4W6E8vA
   wCqLLgqg2ByOU/t0KiDtiNQz8JnT+SRRBbQo89FmvCl6Z4d0rXgJAQOeD
   OEiblTl3Muna1pIBmWXRfq/IA98V1bNPntqu30ecBcu4bgpngrfyPwf5R
   C32xOR92Ej5vfkXpX0qtYO3oq+K4HDnE3Cp4qCc/5oU+7PBC+kGUjC2GG
   h+ZrHj8VL9FdXNRz/lp5o3dQT8Q0+l4m7VFsyr7dwBpL0mMjygaLIHMkB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="313778511"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="313778511"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571088816"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.9.181])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 18:11:36 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 1/8] mptcp: add SNDTIMEO setsockopt support
Date: Tue, 15 Feb 2022 18:11:23 -0800
Message-Id: <20220216021130.171786-2-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

Add setsockopt support for SO_SNDTIMEO_OLD and SO_SNDTIMEO_NEW to fix this
error reported by the mptcp bpf selftest:

 (network_helpers.c:64: errno: Operation not supported) Failed to set SO_SNDTIMEO
 test_mptcp:FAIL:115

 All error logs:

 (network_helpers.c:64: errno: Operation not supported) Failed to set SO_SNDTIMEO
 test_mptcp:FAIL:115
 Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 net/mptcp/sockopt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dacf3cee0027..f949d22f52bd 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -343,6 +343,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
 	case SO_RCVLOWAT:
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
+	case SO_SNDTIMEO_OLD:
+	case SO_SNDTIMEO_NEW:
 	case SO_BUSY_POLL:
 	case SO_PREFER_BUSY_POLL:
 	case SO_BUSY_POLL_BUDGET:
-- 
2.35.1

