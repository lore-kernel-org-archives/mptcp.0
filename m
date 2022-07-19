Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D76EA9
	for <mptcp@lists.linux.dev>; Tue, 19 Jul 2022 01:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658193471; x=1689729471;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1+eK1CgUJFSAKDtmTtuy09bbdnezxDjy0DEZ8K+wXYA=;
  b=dE4oHCQsxEOKnWC43fvssIAQLAOW7TKD5Ktll5X0v5+BBPUKc1Pt462D
   grVfACKn7pvt5SPn/saQsIgBr8ujjX/J3qvB+LticEEwAnU7MPkSm4um9
   n5Y8aMg1dHDyDW/dSCowD5uZ80/hiHpFidqbK+7/WIdxLMXGzAbCpX0aE
   hzOUEvVXQMHuqXpC2+XsGouWlLJk4kzVtvizOBb/4Z4GGrXoLT3Okb+sV
   g7McBQHVQFWVz6s3MAKY8dRHw21yxeFWmcvRLML5DKc6L21IDTVdph+db
   KmA5MQz67HyL9vGc89uqLyldiR+GnUscTRuOLCYX7+f437rW7UCYUsFkj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="273188993"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="273188993"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:17:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="724069780"
Received: from sinforoz-mobl.amr.corp.intel.com ([10.251.20.49])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:17:50 -0700
Date: Mon, 18 Jul 2022 18:17:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: Draft talk proposal for MPTCP @ Linux Plumbers '22 (3rd draft)
In-Reply-To: <7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net>
Message-ID: <38919512-f6f-1035-763f-67cd15a5febb@linux.intel.com>
References: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com> <3f3a487-64b-e687-f566-ae9b3b930bb@linux.intel.com> <7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


Here's a new draft based on Matthieu's feedback for v2 
(https://lore.kernel.org/mptcp/7cd436ad-6c05-d788-7af3-2ff08d647dfd@tessares.net/).

The main goal was to frame the proposal as an illustration of tradeoffs 
between different kernel extensibility options (BPF & genl).


---

Multipath TCP (MPTCP) was initially supported in v5.6 of the Linux kernel. 
In subsequent releases, the MPTCP development community has steadily 
expanded from the initial baseline feature set to now support a broad 
range of MPTCP features on the wire and through the socket and generic 
netlink APIs.

With core MPTCP functionality established, our next goal is to make MPTCP 
more extensible and customizable at runtime. The two most common tools in 
the kernel's networking subsystem for these purposes are generic netlink 
and BPF. Each has tradeoffs that make them better suited for different 
scenarios. Our choices for extending MPTCP show some of those tradeoffs, 
and also leave our community with some open questions about how to best 
use these interfaces and frameworks.

As one example, we are extending the MPTCP packet scheduler using BPF. 
When there are multiple active TCP subflows in a MPTCP connection, the 
MPTCP stack must decide which of those subflows to use to transmit each 
data packet. This requires low latency and low overhead, and direct access 
to low-level TCP connection information. Customizable schedulers can 
optimize for latency, redundancy, cost, carrier policy, or other factors. 
We have patches implementing a proof-of-concept BPF packet scheduler, and 
hope to discuss with the netdev/BPF maintainers and audience how we might 
best structure the BPF/kernel API to balance long-term API stability, 
future evolution of MPTCP scheduler features, and usability for scheduler 
authors.

The next customization feature is the userspace path manager added in 
v5.19. MPTCP path managers advertise addresses available for multipath 
connections, and establish or close additional TCP subflows using the 
available interfaces. There are a limited number of interactions with a 
path manager during the life of a MPTCP connection. Operations are not 
very sensitive to latency, and may need access to data from userspace. 
This led us to expand the MPTCP generic netlink API and update the 
Multipath TCP Daemon (mptcpd) to support the new commands. Generic netlink 
has been a good fit for path manager commands and events, the concepts are 
familiar and the message format makes it possible to maintain forward and 
backward compatibility between different kernel versions and userspace 
binaries.

MPTCP development for the Linux kernel and mptcpd are public and open. You 
can find us at mptcp@lists.linux.dev, https://mptcp.dev, and 
https://github.com/intel/mptcpd



--
Mat Martineau
Intel
