Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0641F26F46E
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054100; cv=none; b=oJilxnGAmu46dy2j3viaogZOeJGi3PLhirAozcbgsKzkMgCGTBE9rGLt5bTi0zMEAhQg5OkyzTvbWkR54G3IbjQ4zSnONMfy6wY/cOrL4z/neZ2meKR9K6HE+8PVrNm/L4E/e91oLHzQBWXdduiAQIXyJ8KO/vZVGYyqLu20XNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054100; c=relaxed/simple;
	bh=nZ5Xp6byjCl3oCAvugFYrG83MC+nn4Tj+5A3QZuAmR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1rbr0MxSHVwLPBmtKDFnPZyTIy28um5Rb1EXBoA1v4TeVYejp0yV7gqOdEV7p/au1NMUVz9k8Sgiu9Zc/XiiOofaQBFk30b4DW+NxflmV9RG6TSkBRvDlghNnB3oex7R9O0SeZqfmG1O9flwSOdrxLPfoe7Mukc0ljbFx8dPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEqqXRhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEqqXRhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC55AC4CEF7;
	Thu, 13 Nov 2025 17:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054099;
	bh=nZ5Xp6byjCl3oCAvugFYrG83MC+nn4Tj+5A3QZuAmR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KEqqXRhZJH/tmTDx9+n9GoCEuL0nYoxiYZmulDDLVUYI/GsOGZweKFq68+/DUiZr8
	 giwuCO/hr6ZokEl/Z5aXaVUUp7fVu5660ayRSdwn48fdwGTSj+g4bnq7LUSYMSxaJV
	 irBzVS+Mp47eiDdIyV0JORAWP5dgGF8e3wXdq0Rq9AP7wRV5EtDlSxpjPOXXDlwzOO
	 VpoIcxeulEyu3O85HOT+eUKA4/z9Lmf7EsYjmxJlsnIDT+VzLdJI17+TWkVvhu5Jka
	 Xn/7IAsgCofLuk7FdtPh8CdNYwDEl7T2Vlr8oCAEnkefa+AI3Gzcul9ddB5gPVwL1R
	 EQwSTip+DxAHw==
Message-ID: <e320db27-f629-439b-b5dd-b75a18d3cc4f@kernel.org>
Date: Thu, 13 Nov 2025 18:14:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 mptcp-net 1/3] mptcp: fix grafting corner case
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1762992570.git.pabeni@redhat.com>
 <4696be966622c9d340e8bfa4728b219b7cac1d1b.1762992570.git.pabeni@redhat.com>
 <49c300cc-e000-420d-82ad-aa59e5f1cd76@kernel.org>
 <2102ad3b-4f22-4da7-ac2f-7da0eba0ba46@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2102ad3b-4f22-4da7-ac2f-7da0eba0ba46@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 13/11/2025 18:09, Paolo Abeni wrote:
> On 11/13/25 9:47 AM, Matthieu Baerts wrote:
>> On 13/11/2025 01:10, Paolo Abeni wrote:

(...)

>>> @@ -3767,6 +3776,8 @@ bool mptcp_finish_join(struct sock *ssk)
>>>  		goto err_prohibited;
>>>  	}
>>>  
>>> +	mptcp_check_graft(parent, ssk);
>>
>> Is it OK to graft it even in case of errors in __mptcp_finish_join()?
>> i.e. not in an established state or !msk->allow_subflows.
>>
>> Should it not be done after the block below, if there was no error?
> 
> My understanding/hope is that grafting early don't cause issues:
> - no UaF access to ssk->sk_socket, because ssk either do finish
> successfully the join or is reset/delete very soon.
> - no ref leak, because ssk does not acquire any actual reference on
> msk/socket.
> 
> It's needed to do it in mptcp_finish_join(), to ensure that in patch 3/3
> all the subflows will always push accounted data after that
> mptcp_graft_subflows() completes - or more specifically the
> `backlog_unaccounted` counter is flushed.
> 
> Let me see if I can rework 3/3 without this patch

We don't need to drop this patch if it fixes thing. I was only asking
some questions to understand the behavioural change, and if that was not
going to introduce different issues :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

