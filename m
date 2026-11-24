Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795538144;
	b=NyB2Lm/ulG+W+IJjjv2VU7FbpZRvf6AaDgzc3PF8p0vcHT3Swd2QLehGqXBgp8fDVgUi
	 A8R1g5laXs/8f2tqDf9IOTH8Wy1MQdx/x6SicvlA9f72wLW3ZkeKipmozvd0JbSIzyt0g
	 17dxLDsNBrxS8pew6aZCPt5JVzUYPW5D2nQpRJqO6rYN4W6zGsp8cRZ35i1MO9s5i1UWa
	 BTY3MhZLJT9c7A56c6yMfTLXRA6BeqHxhmb/e18oY7+uPk1VEcZpvKRteqzH9leXuRLEU
	 q1a8ZTDor/dRe438jOQYWFRQPn6rbMYlW8jPNzErvyuOlo9Cpl13TZWxj7d++yeAPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538144;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OBMQw7/vhRF0vwaX0C2BAIakFeOT6gsUdxCLmJj3Ge4=;
	b=3FZljp1nsQIdVFdAvzeZoU7keE+i8u8wQ+6oDOtdIxxHTTB50DN8s4ks0IQCC8OMiGDe
	 7XvnDY7582qFZqzGXDK3oCl7RmAKa83UPBbxxk9cBVKI/Fmw+AjdD5l40b5HxFc/A7IQo
	 zLu5POgTofZab++K35+uCKI1iQ2EWDIjl5KAtimYAFgU3brYGf8UhWADHsKLhjVM5fE5J
	 KAvgnCLbBAhBCS3ZyXIpqMM9/F5+D3F3RU+H9C57h6MKK3hzYA7STXpq02Xp5Rt6ANr/m
	 y32M+zHQQ81ahdHYYIhYZ8LJ3YeHD2Fr95YtUcjsu3a+3WMn/foDsui9c+VQzasH+lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ODIxksv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE732606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODIxksv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6801F000C4;
	Tue, 24 Nov 2026 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795538143;
	bh=OBMQw7/vhRF0vwaX0C2BAIakFeOT6gsUdxCLmJj3Ge4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ODIxksv/Ag5hQSUBRkXaChaNQBgFLnX1vpXVy6VIY7dyKthoR4toBnVyc0O9JIEq0
	 No+rNhQhQm9hP2pZtBhbHLc+h8c0A//7iTbnvpjW5ZJDom1+JUDPUPL61Hawo5fGjH
	 vnZlVH34XscTzJuqltDZo73AuJu5LyGnua+W2tqoORxwr6Bva3aPMYBFUN9DWNwFzB
	 m48jNYouEOibTND4oR59Hs3pd2JUJz/X6IacD8QD/h/DOG15HwW58kX69fwNu0+kTv
	 b/x600MNpxYezNGvy2uFGz88TsGWMeiSi/r/6311OsW9y60g3K12Pvm33gt51PCgTF
	 vubc+w8NoYscw==
Message-ID: <f4a2955e-90d2-49f7-813b-f09319f18788@kernel.org>
Date: Tue, 24 Nov 2026 17:35:41 +0100
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
Subject: Re: [PATCH mptcp-net v2 28/62] mptcp: no fastclose reset from
 SYN_SENT subflows
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
References: <20261121-mptcp-cmason-fixes-v2-28-00327fd1de1f@kernel.org>
 <179541555288.3133.1892545149485565462@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179541555288.3133.1892545149485565462@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 07:32, netdev-bot+sashiko@kernel.org wrote:
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index f80fac0c22c06..55ff0298e5dd2 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -3297,6 +3297,10 @@ static void mptcp_do_fastclose(struct sock *sk)
>>  
>>  		subflow->send_fastclose = 1;
>>  
>> +		/* no reset in SYN_SENT, as TCP does */
>> +		if (ssk->sk_state == TCP_SYN_SENT)
>> +			goto unlock;
>> +
> 
> [Severity: Medium]
> The commit message says:
> 
>   "Skip them again in this state, as TCP does: the subflow is still
>   moved to TCP_CLOSE, and a later SYN-ACK gets a reset from the stack."
> 
> With this branch, a SYN_SENT subflow leaves mptcp_do_fastclose() with only
> send_fastclose set. It is still TCP_SYN_SENT and still hashed.

Indeed.

(...)

> Could this branch move the subflow to TCP_CLOSE, for example with
> tcp_set_state(ssk, TCP_CLOSE), before jumping to release_sock(ssk)?

Yep, will fix in v3.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

