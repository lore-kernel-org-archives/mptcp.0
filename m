Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DC38EA
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 01:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645060897; x=1676596897;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7rGTmA6d0wOc65sPkDd2Itwkmtq4jvVPi3vgED+7U80=;
  b=QWN8XHxqj4KHhI2RlxJ2lZSLNkitZjTtEZTno9Z86Ynp7MdGpnCs/GB7
   Gdk7aozNVqGkLqWuiguWTGS9VLf1Nz2C3vqZ6usGnopccVxGz4Tykd8by
   29LnTTtw7UWEP8B+V1glcn7wHlALy4574PyN3Bp4tLsDG4nxLl1oYW4S2
   GChd9zJ4QN3P/mBaRxtSyU6LGGRMcR5bTuhvaljTA0uCdbkLvg2DEIM8L
   J90tJNXNNy32hsf8Qv+5ECBZv5LK52Rxv6hhC5q6YXaGnzvJZW8p34QZb
   jRB6Kcj5YyLF48QoxaM3BHXXP8j06FY0d4day3ve9zxeLQpp+yueMix+g
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234297216"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="234297216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:21:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="681752043"
Received: from hasaeed-mobl.amr.corp.intel.com ([10.209.58.207])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 17:21:36 -0800
Date: Wed, 16 Feb 2022 17:21:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next 0/6] MP_FAIL echo and retrans
In-Reply-To: <cover.1645009373.git.geliang.tang@suse.com>
Message-ID: <bf2f5d27-fe3f-9b6a-6533-ed82982c6298@linux.intel.com>
References: <cover.1645009373.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 16 Feb 2022, Geliang Tang wrote:

> This patchset added MP_FAIL echo and retrans support. Except the last
> patch, others work well.
>
> Here I have some questions about it.
>
> 1. How to distinguish an MP_FAIL packet and an MP_FAIL echo packet?
>
> Unlike ADD_ADDR, there's no echo bit in a MP_FAIL packet. Patch 1 used
> simple method to distinguish them.
>
> MP_FAIL carries the data sequence number of the checksum failure.

The RFC says (after Figure 16):

"The receiver of this option MUST discard all data following the data 
sequence number specified."

So MP_FAIL carries the sequence number of the last "good" byte received.

> MP_FAIL echo carries the received data sequence number of a MP_FAIL.

I'm assuming by "MP_FAIL echo" you're referring to the MP_FAIL response 
mentioned in RFC 8684 section 3.7: "While in theory paths may only be 
damaged in one direction -- and the MP_FAIL signal affects only one 
direction of traffic -- for simplicity of implementation, the receiver of 
an MP_FAIL MUST also respond with an MP_FAIL in the reverse direction and 
entirely revert to a regular TCP session."

The MP_FAIL sent in response doesn't contain the received data sequence 
number of an MP_FAIL, as I've read the RFC (if I missed something please 
point me to it). As I read the sentence above, the MP_FAIL sent in 
response just contains the sequence number of the last "good" byte 
received *by this peer*. The difference is that this MP_FAIL was triggered 
by a received MP_FAIL instead of a checksum failure.


> 2. For the multiple subflow case, MP_FAIL echo is sent on another subflow,
> not the subflow receiving this MP_FAIL. Since the receiving subflow will
> be closed by MP_RST after a while.
>

If there are multiple subflows, MP_FAIL is only sent with TCP RST. The 
subflow is immediately disconnected and there is no need to send MP_FAIL 
on any other subflows since they are still working properly and can handle 
MPTCP-level retransmissions to recover the data stream.

A MP_FAIL sent in response to another MP_FAIL only happens in the "single 
subflow with checksum error and contiguous data" special case.

> 3. Patch 5 added mp_fail_timer as a struct member of struct
> mptcp_subflow_context. Is there a better place to add this timer?
>

I'm not sure a separate timer is needed?

There's no need to retransmit MP_FAIL when there are multiple subflows, or 
a single subflow with noncontiguous data.

In the remaining case (single subflow with contiguous data), the 
connection is trying to fall back so there's no need to use 
msk->timer_ival for MPTCP-level retransmits or DATA_FIN retransmits. 
msk->timer_ival is available to trigger a check if we have not received a 
response from the peer after sending MP_FAIL.

I don't think we should put a lot of work in to recovering from lost 
MP_FAILs - if the peer doesn't respond properly it's an option to just 
give up and reset the connection.


-Mat



> 4. Just like the way of dropping the ADD_ADDR packets in the ADD_ADDR
> timeout testcases, patch 6 tried to use iptables bpf to drop the MP_FAIL
> packets too. But it doesn't work.
>
> Drop ADD_ADDR packets using this bpf rule:
>
> "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>                 (ip6 && (ip6[74] & 0xf0) == 0x30)'"
>
> I used a similar rule to drop MP_FAIL packets:
>
> "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x60) ||
>                 (ip6 && (ip6[74] & 0xf0) == 0x60)'"
>
> I thinks the offset shouldn't be 54 or 74 here. Matt, could you please
> give me some help about how to get the right offset values?
>
> Thanks.
> -Geliang
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/261
> Depends on: the "add mp_fail testcases" series.
>
> Geliang Tang (6):
>  mptcp: add MP_FAIL echo support
>  mptcp: add mibs for MP_FAIL echo
>  selftests: mptcp: add MP_FAIL echo mibs check
>  mptcp: add a new sysctl mp_fail_timeout
>  mptcp: add MP_FAIL retrans support
>  selftests: mptcp: MP_FAIL timeout testcases TODO
>
> Documentation/networking/mptcp-sysctl.rst     | 10 +++
> net/mptcp/ctrl.c                              | 14 ++++
> net/mptcp/mib.c                               |  2 +
> net/mptcp/mib.h                               |  2 +
> net/mptcp/options.c                           | 23 ++++-
> net/mptcp/pm.c                                | 41 ++++++++-
> net/mptcp/protocol.c                          |  1 +
> net/mptcp/protocol.h                          |  7 ++
> net/mptcp/subflow.c                           | 30 ++++++-
> .../testing/selftests/net/mptcp/mptcp_join.sh | 84 +++++++++++++++++++
> 10 files changed, 207 insertions(+), 7 deletions(-)
>
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
