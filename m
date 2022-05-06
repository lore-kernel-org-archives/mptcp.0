Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6B62A
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651799484; x=1683335484;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v9mpXvU3XHd7dTBQzwS7hLxGRKoG1NYs+W8iaCU5jME=;
  b=L3b3UFcvCLRwwU4mVab0Bj2nkQnWtkD+ufDjMQC6OHqugBveWgBbNqSZ
   9L4JCVTZFX6XN2Pa1GjF+u4oNZdWgOfeY7dzPUyoXwR79N9jnYOVmuD8K
   gi/TFLKIlxgvTfKYaT5pEFn/gJFV4PaGm0f8fjp/BmVPcQ+l2JjlLWutt
   m4gAdwcPjCG+0X6hCuxT2NVnHUqiNwWrkp71gX64dQzsOG+EkaeGNVbm7
   z21gA9Dw4zPKhbQccaMZg3Ui+jkDj8tfzdTIhBFDnuEYB8h1a0pU3la7s
   y6ONeFbw0MpqCnDvqVfTDNu7nNClDEChmwyC4riAoAlTa9AbD/sd/0WpG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267910995"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267910995"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:11:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665234055"
Received: from barreola-mobl1.amr.corp.intel.com ([10.212.167.175])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:11:19 -0700
Date: Thu, 5 May 2022 18:11:19 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Maxim Galaganov <max@internet.ru>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: apropos
 https://github.com/multipath-tcp/mptcp_net-next/issues/265
In-Reply-To: <3c85fe48-69fe-0655-2146-a4424e02f185@internet.ru>
Message-ID: <d7497da1-86e4-30ae-aca-633b71facdcd@linux.intel.com>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com> <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru> <e69d4d2bead08317ad3af55ffe415b8f94877948.camel@redhat.com> <3c85fe48-69fe-0655-2146-a4424e02f185@internet.ru>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 4 May 2022, Maxim Galaganov wrote:

> On 04.05.2022 12:52, Paolo Abeni wrote:
>> 
>> Could you please additionally test the following patch? Kernel for both
>> arches must be rebuilt.
>> 
>> This should cause old x86 build with csum enabled to fallback to TCP
>> while interoperating with new ones, which is ugly and bad, but - given
>> that csum is disable by default - possibly still acceptable?!?
>
>
> The results for me are as follows:
>
> old x86_64 (5.17.5) + old mips (5.15.35) => reset
> new x86_64 (5.18-rc5+patch) vs old mips (5.15.35) => works
> new x86_64 (5.18-rc5+patch) vs new mips (5.15.35+patch) => works
> old x86_64 (5.17.2) + new mips (5.15.35+patch) => reset
> old x86_64 (5.17.2) + new x86_64 (5.18-rc5+patch) => reset
> new x86_64 (5.18-rc5+patch) talking to itself => works
>
> I edited the patch so that it applies to my kernels, and this might be the 
> reason I don't see fallback but see reset instead -- I don't have "mptcp: TCP 
> fallback for established connections" patches in my tree as they are only in 
> net-next yet. Or I may be doing something stupid.
>
> Is there a way for an old box without infinite mapping support to fallback an 
> established connection in case of csum failure?
>

In some cases, I think we can do that!

Both peers do not consider MPTCP "fully established" until they receive a 
valid DATA_ACK, and the old box will fall back if the new box sends an 
infinite mapping in response to the first data. So, if as part of the fix 
we make sure the new box responds to a bad checksum in the initial DSS (or 
MPC+DATA) with an infinite mapping instead of a reset, fallback should 
work. And I think what's needed to do that is to only set subflow->mp_fail 
at the end of validate_data_csum() if subflow->fully_established is 
'true'.

However, if the new box is the first to send data with a checksum, the old 
box decides whether to reset or fallback. It looks like unpatched 5.17, 
5.16, and 5.15 would send a reset in this "patched host sends data first" 
scenario. 5.14 looks like it would fall back? Older MPTCP kernels don't 
support DSS checksums.

This means that if the use case is a client/server setup where the client 
sends data first, and the server is running a new/patched kernel, we get 
the fallback behavior. That's good!


This still leaves that "patched host sends data first" scenario that 
should be addressed. The RFC requires checksums to be enabled if one peer 
requests it in the SYN/SYNACK handshake. Is it too much of a kludge to use 
a sysctl that would force TCP fallback if a peer requests checksums? This 
would be just like the behavior we had in v5.13 and earlier. We could add 
another state to the existing MPTCP checksum sysctl ("force fallback if 
checksums requested").


--
Mat Martineau
Intel
