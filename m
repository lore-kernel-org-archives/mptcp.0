Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C98F17CA
	for <mptcp@lists.linux.dev>; Tue,  3 May 2022 18:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651603061; x=1683139061;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GcJyGAbwEfmrFRxXs2AbhEHjcPMnhIOeXshfW+jcV/0=;
  b=l+rqUiuRPoVQdnv3FttGHFySeNsFCiK6i10zdTEP62KHUNW7om63zw71
   Xv9PBsThaRmDuqVaWYiX2bQtD2rgdLuDsWcd70IL1KSKv3tAUpjk+Fiw6
   sjy6OHKiqIVwO0xNXP8DJjcKQthWB9+Dyxk/H7XIFVTuNTdBM3JDX/8Ci
   kriJblIS9je+1eeBr6JmyQO9Po+fdwu3RLS2RfNIKgDWxvLBkmAOx3FpT
   lBYs6Kl17/CoBRv6BT6NyQPbX3QjMFOJ93lL7FSd2jUMG9aEK2/hOfurB
   JoqmIo0/Q/S9VVRTNPx9/OQweRABjcjk9SLpy3BAmwPWvPuvIZLj/cba1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249537543"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="249537543"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:37:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="599186078"
Received: from skarmaka-mobl2.amr.corp.intel.com ([10.209.21.54])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:37:15 -0700
Date: Tue, 3 May 2022 11:37:07 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>, Christoph Paasch <cpaasch@apple.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: apropos https://github.com/multipath-tcp/mptcp_net-next/issues/265
 (checksums)
In-Reply-To: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com>
Message-ID: <e868da1-c75e-2027-83f8-2aae37cfb923@linux.intel.com>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 29 Apr 2022, Paolo Abeni wrote:

> Hello,
>
> I'm investigating the mentioned issue. Not strictily related to the
> observed failure, I think/fear we have a very serious problem WRT csum.
>
> Currently, AFAICS, we encode the csum converting the value returned
> from csum_fold(csum_partial(csum_unfold)) to be:
>
> https://elixir.bootlin.com/linux/v5.18-rc4/source/net/mptcp/options.c#L1343
>
> while the UDP/TCP csum store directly the result for the same
> operation:
>
> https://elixir.bootlin.com/linux/v5.18-rc4/source/net/core/dev.c#L3228
>

Another example where the checksum is usually assigned in the tcphdr shows 
similar direct assignment:

https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_ipv4.c#L634

> I guess we are doing it wrong but we don't obseve any specific problem
> as tests runs on the same arch and we do swap on rx, too.

It looks that way to me as well... Back when we did interop with 
multipath-tcp.org (before moving to MPTCPv1, which was prior to 
upstreaming), we hadn't added checksum support yet.

> I think should see sistematic csum failure when the involved peers have
> different endianess (e.g. x86 vs arm). If anyone has easy access to
> both systems, could please verify the above?

Most ARM systems are also little-endian.

Aside from mixed-endian interop, there's also stack interop to consider. 
@Christoph, do you know if DSS checksums are interoperating with other 
MPTCPv1 stacks?


The emulated MIPS VM I tried to set up in qemu last year was not stable 
enough to even 'git clone' the kernel code, it would be worth trying that 
again with a cross-compiled kernel.

I noticed yesterday that the BPF CI is running big-endian tests on the z15 
architecture. I think that's through travis-ci. Do CI providers like 
Travis or Cirrus allow interop testing between multiple VMs?

Checking on other tools we could use to confirm checksum operation (and 
run on either big- or little-endian platforms), it looks like wireshark 
tries to track DSS checksums but does not verify them. Packetdrill seems 
to have some code (maybe incomplete?) for getting the checksum data from 
headers - would require some work to complete that code and add test 
cases.

>
> If the above is true the nasty part is that I don't see how to fix this
> without breaking the interop with bugged versions :////

Same :|

--
Mat Martineau
Intel
