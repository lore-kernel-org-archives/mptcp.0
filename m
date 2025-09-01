Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5B730F549
	for <mptcp@lists.linux.dev>; Mon,  1 Sep 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721337; cv=none; b=nbdY8pqYP9TRokQvkcaeEkhSXc7Uq5Jq+iiT2bfPZxCD833kJLQAieCtqyQdpkwKsOanfEGzZ5XPmwCGh7MaGZmojlqF1pAbe0AnoGYm9no2OW70jmr/2ph23BPj4JAii1/zujzSRf61w1igVrOAXu6JgowYaIkdQB52jFAlDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721337; c=relaxed/simple;
	bh=h3EFOgl7vbDyS9f3AHHoAGwDAr2s1fYv+Ej50/6X8Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozSdENhy4EP6MHmfXECOO2nMiPIgWEieRbM7hAaY5me/lLLzYvqLkxoPhusmoMSbd7kOsfIe4E2SUALW0cKyyqnBdqeMVAaTROyTCOVxDUP/RuLEsDcwV7vLRO1HP7pMD0aTpRKyOMYnHOmymKO24iTSqdutk1ni9RKwhSHrhSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjcxogF/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjcxogF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C213AC4CEF4;
	Mon,  1 Sep 2025 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756721336;
	bh=h3EFOgl7vbDyS9f3AHHoAGwDAr2s1fYv+Ej50/6X8Kw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CjcxogF/cozEtKq7V02xCIypMBvnzQoRZhomDeHAROxLJONRRj5csoLicjd4r7SUN
	 HUadUchDy+tEPJSxaZ/xsZkqHbgtK2n4O0t05+9LyP3zoeqGEJpSll+Rc1cI9rAvqX
	 6XVsXF/18So07zFOGuZA8P6ZY64osi1zi7VxN9LSvXd68k+GFkni/GX1qwfkBScRze
	 rK/y7XlDJyy+NEIG+U7LQD9shDON0QGhXn00ZnjsMe/XrsmjJCgGPOHwNvsLsd1VaP
	 Cl7+azV3C3HwuF0GUI2cl+oR+ABnxziXI7llvf0d4rVrTmiyE7m5/pMtWmYuwMyx8n
	 8213VS37z6DJA==
Message-ID: <8d4ba38a-e19d-408b-b81d-a75362d170e2@kernel.org>
Date: Mon, 1 Sep 2025 12:08:53 +0200
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
To: Mat Martineau <martineau@kernel.org>,
 Christoph Paasch <cpaasch@openai.com>
Cc: mptcp@lists.linux.dev
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-2-78b25dda7708@kernel.org>
 <CADg4-L_yzQo7Xs3aVL=sBY2M6OwZ=XDHCTdaS3KyiZa0hOct0g@mail.gmail.com>
 <9de05bc0-fcf6-364f-b143-fb72cb8c4cae@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9de05bc0-fcf6-364f-b143-fb72cb8c4cae@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph, Mat,

On 30/08/2025 02:58, Mat Martineau wrote:
> On Fri, 29 Aug 2025, Christoph Paasch wrote:
> 
>> On Fri, Aug 29, 2025 at 1:33 PM Matthieu Baerts (NGI0)
>> <matttbe@kernel.org> wrote:
>>>
>>> During the connection establishment, a peer can tell the other that it
>>> cannot establish new subflows to the initial IP address and port by
>>> setting the 'C' flag [1]. The RFC8684 is strict about that:
>>>
>>>   (...) therefore the receiver MUST NOT try to open any additional
>>>   subflows toward this address and port.
>>>
>>> It is then important not to let the userspace PM establishing such
>>> subflows, and return an error (ECONNREFUSED) if it tries to do so.
>>>
>>> Fixes: 702c2f646d42 ("mptcp: netlink: allow userspace-driven subflow
>>> establishment")
>>> Link: https://datatracker.ietf.org/doc/html/rfc8684\#section-3.1-20.6
>>> [1]
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>>  net/mptcp/pm_userspace.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
>>> index
>>> 1911fe1799fa38a53381247a830a9a0daf1c4492..9968dc9a8b45112114953f66848ea22c971136d6 100644
>>> --- a/net/mptcp/pm_userspace.c
>>> +++ b/net/mptcp/pm_userspace.c
>>> @@ -391,6 +391,12 @@ int mptcp_pm_nl_subflow_create_doit(struct
>>> sk_buff *skb, struct genl_info *info)
>>>         if (err < 0)
>>>                 goto create_err;
>>>
>>> +       if (READ_ONCE(msk->pm.remote_deny_join_id0) && addr_r.id == 0) {
>>
>> If userspace wants to, it could still work around that by still using
>> the initial subflow's IP-address and just use a non-zero address-ID.

Good point, I missed that!

>> Is that really a concern ? Sure, the IETF-draft says "MUST NOT", and
>> so, shouldn't we leave it up to the userspace PM to make that decision
>> ?
>>
> 
> I concur with Christoph on this one, I think the PM (userspace or
> kernel) is responsible for this aspect of the protocol so it doesn't
> need to be double-checked here.

Indeed, we could leave it up to the different PMs to make that decision.
Initially, I didn't have this patch, and I had a simple patch setting
the corresponding sysctl to 0 in userspace_pm.sh, just to check the
event was correctly announced. But when writing the last patch's commit
message ("mptcp: pm: nl: announce deny-join-id0 attribute"), I realised
that the main missing feature was a way for the userspace daemon to know
that the C flag was set. We cannot backport patch 7/7, but we can
backport this one, and have a way to know this info on older kernels. I
should have mentioned that in the commit message.

In this case, I think we have a few options:

- Keep this patch, but update the commit message to make it clearer
what's its purpose, see [1]

- Same, but revert it after patch 7/7 on net-next.

- Keep it, but also check for the address and port.

- Drop it.

What would you prefer?

Personally, I think we should keep it, at least for stable, but we don't
need to check for the address and port: even if it is easy to check, it
might be good to let a way for the userspace to still create such subflow.

[1]: The last paragraph in this commit message would then be:

> It is then important to let the userspace daemon know it is not allowed
> to establish such subflows, and return an error (ECONNREFUSED) if it
> tries to do so. Note that the userspace daemon will still be able to
> establish subflows to the initial IP address and port, but by giving a
> different remote ID: that's OK, that's its responsibility ; worst case,
> the MP_JOIN is rejected by the other peer.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

