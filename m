Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CA3FC0
	for <mptcp@lists.linux.dev>; Mon, 23 Aug 2021 20:12:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="215333574"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="215333574"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:12:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="493142579"
Received: from kkomeyli-mobl4.amr.corp.intel.com ([10.212.143.145])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 13:12:52 -0700
Date: Mon, 23 Aug 2021 13:12:51 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev
cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Florian Westphal <fw@strlen.de>
Subject: Key signing for MPTCP kernel development
Message-ID: <75c7bd9f-40c2-4356-baf6-323d5efee11b@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello -

Matthieu and I were having a conversation about key signing and 
kernel.org, and as subsytem maintainers it would be good to both be part 
of the kernel.org web of trust. As far as I know, the only regulars at our 
meetings who are already in the web of trust are me & Florian.

I'd like to confirm key IDs at the usual Thursday meeting this week 
(https://github.com/multipath-tcp/mptcp_net-next/wiki/Meetings), for those 
who want to participate.

Information on use of pgp in kernel development is at 
https://www.kernel.org/doc/html/latest/process/maintainer-pgp-guide.html

You can look up existing public keys at 
https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/ or 
https://keyserver.ubuntu.com/


--
Mat Martineau
Intel
