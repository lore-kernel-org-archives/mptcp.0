Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9751E25F9
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762938972; cv=none; b=WUW9bV+UX3silAxO8O2Uq0BfXgMG5GFqW/p0RcrfuQ+phSZ6j5EhJPlFivtSTQ9+A5RwdE2U1clmEnFdefAX67LYPjE5U4QSYt1KGS1jkafrWB/R3wJfjvAYnBgA4q3IFWeLaxqHRKBXoHIoe5IB6JBVP6jThthlFXL3Rc0ILgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762938972; c=relaxed/simple;
	bh=KX8p/nrOy43tB40AVnXwFzxc00/8U13AvcwVfL7NDMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Af3wrXoaLaWApEd/SPMRfrtOCXCXxYfNxT29E+ehvd0C5QBl/ITZt7DHbBB1rT8fMVFNSkw9ghhvpSEBcw1J3UGLd/7/Lls3a9+vWRJ3uLQvZiMCAlA2p81r2n+7/jt/mNeglGV2DLgrPzJSKwlDZxc52OZfcq3ZXjoUwFNZ0jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfUuhobP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfUuhobP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFF0C4CEF8;
	Wed, 12 Nov 2025 09:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762938972;
	bh=KX8p/nrOy43tB40AVnXwFzxc00/8U13AvcwVfL7NDMI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tfUuhobPeOqQ/n1ckGBaqPZF4NrlG3XHt/YWKog8SVIo4VGhjZuNgUOelrPdbuhFT
	 h7hOIop7abtp7KpREQp1GfmZsPuiFe2CFn8ErblzmR27fIybktkNG7yH5GxBVV26wF
	 EJGNePbEpkHUFQjMA3vTfq8+n1RcUD3uPrbarO3yXPlYYUV2iHiVMvsdciUjvrWX7I
	 ZwgXAbzOiRYNlp7ltlXqSYPfJl9Aw4GZIsjxcm2CnGp9n6zb05VQmjF/T4/r6hFilB
	 DYbCeCcBHfoG6XzM/P67Pn0wAEoOa56xBtXtEuOJeFuTeYwct+UHoA/vFPhUGK7KfX
	 24i+SuL9w4Uyg==
Message-ID: <d557d65a-3b3c-484a-a5d3-d526b46317f7@kernel.org>
Date: Wed, 12 Nov 2025 10:16:09 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 1/3] net: factor-out _sk_charge() helper
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1762551942.git.pabeni@redhat.com>
 <063e2bc8e98ce050286eb4309bf4bd47716cc3f8.1762551942.git.pabeni@redhat.com>
 <a2449ccf-69a5-4503-a687-074b4436223a@kernel.org>
 <63928360-2947-49d7-8e8e-9f83745f3556@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <63928360-2947-49d7-8e8e-9f83745f3556@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for your reply!

On 12/11/2025 10:04, Paolo Abeni wrote:
> 
> On 11/11/25 6:38 PM, Matthieu Baerts wrote:
>> On 07/11/2025 22:55, Paolo Abeni wrote:
>>> Move out of __inet_accept() the code dealing charging newly
>>> accepted socket to memcg. MPTCP will soon use it to on a per
>>> subflow basis, in different contexts.
>>>
>>> No functional changes intended.

(...)

>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>> index a31b94ce8968..08d811f11896 100644
>>> --- a/net/ipv4/af_inet.c
>>> +++ b/net/ipv4/af_inet.c
>>> @@ -756,23 +756,8 @@ EXPORT_SYMBOL(inet_stream_connect);
>>>  void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
>>>  {
>>>  	if (mem_cgroup_sockets_enabled) {
>>> -		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
>>> -
>>>  		mem_cgroup_sk_alloc(newsk);
>>> -
>>> -		if (mem_cgroup_from_sk(newsk)) {
>>> -			int amt;
>>> -
>>> -			/* The socket has not been accepted yet, no need
>>> -			 * to look at newsk->sk_wmem_queued.
>>> -			 */
>>> -			amt = sk_mem_pages(newsk->sk_forward_alloc +
>>> -					   atomic_read(&newsk->sk_rmem_alloc));
>>> -			if (amt)
>>> -				mem_cgroup_sk_charge(newsk, amt, gfp);
>>> -		}
>>> -
>>> -		kmem_cache_charge(newsk, gfp);
>>
>> Mmh, this code has been moved from inet_csk_accept() to __inet_accept()
>> in net-next only, see commit 4a997d49d92a ("tcp: Save lock_sock() for
>> memcg in inet_csk_accept()."):
>>
>>   https://lore.kernel.org/20251014235604.3057003-2-kuniyu@google.com
> 
> Right you are!
>
>> Should we only apply these patches in our export branch, for net-next?
>> If yes, then I guess we should remove the Fixes tag in patch 3/3.
>
> Technically is a fix. Even prior to the backlog introduction bad thing
> could happen, as passive msk does not have memory by the subflow only
> accounted.
> 
> TCP-level OoO could potentially use a lot of system memory that will not
> be memaccounted.
> 
> Unfortunately it's not easy to have a clean net patch.
> 
> I suppose with can have this as net-next fixes (including the fixes tag
> in 3/3) as the change is invasive and the thing is broken since the
> beginning.
> 
> WDYT?

It sounds good to me. When these patches will be in Linus tree, we can
ask to backport these 3 patches from this series, plus commit
4a997d49d92a ("tcp: Save lock_sock() for memcg in inet_csk_accept()."), no?

If yes, do you think I can add a "Cc: stable", and explaining in the
comments that it is because it depends on a patch that is only in
net-next, and the fix is not urgent?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

