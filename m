Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882821401B
	for <mptcp@lists.linux.dev>; Mon, 29 Jan 2024 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555772; cv=none; b=M5SZQQUjswjvAgMKTiYnMdhxoJx5v0bi3LImVgmWOwxMPV04AM2gfu57kN7f8ywlz9ZhGICAIqIEZDyapzr6012KwmP82AlNvYypsu2266Rpu8Plw91etT/OXU6iA3yxHVk9x7R4xnuevNvU9Ru05Q3jSV6uGsBiGQPeks8QzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555772; c=relaxed/simple;
	bh=eW/ohUfY6+t13AZNYiM07W89GbwzhBKiAEVZlBwD/vc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eBlBvIv8Edl2QU3rLRxA7Lf/lsy/0sFq7dN7Cn4GY5jVAq+zBWk3Pka8UqCpdWIK+QfLV29brjSEhpCtybnAnH2OeUweSUO/7+j9pb+byIcCUVPAXfUYjZ0X79seKc9lpIBIhJAgQIUm/fdGoPAt77JHnB0BhioXo7AIOyuAp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhK/IIfh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhK/IIfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B57DC433C7;
	Mon, 29 Jan 2024 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706555772;
	bh=eW/ohUfY6+t13AZNYiM07W89GbwzhBKiAEVZlBwD/vc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OhK/IIfhE9/GNtQgp/jVms3aYmiXzbJU9I8dgLbzJn9iELX9grGjA2tkq8GyyHCdN
	 uoFVm+pWY0vjp8sKV4gw/XOuWzlveSQ+ZpGdjr4tXtZgKX+4jHzM6A0DqmKJFgzjhF
	 83Bh0lJXqt56yBEQGt+kF0Jz70XVMw5kvEqW5u84TpJGu1x1iOuWdQbKkWEWXGB0VA
	 Qt1PQtpyJDAc143hbJOvSbIezLQhfMgTKV4iaXIPrcEZN4IE88nvel/XphJkF3Ew+w
	 p9qf5tpUUExBwgGDtWhk9pYINGVHcyHWpgSURkbpFBs3ypWWnEo1tMOaRtiuVd+Yy9
	 fOTzZS+CeakLQ==
Date: Mon, 29 Jan 2024 11:16:11 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: really cope with fastopen race.
In-Reply-To: <482549332bcc96a8b4dd37292cb289b271b49511.camel@redhat.com>
Message-ID: <32222760-1d3f-5acb-63b5-774e7968741c@kernel.org>
References: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com> <89ef77af-b4b5-8674-52e0-92405a0c0ea9@kernel.org> <482549332bcc96a8b4dd37292cb289b271b49511.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 29 Jan 2024, Paolo Abeni wrote:

> On Fri, 2024-01-26 at 17:18 -0800, Mat Martineau wrote:
>> On Wed, 24 Jan 2024, Paolo Abeni wrote:
>>
>>> Fastopen and PM-trigger subflow shutdown can race, as reported by
>>> syzkaller.
>>>
>>> In my first attempt to close such race, I missed the fact that
>>> the subflow status can change again before the subflow_state_change
>>> callback is invoked.
>>>
>>> Address the issue additionally copying with all the states directly
>>> reachable from TCP_FIN_WAIT1.
>>>
>>> Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
>>> Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
>>> Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>
>> I wasn't able to reproduce the CI failure, and the change looks good to
>> me. We'll see if CI is happy when this is applied to export-net.
>
> I used the repro provided by syzbot upstream:
>
> https://lore.kernel.org/netdev/000000000000e8ecae060fae7a47@google.com/
> https://syzkaller.appspot.com/x/repro.c?x=17abc23be80000
>
> with my default debug config, and here it reproduced the issue reliably
> on the unpatched kernel (and no splat with the patched one).
>

I was not very specific in my wording: I was referring to the CI failures 
when it applied this patch to export-net:

https://lore.kernel.org/mptcp/482549332bcc96a8b4dd37292cb289b271b49511.camel@redhat.com/T/#mfb81b40b8a42912362eede622b5a15b17313d2a2

...not the failure reported by syzbot that this patch is intended to fix.

I did run export-net plus this patch through the 
mptcp-upstream-virtme-docker environment and it worked fine, so I think 
it's ok to apply.

- Mat
