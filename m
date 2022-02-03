Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255C2F27
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643848726; x=1675384726;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zi1p3dq9Q/O228UMUJlDIA2pKPVfH57qdJYq1k4kSUc=;
  b=Ed3BOWpJyJcHlJsGIAIhdvXG60dtDZccVIOT2E9UMfe7kW1D/Z7LLePu
   EkymYsCIAP2RQeBcg9q75dt+YgWWeRxYt7Ni8KPz5iPTAVTsN0cXuMOtx
   fzz2O+FyY45Vyed8tGB9coxNqKHHfdZ9LAE2tUHWhiKsdj69uxhVJqW67
   ZE70UgeWDiENnN26g1yZdYprk5GjVjEnqoMSxt2f4Uj5JFEQaJtbo99xq
   /Yh6JGvcrOfE2jvLxlGs0hdKA+G4N9pmmodtYGg38DX8gTqG+p60oILUY
   9DqDxzVn9sPiz1ERypIdLzpEtfXqSRfTFEfKIxrHoQDVB8klXlGacO0oc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311354454"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="311354454"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:38:45 -0800
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="523709926"
Received: from lddickin-mobl1.amr.corp.intel.com ([10.212.228.203])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:38:45 -0800
Date: Wed, 2 Feb 2022 16:38:41 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: use nla_parse_nested
In-Reply-To: <8339d9dc-4055-57c9-9c97-9ca4075c7496@tessares.net>
Message-ID: <a83209f-7839-d87f-5d27-fd337cd972c@linux.intel.com>
References: <022caed0c9e5964f525336aced8233338c29386f.1643437533.git.geliang.tang@suse.com> <25250bc9-015e-df2a-582d-5b5dd3eabdcb@tessares.net> <20220130043318.GA7781@dhcp-10-157-36-190> <8339d9dc-4055-57c9-9c97-9ca4075c7496@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 31 Jan 2022, Matthieu Baerts wrote:

> Hi Geliang,
>
> On 30/01/2022 05:33, Geliang Tang wrote:
>> Hi Matt,
>>
>> Thanks for your review.
>>
>> I don't know why this commit didn't show in the patchwork. The CI seems to
>> have complained about it.
>
> It seems the issue was on kernel.org side, now fixed: your patch is on
> patchwork and lore.
>
>> On Sat, Jan 29, 2022 at 12:53:20PM +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 29/01/2022 07:26, Geliang Tang wrote:
>>>> NLA_F_NESTED has been used in both 'pm_nl_ctl' and 'ip mptcp'.
>>>
>>> Was it always the case for 'ip mptcp'? I mean, we cannot break the user API.
>>>
>>> And even if it was always the case for 'ip mptcp', there could be other
>>> tools not using NLA_F_NESTED. Maybe we can ignore them in this specific
>>> case but I'm not sure.
>>
>> I think now is the right time to switch to the new API: nla_parse_nested.
>> Since now no other tool uses our mptcp netlink yet, only 'ip mptcp' and
>> 'pm_nl_ctl'. There's no need to consider about the compatibility.
>
> I would like to only consider Open-Source tools but I don't think we
> can. It is unlikely someone wrote a new tool not using NLA_F_NESTED but
> I don't think we can be 100% sure. This is an uAPI break to change this
> I think, no?
>
>> The old
>> API - nla_parse_nested_deprecated - is reserved for the compatibility of
>> the netlinks that already have some user tools using its interface in the
>> non-NLA_F_NESTED way. We are not the case.
>>
>> Switch to the new API can force the user tools to use the NLA_F_NESTED way
>> from now on. That makes sure no user tool uses the non-NLA_F_NESTED way for
>> our mptcp netlink. Otherwise, one day the old API will be abandoned, and
>> then if there're some user tools use the non-NLA_F_NESTED way, we will have
>> to deal with the compatibility at that time. If we switch to the new API
>> now, we can avoid this potential trouble.
>
> I guess the compatibility will need to be kept of a bit of time. This
> function is used in 250+ places in the kernel. I guess it has the
> "deprecated" word in the name to clearly indicate "you should not use
> that for new features" but not to say "in a few months, we will drop
> this, deal with it now.", no?
>

It seems like the meaning of "deprecated" is the former ("don't add new 
calls to this")... but we did add our use of the function in 2020 after it 
was already deprecated! Given the "do not break userspace" rule for kernel 
changes, I don't expect the deprecated to go away and for now I think 
we should leave it unchanged. When we discuss patches at this week's 
meeting I'll see if others agree.

> It would be easier to use nla_parse_nested() instead of
> nla_parse_nested_deprecated() but I don't think we can.
>

--
Mat Martineau
Intel
