Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6710E5
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673056002; x=1704592002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iTh16ITNNvW1Q0l/LFoKifGNe3GuHiKv0MuFonpu8VA=;
  b=Z6mJcuPk/0rRk6eoMInG+2IBwhcwpxyPWchk14vC0SDG3bajsMXcRmVA
   2AC3rnVOXOrCtUuGcM6uWuQsh6dE017hzxH5rEBN95m+N2lC9lHBH/NUU
   B5u3re2hr79jGc1xP7FRphko6VRLYnwwStjD3XY86M0y/wLULK195rHjt
   f3FaNBNn+LiuldGkePWNaBIpwg3byRAWP6IYeAr1cRAXhYl1G74rDKyaY
   uKMhOXbuEOGdHWLuo+xgGbUqSQj8SeQOqzAUjXmHRcGbt+lOTH46HqLAd
   S5IHdcq45knc+WXe3CV3A06J+BALJXV3MrPh58StK2Ow3PT4PJeFMMeg5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="310393546"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="310393546"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="606066133"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="606066133"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:46:42 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH 5.10 0/4] mptcp: Stable backports for MPTCP request sock fixes
Date: Fri,  6 Jan 2023 17:46:27 -0800
Message-Id: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greg -

Here are backports of the MPTCP patches, and one prerequisite, that
recently failed to apply to the 5.10 stable tree. They prevent IPv6
memory leaks with MPTCP.

Thanks!


Florian Westphal (1):
  mptcp: mark ops structures as ro_after_init

Matthieu Baerts (3):
  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
  mptcp: dedicated request sock for subflow in v6
  mptcp: use proper req destructor for IPv6

 include/net/mptcp.h   | 12 +++++--
 net/ipv4/syncookies.c |  7 ++--
 net/mptcp/subflow.c   | 76 +++++++++++++++++++++++++++++++++----------
 3 files changed, 71 insertions(+), 24 deletions(-)

-- 
2.39.0

