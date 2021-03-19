Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649A5F
	for <mptcp@lists.linux.dev>; Fri, 19 Mar 2021 21:08:43 +0000 (UTC)
IronPort-SDR: xypqKrrcd+KXsoMavVsPYRgR9pjDjjRwPPKszn6KHS6pxtIpVDcVvGfR3a3DqXahp/zg4EdWhR
 vdhqRvvV6Fgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="177553958"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="177553958"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:08:42 -0700
IronPort-SDR: ZcM0s4S1hFRyNKkUH87311cGkCCaSxSeZ3NcFxrcvOC7bPFzVeGiGcGMl2byi0pqYo4bBAbsQG
 /PNivBSCdhPA==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="413660147"
Received: from johnmc3x-mobl1.amr.corp.intel.com ([10.255.228.189])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 14:08:42 -0700
Date: Fri, 19 Mar 2021 14:08:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, mptcp@lists.01.org
cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliangtang@gmail.com>, 
    Florian Westphal <fw@strlen.de>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Davide Caratti <dcaratti@redhat.com>, 
    Ossama Othman <ossama.othman@intel.com>, 
    Christoph Paasch <cpaasch@apple.com>
Subject: MPTCP Linux mailing list transition
Message-ID: <cccc879d-d729-9043-38c5-3996c7c66d@linux.intel.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


Hello -

We're in the middle of a transition to a new mailing list at 
mptcp@lists.linux.dev, with a couple of steps to go:

  * Updating patchwork to use the new address (request is pending)

  * Re-subscribe everyone to the new list


For now, please cc patches to both lists so we can be sure they are 
tracked with patchwork.

If you would like to immediately subscribe to the new list, send a message 
to mptcp+subscribe@lists.linux.dev . I will bulk subscribe based on the 
existing 01.org subscriber list in the next several days.

--
Mat Martineau
Intel
