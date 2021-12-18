Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75EB2C9C
	for <mptcp@lists.linux.dev>; Sat, 18 Dec 2021 01:17:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="220548210"
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="220548210"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 17:17:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,215,1635231600"; 
   d="scan'208";a="585749660"
Received: from jasanch5-mobl1.amr.corp.intel.com ([10.212.247.3])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 17:17:12 -0800
Date: Fri, 17 Dec 2021 17:17:12 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Kishen Maloor <kishen.maloor@intel.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 08/21] mptcp: attempt to add listening sockets
 for announced addrs
In-Reply-To: <36f0c0b90d362b0f6a2ab02ba1f192eb87481752.camel@redhat.com>
Message-ID: <c44c731d-6031-7ad3-7270-979436ae6816@linux.intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>  <20211216222314.1244708-9-kishen.maloor@intel.com> <36f0c0b90d362b0f6a2ab02ba1f192eb87481752.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 Dec 2021, Paolo Abeni wrote:

> Hello,
>
> On Thu, 2021-12-16 at 17:23 -0500, Kishen Maloor wrote:
>> When ADD_ADDR announcements use the port associated with an
>> active subflow, this change ensures that a listening socket is
>> bound to the announced address and port for subsequently
>> receiving MP_JOINs from the remote end.
> Is this change strictly needed for user-space path manager? I
> personally think we should avoid it.
>

Definitely something we should discuss! I had initially thought that less 
state would be needed in the kernel for userspace PM sockets. Maybe we can 
still achieve that.

> yes, port-based endpoints do create an in kernel listener socket, but
> that is sort of last resort thing, it's a single socket per endpoint,
> and it's created at endpoint creation time.
>

The proposed code shares the listening sockets to limit how many are 
needed, although that behavior will definitely depend on the userspace PM 
using the same addrs & ports across different MPTCP sockets.

> The fact that potentially multiple listener could be created "under the
> hood" at run-time can have a number of bad side effects hard to track.
> e.g. if an application already create multiple listeners on different
> address, it will randomly fail at startup...

An application trying to listen on those same ports would fail whether 
these "extra" listening sockets were created and tracked in the kernel or 
by a userspace daemon, wouldn't they? With those sockets owned by 
userspace at least it might be more obvious what's going on.

I haven't (yet?) thought of a way to have a "MP_JOIN-only" listener that 
would avoid such address/port collisions with other applications without 
getting too invasive in the af_inet or tcp code.

>
> Can't instead the user-space path manager creating the listeners as it
> fits it's strategy better ?!?
>

Kishen can confirm, but I think he was looking at the netlink 'announce' 
command being a request from userspace to both (1) send the ADD_ADDR and 
(2) ensure that MP_JOINs sent by the peer in response would work 
correctly. This is more like the behavior of the userspace PM netlink 
commands in the multipath-tcp.org kernel. Due to implementation 
differences in handling incoming MP_JOINs, now we have to figure out if 
responsibility for #2 belongs with the kernel or userspace daemon.

Kishen, did you consider having the daemon own the listeners? What 
tradeoffs do you see with that approach?


Thanks,

--
Mat Martineau
Intel
