Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8126133936B
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732458; cv=none; b=J1GsnNwPfvg/t5EHKlFdn7ET5fZAaNmpy89kjXnhri4zOwRHT/gi5JT6R/wQe9Hddg0LcKRqktgSS93W7c7jm1XxPe1a8AB661GTCfsTaEIbzKbMpx1deJRYdXTNQ0st4VZrB6O5wV9kzJedqeFnAAMfjmhYgktqNeaKyY9MX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732458; c=relaxed/simple;
	bh=nDHhzb2vnOhpg4fn0MzsTczFv246b+Ig2DKDWwOI7kc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gAB/pVppTZ5Z8p+AH3h6H6HJ4c7Kev+bz0giSpsW9vMxXebWrQj68HNIF8CHRUzTZpoc33fnF4POPHPfa97qa+8r1RAWNMdVjaVhxTTzLQUbRoBSKKsnMgrBfqEhrDQSGx9K3R0uCImqLlsUyH2/9F3LC07HN5H8xUfMiBcfBlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h45Xiew4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h45Xiew4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4A01F000E9;
	Fri, 14 Aug 2026 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732457;
	bh=lWVxGpl5ezAYCw3gkGwvab2BYOdY81Y2lBGi0jukFe8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=h45Xiew4+aEISk1eqTRwK1OUFM2w23fAIcccIo2HSD8Ckq1S9wAKnRr5oxaQDloaF
	 Wp4m4Pi52G7czXPq6vPOYGTqS73la6pBUtTAmXl94vr9r7v4D3yPgHpYcuddS0bezx
	 gbmkelxDes0t5FhBlOruNQmAQNhMO2Eusm4/v/fi5GBb8eW8MN4KbV0ZM/QZtOJoDI
	 WMPlJIlUsMgBhOSPCa0A8ehyBqdBHymxnGBeiO9HVbqWsPgK9vc3grSVKP9vU1gq99
	 axXW+wD0fChl/RIQZeMCAeJvSW/+HVlVf2YlHFae/s5Uu5YP+sbKy4UORZyCJvSkv1
	 sQT0z6GhYWSNw==
Message-ID: <89cad67d-868c-4081-909f-84957d208ec4@kernel.org>
Date: Fri, 14 Aug 2026 20:34:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH export v3 2/4] mptcp: reject joins after fallback in
 mptcp_is_fully_established
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chenguang Zhao <chenguang.zhao@linux.dev>, mptcp@lists.linux.dev,
 Chenguang Zhao <zhaochenguang@kylinos.cn>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-3-chenguang.zhao@linux.dev>
 <1d7c56b9-00c1-4550-a403-c3d704259267@redhat.com>
 <41078a8c-00c7-4cb1-8e57-237b4ea6c2f0@kernel.org>
 <643936d9-5da2-45cc-b108-f7c2e7785044@redhat.com>
 <a52da320-e6f2-4ccb-92ca-7ad28ebd49f2@kernel.org>
 <8f69b636-57ff-4f1b-a562-826306ab23d3@redhat.com>
 <0146a9b7-f2aa-4412-8cc4-0cdbdd41a40e@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0146a9b7-f2aa-4412-8cc4-0cdbdd41a40e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2026 18:49, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 14/08/2026 13:06, Paolo Abeni wrote:
>> On 8/14/26 11:09 AM, Matthieu Baerts wrote:
>>> 14 Aug 2026 10:43:41 Paolo Abeni <pabeni@redhat.com>:
>>>> It's not clear to me what actually goes wrong and how. Do you have handy
>>>> a event sequence or stack trace demonstrating the critical scenario?
>>>
>>> Indeed, better with packetdrill scripts:
>>>
>>> https://github.com/chrisocean716-star/packetdrill/blob/bf9be7a7bee3687500444b284a9db2a0009a5252/gtests/net/mptcp/dss/dss_drop_after_data_fallback_server.pkt
>>>
>>> => A fallback is done, a subflow can be initiated, then rejected.
>>>
>>>
>>> https://github.com/chrisocean716-star/packetdrill/blob/fed57fab92c407eb433acdb8c8ce72bd8e3e2f37/gtests/net/mptcp/mp_join/mp_join_server_after_fallback.pkt
>>>
>>> => The MP_FAIL is partially ignored if received before being in fully
>>> established state.
>>
>> Thanks!
>>
>> I'm pretty sure there is a miss-intepretation of the 2nd case.
> 
> Thank you for having checked!
> 
>> The problem is not with `msk->fully_established`. AFAICS
>> msk->fully_established is true when the MP_FAIL is receive.
>>
>> The passive msk socket sets it at MPC ACK reception.
> 
> Indeed, I should have checked the code instead of only reading the
> comments from this test :)
> 
>> The problem is that, at MP_FAIL reception, the infinite mapping is not
>> sent immediately, but it's scheduled with the next xmit, and until such
>> point the msk does not perform the fallback.
>>
>> I think a proper solution would be bounding MP_FAIL (reply) and infinite
>> mapping in the same ack.
>>
>> As noted by Gang, it may require a new helper (build on top of the
>> tcp_send_ack).
> Sounds good to me!
> 
> What about the 1st case (fallback)?
> 
> Would it help to reset msk->fully_established in
> __mptcp_try_fallback()?(while holding the data_lock? not even sure it is
> needed at that stage)
> But here, we will also need to update subflow_token_join_request() to
> check mptcp_is_fully_established, or even mptcp_can_accept_new_subflow.
> (I can send a quick RFC patch)

Sent:
https://lore.kernel.org/20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org

> It would also benefit to the in-kernel PM and others places using
> mptcp_is_fully_established(). subflow->fully_established doesn't need to
> be reset.
> 
> Cheers,
> Matt

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

