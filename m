Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5B510E5
	for <mptcp@lists.linux.dev>; Sat,  7 Jan 2023 01:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673054408; x=1704590408;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bbtqqF+B69tHNesf0wgtgTqkjy1s0lJrqw2if/BTft4=;
  b=gYi+1S0JRx/2JFM1ODoSKVL7fDDiolwyF2jt6JcAYx8FoojYiBJuAbJI
   0cui8nn7x+BVNvJUd52diJOnoSxKsagPS8Ux9nTo/CGA9AY27XsfyXgwG
   QKZZY/w8Qy3fCCTYIEvS0W/uR3+FDsH0e68iiB9RkXpZaVyzu1ocgn5Fi
   +T0tqfP6e+qVsIpaR0XbvPjBoR6cINPU95NggqzQ5FuJoNZUNiBpVzY/X
   S4GnCipawuXz1aDAtFe9dxW/favyHhPOR3qu3hw1kEosfKy5TjvvtCIui
   dWkf++roBYrHiV08UXbMkydIP346/eEDJ7yEKDCmJgMaQaOyn8uQMfJTG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="322672294"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="322672294"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:20:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="649475308"
X-IronPort-AV: E=Sophos;i="5.96,307,1665471600"; 
   d="scan'208";a="649475308"
Received: from mechevar-mobl.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.66.63])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 17:20:07 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	matthieu.baerts@tessares.net,
	pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: [PATCH 5.15 0/2] mptcp: use proper req destructor for IPv6
Date: Fri,  6 Jan 2023 17:19:56 -0800
Message-Id: <20230107011959.448249-1-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greg -

Here are backports of two MPTCP patches that recently failed to apply to
the 5.15 stable tree. Two prerequisite patches are already queued in
5.15.87-rc1:

  mptcp: mark ops structures as ro_after_init
  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies

These patches prevent IPv6 memory leaks with MPTCP.

Thanks!


Matthieu Baerts (2):
  mptcp: dedicated request sock for subflow in v6
  mptcp: use proper req destructor for IPv6

 net/mptcp/subflow.c | 53 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

-- 
2.39.0

