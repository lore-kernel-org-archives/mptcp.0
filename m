Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680940;
	b=PtAcLD6eiFARPiWrez+/9AuWbWERAsVQct+XeFacgHvRROw6l9yoOjGjdVYe1uaqablH
	 HELICxo/lRvpW37VIYDRzViffblxqVEGdApaADlG0lvFfLKU2OrWnq8Ly9XNv+xRjK+HR
	 txuJ277LooYzuZFTepTk4tHi+bAkYZM4ojljcKVPjUK/U/26KKRHBQ/OAv4zIH/oFr2O2
	 43PrArr+aOhbkO2P2guLNYjgWOus0XMsHXqDnNloQnVQvI++E04onfbF5GBByOucwDCKX
	 S7X4WtSUGB40TX4nSTRWGbJdgTO4z8eOBSsT1CsS5lhJbUn3efzLtDd8VglgmrQAm9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680940;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:References:From:Cc:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=b7lbPIQLNlVsEj95Citm4eh1mbFI6ZwEstW1WJp6Nbs=;
	b=nQoQgxUtmKmgjR8JBbacu/ARONmZ+Vhl/m+aG4YqwYNwJfujN4SvPgVUt78im+iYfCWt
	 g0OtpNmippON1gAmyz8Rqr97zflnmzdrlw36AGhMcPB3jPFlR6zEvKKkOFdRNQXCjre/g
	 D71j5QSZnoiBgURY58/oFgnjoIAOIqx5CRH20LCNHp0TedNRDbkaOZDeztwj/nn3vYMLE
	 XWbHEF5OSNsO0cnVs45PaCZM5htegBJS8dMWpbYEA4rlPs7ttAhemqFeKHhBoDgSTGOLG
	 xmKSkx1GQHnzYM9OggXt+rVwYY8op8l1jGlBuBd2cVV7+MFFf98X506WQDMW9Ep9cDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KL5kTtsX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC13606A327
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KL5kTtsX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D575A1F000D4;
	Thu, 26 Nov 2026 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680940;
	bh=b7lbPIQLNlVsEj95Citm4eh1mbFI6ZwEstW1WJp6Nbs=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=KL5kTtsX64Mcxiv1OCdMKA+D1/Gdyfj0OnrAlCIn8SeA+pDh5uqEF0ALbeX+QZSyD
	 JKpB4pL7jGfujygy81fe6cbTTfMhPD3SbxU/FllSlZk9mXyzs7ucYqeQSoEhI+ZZDR
	 2rnk3HaEs06h+DDLjRl6rvuH8sxUb6C/iM4pMdNwCMaG1Y9uKTa90qD4pN3PupPpuZ
	 aSNdXp3TzhUYIYdOa94LrSBIvaisie/5IH69KZ6ycLV4U9YhbkcgZL0n7cZ9k0fdaI
	 RI2AKrpYIZ3qvbOkc8Iikbh3nCG3gIbVR4ExNd1kuAk9j9EvGDlbpzR0uaDbCdSp4f
	 FGNjo4AzlfSxA==
Message-ID: <57840818-900f-4c5e-b24c-ddba1eddb93e@kernel.org>
Date: Thu, 26 Nov 2026 09:15:37 +0100
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
Subject: Re: [PATCH mptcp-net v3 15/50] mptcp: clear sk_err on connect(), as
 TCP does
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-15-416c0920c73f@kernel.org>
 <16b6809a6e7f12a4f611442fcb04d91b0bae48de.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Linux <mptcp@lists.linux.dev>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <16b6809a6e7f12a4f611442fcb04d91b0bae48de.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the review!

On 26/11/2026 07:40, Geliang Tang wrote:> Hi Matt,
> 
> On Tue, 2026-11-24 at 22:59 +0100, Matthieu Baerts (NGI0) wrote:
>> After a disconnect with connect(AF_UNSPEC), an error from the previous
>> connection, e.g. a reset not reported yet to the application, was still
>> reported for the next connection, by poll(), SO_ERROR, and the first
>> send() or recv(). TCP clears it in tcp_connect_init(): do the same,
>> once the subflow connect() succeeded, so an early failure keeps it.
>>
>> This issue has been found by an AI code review agent, while reviewing
>> other fixes, and confirmed with a reproducer: the peer resets the
>> connection, the error is not read, then the socket is disconnected and
>> connected again. SO_ERROR then reported ECONNRESET each time, while TCP
>> reported no error, as MPTCP now does.
>>
>> Fixes: 3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Thanks for this fix. Looks good to me!
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>
> 
>> ---
>> v2: new, for an issue found by a review agent
>> ---
>>  net/mptcp/protocol.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index ff1dcf306723..6328815ad273 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -4452,6 +4452,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
>>  	if (err < 0)
>>  		goto out;
>>  
>> +	/* as tcp_connect_init(): drop an error from a previous connection */
>> +	WRITE_ONCE(sk->sk_err, 0);
> 
> tcp_connect_init() also calls sock_reset_flag(sk, SOCK_DONE) here; maybe MPTCP
> needs this sock_reset_flag(sk, SOCK_DONE) too.

We are doing that in mptcp_disconnect() and I think that's enough. From
what I see a reused msk can't reach mptcp_connect() without it, and
nothing can set SOCK_DONE again before the next connection is
established. In fact, I think the sock_reset_flag(sk, SOCK_DONE) in
tcp_connect_init() is redundant and not needed.

(Note that on the other end, it seems better to clear sk_err here than
in the disconnect, similar to TCP, so the error can still be seen after
disconnect(), and before connect()).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

