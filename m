Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605377;
	b=2Bprg+MWRGnWbY/4pTDZ16iYmMISedkD98UTHz4iMVy+jikoVhxsMtfVfXzk7Kz2aZ5r
	 VymeYF+P04Iy6t8OnUtfM23ZGxRZLDLF/SbuSrYhad6Oy2lyD0u42tuglRAhEdXdOHIq3
	 v0tVlsn8iIsx0Hi53Mqjm7j9gd095lQVmcx/XLKa0MY1+4tmndAdQvskHXVJoKGJr4ugx
	 xIPYO1pkXm5KAvaOuRlghHEKPSUtdlrjHHL8jAWHWc1uDk+7a/0Gi8z9/ptdxDCB/d4Yf
	 IMzz8DCRInY0NvJ23shplCsiUdduJS+U7D3m+JM7rvtqcFrOHYI6y16/Ssxxngb97NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605377;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:From:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OvNroLFyktdE2jtqQeMDvHok+9Y9+lXTyyCwC9d6frg=;
	b=Sv2oBh7GBhxVmLGa+v3XugqJxFWYNmM1+wefcWgiaPcYXw+1ZBhtzzlUnSekXS68B0wF
	 T4K4NMt3FhFNBaYqdKy8qMQCZFP9bfE61R0krnJwgDXWUTDcZK+03s83VGooF5BtJksLX
	 jO3HHvM8GFH3a2CB4/KGRT5bBbarANG20RMK97Yla9Uv2Nv9me8hLk7RplVxy1Hi5XShr
	 lkMSEecX3ybfomplvYaG6AEA7+V2UDMSR7VncaJ82O+M2d5qT1UIBLlHhkFR15URSmIF9
	 k/O+Sl73i81uf6KwbNDO1vyw2CQV4t1AgDRS7gl6pG7y3xGDUhjO10Jns+mIl4/xfvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnSXNNA+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFE606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnSXNNA+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE541F000C1;
	Wed, 21 Oct 2026 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792605376;
	bh=OvNroLFyktdE2jtqQeMDvHok+9Y9+lXTyyCwC9d6frg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SnSXNNA+oy1FBJaW4z8f1QP6j38gOOjHXx7xTKAsXLcXHlv+xPSAoFzaKEr8DiItK
	 eVfa8rE0j1w3m9dLg8UcG94of3ItvwW2uEMvh3wONbMP7ez3mfXA7njK7KUOBZvMbd
	 TAVeAjO9bC8Dk7X2b9qlKeXHJhPPbOjEbrTEd87+3XJ+h/Hqo2WCMyBwKMnbU4iMuw
	 6HIwGO7p1d99XhNZ7gPqC7tLsZpOsXb8nqZ1CQWOfynN6AqgGxGQU9uLcjETxATANz
	 XB8db2BIR4K7iNBzcdvcb6vG4Fzy6AxkoqcHHR9aSarbqaAqZsppn1UZw+yXyEeLB5
	 mmPuOeoamWyAw==
Message-ID: <decee37e-e60d-4703-9b10-c8ce35c3f78e@kernel.org>
Date: Wed, 21 Oct 2026 19:56:12 +0200
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2] mptcp: push queued data on passive TFO
 subflows becoming established
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: rameshsv06@gmail.com
Cc: mptcp@lists.linux.dev, petar.sakic@ink.fish,
 rameshkumar.t@phytecembedded.in
References: <20261012111001.542847-1-rameshkumar.t@phytecembedded.in>
 <179193667256.3135.13011798294766264196@kernel.org>
 <964aeab4-7974-4a84-a391-65a00da9de72@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <964aeab4-7974-4a84-a391-65a00da9de72@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi T S,

On 14/10/2026 10:28, Matthieu Baerts wrote:
> Hi T S,

Just to follow-up here: do you still plan to send a v4 with the
different fixes (Fixes tag, Signed-off-by/author, using
syn_fastopen_child), the packetdrill test for that case, and eventually
another fix for the fallback case (that can be for another series).

If you don't plan to send a new version, or you have issues, please comment.

Cheers,
Matt

> 14 Oct 2026 02:11:13 netdev-bot+sashiko@kernel.org:
> 
>> Thank you for your contribution! Sashiko AI review found 3 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 · Medium: 1 · Low: 1
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] The fix is incomplete.
>> - [Medium] The fix also misses the fallback path.
>> - [Low] The commit tags are wrong.
>>
>> --
>>
>> mptcp: push queued data on passive TFO subflows becoming established
>>
>> This commit makes check_fully_established() call __mptcp_check_push()
>> when a passive TFO subflow (subflow->is_mptfo) becomes fully
>> established. The goal is to flush data the server wrote while the
>> subflow was still in SYN_RECV. Without the flush, that data stays in
>> the msk write queue because the MPC third ACK carries no DSS.
>>
>> Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
>>
>>> Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
>>> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
>>
>> [Severity: Low]
>> This isn't a bug, but does fb7084501a61 exist? The hash doesn't resolve
>> in the tree, and no commit has that subject.
> 
> Nice, the LLM invented a plausible commit...
> 
> BTW, don't forget the "Assisted-by: LLM" tag.
> 
>> The passive TFO and is_mptfo handling seem to have come from these
>> commits:
>>
>>   36b122baf6a8 ("mptcp: add subflow_v(4,6)_send_synack()")
> 
> Yes
> 
>>   dfc8d0603033 ("mptcp: implement delayed seq generation for passive fastopen")
>>   4ffb0a02346c ("mptcp: add TCP_FASTOPEN sock option")
>>
>> Should the Fixes tag point at 36b122baf6a8 or dfc8d0603033 instead?
>>
>> Also, the Signed-off-by address (rameshkumar.t@phytecembedded.in) doesn't
>> match the author address (rameshsv06@gmail.com). Checkpatch reports this
>> as FROM_SIGN_OFF_MISMATCH.
> 
> Indeed: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/38243594334
> 
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 20490410fa22f..33eede084af8d 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -1046,6 +1046,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>>>
>>>     mptcp_data_lock((struct sock *)msk);
>>>     __mptcp_subflow_fully_established(msk, subflow, mp_opt);
>>> +   if (subflow->is_mptfo)
>>> +       __mptcp_check_push((struct sock *)msk, ssk);
>>
>> [Severity: High]
>> Does this check miss passive TFO children whose SYN carried no data?
>>
>> mptcp_fastopen_subflow_synack_set_params() sets is_mptfo only after it
>> finds SYN data in the subflow receive queue:
>>
>> net/mptcp/fastopen.c:mptcp_fastopen_subflow_synack_set_params() {
>>     ...
>>     /* A valid TFO cookie does not guarantee SYN data. */
>>     skb = skb_peek(&ssk->sk_receive_queue);
>>     if (!skb)
>>         return;
>>
>>     subflow->is_mptfo = 1;
>>     ...
>> }
>>
>> The TCP core still creates a full TFO child for a data-less SYN that has
>> a valid cookie. It also does this when TFO_SERVER_COOKIE_NOT_REQD is set:
>>
>> net/ipv4/tcp_fastopen.c:tcp_try_fastopen() {
>>     ...
>>     if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>>           (syn_data || foc->len >= 0) &&
>>           tcp_fastopen_queue_check(sk))) {
>>     ...
>> }
>>
>> tcp_conn_request() then puts that child straight into the accept queue,
>> while the subflow is still in SYN_RECV.
>>
>> Suppose the application accepts and writes at once, as a
>> server-speaks-first protocol does. mptcp_sendmsg_frag() returns -EAGAIN
>> because !__tcp_can_send(ssk). __mptcp_push_pending() then exits with
>> nothing copied, so the rtx timer is never armed.
>>
>> When the pure MPC third ACK arrives, is_mptfo is 0 at this point and the
>> push is skipped. mptcp_incoming_options() then returns before
>> ack_update_msk():
>>
>>     if (!(mp_opt.suboptions & OPTION_MPTCP_DSS))
>>         return true;
>>
>> So won't the queued bytes stay stuck until the peer sends something,
>> exactly as before this patch?
> 
> Indeed (as mentioned in the human review).
> 
>> Would it work better to replace the is_mptfo test with one that covers
>> every passive TFO child, such as tcp_sk(ssk)->syn_fastopen_child? Another
> 
> Good idea to use syn_fastopen_child here.
> 
>> option is to push whenever data is pending.
>>
>> [Severity: Medium]
>> What happens on the fallback path of a passive TFO subflow?
>>
>> The third ACK may carry no MP_CAPABLE option. That happens if a middlebox
>> stripped MPC and the client fell back, or if the peer doesn't conform. In
>> that case check_fully_established() never reaches set_fully_established:
>>
>> net/mptcp/options.c:check_fully_established() {
>>     ...
>>     if (!(mp_opt->suboptions & OPTIONS_MPTCP_MPC)) {
>>         if (subflow->mp_join)
>>             goto reset;
>>         subflow->mp_capable = 0;
>>         if (!mptcp_try_fallback(ssk, MPTCP_MIB_MPCAPABLEDATAFALLBACK)) {
>>             MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>>             goto reset;
>>         }
>>         return false;
>>     }
>>     ...
>> }
>>
>> mptcp_try_fallback() switches the msk to fallback mode, but it doesn't
>> push pending data.
>>
>> The fallback push in mptcp_incoming_options() is checked before
>> check_fully_established() runs, so it only fires on later segments:
>>
>> net/mptcp/options.c:mptcp_incoming_options() {
>>     if (__mptcp_check_fallback(msk)) {
>>         ...
>>         if (sk_stream_memory_free(sk))
>>             __mptcp_check_push(subflow->conn, sk);
>>         ...
>>     }
>>     ...
>>     if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>>         return sk->sk_state != TCP_CLOSE;
>>     ...
>> }
>>
>> In a typical TFO request/response, the client already sent its request in
>> the SYN and has nothing more to send.
>>
>> Could a server reply written during SYN_RECV also get stuck in the msk
>> write queue on this path, with no rtx timer armed?
>>
>>>     mptcp_data_unlock((struct sock *)msk);
>>>
>>> check_notify:
> 
> It's plausible, but: to be confirmed with a packetdrill test, and it should
> be part of another fix. Do you want to work on that too?
> 
> Cheers,
> Matt
> 
>>
>> --
>> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012111001.542847-1-rameshkumar.t%40phytecembedded.in
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

