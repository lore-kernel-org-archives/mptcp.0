Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4FC198E7B
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126657; cv=none; b=tr2qeTPp5vpEWft4ppKb8RVS/2IiIOGIqDIGr3rokQnl8ZevRGOhR41n7kbQTbTGyCjXJKraAZGH3q1OfRrxxby8oO/hLQla7wkQO2JQ7xUThF+EKpUzaRcXBZnhr2LFArwluZmbfUEqXJED5MYjqjmDqqitV7RMDmlsm4y67cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126657; c=relaxed/simple;
	bh=tQXK3lmFe4ZMvxCrKKbiDVxRkJQJT8YV6+h8yykrcs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j63BwvDOExh2Lnf+yG4dwC65FYLkBj0bG4No0Wl5dTPkrxlwr0YQlYQ6IqPHRBB1oA2J2ZgMfEbghT5LabxEX1XKUeAsWIzrUhOk2noKMmideXJBu58g4k8D5ypcx5MbaYo53Xsq298JpKsQOuUkrfmN2cdytCBrepDWgC/ZVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKy9c8DS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKy9c8DS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD52C4CEE2;
	Fri, 17 Jan 2025 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737126656;
	bh=tQXK3lmFe4ZMvxCrKKbiDVxRkJQJT8YV6+h8yykrcs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vKy9c8DS+t6vF9PHS5CVUgwiBwxFiZSZ5qLw3DJLk7MQZiVojbEmsgMCU8dzP4Oez
	 QXSMaOgjaTQ9gdZrqY0ygPvyFzPgCZq2iWFB5J/2f0WpCvvsu/4xwhPD0LVYEffws0
	 uDKNwMvMddI8D1sTGRowQeUVKWUfaKY5xadNDXwqS0jt9lK+0IB5ly8pktbXtf31ER
	 UzYEKK7su3srJQYkX74OAYT5Cy1kXVtXDU/c4tbfKR64WIH4vFjhITHHH7VY7pOKGh
	 hwVUkeCdcJgLdj/ftmFLu1apH0k6qQkIpXKUjgGeiZjSzWlHFgNNTrVdvqewjpWoBn
	 pYVqfStxOLfTg==
Message-ID: <0ee61322-ca68-4c2f-8b2f-1358630b05dc@kernel.org>
Date: Fri, 17 Jan 2025 16:10:54 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 3/3] mptcp: blackhole only if 1st SYN retrans
 w/o MPC is accepted
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20250114-mpc-no-blackhole-v1-0-994bd2a357fb@kernel.org>
 <20250114-mpc-no-blackhole-v1-3-994bd2a357fb@kernel.org>
 <91ff8079-cb49-0b23-57bd-c18f6dc1ff87@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <91ff8079-cb49-0b23-57bd-c18f6dc1ff87@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 17/01/2025 01:26, Mat Martineau wrote:
> On Tue, 14 Jan 2025, Matthieu Baerts (NGI0) wrote:
> 
>> The Fixes commit mentioned this:
>>
>>> An MPTCP firewall blackhole can be detected if the following SYN
>>> retransmission after a fallback to "plain" TCP is accepted.
>>
>> But in fact, this blackhole was detected if any following SYN
>> retransmissions after a fallback to TCP was accepted.
>>
>> That's because 'mptcp_subflow_early_fallback()' will set 'request_mptcp'
>> to 0, and 'mpc_drop' will never be reset to 0 after.
>>
>> This is an issue, because some not so unusual situations might cause the
>> kernel to detect a false-positive blackhole, e.g. a client trying to
>> connect to a server while the network is not ready yet, causing a few
>> SYN retransmissions, before reaching the end server.
>>
>> Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/ctrl.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>> index
>> 3999e0ba2c35b50c36ce32277e0b8bfb24197946..2dd81e6c26bdb5220abed68e26d70d2dc3ab14fb 100644
>> --- a/net/mptcp/ctrl.c
>> +++ b/net/mptcp/ctrl.c
> 
> Some more context before the diff hunk:
> 
>>     if (subflow->request_mptcp && ssk->sk_state == TCP_SYN_SENT) {
>>         struct net *net = sock_net(ssk);
>>         u8 timeouts, to_max;
>>
>>         timeouts = inet_csk(ssk)->icsk_retransmits;
>>         to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>>
>>         if (timeouts == to_max || (timeouts < to_max && expired)) {
> 
> I think it would help to change the above code to:
> 
>>     if (ssk->sk_state == TCP_SYN_SENT) {
>>         struct net *net = sock_net(ssk);
>>         u8 timeouts, to_max;
>>
>>         if (!subflow->request_mptcp) {
>>             subflow->mptcp_drop = 0;
>>             return;
>>         }
>>
>>         timeouts = inet_csk(ssk)->icsk_retransmits;
>>         to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;
>>
>>         if (timeouts == to_max || (timeouts < to_max && expired)) {
> 
> (end of added hunk)
> 
>> @@ -418,9 +418,9 @@ void mptcp_active_detect_blackhole(struct sock
>> *ssk, bool expired)
>>             MPTCP_INC_STATS(net, MPTCP_MIB_MPCAPABLEACTIVEDROP);
>>             subflow->mpc_drop = 1;
>>             mptcp_subflow_early_fallback(mptcp_sk(subflow->conn),
>> subflow);
>> -        } else {
>> -            subflow->mpc_drop = 0;
>>         }
> 
> And drop this from the patch:
> 
>> +    } else if (ssk->sk_state == TCP_SYN_SENT) {
>> +        subflow->mpc_drop = 0;
> 
> That way ssk->sk_state is only checked once.

Good point!

I forgot to mention that, but I duplicated the simple check to avoid
conflicts with the backports. But on the other hand, it will only
conflict with the previous patch. So if you prefer, and not to block it
the patch for net-next, I can also send this fix patch later on.

If we decide to go into that direction, I suggest moving the SYN_SENT
check at the beginning:

  if (!sk_is_mptcp(ssk) || ssk->sk_state != TCP_SYN_SENT)
      return;

  subflow = mptcp_subflow_ctx(ssk);

  if (!subflow->request_mptcp) {
      subflow->mpc_drop = 0;
      return;
  }

  timeouts = inet_csk(ssk)->icsk_retransmits;
  to_max = mptcp_get_pernet(net)->syn_retrans_before_tcp_fallback;

  if (timeouts == to_max || (timeouts < to_max && expired)) {

  (...)

WDYT?

(Or I can also keep the fix like it is for the moment, and add another
patch containing this refactoring).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

