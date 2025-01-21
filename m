Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2F1F8907
	for <mptcp@lists.linux.dev>; Tue, 21 Jan 2025 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498971; cv=none; b=UH1Qu76Ifur7ueoyztSrXa3Z6B9XwRrUAKBkDpWUjl85ieKbAVV0o7tOSL3nOFMUWWT+9uBm8TwJ7fbvAZq/f1S3SyX94Wf2GlJEIHq8eGTjoRE23Q6MbS/40D0usUiJALPTNE7w1DXQz08h7x9MSn85MBUR6154b0o8pHCkLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498971; c=relaxed/simple;
	bh=FSKlAUlIUIs8C3QzB1hhY35zI3Dp8TAF28GjmiguU+k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hyc7doAJlNfZW3g9gTAu94Dt5jXp6TwV+1m24PkSnGG/tPlViDYpJlbEsQmrmcn9PI5bqEhcms0OUz79niPJnRAAta6QYqR6RsQvpnkm+nhCW8zVpeRVfQf/85KXF/w8NRBJ7fSxynUu+QVjXUh/u7yrc6fmImsXBiZLk4M0WK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx/uaOIA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx/uaOIA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28903C4CEDF;
	Tue, 21 Jan 2025 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737498971;
	bh=FSKlAUlIUIs8C3QzB1hhY35zI3Dp8TAF28GjmiguU+k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kx/uaOIAZMMe6nVn89CuGyUmQZKyopP30lOIc0tLigUsN7+lQ1yEpjfqO3qgYJa2e
	 ++xqR/iiPsZ9qdat87Ko/xKYseKGIBRIJJy05gNTodbgfPcw/aeq3JihwpiGTuaq2/
	 Ln2ryxx2BsRoVFNeIs+vfd9VGPt8NZJ2qLUPpHLfB+3HFEH6ziH5m0jQMIJtp6iI9b
	 gTJfHI6RVv78oKHiuWD9Vdq40t0zh1wqqHeChTHIQRmBxyn76CXA2fj4d+bxZ70DL+
	 Js973sOzWxLgEdIMsW1PnaT/TmyEGEbk2+Hl24s+OXpkI3Y3wuuZYsaYz3/yyJymQ0
	 /q2v/VzNVK2/g==
Date: Tue, 21 Jan 2025 14:36:10 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/3] mptcp: blackhole only if 1st SYN retrans
 w/o MPC is accepted
In-Reply-To: <0ee61322-ca68-4c2f-8b2f-1358630b05dc@kernel.org>
Message-ID: <d4969576-7cc3-d789-ab4a-b08c6a9f0344@kernel.org>
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org> <20250114-mpc-no-blackhole-v1-3-994bd2a357fb@kernel.org> <91ff8079-cb49-0b23-57bd-c18f6dc1ff87@kernel.org> <0ee61322-ca68-4c2f-8b2f-1358630b05dc@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-696992020-1737498971=:90370"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-696992020-1737498971=:90370
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 17 Jan 2025, Matthieu Baerts wrote:

> Hi Mat,
>
> On 17/01/2025 01:26, Mat Martineau wrote:
>> On Tue, 14 Jan 2025, Matthieu Baerts (NGI0) wrote:
>>
>>> The Fixes commit mentioned this:
>>>
>>>> An MPTCP firewall blackhole can be detected if the following SYN
>>>> retransmission after a fallback to "plain" TCP is accepted.
>>>
>>> But in fact, this blackhole was detected if any following SYN
>>> retransmissions after a fallback to TCP was accepted.
>>>
>>> That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
>>> to 0, and 'mpc_drop' will never be reset to 0 after.
>>>
>>> This is an issue, because some not so unusual situations might cause the
>>> kernel to detect a false-positive blackhole, e.g. a client trying to
>>> connect to a server while the network is not ready yet, causing a few
>>> SYN retransmissions, before reaching the end server.
>>>
>>> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> net/mptcp/ctrl.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> index
>>> 3999e0ba2c35b50c36ce32277e0b8bfb24197946..2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb 100644
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>
>> Some more context before the diff hunk:
>>
>>>     if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
>>>         struct net *net = sock_net(ssk);
>>>         u8 timeouts, to_max;
>>>
>>>         timeouts = inet_csk(ssk)->icsk_retransmits;
>>>         to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>>>
>>>         if (timeouts == to_max || (timeouts < to_max && expired)) {
>>
>> I think it would help to change the above code to:
>>
>>>     if (ssk->sk_state == TCP_SYN_SENT) {
>>>         struct net *net = sock_net(ssk);
>>>         u8 timeouts, to_max;
>>>
>>>         if (!subflow->request_mptcp) {
>>>             subflow->mptcp_drop = 0;
>>>             return;
>>>         }
>>>
>>>         timeouts = inet_csk(ssk)->icsk_retransmits;
>>>         to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>>>
>>>         if (timeouts == to_max || (timeouts < to_max && expired)) {
>>
>> (end of added hunk)
>>
>>> @@ -418,9 +418,9 @@ void mptcp_active_detect_blackhole(struct sock
>>> *ssk, bool expired)
>>>             MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
>>>             subflow->mpc_drop = 1;
>>>             mptcp_subflow_early_fallback(mptcp_sk(subflow->conn),
>>> subflow);
>>> -        } else {
>>> -            subflow->mpc_drop = 0;
>>>         }
>>
>> And drop this from the patch:
>>
>>> +    } else if (ssk->sk_state == TCP_SYN_SENT) {
>>> +        subflow->mpc_drop = 0;
>>
>> That way ssk->sk_state is only checked once.
>
> Good point!
>
> I forgot to mention that, but I duplicated the simple check to avoid
> conflicts with the backports. But on the other hand, it will only
> conflict with the previous patch. So if you prefer, and not to block it
> the patch for net-next, I can also send this fix patch later on.
>

Hi Matthieu -

Ok, I see. How about reversing the order of patches 2 & 3 to get rid of 
the dependency?


> If we decide to go into that direction, I suggest moving the SYN_SENT
> check at the beginning:
>
>  if (!sk_is_mptcp(ssk) || ssk->sk_state != TCP_SYN_SENT)
>      return;
>
>  subflow = mptcp_subflow_ctx(ssk);
>
>  if (!subflow->request_mptcp) {
>      subflow->mpc_drop = 0;
>      return;
>  }
>
>  timeouts = inet_csk(ssk)->icsk_retransmits;
>  to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>
>  if (timeouts == to_max || (timeouts < to_max && expired)) {
>
>  (...)
>
> WDYT?
>

Good suggestion, that's a clearer way to do it.

> (Or I can also keep the fix like it is for the moment, and add another
> patch containing this refactoring).

Not sure if you're referring to my suggestion or not. Probably the 
clearest option is to post a v2 based on this discussion :)


- Mat



--0-696992020-1737498971=:90370--
