Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765F363
	for <mptcp@lists.linux.dev>; Wed,  2 Nov 2022 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667347902; x=1698883902;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=62lcq6FS5pc/SrcbXyO6E3M3qsRX8lqsmJ/vXD604mM=;
  b=GZVy2xWFzVtBQDCIqqceLJNRzQgJGf7aBfMIxfCU8OWBzZUMqVMOKj6p
   NPT+0LQ357a0hlmmzYGU6CnW8XN+igWrroGlWVKfB3y0ohdRriEB2LO7/
   AKSyqvD1SwWKDu3Ld2LgBZ3RiR0U3If2aAfBcxzECX5Rr0NKOF+Ac2HBq
   KFygrMQ9Z1BMrcicmRAJ+G4/TaPxq8HznDxa5PDuvpvJCUScn907DldaF
   pOmNcbTmgyZxx+STPR6E2r4vTd1rhyjQd5Tm5akzX7o0eSLFOwCStyqyE
   84b7FT4DyqlhQ6+MsH8drMJMKFX76Tnp42UAISsy189Cjy39bDup4ZmsK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371361081"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="371361081"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 17:11:41 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="739532369"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="739532369"
Received: from ckong3-mobl1.amr.corp.intel.com ([10.209.110.122])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 17:11:41 -0700
Date: Tue, 1 Nov 2022 17:11:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: use max_time instead of
 time
In-Reply-To: <9e501292-c3e9-6b3c-9457-407df7fa43ba@tessares.net>
Message-ID: <26d6c1ad-f4c6-49c6-49d9-aba1aafd8b45@linux.intel.com>
References: <20221022133528.31996-1-geliang.tang@suse.com> <2c99f83f-4e2a-9205-7690-2cdde6f2a335@linux.intel.com> <9e501292-c3e9-6b3c-9457-407df7fa43ba@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 31 Oct 2022, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 25/10/2022 02:15, Mat Martineau wrote:
>> On Sat, 22 Oct 2022, Geliang Tang wrote:
>>
>>> 'time' is the local variable of run_test() function, while 'max_time' is
>>> the local variable of do_transfer() function. So in do_transfer(),
>>> $max_time should be used, not $time.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>
>> Looks good to me, thanks Geliang:
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>
> Should this go to -net with a 'Fixes' tag?
>
> Fixes: b6ab64b074f2 ("selftests: mptcp: more stable simult_flows tests")
>
> If yes, I can add do the modifications when applying the patch, no need
> to send a v2.
>

Since the old code works, I think it's ok to just apply for mptcp-next.

--
Mat Martineau
Intel
