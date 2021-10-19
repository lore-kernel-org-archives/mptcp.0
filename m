Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C32C80
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 01:01:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="291865821"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="291865821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 18:01:51 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="629406985"
Received: from phamal-mobl.amr.corp.intel.com ([10.252.131.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 18:01:51 -0700
Date: Mon, 18 Oct 2021 18:01:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: psonparo@redhat.com
cc: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Subject: MPC+Data bug progress?
Message-ID: <3f242ebc-3674-9468-f2b0-9fd756d54048@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hi Poorva -

Are you planning to send a kernel patch for the "Receiver key 
overwritten..." bug?

https://github.com/multipath-tcp/mptcp_net-next/issues/233

I don't think anyone else is working on it because the bug is assigned to 
you, and we need to upstream a patch soon to get in to the v5.15 final 
release. So please confirm your plans so we know if someone else should 
look at this kernel change!

Thanks,

--
Mat Martineau
Intel
