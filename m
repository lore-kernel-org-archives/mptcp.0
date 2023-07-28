Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC01BB37
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 18:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE5C433C7;
	Fri, 28 Jul 2023 18:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690568622;
	bh=y+S5ZuzRqN9GAnRVckqeco07cn6B3+SHiezqG6WFeNc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J30VAusKTCsw57c9rPYUH1AMlMzoqS+xNEedbH85AizYioxwVV7Ul4SvQ36GhFWA5
	 koufAg084x+f7LnermbRmuy3wiYVb0dhlDjhSfSW/IuS7+k9bm6ho4NB91nwcm3EHQ
	 p2nvii87uxQ/v0+esP/6ZMJ6b6AsZKvw8kcggP0be3UnawNA7JDKFYiWxuYD1xbaI9
	 rgVW2/BBB03v9xgXXTGJXRABAnJIYtuqoo0t/3m4vWKGfyMC5VrsSxBdJrGMbMbNW2
	 BvpDgAweW46UqvfHuPWWJset7cxwJttqkTKbJGxYQoibNC5+NZgga2S52lPmLaJZMq
	 6EJehV4vIV++Q==
Date: Fri, 28 Jul 2023 11:23:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 08/13] mptcp: add subflow_set_stale
 helper
In-Reply-To: <b9ca829c-790f-82bf-f0a9-c0d81792ce01@tessares.net>
Message-ID: <b2e609ac-d848-88bf-cca2-e635d7ca5ec2@kernel.org>
References: <cover.1689650435.git.geliang.tang@suse.com> <94b445b3225d4f91e2d05cab0338c4367ecbabb4.1689650435.git.geliang.tang@suse.com> <f678a249-e191-05ca-012f-28811c520b51@kernel.org> <b9ca829c-790f-82bf-f0a9-c0d81792ce01@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1772668913-1690568622=:84334"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1772668913-1690568622=:84334
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 28 Jul 2023, Matthieu Baerts wrote:

> Hi Mat,
>
> On 28/07/2023 03:30, Mat Martineau wrote:
>> On Tue, 18 Jul 2023, Geliang Tang wrote:
>>
>>> Add mptcp_subflow_set_stale() helper.
>>>
>>
>> I was trying to remember the use case for this. The closest thing I can
>> find is this:
>>
>>     => the scheduler should be able to interact with the "stale" logic
>>        we have in the upstream kernel: mark a subflow as stale / back
>>        active.
>>
>> from
>> https://lore.kernel.org/mptcp/dd4363e7-d057-97e8-0b5f-8570f39aa538@tessares.net/
>>
>> I think that need is met by the change in patch 11 to export
>> mptcp_pm_subflow_chk_stale - if a particular scheduler wants to track
>> some stale-like metric, it can do so with its own sk_storage values.
>> There's also the matter of coordinating the values of stale_count and
>> stale_rcv_tstamp.
>>
>> My suggestion is to drop patches 8, 9, and 10 unless there's a
>> compelling reason to allow a BPF scheduler to control this bit. If
>> there's a need for it please speak up!
>
> If I'm not mistaken, the 'stale' logic is currently used by the core not
> to use a subflow (when calling mptcp_subflow_active()). A packet
> scheduler might want to proactively mark a subflow as stall, e.g. if the
> latency is too high, too many retransmissions, etc. and just set the
> subflow as stale.
>
> But maybe we cannot do that because the core will reset stale in some
> conditions? Maybe we need something similar but not reusing "stale"?
>

That's what I'm thinking, yes. Individual BPF schedulers could create 
their own "skip this subflow if possible" variables in their custom 
sk_storage structs, and those would not have the complex interactions with 
stale_count and stale_rcv_tstamp.


- Mat
--0-1772668913-1690568622=:84334--
