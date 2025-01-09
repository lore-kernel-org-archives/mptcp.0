Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B7C20551B
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425209; cv=none; b=bkzlkN7PinzfLfk6xIHKv4OSouHVQtcSsW8L2uJF82gmLOdXwhUGf2Jeshvj0SmYqJARexop5QYmUXb9+df5Qf7gBS7iTmIHmJzKoG6fweE1Ia5DOSy84bdOsOz8QdZQn3KTRwNbAEKbYenxw6HB0j6baporc5SwgwcHJccEoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425209; c=relaxed/simple;
	bh=oSZkhDcy/wTygWRX3ru3pofK6WXLe/kAWxM/Pv4sbAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ICZJ7T0fqqqt62JxR/5gay4F7hkj2p71c9q8EA4P1C0QEBEau8KqefCOGZO79o5RlFsBhczzJsJi4Lqjp7zX8PSdjLjqQAoFjRDjguK6RljqJO58dTK5gb5HSfm+cjB8mR6QpzrVtRm03beEP3eBohE1ZjBQbPlM10+d7NI4+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9wKVNNY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9wKVNNY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8FEC4CED6;
	Thu,  9 Jan 2025 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736425209;
	bh=oSZkhDcy/wTygWRX3ru3pofK6WXLe/kAWxM/Pv4sbAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E9wKVNNY8ps/aKnD/HFcsYR4RVI1y7eD6evSYnjIN2ye4m0n8MmDBPk9G9N6ziJok
	 kLsC9BgfKKg8t4zW2onMdCwgovRm9TQZfOqtSJA5LLHX3ibGrFRTk5PzWXh0Hqw7kd
	 j/vK/bDiPGhWZ5DHcblIM31AmaefkTBh1UaElVlID65QKSVTRRdp3kDvL6Mu85O4eD
	 kFnRsvCBTw/0tieJj9xUKvMfM1ebGhExTdJO5X2fIOZdQIpZIJG+bzFUzAwiC8foRt
	 DaJ+4uTRZJKdmg8xQFnBSfqQx5ZoDf38EkJkL+ncBzyV8txsjJO9wIsDfpmceCRzCS
	 da7w5Y8hQVofA==
Message-ID: <9f8c7031-4f5d-4195-93de-e23491799367@kernel.org>
Date: Thu, 9 Jan 2025 13:20:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 5/8] mptcp: userspace pm set_flags id
 support
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736308884.git.tanggeliang@kylinos.cn>
 <30061158e34c4fbf9063150e6aec40c0eed42b6b.1736308884.git.tanggeliang@kylinos.cn>
 <f3e45b8c-54e4-44af-bad2-63b6221cbcf0@kernel.org>
 <3284b879-8844-4324-ae92-970c4fe5d686@kernel.org>
 <51c240cd267760b883bd2749e0a01be5854f62a9.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <51c240cd267760b883bd2749e0a01be5854f62a9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for your reply!

On 09/01/2025 04:40, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for the review!
> 
> On Wed, 2025-01-08 at 19:51 +0100, Matthieu Baerts wrote:
>> On 08/01/2025 19:47, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 08/01/2025 05:21, Geliang Tang wrote:
>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>>
>>>> Similar to in-kernel PM, this patch adds address ID support to
>>>> set_flags()
>>>> interface of userspace PM, allowing it to work with either an
>>>> address or
>>>> an address ID.
>>>>
>>>> When an address ID is used,
>>>> mptcp_userspace_pm_lookup_addr_by_id() helper
>>>> is used to look up the address entry in the local address list
>>>> instead of
>>>> using mptcp_userspace_pm_lookup_addr().
>>>
>>> Mmh, I'm still not sure about that. As I was saying in [1], if I'm
>>> not
>>> mistaken, with the userspace PM, it is possible not to find any
>>> entries
>>> here, e.g.: if a subflow using this address has not been added or
>>> the
>>> address has not been announced. (I guess the initial address is not
>>> there then).
> 
> The previous version (in [1]) did have this issue and userspace_pm.sh
> tests would fail because of it, but this new version has fixed it.
> 
>  mptcp_pm_nl_mp_prio_send_ack(msk,
>                               entry ? &entry->addr : &local->addr,
>                               remote, bkup);
> 
> When the entry is not found, we continue to pass local->addr to ensure
> the same behavior as before.

Yes indeed, the tests are fixed, but if 'entry' is NULL, the address you
will give will be empty, so it will not be able to find any subflow to
send the MP_PRIO, right?

>>> Do you think this patch is worth it? Setting by ID for the in-
>>> kernel PM
>>> makes sense: unique ID for the netns, easier to type the ID than
>>> the
>>> full address. While for the userspace PM, it will be managed by a
>>> daemon
>>> that will have to track addresses anyway.
> 
> I think it's still useful to extend this functionality while the
> original behavior is not affected, at least it doesn't hurt.

I'm sorry, I think it is not that simple: if we extend this
functionality, it means we will have to maintain it. Here, the interface
looks buggy because it will not work with all addresses: the initial
ones, the ones not announced but implicitly used, etc.

If the interface does not always work, I don't think we will recommend
using it, then why do we need to maintain it?

> We cannot assume that userspace PM is always managed by a daemon. We
> have exported its interfaces to BPF. We allow users to customize path
> managers. That means we also allow users to use their own userspace PM
> in any way.

I think the BPF PM is different: it is a different interface.

To interact with the userspace PM, it is required to monitor the MPTCP
events sent via Netlink, e.g. to get the token. When a new subflow is
created, the userspace will know which addresses (including the ID) it
is linked to. In this case, why only setting the ID in the address
structure if it doesn't always work, while setting the address will
always work as expected.

> Another consideration is that we need to maintain the consistency
> between in-kernel PM and userspace PM.

Not really: when they can do the same thing, yes, but the two interfaces
are different. We don't have to keep the consistency if it doesn't make
sense to do so.

> For ease of maintenance, we need
> to make these two PMs use the same code as much as possible, and only
> abstract their differences through PM interfaces such as get_addr,
> dump_addr, set_flags, etc.

Yes but there are some limits: if some code is shared between multiple
interfaces, it is important not to break one of them when changing the
code. In other words, if the behaviour is very similar (e.g. get_addr),
that's fine. But if they start to be too different, you have complex
common code where you need to think "OK, this one acts like that, but
the other one like that", and complexity is not good for the
maintenance. In this case, it sounds better to keep them separated.

> At present, the biggest difference between
> the two is that they use different linked lists (pernet-
>> local_addr_list vs. msk->pm.userspace_pm_local_addr_list) to store
> address entries, so we only need to put the code for operating the
> linked lists into the interfaces of each PM. This is also the goal of
> adjusting the pm interfaces in this series.

Yes, but that's not the only difference, because the interfaces are
different.

With the in-kernel PM, we act per netns, while with the userspace PM, it
is per connection. Because of that, addresses lists are managed
differently, leading to different concept, e.g. the list not having all
addresses, the addresses not having ID 0 in one, but OK in the other,
etc. With shared code that acts for both of them, you need to keep
thinking about these differences when reading or writing code, and
that's a source of error I think.

>>> Or in other words, do you have a use-case for this? To me, it looks
>>> like
>>> "yes, you can only set the ID, but it might not always work". Then
>>> maybe
>>> better to always set the full address, no?
> 
> If you're worried that this functionality isn't covered by tests, I've
> added a test that covers it in BPF path manager selftests:
> 
>         err = userspace_pm_set_flags(token, addr, "backup");
>         if (!ASSERT_OK(err, "userspace_pm_set_flags backup"))
>                 goto close_accept;
> 
> 	...
> 
>         err = userspace_pm_set_flags_by_id(token, 100, "nobackup");
>         if (!ASSERT_OK(err, "userspace_pm_set_flags_by_id nobackup"))
>                 goto close_accept;

I would need to check the BPF PM interface, but for me the userspace PM
and BPF PM interfaces don't have to be the same, e.g. why having a dump
if the BPF PM can directly access data from the kernel? Same here for
the ID: it depends if all IDs are tracked in the corresponding list,
e.g. it might not be the case with an "announced" list.

But also yes, if something is exposed to userspace (via Netlink), it
should be covered by a test (using the userspace Netlink interface)

>>>
>>> [1]
>>> https://lore.kernel.org/mptcp/d01d0e8a-5606-4152-aabe-32e4402adeeb@kernel.org/
>>
>> Note: if we drop this patch (I think it is better), maybe patch 8/8
>> is
>> not worth it: not to have a "common" section with plenty of 'if
>> (token)', no? Or do you really need them for the BPF PM?
> 
> Here we are only adjusting set_flags interface of in-kernel PM and
> userspace PM, which has nothing to do with the BPF PM implementation.
> 
> It seems that moving the code in mptcp_pm_nl_set_flags_doit() to
> mptcp_pm_set_flags() can remove these 'if (token)':
> 
> int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info
> *info)
> {
>         return mptcp_pm_set_flags(info);

I'm not sure whether it is useful to have one function simply calling
another function that is only used once.

> }
> 
> static int mptcp_pm_set_flags(struct genl_info *info)
> {
>         struct mptcp_pm_addr_entry loc = { .addr = { .family =
> AF_UNSPEC }, };
>         struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
>         struct nlattr *attr_loc, *attr_rem;
>         int ret;
> 
>         if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
>                 return -EINVAL;
> 
>         attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
>         ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
>         if (ret < 0)
>                 return ret;
> 
>         if (info->attrs[MPTCP_PM_ATTR_TOKEN]) {
>                 if (GENL_REQ_ATTR_CHECK(info,
> MPTCP_PM_ATTR_ADDR_REMOTE))
>                         return -EINVAL;
> 
>                 attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
>                 ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
>                 if (ret < 0)
>                         return ret;
> 
>                 if (rem.family == AF_UNSPEC) {
>                         NL_SET_ERR_MSG_ATTR(info->extack, attr_rem,
>                                             "invalid remote address
> family");
>                         return -EINVAL;
>                 }
> 
>                 return mptcp_userspace_pm_set_flags(&loc, &rem, info);
>         }

The problem is the same: ↑ is specific to the userspace PM, why moving
the code here in the common section then?

Same for the code ↓.

So at the end, the only common code is the parsing of the local address,
so just GENL_REQ_ATTR_CHECK(MPTCP_PM_ATTR_ADDR) and
mptcp_pm_parse_entry(MPTCP_PM_ATTR_ADDR). Is it worth it?

So if we want to share code, all we can get I think is this:

  int mptcp_pm_nl_set_flags_doit(...)
  {
      (...)

      if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
          return -EINVAL;

      attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
      ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
      if (ret < 0)
          return ret;

      if (info->attrs[MPTCP_PM_ATTR_TOKEN])
           return mptcp_userspace_pm_set_flags(&loc, info);

      return mptcp_pm_nl_set_flags(&loc, info);
  }

Not a lot to share, but at least there is nothing PM specific here,
except to pick the interface to continue with. And yes, that's something
that could be done, but that's not much...

> 
>         if (loc.addr.family == AF_UNSPEC) {
>                 if (!loc.addr.id) {
>                         NL_SET_ERR_MSG_ATTR(info->extack, attr_loc,
>                                             "missing address ID");
>                         return -EOPNOTSUPP;
> 		}
>         }
> 
>         return mptcp_pm_nl_set_flags(&loc, info);
> }
> 
> WDYT?
> 
> -Geliang
> 
>>
>> Cheers,
>> Matt
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

