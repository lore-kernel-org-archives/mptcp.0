Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598119;
	b=VAlGPN2lYihikkB6/4p+s25tMVBpxWWmMBWCzHq4HrYyThSJaF8AS+hlArfEkLD6aKXP
	 z7B+7k1Rfa1Zzz02QKBpTEF7bUzmB5M0MjuZQSfeUkWRI1g4ziC6GfsSYx4P8ZT/4dz4I
	 P6uYq02buzZKBXEcVMu6z7BLmVsOKR2wfPsMo9o7hFC++Snotvuf57+Qkz5mvHMWwWKXi
	 SuB756E5zn9s9SPvuSrK6uI7Tnw0SmVZkyB2EDSMVGzH7v6juFy9KZWkJq0iiWeM/1+EW
	 y38u8OKLXzLcrjYSvQbkJ86XRd0aj5749BmMXdFucifYD9tn+en9MsrfpXfYTYDteYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598119;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=At1d4DsGvoBkrkeqmLrpO5m115sUYRFdd0heKIcaWwI=;
	b=ZaObDTpAQslR6KqUjonqTifuCJAYD4axPS+Oab5Zjdcda9iVpAC2uXzgGAGl/B4YZThq
	 PAJp77DWQiqRo2NgnErYJUPfhheNFN654m/Q+QC+DBFKJnu0Yn33makNBGzd3T7NSn8Cs
	 FXmHXSCz/aKjYRQlO2zsUxkeuCjBq5yF1kzd3KQeJ2zxy0UjtHpCmkxOfMmV64NEspPbu
	 5HpAbh3JcDzPBT9/h2OzEtcHnK25cpSbgOH/5B8gEL+MREbQSxA0SYa2GlUP9pUqFhLoN
	 kmy6766hO3QGUdKILtf43pU4VRUM5hfpT1rd4Q7LMJo3gzOgNW4vcwNbvdJvA6Ku/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQVEFCae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B35606A33A;
	Wed, 25 Nov 2026 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQVEFCae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DEF1F000CF;
	Wed, 25 Nov 2026 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795598119;
	bh=At1d4DsGvoBkrkeqmLrpO5m115sUYRFdd0heKIcaWwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QQVEFCaevC7OTekhbBH2fgLn4bFnpcyHnzmYrRUGMUcC5JrLTKUIxKjfqOj6VPeg3
	 LTXhE4pmeFxRUkpOluQWzi6TDDsfzXAfeUT+fLVZ+ovCyKffXaTIm/kLqEBHDL6JM6
	 MTxr7UOGEI5GVWqAY/LonJF9cdbdWEof0Xc3rPwNJLTQi1NB+muhq6qViOsqiW3uH4
	 yaUK/haeqkqCJDEYjt61wNoMxmdD/DYMYUj4GwXtUAeQ+VFTPZmQJ0K/Xfu6aVoWKP
	 J8mcQEsbf0ni5BgSbLUyy5ILwP8q1f206/aWTNEXSLqHCpPGdSjBvl5wpSYtnJ+Edu
	 STtAhutLpek8A==
Message-ID: <16abfc2d-daf1-477b-87a0-7a6993370b6f@kernel.org>
Date: Wed, 25 Nov 2026 10:15:13 +0100
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
Subject: Re: [BUG] mptcp: pm: WARNING in mptcp_check_listen_stop() when listen
 fails on a new endpoint listener
Content-Language: fr
To: Kyuwon Cho <kyuwoncho18@gmail.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <179502042942.2742790.17887994424282536144@gmail.com>
 <5d651146-b21d-44da-9f15-860f0c9c2dc5@kernel.org>
 <179502653236.3033236.9177220287548482679@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179502653236.3033236.9177220287548482679@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kyuwon,

On 18/11/2026 19:31, Kyuwon Cho wrote:
> Hi Matt,
> 
> On 18/11/2026 19:18, Matthieu Baerts wrote:
>> Please always decode stacktraces with ./scripts/decode_stacktrace.sh.
> 
> I'll keep that in mind and decode them in my next reports.
> 
>> Out of curiosity: if your LLM has already analysed the root cause and
>> has a reproducer, why not ask to generate a fix and send this patch
>> instead of the bug report?
> 
> I'm more used to communities like LLVM, which are cautious about
> LLM-generated patches, and I was hesitant to send a fix for code I
> don't know well, made in a way I couldn't fully judge. So I only sent
> the root cause analysis. Thanks for explaining; I'll send a tested
> patch with later reports when I can.

Thanks!

> For this one we do have a small candidate fix, tested with the
> reproducer: it puts the MPTCP socket back to TCP_CLOSE when
> __inet_listen_sk() fails. Since you already have a fix for v2, would it
> still help if we posted it, or should we leave it to your series?

In the meantime, I guess you saw the patch I sent to the MPTCP ML:


https://lore.kernel.org/20261121-mptcp-cmason-fixes-v2-36-00327fd1de1f@kernel.org

If the fix was different and your reproducer still see the WARN with the
patch I sent, feel free to share yours.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

