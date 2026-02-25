Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3583D3D02
	for <mptcp@lists.linux.dev>; Wed, 25 Feb 2026 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038648; cv=none; b=oefiBlQbiKqT+Zz6JNVW82n3QXIRUVeMgbpx8d9b74y5cDCPqXh0QjGCEj0YMRusEY8rpqrC7LT0WDwljcXIlDfYRlwV+c0Oswzqu2qGtYJbbJzbDKf2L6AMOAqhEijgeAhjRbz6k8nw5txrbzDwHUWlIfhdkKRnkVQlLqWRcRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038648; c=relaxed/simple;
	bh=VBHkKxX8oNZzhLgL1J5q6g7Gnofc/pxduRA4VUiLRzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T0a444U+T3XCMYqiiCKdsfJId76OBduOsL7NKyUyrBwnBi418OR2EWLOL4qt7E+NY9VKj1ef7E7O9MbEc1AvIjP0U3CHNcVFVvcnTy5doXyN0J/x+MReaYrq1MpBMFrZzHyWSCPWBIoZODa2V9a5S5eEGCmqcASjW8O/PN6RlIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdVuUcI9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdVuUcI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72532C116D0;
	Wed, 25 Feb 2026 16:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772038648;
	bh=VBHkKxX8oNZzhLgL1J5q6g7Gnofc/pxduRA4VUiLRzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=bdVuUcI9a8PigPiN/i19OuBAZEYfE+EDb3cCHIbhcl3aiuU0TiX8wkPzT/1TJqBF/
	 pzzgmW6ROw7oFqCkrqUBfLhbcvcdUHL+TLRjc+9cDfEnXa/zt9gnWvTQr6D7gRsKM1
	 BNfh521IzF02hpJYsx8Bh+K1ZOA9iuIE1LEQCIzK22Oteecz4v2AF4JaN84z1GFpgz
	 /Zr4CAb2zcUFrhWfYRFlP9rStqg2xHBiP2PUcZYT7MP6GxPls3ME9UgqiPS2KSkd5T
	 Ttmp16mmS9XXSlE8GpQL219BmCzRCdzCctyJtAhx3AqgbQ2vEGnLO4UCCSaOIOOLjp
	 2qIePIArZ6ALA==
Date: Wed, 25 Feb 2026 08:57:27 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: avoid sending RM_ADDR over
 same subflow
In-Reply-To: <886fecf3-e73c-4f23-9dc8-21a7c5aba9e4@kernel.org>
Message-ID: <9e46338e-5f27-69fa-a3bd-7dbc7674a275@kernel.org>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org> <20260220-mptcp-issue-612-v2-1-089684a6edcb@kernel.org> <60bfc032-effc-f85f-6e64-7af0cd3daeeb@kernel.org> <886fecf3-e73c-4f23-9dc8-21a7c5aba9e4@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 25 Feb 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you for the review!
>
> On 25/02/2026 05:12, Mat Martineau wrote:
>> On Fri, 20 Feb 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> RM_ADDR are sent over an active subflow, the first one in the subflows
>>> list. There is then a high chance the initial subflow is picked. With
>>> the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
>>> linked subflows are closed. This is done for each active MPTCP
>>> connection.
>>>
>>> MPTCP endpoints are likely removed because the attached network is no
>>> longer available or usable. In this case, it is better to avoid sending
>>> this RM_ADDR over the subflow that is going to be removed, but prefer
>>> sending it over another active and non stale subflow, if any.
>>>
>>> This modification avoids situations where the other end is not notified
>>> when a subflow is no longer usable: typically when the endpoint linked
>>> to the initial subflow is removed, especially on the server side.
>
> (...)
>
>> This is definitely an improvement over the older code, thanks! It does
>> still send RM_ADDR exactly once. It could also RM_ADDR using *all*
>> active non-stale subflows (any that are delivered after the first would
>> be ignored). In terms of interoperability there is the risk of confusing
>> the peer's path manager if it doesn't handle RM_ADDR for a non-existant
>> subflow.
>>
>> Maybe that's more of a mptcp-next feature (if it makes sense to do at all).
>
> I think implementing this would definitively be mptcp-next material. If
> we want this, we will also need to change the way the option is added:
> for the moment, the rm_list is copied in the msk, and a bit is set
> before triggering the ACK, and when sending the ACK, the bit is reset.
> So we would need to also record the subflow IDs that should send the
> RM_ADDR, and only remove the main bit when all of subflows have sent it.
>
> Now regarding the behaviour, I think it more likely to have concurrent
> issues: maybe a subflow could be re-created or an ADD_ADDR could be
> received before all RM_ADDR are transmitted, e.g. in case of bufferbloat
> on one path?
>
>> The v2 patch here is closer to the existing behavior so I'm ok with
>> approving it:
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>
> Thanks! Is this tag also covering patch 2/2?
>

Yes, I had intended to reply to the cover letter to RvB the series. 
Thanks for clarifying.

- Mat
