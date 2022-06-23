Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EC01FAC
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 23:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656026384; x=1687562384;
  h=date:from:to:subject:message-id:mime-version;
  bh=wFALJ5J/RTwzCV1qDIWBompLmZZD1dDHcgmVLkLmFxw=;
  b=dwHoiy/4nqHrtVLkoeitsObhFvEIT73AHwrdUnjjZ8cRcJTIbmubTBdN
   gmuvmoTaBwzZp+oKOY6ywzzLWkIc9cPdIpIsW8w2nWWBb3/Cj719MSWhy
   vH1bqRjpmOa5CxDfBnMvq7tSiU42dtrwRu18Hm8oGIlnPcPyQ5AUlqaA1
   Q5ZUG0wfRIV2sBROSNVoDgedxJY35RHsJMtmZyFtX8+TCH6LcfMXFElYG
   TUatvV8Tl1h8b8oHbK9UemiPP1u16VtlZDfMGKsUn1U3e6oIvTrfReOVU
   vAvMzfrIAuq6B7mOlCwCHMDlUt816Ab7GEGXKQ4QAk7UM2g73FHkJcz3s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281948394"
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="281948394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:19:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,217,1650956400"; 
   d="scan'208";a="691259749"
Received: from jngertso-mobl1.amr.corp.intel.com ([10.212.159.56])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 16:19:43 -0700
Date: Thu, 23 Jun 2022 16:19:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Should the MIB_RMSUBFLOW commit go to -net?
Message-ID: <ad151d35-f094-675d-5ced-71df98ea5857@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


I was preparing the patches we had agreed to be ready for net-next in the 
meeting today:

         - [f1eb3f2cb4d2] mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy (Geliang Tang)
         - [f3c5dde10031] selftests: mptcp: userspace pm address tests (Geliang Tang)
         - [92378ff55152] selftests: mptcp: userspace pm subflow tests (Geliang Tang)
         - [1908a4ccaa2c] selftests: mptcp: avoid Terminated messages in userspace_pm (Geliang Tang)
         - [bac5548c7c47] selftests: mptcp: update pm_nl_ctl usage header (Geliang Tang)

I think the selftest commits are definitely best for net-next. But for the 
first one ("mptcp: update MIB_RMSUBFLOW in cmd_sf_destroy"), should we add

Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow establishment")

and include that in a patch set for -net? Seems like it would be good to 
improve the MIB accuracy with the userspace PM in 5.19.

Link to commit in patchwork: 
https://patchwork.kernel.org/project/mptcp/patch/723d61d82730b996132925686b43f9c3c79bc747.1655355422.git.geliang.tang@suse.com/


If that patch goes to -net, it would also require waiting until the next 
net/net-next sync before sending the selftest patches listed above.

--
Mat Martineau
Intel
