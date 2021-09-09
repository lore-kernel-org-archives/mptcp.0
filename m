Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DB3FF0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 16:08:19 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="284533551"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="284533551"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:08:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="513836870"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:08:16 -0700
Date: Thu, 9 Sep 2021 09:08:16 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: MPTCP export branch - build errors due to -Werror
Message-ID: <ddbdbbb6-ee39-40a1-c1d2-e0f1b1b3aa91@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


I mentioned in the meeting today, kbuild's build step is failing due to 
warnings being treated as errors.

The fix to change -Werror to be under the COMPILE_TEST config flag is 
commit b339ec9c229aaf399296a120d7be0e34fbc355ca in Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b339ec9c229aaf399296a120d7be0e34fbc355ca
https://lore.kernel.org/all/YTfkO2PdnBXQXvsm@elver.google.com/

Not sure when it will show up in net-next (hopefully soon!), but it would 
be good to cherry-pick in the export branch in the mean time.


Thanks!

--
Mat Martineau
Intel
