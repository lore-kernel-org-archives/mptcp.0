Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DCC33E5
	for <mptcp@lists.linux.dev>; Tue, 25 Apr 2023 19:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6033C433EF;
	Tue, 25 Apr 2023 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682451242;
	bh=XYJWcOJO7CWSAZ3zFhVM4yuQgktSCXgeNnwn5evnoSE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Zawx+yohYWiB6MoLiolCl7BYL3etsgjYR8YV1c6JZrPvtgo7a7fndANTU5x7WgMdN
	 WLcudjExowC3o47TZIdnAw98iEeOY0ElDRX8fdk+sUZCOMMi/EnxsFc/xeQERFYzIy
	 Hp2aBlLQ5fWoNGolUCIMsQG5mODpcfgZ8qY8K0WiTB1P0sL6TfjMKtKxoIRG4YCvrF
	 8BThvhKwyfvxrKepb6EFPKB3t8GLpNEJXr8l1Omb9wHjLKdST49CeHDdwf4bscAFq3
	 HXsoeP+4Zq0/Q1z4HkoaHaAQpg0+dc8N1xnCGkzecu9rsvg38glhewPdu4ZFPTAvTS
	 jjRqAEjIwjHrA==
Date: Tue, 25 Apr 2023 12:34:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 00/13] selftests: mptcp: skip tests when features
 are not supported
In-Reply-To: <a6bf07b0-9760-dfce-e1f0-e8bc19d6839e@tessares.net>
Message-ID: <d78c4d66-87e4-ea50-e0f7-e530006d3cda@kernel.org>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net> <03935b76-591d-85af-ad97-62c5ed5acedb@kernel.org> <a6bf07b0-9760-dfce-e1f0-e8bc19d6839e@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 25 Apr 2023, Matthieu Baerts wrote:

> Hi Mat,
>
> On 25/04/2023 01:47, Mat Martineau wrote:
>> On Fri, 7 Apr 2023, Matthieu Baerts wrote:
>>
>>> Selftests are supposed to run on any kernels, including the old ones not
>>> supporting all MPTCP features.
>>>
>>> These different patches add support for older kernels. More similar
>>> checks will be needed but here is a first batch not to have too many
>>> patches (because each patch fixes different commits).
>>>
>>> I tried to minimise the modifications and do the checks from the bash
>>> script not to have to detect the feature when being used in a .c file,
>>> then pass the info to the bash script, skip the test, clean the
>>> environment, etc.
>>>
>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> Hi Matthieu -
>>
>> The "skip if MPTCP is not supported" patches (1-7) and patch 10 (missing
>> ip tool) look good to me:
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>
> Thank you for having looked at these patches!
>
> I was already working on a v2 and these patches will be slightly
> modified. I will not add your RvB tag right now if that's OK.
>

Sure, no problem.

>> I have some comments on patch 8 and related, I'll reply separately on
>> those.
>
> Thank you! I only saw one comment on patch 11/13. Did I miss something?
>

You didn't miss anything - I should have been clearer that I intended for 
the patch 11 reply to address the common issues of the remaining patches 
(8-9, 11-13).


- Mat

