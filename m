Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795678542;
	b=0mhnbu7OxFKz4E7Q5lLCEWFHv+D2owPEEFyIvmRh7rj3MM/iNqZ1RnZsRXJKfPGlvNJv
	 M/4dAKXjjWZYVfWTaGrjQn7KyWpc9Pg+fF/hybbs1XwoinLkTtPMDkCMuJ9szGAqHY+J4
	 OaVb1vDTTCorWxOo3zlUNssqCM2KrE46ZkHihBuC91mz9+fi+fzN9EGP2Bnz3hT/3H7Mo
	 HW0WKOpGtRmWzADRxwAZJmCdYAFZioJvv9Vf4tqNa3wjforHBXprpiDM4MXzOnDSc11RS
	 /FkDwyoXHZzMMTqr80JxBbeVZgN84YkZCsyYRDnfHMo7cSYtHDZDEuzr89mtF+4xq0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795678542;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pM/TtAVOo1QHMT4EE4NtF07zOQ7QPqmCUr7TKdrn54Q=;
	b=lQtdYECv/tZLs+DHESpFbCPZ9KO5bItPzHjw///AjNq9L7gecyQnz5WV/+BMP+IGOIIz
	 Klcgg6FCPYXSXTOD0eho4/OOBAgHT2XzjvexEg+atIX/j5mAEGUPRaZo6OX5xpBgX1H+w
	 FX5uHaQTYvzGsyn/2X2ZDJZiaC7zZL+waFC38fruGVQ983dUoIqc875JWtlGFmDvujP4m
	 /gJtZaQ8ZHhP3F0IruTzJIMIM7UmVO1u88fL4S2WLYkJzsMmosFTgFovENYC9nsCxQTNi
	 1y1UZLGe5XlVFufb3pQgQXk3IseMwouZPTyXfGhfA16jUrfUKyKHQwEgzRmiBD14/Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on+BJ8zB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FDD606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on+BJ8zB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B231F000CA;
	Thu, 26 Nov 2026 07:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795678541;
	bh=pM/TtAVOo1QHMT4EE4NtF07zOQ7QPqmCUr7TKdrn54Q=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=on+BJ8zBF9+v511vlK5pjYnD4kmiSTTPpyJ0j8RGd+TlcCvFlkdSRko9QMcObSLaP
	 aTQxJthtbgppELstseUFouRxqbjejateHr1svKRRcTtYAFyxgRKqp0NNA0W5mPHBUT
	 1xA7/LO/kf4IF+KWypQSvDW1y3dQjmFjDtW5F/0COR4QuCFr6NstI0bJavvROhKGfv
	 WYfT90AZab6ks8+pzwGV6akvywNZZ4rE9lkJ2w8CnztKNMNG6U1R7dAvHJKx0cfPw5
	 i25fTFO/jv5Mk9hBT4VBLv8SaiWov/POUcwkcw2LfhyHptO8/ETdlMzGEz+f1SLZqV
	 4DhGODvow/inQ==
Message-ID: <434088a0-a6aa-4257-9371-faeb229ec154@kernel.org>
Date: Thu, 26 Nov 2026 08:35:38 +0100
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
Subject: Re: [PATCH mptcp-net v3 18/50] mptcp: no fastclose reset from
 SYN_SENT subflows
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-18-416c0920c73f@kernel.org>
 <50f4d21d44f291853805421d84e2a4ac3f25010f.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <50f4d21d44f291853805421d84e2a4ac3f25010f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the reviews!

On 26/11/2026 08:04, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
>> mptcp_do_fastclose() sends a reset with an MP_FASTCLOSE on each subflow
>> not in LISTEN or CLOSE, also on the ones in SYN_SENT, while TCP sends no
>> reset in this state, see tcp_need_reset() used by tcp_disconnect(). On a
>> disconnect in SYN_SENT, e.g. with connect(AF_UNSPEC), an MPTCP client
>> then sends a reset with an MP_FASTCLOSE carrying an unknown key, 0. With
>> TCP_FASTOPEN_CONNECT, this reset is even sent before any SYN.
>>
>> Before the commit below, these resets were sent by tcp_disconnect(), so
>> not in SYN_SENT. Skip them again in this state, as TCP does, but move
>> the subflow to TCP_CLOSE at once, as tcp_disconnect() does: a SYN-ACK
>> received before the end of the close cannot complete the connection, and
>> a later one gets a reset from the stack.
>>
>> This issue has been found by an AI code review agent, while reviewing
>> "mptcp: clear DEFER_CONNECT on disconnect", and confirmed with a new
>> Packetdrill test: a disconnect in SYN_SENT, then the SYN-ACK. Without
>> this patch, a reset with MPTCP options was sent at the disconnect,
>> before the one replying to the SYN-ACK:
>>
>>   disconnect_in_syn_sent.pkt:16: error handling packet: live packet field ipv4_total_length: expected: 40 (0x28) vs actual: 56 (0x38)
>>
>> Fixes: ae155060247b ("mptcp: fix duplicate reset on fastclose")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> v2: new, for an issue found by a review agent
>> v3: move the subflow to TCP_CLOSE at once, not to complete the
>>     connection with a SYN-ACK received in between (Clashiko)
>> ---
>>  net/mptcp/protocol.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 87f6da0f6cab..6c712f677220 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3321,6 +3321,12 @@ static void mptcp_do_fastclose(struct sock *sk)
>>  
>>  		subflow->send_fastclose = 1;
>>  
>> +		/* no reset in SYN_SENT, but a close at once, as TCP does */
>> +		if (ssk->sk_state == TCP_SYN_SENT) {
>> +			tcp_set_state(ssk, TCP_CLOSE);
>> +			goto unlock;
>> +		}
>> +
> 
> The existing check for LISTEN and CLOSE states in this function uses
> 
> 		if ((1 << ssk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)).
> 
> For consistency, it would be better to use the same style for the SYN_SENT
> check here:
> 
> 		if ((1 << ssk->sk_state) & TCPF_SYN_SENT)
> 
> This keeps the code style uniform throughout the function. WDYT?

It's good to keep the code style uniform, but I don't think doing that
here is interesting: converting the state to a bitmap is good to check
for multiple states, but not just for one where we can directly compare
the state. Plus it looks this conversion is never done to compare just
one state (except in sock_map_sk_state_allowed() but that feels wrong).

So I think we should better not change this, no?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

