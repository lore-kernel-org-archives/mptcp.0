Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52407B
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656548219; x=1688084219;
  h=date:from:to:subject:message-id:mime-version;
  bh=DquRVD8ZDpwFCE9tJKiDOO5eqxwejBvk5lXfn1ybgIc=;
  b=QvmVcK8C6gTVzMqv4q+6rmjELQBkc4SWqmYLK0i2uxv5sVbOkXBGNDjH
   WQ8FXpLrN04Ua/p5md9vaXbR34L/tcvZ1M+u90/ZW8DcgOfD8GZnlQqyy
   5WztrjU4qFAF+yBl/7/xjfG8X5P2j35ojTx/6v0Wk+l2TFA3trqYeO8pi
   u3U/fJFHW5UZmmbfANyVptQIY72kwPw+pmOX9IiJweHhRrtbztxMdLNwP
   LJqaiXmLmCwypJIE954SnSeA6F8UHdmHFfqbo29DeC9v1fTVSN+DtU6ON
   PuSvw/kqoKSQwF8hY6Wj+7iUbABhE7/senktLwva4TIXUQfia/Iv9AUjD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283294378"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="283294378"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 17:16:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="693814616"
Received: from bschenc3-mobl.amr.corp.intel.com ([10.209.57.164])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 17:16:53 -0700
Date: Wed, 29 Jun 2022 17:16:53 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Draft talk proposal for MPTCP @ Linux Plumbers '22
Message-ID: <78ff1ebd-f440-9dd0-256-abf3345e6d3@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


At our recent weekly MPTCP meetings, I've talked about proposing a Linux 
Plumbers talk this year. Matthieu and I have discussed collaborating on 
it.

My high-level idea was to focus on our new customization features: 
userspace path management and BPF packet schedulers.

Since MPTCP is a community effort, I'd like to share this draft so I 
can be sure to focus in the right areas and represent the community well. 
Please review and comment!

Side note: I've included the https://mptcp.dev URL even though it's not 
working yet. Matthieu, do you think we could get something set up there 
before September? The old https://is.gd/mptcp_upstream URL we used for the 
2019 talk doesn't work any more.

----

Multipath TCP (MPTCP) was initially supported in v5.6 of the Linux kernel. 
In later releases, the MPTCP development community has steadily expanded 
from the initial baseline feature set to now support a broad range of 
MPTCP features on the wire and through the socket and generic netlink 
APIs. The first phase of development focused on solid support of server 
use cases. Two current projects are intended to make MPTCP more 
customizable for client devices and unique use cases without requiring 
custom kernel modules.

The first of these customization features is the userspace path manager 
added in v5.19. On the kernel side, MPTCP's generic netlink API was 
updated with new commands that allow a userspace process to control 
multipath address advertisements and the additional subflows that can add 
paths to a MPTCP connection. The Multipath TCP Daemon (mptcpd) is the 
first userspace daemon to support these commands. With these components, 
systems can now customize MPTCP behavior on a per-connection basis. The 
in-kernel path manager, which remains available, has configuration options 
that affect all connections in a network namespace. We will show what the 
userspace and in-kernel path managers are best suited for and explain the 
tradeoffs between them.

A BPF packet scheduler framework is also in active development. When there 
are multiple active TCP subflows in a MPTCP connection, the MPTCP stack 
must decide which of those subflows to use to transmit each data packet. 
The default in-kernel scheduler tries to utilize all the available 
subflows to favor throughput, but is not tunable. Customizable schedulers 
could optimize for latency, redundancy, cost, carrier policy, or other 
factors. We will review the progress that MPTCP Linux developers have made 
on this feature to date, along with some of the challenges of integrating 
BPF into the MPTCP transmit path.

MPTCP development for the Linux kernel and mptcpd are public and open. You 
can find us at mptcp@lists.linux.dev, https://mptcp.dev, and 
https://github.com/intel/mptcpd

--
Mat Martineau
Intel
