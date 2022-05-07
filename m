Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BA7E2
	for <mptcp@lists.linux.dev>; Sat,  7 May 2022 00:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651884553; x=1683420553;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kFGcPMDpA1aXWonyuI/CpKf+v81VoqJiXYMobDw9wMI=;
  b=BjjsRSQzQ9uytIqzxnR2qtF1CPFZag37eeB+QiYaJ3J0+rfsO7Wbj28V
   e04uhS0Y800fPe2FjxSIB78p2jKk+EYhwswFow7wn1OsqkTD1PjLLJRop
   vwvv/BNqBZPs/665EZ5hqs4ykZffNkVsasgFQu/NP7d941o9qZg1kSsKa
   5AaNgz7NZyCcPwnO8jNgW7H+dpEFbYfQq9/VoQJ3GebCP5SmzSxDJwQBn
   y2fw8GDX8XZ0wiYP0pE2wMR0cVHhf8D6e2Y3IqaD+6O28ldoUmQkpAl4S
   pf2yb7EAdIA+VnnB74L7PngpT6dMN+e9Zddcudf2cq83fRmFqhzN1B8iE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="355051259"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="355051259"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 17:49:12 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="622053702"
Received: from jrbond-mobl1.amr.corp.intel.com ([10.212.218.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 17:49:12 -0700
Date: Fri, 6 May 2022 17:49:11 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Maxim Galaganov <max@internet.ru>, Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
Subject: Re: apropos
 https://github.com/multipath-tcp/mptcp_net-next/issues/265
In-Reply-To: <d7497da1-86e4-30ae-aca-633b71facdcd@linux.intel.com>
Message-ID: <3e24164-f9c0-29f3-d012-b97255571d4@linux.intel.com>
References: <3e23ea866374467e2c9aeec60049716b42d6634e.camel@redhat.com> <c1513b33-add8-3e16-d14d-0b1886061040@internet.ru> <e69d4d2bead08317ad3af55ffe415b8f94877948.camel@redhat.com> <3c85fe48-69fe-0655-2146-a4424e02f185@internet.ru>
 <d7497da1-86e4-30ae-aca-633b71facdcd@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 5 May 2022, Mat Martineau wrote:

> On Wed, 4 May 2022, Maxim Galaganov wrote:
>
>> On 04.05.2022 12:52, Paolo Abeni wrote:
>>> 
>>> Could you please additionally test the following patch? Kernel for both
>>> arches must be rebuilt.
>>> 
>>> This should cause old x86 build with csum enabled to fallback to TCP
>>> while interoperating with new ones, which is ugly and bad, but - given
>>> that csum is disable by default - possibly still acceptable?!?
>> 
>> 
>> The results for me are as follows:
>> 
>> old x86_64 (5.17.5) + old mips (5.15.35) => reset
>> new x86_64 (5.18-rc5+patch) vs old mips (5.15.35) => works
>> new x86_64 (5.18-rc5+patch) vs new mips (5.15.35+patch) => works
>> old x86_64 (5.17.2) + new mips (5.15.35+patch) => reset
>> old x86_64 (5.17.2) + new x86_64 (5.18-rc5+patch) => reset
>> new x86_64 (5.18-rc5+patch) talking to itself => works
>> 
>> I edited the patch so that it applies to my kernels, and this might be the 
>> reason I don't see fallback but see reset instead -- I don't have "mptcp: 
>> TCP fallback for established connections" patches in my tree as they are 
>> only in net-next yet. Or I may be doing something stupid.
>> 
>> Is there a way for an old box without infinite mapping support to fallback 
>> an established connection in case of csum failure?
>> 
>
> In some cases, I think we can do that!
>
> Both peers do not consider MPTCP "fully established" until they receive a 
> valid DATA_ACK, and the old box will fall back if the new box sends an 
> infinite mapping in response to the first data. So, if as part of the fix we 
> make sure the new box responds to a bad checksum in the initial DSS (or 
> MPC+DATA) with an infinite mapping instead of a reset, fallback should work. 
> And I think what's needed to do that is to only set subflow->mp_fail at the 
> end of validate_data_csum() if subflow->fully_established is 'true'.

The subflow->fully_established flag in the kernel code is set when the DSS 
is received, and some modifications to set that flag later was not 
compatible with the self tests. So I'm trying something slightly different 
that doesn't depend on that specific flag, but that's still a 
work-in-progress.

>
> However, if the new box is the first to send data with a checksum, the old 
> box decides whether to reset or fallback. It looks like unpatched 5.17, 5.16, 
> and 5.15 would send a reset in this "patched host sends data first" scenario. 
> 5.14 looks like it would fall back? Older MPTCP kernels don't support DSS 
> checksums.
>
> This means that if the use case is a client/server setup where the client 
> sends data first, and the server is running a new/patched kernel, we get the 
> fallback behavior. That's good!
>
>
> This still leaves that "patched host sends data first" scenario that should 
> be addressed. The RFC requires checksums to be enabled if one peer requests 
> it in the SYN/SYNACK handshake. Is it too much of a kludge to use a sysctl 
> that would force TCP fallback if a peer requests checksums? This would be 
> just like the behavior we had in v5.13 and earlier. We could add another 
> state to the existing MPTCP checksum sysctl ("force fallback if checksums 
> requested").
>
>
> --
> Mat Martineau
> Intel
>
>

--
Mat Martineau
Intel
