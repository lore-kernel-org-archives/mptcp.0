Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397656030
	for <mptcp@lists.linux.dev>; Thu, 14 Jul 2022 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657839041; x=1689375041;
  h=date:from:to:subject:in-reply-to:message-id:references:
   mime-version;
  bh=I7xazlrhsbTG5o6551bCZ/VX4wrSAenM4gvW0mlQ3vQ=;
  b=NznDoj2lqkys7cD7pHybY78RnHqHRWzS4yNhc6fgGJgSO0K5FN4os0qG
   k1eFGsa0qWr7jfIPsjdJsCv2ybs1eeQ1zJy6nF5QWel/g6CM473ICo1As
   HqMZJsDjfGM/6XyfbJZZNpkC8FdDG2aGcs9ff6PdSqtrnTKUbQlm3dyK7
   WfzyFCiAla+C6rXG1n5y50QyG7EhqlfDthEHZWhfIOlFJaTA0Nh72IbC8
   PMHdHUJBROjb16A2ktC8JJoPgxGiqaZXPe3V3F2tFX++PB1dd0tbBOpEY
   A+uWg+UfIrzXWsZEJYlmZN12w7weYcyPQuHHG9AhGCiZFkfvpmBhvbWNJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284402578"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="284402578"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:50:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628875812"
Received: from dwalters-mobl1.amr.corp.intel.com ([10.209.100.35])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 15:50:40 -0700
Date: Thu, 14 Jul 2022 15:50:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: Draft talk proposal for MPTCP @ Linux Plumbers '22 (2nd draft)
In-Reply-To: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com>
Message-ID: <3f3a487-64b-e687-f566-ae9b3b930bb@linux.intel.com>
References: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


After some discussion at out last couple of weekly meetings, here's an 
updated draft.

Changes:

  * Moved BPF section up (before userspace PM)
  * Emphasized interactive discussion for BPF issues we've been trying to 
resolve, like the BPF/kernel API.
  * General edits

Suggestions, edits, feedback, etc, all welcome!


---

Multipath TCP (MPTCP) was initially supported in v5.6 of the Linux kernel. 
In later releases, the MPTCP development community has steadily expanded 
from the initial baseline feature set to now support a broad range of 
MPTCP features on the wire and through the socket and generic netlink 
APIs. Two current projects are intended to make MPTCP more customizable 
for client devices and unique use cases without requiring custom kernel 
modules.

One of these projects is the BPF MPTCP packet scheduler framework. When 
there are multiple active TCP subflows in a MPTCP connection, the MPTCP 
stack must decide which of those subflows to use to transmit each data 
packet. The default in-kernel scheduler tries to utilize all the available 
subflows to favor throughput, but it is not tunable. Customizable 
schedulers can optimize for latency, redundancy, cost, carrier policy, or 
other factors. We have patches implementing a proof-of-concept BPF packet 
scheduler, and hope to discuss with the netdev/BPF maintainers and 
audience how we might best structure the BPF/kernel API to balance 
long-term API stability, future evolution of MPTCP scheduler features, and 
usability for scheduler authors.

The next customization feature is the userspace path manager added in 
v5.19. On the kernel side, MPTCP's generic netlink API has new commands 
that allow a userspace process to control multipath address advertisements 
and the additional subflows that add paths to a MPTCP connection. The 
Multipath TCP Daemon (mptcpd) is the first userspace daemon to support 
these commands. With these components, systems can now customize MPTCP 
behavior on a per-connection basis. The in-kernel path manager, which is 
enabled by default, only has per-namespace configuration. We will show 
what the userspace and in-kernel path managers are best suited for and 
explain the tradeoffs between them.

MPTCP development for the Linux kernel and mptcpd are public and open. You 
can find us at mptcp@lists.linux.dev, https://mptcp.dev, and 
https://github.com/intel/mptcpd


--
Mat Martineau
Intel
