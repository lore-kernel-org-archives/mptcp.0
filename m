Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5089F4C64
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645223861; x=1676759861;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iBriAZoCSv2Mg4UFBngGUysKoVw12BB0Ar5aHjjsWoc=;
  b=WbmrjiquxSOnC45e8Kzh+6BcDlW/WyhU0nMEtlCv2b6PIFabzkuhuGOV
   3lJbablDfypvcJML2X/mXFFYLN1q5o7q4WinbV1Y/PJHZvoN2oe7BpOyW
   R9WXO11N+MDNy1BWRfenDhx5Gh03QDv+Yy4/5lJBxhCv6kdDr7X+8NeFX
   D6uOMpWbTU4+xzNjHoX/nQMHjXsPEjJMRYA5BGFWvNh2BmR3pX27ZlxYj
   69aOakyb1hauY2EAzryTHL5f9wkM7paL2V8y6D9DLWd7cdfbH/EiUy/ZL
   os0cqpXvK6S1qkVUXDjxML1AKXKx1cV9ZpjShj7JE8Nk1K+PzN9dYIIry
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="248820946"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="248820946"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:37:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="778137332"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 14:37:40 -0800
Date: Fri, 18 Feb 2022 14:37:39 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/9] Refactor mptcp_join.sh
In-Reply-To: <c906d5d7-976d-e956-81c1-c06223c0b858@tessares.net>
Message-ID: <f3c2e0ed-a93d-2fda-9c43-82b4e9133795@linux.intel.com>
References: <20220217174329.826430-1-matthieu.baerts@tessares.net> <ffdf6780-5cc7-bde4-586e-eb36c7a409d@linux.intel.com> <808f443ae9db49c2e5bc69a2285f230d5369853c.camel@redhat.com> <a58fd624f7261abfe417f27b92dc906aab5fb22f.camel@redhat.com>
 <b53e8f70-dfb9-b587-5ac2-76d2e92272f1@linux.intel.com> <c906d5d7-976d-e956-81c1-c06223c0b858@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Feb 2022, Matthieu Baerts wrote:

> Hi Mat,
>
> On 18/02/2022 19:59, Mat Martineau wrote:
>> On Fri, 18 Feb 2022, Paolo Abeni wrote:
>>
>>> On Fri, 2022-02-18 at 12:04 +0100, Paolo Abeni wrote:
>>>> On Thu, 2022-02-17 at 16:33 -0800, Mat Martineau wrote:
>>>>>> Patch 4/9 is the updated version of the previous patch 3/9 from v1:
>>>>>> mainly
>>>>>> rebased. I only added one line in the "usage()" function and use
>>>>>> lower cases for
>>>>>> only_tests variable.
>>>>>>
>>>>>> Patch 5/9 is new and similar to the previous patch: another way to
>>>>>> execute a
>>>>>> specific test, useful when using 'git blame'. Also help to have
>>>>>> patch 6/9.
>>>>>>
>>>>>
>>>>> These are running fine for me, it's just the issue of 2000+ lines of
>>>>> churn
>>>>> and the potential (or even likely) net/net-next merge conflicts if
>>>>> we need
>>>>> to modify mptcp_join.sh after the 5.18 merge window. Hopefully all the
>>>>> work we're doing now to stabilize the tests means we will not have
>>>>> as many
>>>>> -net mptcp_join.sh changes in the next cycle, but we would still
>>>>> probably
>>>>> run in to some headaches. If we do apply these it would need to be
>>>>> right
>>>>> before net-next closes for 5.18.
>>>>>
>>>>> Since you've put this much work into this patch it implies that you
>>>>> think
>>>>> the merge headaches would be worth it for the 5.18 development cycle :)
>>>>> For the way I use the test script the ability to test by number is not
>>>>> that critical - is anyone else (Paolo?) thinking you'll use this
>>>>> feature?
>>>>
>>>> That feature would have saved a significant amount of my time in the
>>>> past weeks. I think the diffstat is a bit too much, and I still would
>>>> prefer the other approach of filtering out the test in each helper used
>>>> by the test themself.
>>>
>>> Uhmmm... my main argument vs the current version of patch 4 is defeated
>>> by patches 5 && 6, which look useful. So I'm ok with patch 4 as is...
>>>
>>
>> Ok, thanks for the insight! I do like the features, just wanted to make
>> sure there's enough interest to justify the conflict resolution work
>> we're signing up for. And it does seem like the payoff is worth it. At
>> least it's a selftest script and not kernel code that could be disrupted
>> by incorrect git conflict resolution here :)
>
> I think it is the good time to do that when you look at the diff with
> the -net branch: a lot of other modifications in the same area have been
> queued up in net-next :)
>
>>>> Additionally, I think it would be nice replace the 'bare' ip netns exec
>>>> ...' we still have in some the userspace tests with the appropriate
>>>> helpers - possibly worth a separate, independent patch.
>>>
>>> ... still think it would be nice (almost necessary) cover the above ->
>>> migrate all direct ip netns exec... usage to the appropriate helper.
>>>
>>
>> Sure, that would be good too.
>>
>> Matthieu, I think it would be good to delay adding 4/5/6 to the export
>> branch until mptcp_join.sh has stabilized in -net and been merged back
>> to net-next - what do you think? Once these changes go in to the export
>> branch we have a lot less flexibility in the order that patches go to
>> net-next.
>
> Sure I can. Do you mean waiting for the other patches that are in review
> to fix issues in the tests?
>

Yes, that's part of it.

I can't send these for net-next until after these patches show up in 
net-next (via merge from -net):

https://lore.kernel.org/netdev/20220218213544.70285-1-mathew.j.martineau@linux.intel.com/T/

Any groups of patches touching mptcp_join.sh after these major-churn 
patches in the export branch would be blocked from net-next upstreaming 
until net/master and net-next/master are synced again.

Also, any mptcp_join.sh development work on the export branch would have 
similar dependencies. But I probably shouldn't worry about that too much.

> I was thinking about that and I don't know if we need to wait: we
> already have the commit 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp
> wrappers") in net-next and there is no patches for -net that are
> currently planned if I'm not mistaken.
>

-net patches are rarely planned :)

> If we still want to send them to net-next later, I can also apply these
> patches after "git markup: features net-next": so just after new patches
> that will come in the next days/weeks.
>

That should work. Thanks!

Also, to be clear for patches 4-6:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
