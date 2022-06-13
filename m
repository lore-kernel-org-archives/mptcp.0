Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FC3D8E
	for <mptcp@lists.linux.dev>; Mon, 13 Jun 2022 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655161945; x=1686697945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=plw0g8+RkSUnkSPmXwVcrtrptifcs7E/Cd9Ybcvx7XU=;
  b=LJxnQqH7ytKzNfLblO/zzZ45VrzYh8FSMzVa4l3M90E7KaquvHGjMQPP
   WSA4oZZtXInT4pwQcXUOWWXAnBuSvfI9kKoKiGayJ+gVQUdSLPr4lbMp3
   tgiwpNyMpsdeJUJbdQroetDM4aSEGvj6TR65Fh0YGYFdQvT8qKeBa2RNL
   UoYr8vaotnDXlcQ0cPgJFtESGY/irGnDUfJ3CA0hI/ebwOVdxfyaAO/UU
   CiGih1u7nAbUCeQm1UBPODuF92lygojeMexy6Tunr9Wdr+bRUfawu9yNx
   kwRQ52fPyoRvMqQc2tZuOV+qtHa5y5VVE6U/LJJRd/dMrEAdB3M+kqF3G
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258884644"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258884644"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:12:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="611981035"
Received: from jfgiesbe-mobl.amr.corp.intel.com ([10.209.95.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 16:12:24 -0700
Date: Mon, 13 Jun 2022 16:12:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: MPTCP community meeting cancelled for 2022-06-16
Message-ID: <9e4b323-4c40-5818-99-42aee982a9f@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello -

There won't be a MPTCP community meeting this week due to lack of 
available Mat(t)s.

We'll resume at the usual time next week: 2022-06-23 15:00 UTC


Meeting info: 
https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings


Thanks,

--
Mat Martineau
Intel
