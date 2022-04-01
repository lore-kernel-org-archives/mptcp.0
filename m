Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937CB7C
	for <mptcp@lists.linux.dev>; Fri,  1 Apr 2022 19:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648841837; x=1680377837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KcNx+X93vdLXO2gQ1J0ht+MRvYr1tCclB140EZBxEtk=;
  b=TFpsnE4UslbdhQmqXE7OwF6s64EjzkM3HMSFaqvXSlZZUxqcMrQuOEUv
   1/44jwggZkCJtTmhQCsieRhHbh7LfwNvVdoMbr5/DncOqKg0NAfgVS8Pn
   PgEbwr+mAcCs0O4986ne1OJrIaoXneFKLGSFfbvSIxxj+cxI4a4CH1pdI
   zv1vigaXD3hBVN7J4GoB4m1RORN7Ud4VgHdnMnkLO1ODw44IcfZ8ZytWK
   tM/w5TwO/Yq0qFCdofhw3TjNL0AecQlw7xvuBAhwhD0kRF8To71uHxhrh
   0xN26GV2bcuvIRY4nG/yLExTnpBqvxF7aEKJeCLrB+eQnbsGq5fXcsoCS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="242358949"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="242358949"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="640638789"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.212.187.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 12:37:16 -0700
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: kishen.maloor@intel.com
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v9 2/6] mptcp: bypass in-kernel PM restrictions for non-kernel PMs
Date: Fri,  1 Apr 2022 12:37:12 -0700
Message-Id: <20220401193714.10268-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329021401.1196466-3-kishen.maloor@intel.com>
References: <20220329021401.1196466-3-kishen.maloor@intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch exposes some incorrect behavior in my userspace PM selftests
that are already in the export branch. If you could add the squash-to
patch at the beginning of your series to revert the bad test, and add
the new self test commit after "mptcp: bypass in-kernel PM restrictions
for non-kernel PMs" I think that addresses the test problem.

Mat Martineau (2):
  Squash-to: selftests: mptcp: Add tests for userspace PM type
  selftests: mptcp: ADD_ADDR echo test with missing userspace daemon

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.35.1

