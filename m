Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF293311592
	for <mptcp@lists.linux.dev>; Tue,  2 Sep 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832329; cv=none; b=N/MVbtZkwR4+TH/IbUzsI5fVWRaORaLeGJ8y+o5o41dabv/Sgmc/SkdsZ3UtIPT6Hjk4RRgp9gSZ0rmOiuL7s4R1xrttVElmbRLxnyfylBkENGWBR8RImow9ATuMovRl4lcOjSiGfK44FjGZgpH3Hq6rpvnsk/p3j4Q/64uGDGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832329; c=relaxed/simple;
	bh=mIan9e2oJqbCcamoVhxr5+tlYY7GgQ4fsbjxwWQnFGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdRnIRsUZm1GQtbqDmvOSlR2SL4clVlJSmXeCQoz22jXPprLG/qRzz4JBUewFX1+/GlEqr478ZnTYHw/pHF0PBka43hj39ZaoIiO+5EjG5DDXF9J5yUVdBmtv81qTNuUZd03TRrFmCQflXZuHrwbDlMXv77oGpHNcGRrybPnp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEHP4jaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEHP4jaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32AC4CEED;
	Tue,  2 Sep 2025 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756832329;
	bh=mIan9e2oJqbCcamoVhxr5+tlYY7GgQ4fsbjxwWQnFGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AEHP4jaZbBVvG5kf6ktkkwlvp+jDbd4PiRZ5m6c2bgLCZr7HQDeKQGEWXrdaFlUTR
	 2NsOnwnxHcbffLi3Hfli7syk3WsoTAEJULRXYHZSBnHqfh9kPN5rstLdBpxq4OCCSK
	 BPrYUI+iHGZoTPn/58GGDv2A9W4fIGc5G4rCjxOVNHzXAtkYmQ6sV7qrwB2eae66As
	 n0dnqhSb0GIPKIuY7GGV5Ld24VJXl2vAAyodz8xURcVw4tk0acAX8BA/ooGTxcosE6
	 obdbkjseqOybBHrv6ewBmQflteGQi9OF9CswvJyDkCvkW9LSzgEmtNXm1Bt7MCYn6k
	 NjTNbEePFmHvQ==
Message-ID: <7602f5c9-7d36-4be4-89bf-2d113d4f13a8@kernel.org>
Date: Tue, 2 Sep 2025 18:58:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 2/7] mptcp: pm: userspace: respect deny_join_id0
 attr
Content-Language: en-GB, fr-BE
To: Christoph Paasch <cpaasch@openai.com>
Cc: Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
 <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
 <9de05bc0-fcf6-364f-b143-fb72cb8c4cae@kernel.org>
 <8d4ba38a-e19d-408b-b81d-a75362d170e2@kernel.org>
 <CADg4-L-LPJ1SNHzDVtosn3S-_1Uh9+9YhwThX24+mB9x2LHcDg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADg4-L-LPJ1SNHzDVtosn3S-_1Uh9+9YhwThX24+mB9x2LHcDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/09/2025 18:43, Christoph Paasch wrote:
> On Mon, Sep 1, 2025 at 3:08 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Christoph, Mat,
>>
>> On 30/08/2025 02:58, Mat Martineau wrote:
>>> On Fri, 29 Aug 2025, Christoph Paasch wrote:
>>>
>>>> On Fri, Aug 29, 2025 at 1:33 PM Matthieu Baerts (NGI0)
>>>> <matttbe@kernel.org> wrote:
>>>>>
>>>>> During the connection establishment, a peer can tell the other that it
>>>>> cannot establish new subflows to the initial IP address and port by
>>>>> setting the 'C' flag [1]. The RFC8684 is strict about that:
>>>>>
>>>>>   (...) therefore the receiver MUST NOT try to open any additional
>>>>>   subflows toward this address and port.
>>>>>
>>>>> It is then important not to let the userspace PM establishing such
>>>>> subflows, and return an error (ECONNREFUSED) if it tries to do so.
>>>>>
>>>>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
>>>>> establishment")
>>>>> Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6
>>>>> [1]
>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>> ---
>>>>>  net/mptcp/pm_userspace.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>>>> index
>>>>> 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f66848ea22c971136d6 100644
>>>>> --- a/net/mptcp/pm_userspace.c
>>>>> +++ b/net/mptcp/pm_userspace.c
>>>>> @@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct
>>>>> sk_buff *skb, struct genl_info *info)
>>>>>         if (err < 0)
>>>>>                 goto create_err;
>>>>>
>>>>> +       if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id == 0) {
>>>>
>>>> If userspace wants to, it could still work around that by still using
>>>> the initial subflow's IP-address and just use a non-zero address-ID.
>>
>> Good point, I missed that!
>>
>>>> Is that really a concern ? Sure, the IETF-draft says "MUST NOT", and
>>>> so, shouldn't we leave it up to the userspace PM to make that decision
>>>> ?
>>>>
>>>
>>> I concur with Christoph on this one, I think the PM (userspace or
>>> kernel) is responsible for this aspect of the protocol so it doesn't
>>> need to be double-checked here.
>>
>> Indeed, we could leave it up to the different PMs to make that decision.
>> Initially, I didn't have this patch, and I had a simple patch setting
>> the corresponding sysctl to 0 in userspace_pm.sh, just to check the
>> event was correctly announced. But when writing the last patch's commit
>> message ("mptcp: pm: nl: announce deny-join-id0 attribute"), I realised
>> that the main missing feature was a way for the userspace daemon to know
>> that the C flag was set. We cannot backport patch 7/7
> 
> Why not ? Yes, it is not typical to backport a new netlink message,
> but I think it makes sense here.
> It basically means that the fix involves not only the kernel but also
> the userspace PMs.

Yes, I guess we could backport it.

I still don't know if we should use the (existing but not used) "flags"
attribute, or a new dedicated one.

>> , but we can
>> backport this one, and have a way to know this info on older kernels. I
>> should have mentioned that in the commit message.
> 
> The problem is that even this here is not complete, right ? A
> userspace pm can still attempt to connect to the IP of the initial
> subflow simply by using another address-ID.

Yes, but that's not an issue for me: that's because the userspace PM
didn't use the expected ID, so it is the userspace PM daemon
responsibility :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

