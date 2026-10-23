Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746540;
	b=Pu9NcbdqRXrW5wQb2oCrzqOCPlMwHBd+15vEwf1UBpnPYkDOXCejpGpq/HasZYS5cw4E
	 42MXjI55bLatRdIU/s1VCHqvMnZO9g6v0gYL8G0Z8IBik0KkxUye3HlvTVxbCCC/H5elR
	 mIEuP4RBOorCw7hsxyNxk0fzAErRBwspP92ZvznkVep6SLncahsNaIQDxzAA1/fehmH5r
	 2NHc8j033PP4Qp1KSb3+Ia/cYojA/X5uHTRhkVOCTFn62VLs2eLsgSaO0iu8Gw13HzkqA
	 uNUAU1rxrXdkCpwhNK4PvuJxVSx4hQvThsqkLTG8wAyNX1ES8ikBPbbOARgIdDqNkcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746540;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KeMhwbM4XKDLOjOlYf1I8A8MxaWR4J/jIyEDC4kqh5E=;
	b=CVlkw9xaeoHrIjxB+Sr/nD7AgxInMh1Hg6YmqR5o6JLsfgEW/j4sJYdAAXnv4JajFxQu
	 QuU3rB5sz47zbwkQ/9385jrYck6XZxVAvyVvRpLTDVGY6iBpu+kZMMybREKa7ruoy6Gty
	 VcC4UxmXfYzHZwVU/drZ9OIRLYpmDCMDMCUz5hLWvRbqm3V7yZJGK2NwHMlzokfZxVnuS
	 2HOOLCzr7aFNorsIKKxO/iCd0J3l+jXcZpfUGiDEBmFkGK9XHQaygrpRoiSOF0LUJ0mNH
	 jiwcxOpNQp6prG1hO2ykWiV4Y3oFUuMLT8KILm0BUCEVqHCpXypGAYD5qlbP5eqErkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHiIgJ5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA2606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 09:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHiIgJ5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0931F01825;
	Fri, 23 Oct 2026 09:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792746539;
	bh=KeMhwbM4XKDLOjOlYf1I8A8MxaWR4J/jIyEDC4kqh5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SHiIgJ5oVQzJ0qOj18bhLca0QU39KkeicWJY1jxNuS1nuWTHSK/S2wq7uRQiz2Bd/
	 JjZPAMDq5+qo6rRvO00opBn8iqt1wCkJOCJMBbXsAYbqA0BOWgXojxbk5YuFOmxX+T
	 8YN2XP1PwfTS9hw90Oy2VDa4OqUDco+s8M0r+ihg4sWRrMYia9aWMTs5B9+gzCZ3xa
	 qSRzmFMP6eNozOTYISyTvLb3dtsShG7bIO2QiR8ggSE7g8K+LZZXAiDoqoje/cE16X
	 azO/3t7fdgNnqLgQZ1pL9b++ro4/mpB9PkNeh7TmETHH5a7DfeLaOrT50CWxBYkBm5
	 Nkj6Eh5Vm27Jg==
Message-ID: <006b3282-7caa-492a-88de-f7b851ed2694@kernel.org>
Date: Fri, 23 Oct 2026 11:08:56 +0200
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
Subject: Re: [PATCH net-next v9] mptcp: normalize seq numbers reported in
 mptcp_info
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, pabeni@redhat.com
References: <179219616568.3135.11934165875223757638@kernel.org>
 <20261023084340.665126-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: fr
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261023084340.665126-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

Thank you for your reply.

On 23/10/2026 10:43, Kalpan Jani wrote:
> Hi Matt,
> 
> Thanks for discussing this with Mat and for the suggestions.
> 
> I understand the main goal is to avoid exposing these sequence counters through the diag interface.
> 
> I think keeping the normalized values available through the MPTCP_INFO socket option, while handling these fields separately for inet_diag, could be a reasonable approach.
> 
> Before updating the patch, could you clarify whether you would prefer:
> - Setting the relevant fields to 0 only when the user lacks CAP_NET_ADMIN, or

If that's possible, that one. We already look for CAP_NET_ADMIN in
mptcp_diag.c, but maybe not for these requests.

(Maybe we should backport this patch, I don't know)

> - Always setting them to 0 for the diag interface?

As a fallback, if the first option is not possible.

> I will also look into whether the byte counters could provide the required values correctly, particularly for snd_una and retransmissions.

Thanks. That's an alternative not to show 0 to userspace. But only if we
display the same things: starting at 0 (or 1 for the SYN), snd_una as a
diff on top of bytes_send, etc.

> For MAP_SEQ, I will account for its relationship with the diagnostic interface when preparing the change.

Thanks!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

