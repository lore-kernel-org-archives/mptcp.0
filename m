Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467D324B33
	for <mptcp@lists.linux.dev>; Sun, 30 Aug 2026 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123606; cv=none; b=urOGc170w21jTWO2jIA/SabrSgGY0Uv30+0dlGbAN3se0DcNHkp1Mn7WeuLFSG+oFXjSw1Ea4xXZhcG/1haHvWjsVTiOpDSEoDTQIVRzq+2i/+pYY8arvX0fB6m4xj/jEhKinZK0wCSy/L4hXZyznPNO3woldoL6JD2/VwWc6D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123606; c=relaxed/simple;
	bh=1yttG0jU1ckvSVSr1wvUm8oADgDV41Q2sqa/w62c90E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qWrZB9iKf6iSEl40291eBHjpOuFma8XSt4bLnL5F/qgPlwPFGY8yzk/X9IIH0h7KH4kTC4fwdouZcEfC3c0TFA31cic16KvLRGABpdetRJrILdigE2YV6t9goZsSHqscTdZ6AfFvyuu+13qoseiRbHqT7e/h87YY/pBWaMyfVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbNCQael; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbNCQael"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFA11F00A3D;
	Sun, 30 Aug 2026 21:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123605;
	bh=wcE9jZgw6nHW/yGtxLX9BMSHOZ9s/JXfnatcqPq1gJo=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=nbNCQaelStU1aYplQvTb+AflXRkkUVjFXb+R5623v7WEzj7ZW0AzSF67eI1+vFD6l
	 fusE1odgAp6m3mdA554UmESnRyhRklZATf9DTGFBTA3p9F2Zcx8TGb80E4sAlAWMmF
	 fYehJrb/HeVJeBDmzKvjVObokYvXwgLB+Fa3IO3kGqafE+e27SJpdALBi45CiB0ATH
	 Fp1SiEbpT0U1eVR3Zr3kqbdnAnzxwNvnFgpc0mzip8FBFxDKzMHrpK1rrAaViAkQC3
	 IVuGHksGGag3yNC51/WCpamkKxu+qh4cW/VlTFEU3woXpJN0LRGKWirq2HxuO009fR
	 flSA5Bd+RjqWA==
Message-ID: <987ee3fe-6533-4739-8181-4367302cac63@kernel.org>
Date: Sun, 30 Aug 2026 23:00:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v3 2/8] mptcp: pm: userspace: lookup: match port
 in priority
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260807-mptcp-pm-userspace-id0-case-v3-0-de9088549924@kernel.org>
 <20260807-mptcp-pm-userspace-id0-case-v3-2-de9088549924@kernel.org>
 <7bf7a43655610da952266aa7bfbec76a1dcb5f22.camel@kernel.org>
 <b1710700-0755-4f74-a6db-cfaa7f28a057@kernel.org>
 <bb74f942d14b1335bd5be83ca8b2c750cc8063b5.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <bb74f942d14b1335bd5be83ca8b2c750cc8063b5.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 30/08/2026 06:43, Geliang Tang wrote:
> Hi Matt,
> 
> On Wed, 2026-08-19 at 09:56 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> Thank you for the review and suggestion!
>>
>> On 19/08/2026 09:23, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> On Fri, 2026-08-07 at 10:41 +0200, Matthieu Baerts (NGI0) wrote:
>>>> In the local address list, there can be entries with the port set
>>>> to
>>>> 0
>>>> -- corresponding to the source port used by the initial subflow -
>>>> -
>>>> and
>>>> others with a specific port.
>>>>
>>>> When performing a lookup, it is important to compare the ports to
>>>> pick
>>>> the right entry: when a specific port is given, then try to match
>>>> it
>>>> first. If no match is found, try to find entries with the port
>>>> set to
>>>> 0.
>>>>
>>>> Fixes: 24430f8bf516 ("mptcp: add address into userspace pm list")
>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>> ---
>>>> v3: new (Sashiko)
>>>> ---
>>>>  net/mptcp/pm_userspace.c | 14 +++++++++++++-
>>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>>> index 663cbeb79548..3f1471ec3fc7 100644
>>>> --- a/net/mptcp/pm_userspace.c
>>>> +++ b/net/mptcp/pm_userspace.c
>>>> @@ -33,10 +33,22 @@ mptcp_userspace_pm_lookup_addr(struct
>>>> mptcp_sock
>>>> *msk,
>>>>  {
>>>>  	struct mptcp_pm_addr_entry *entry;
>>>>  
>>>> +	/* Compare ports when set in addr */
>>>>  	mptcp_for_each_userspace_pm_addr(msk, entry) {
>>>> -		if (mptcp_addresses_equal(&entry->addr, addr,
>>>> false))
>>>> +		if (mptcp_addresses_equal(&entry->addr, addr,
>>>> addr-
>>>>> port != 0))
>>>>  			return entry;
>>>>  	}
>>>> +
>>>> +	if (addr->port == 0)
>>>> +		return NULL;
>>>> +
>>>> +	/* Check only wildcard ports if no exact match with the
>>>> port
>>>> */
>>>> +	mptcp_for_each_userspace_pm_addr(msk, entry) {
>>>> +		if (entry->addr.port == 0 &&
>>>> +		    mptcp_addresses_equal(&entry->addr, addr,
>>>> false))
>>>> +			return entry;
>>>> +	}
>>>> +
>>>>  	return NULL;
>>>>  }
>>>
>>> Personally, I think a single-pass lookup is better than a two-pass
>>> one.
>>
>> Indeed, I initially thought the code wouldn't be very readable, but
>> maybe worth it.
>>
>>> I've implemented a version and it passed the tests:
>>>
>>> static struct mptcp_pm_addr_entry *
>>> mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
>>>                                const struct mptcp_addr_info *addr)
>>> {
>>>     struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
>>>     struct mptcp_addr_info match;
>>>
>>>     mptcp_for_each_userspace_pm_addr(msk, entry) {
>>>         match = entry->addr;
>>
>> Mmh, but now there is a copy for each entry. Not sure what's better.
>>
>>>         if (match.port == 0 && addr->port != 0)
>>
>> (Would it not work to add this condition to the last argument of
>> mptcp_addresses_equal()? → EDIT: no, see below)
>>
>>>             match.port = addr->port;
>>
>> It feels wrong: entry->addr.port == 0 should mean "same port as the
>> msk"
>> (inet_sk((struct sock *)msk)->inet_sport). But this "addr->port" is
>> possibly yet another port.
>>
>> In other words, I think doing that here means accepting the first
>> wildcard one. An example: ID0 is now the first entry, if there is
>> another IP with another specific port, it should be picked in
>> priority.
>> With this code here, I don't think that will be the case: the ID0
>> entry
>> will be picked instead, no?
>>
>> (I think we should have a test with the userspace PM announcing the
>> same
>> address but with another port + doing the listen for this port
>> manually,
>> and checking the IDs being used: shouldn't be 0)
>>
>>>         if (mptcp_addresses_equal(&match, addr, addr->port != 0)) {
>>
>> What if we always call mptcp_addresses_equal without the port check,
>> and
>> do that "manually" here below?
>>
>> -> Return if the port is the same, then save it as wildcard if one of
>> them has no port set.
>>
>> Even there, it feels like the comparison should be stricter: if one
>> port
>> is 0, either the other one is 0 (port is the same, already checked
>> then)
>> or equal to the msk one. I think I quickly tried this at some points,
>> and it was causing issues, but I didn't investigate. Maybe the tests
>> are
>> wrong (mixing up IDs) or there is another bug somewhere... Do you
>> mind
>> looking at this if you have the opportunity, please?
> 
> Apologies for the delayed response.

No need to apologies, it's still way quicker than most of my replies :)

> I've revised the implementation to the following version:
> 
> static struct mptcp_pm_addr_entry *
> mptcp_userspace_pm_lookup_addr(struct mptcp_sock *msk,
>                                const struct mptcp_addr_info *addr)
> {
>         struct mptcp_pm_addr_entry *entry, *wildcard = NULL;
> 
>         mptcp_for_each_userspace_pm_addr(msk, entry) {
>                 if (mptcp_addresses_equal(&entry->addr, addr, false)) {
>                         if (!addr->port)
>                                 return entry;

Even if that's similar to what I did in my patch, should this not be a
wildcard either?

It seems that it should be:

  if (addr->port == entry->addr.port)
      return entry;

  if (!wildcard && (!addr->port || !entry->addr.port))
      wildcard = entry;

No?


It feels that it should even be without the "wildcard":

  __be16 msk_sport = inet_sk((struct sock *)msk)->inet_sport;
  struct mptcp_pm_addr_entry *entry;

  mptcp_for_each_userspace_pm_addr(msk, entry) {
      if (mptcp_addresses_equal(&entry->addr, addr, false)) {
          if (addr->port == entry->addr.port)
              return entry;

          if (!addr->port && entry->addr.port == msk_sport)
              return entry;

          if (!entry->addr.port && addr->port == msk_sport)
              return entry;
      }
  }

  return NULL;

But I just remembered we need to handle the case where a subflow got
created without forcing the source port: we used the same ID as another
subflow, and we still need to match it, even if here the source port is
likely not the same as the msk one, but that's OK. So we need this
"wildcard".

So thank you for the new suggestion, I will take it with the
modification I mentioned, if that's OK for you.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

