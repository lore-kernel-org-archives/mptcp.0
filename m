Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606252;
	b=2v9wnHHMazN+Gm9NXIbxJWCV6uci8N77aggSjJui5KAPIKGFuUXtTqE3sVO/1Kw+6nan
	 bE89zVu2Kjen47yr6ZpHn+o9vfS/rGcZgms8Xom1zM83MLlk2hgluy2MjHYYIf94QY2VZ
	 9o01vQ+hMzYzr6atURnoxybL2mq7CW+Fg4QIS3djbrBCpVhtKSC9I/dr5YGkgR+gDpF/B
	 cEefy+V75MntfOkMyl9SLv7L7dc2E/050PxBKFqSOiTW/LKjQKlIKklMdPQ+Oh1ce82xD
	 oJCU3LwrT8yehtDKWcYcCln0rSb5IgfThFSDzwU0jTDKSVKP59z7BBsA3RKP4IaGOwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606252;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=AJGJFJgIN9a9PiV6Ajvx85dX2jXCPM1+1yjU3R618wc=;
	b=OATAHnJBYqRb3XYmf5CXqK1Bkwlq8gvsYl8wUP0xk48ohPCX3Y1fnLVF2yYWQwoFpbqa
	 dc7yd4JTa+GRHdHf5ntGAxOAmhkdB5W2hKr8vO8Cdp/I2AxErENNqFiOayoSvyq4PRpJZ
	 wlcXGEmDMKOKNU/LmHpP2OYhH7o4IFJvRiNHl8prot3q4dsEQDCVbNUdozCVySprQoCAX
	 pW8ZX2QhhsVatZlqtyZKkXO6iVgUNQj5DdCPJec81JO14J5zUx7NWzcyxiGxsX7zHwNoC
	 Jru/C/4LLUUyaj/ltk8Iw6bfrKTZrg7Vki9tLwKd5hfCw7UQPgAczhYHbaqkefugsDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpqVFAjb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3D606A31A
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UpqVFAjb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D331F000C1;
	Wed, 21 Oct 2026 18:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792606251;
	bh=AJGJFJgIN9a9PiV6Ajvx85dX2jXCPM1+1yjU3R618wc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UpqVFAjbOTRHFupo+qoXpkYD2k2gQvX83OnY6kZUsUEQ/tgbxDt6ccRH0mBtbFOSk
	 LLddelKme1eb6hqJDJl1A/8Q2Ss+h7ZaeOkhT334GOIR9XXOuUPngiqbrP242+YUPl
	 QZPXBpLNJUs9QXTtk4jpq+3/ZNzQTswRRk2SrXzchLpypVKby1UuM2RlxhV73DmN0j
	 TM8SQFtA0a9UAwNJXluo4nJGN0aWz8X2QOKmjL3muycs7LD9TFgmWA9oKg2idgVzfH
	 MhThLk9E8ZZXl9MUo40uLmAD7d0rZWijxs7NWEfHy/d9uyDk4FJYkHKk1LeadKz7oD
	 QE/mY5/41XpRw==
Message-ID: <7ccbd3ab-f6e3-4d67-903c-fa442e875ea4@kernel.org>
Date: Wed, 21 Oct 2026 20:10:48 +0200
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
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
References: <179219616568.3135.11934165875223757638@kernel.org>
 <20261019111637.27002-1-kalpan.jani@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261019111637.27002-1-kalpan.jani@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

Thank you for your patience.

On 19/10/2026 13:16, Kalpan Jani wrote:
> Hi all,
> 
> Thanks for the report.
> 
> I looked into both observations.
> 
> For the first one, I see the concern about reading the sequence
> number and its baseline in separate synchronization windows. The
> connect and disconnect paths also need to be considered when deciding
> how to keep these values consistent. I have not made a locking change
> yet, as I want to avoid introducing a locking issue while addressing
> this.

Yes, maybe we don't need to address this case (see below)

> For the second one, I noticed that mptcpi_rcv_nxt is now reported
> relative to remote_idsn, while MPTCP_SUBFLOW_ATTR_MAP_SEQ still
> reports the absolute sequence number. I have not changed the MAP_SEQ
> attribute, since that would affect an existing diagnostic interface.

I think that should be updated as well.

> Would documenting the normalized sequence numbers in struct
> mptcp_info be sufficient, or do you think any further changes are
> needed?
> 
> I would appreciate your suggestions on the appropriate approach
> before I prepare the next version.

We discussed this case with Mat today. We were thinking about two
solutions: either using the bytes send/received counters (and a diff for
una) for the different fields you updated here, but we didn't check if
it would work, e.g. in case of retransmission how is it incremented
compared to write_seq?

At the end, what we want is not to expose these counters to the
userspace via the diag interface, so visible with a simple "ss -Mae". We
wonder if an easier alternative wouldn't be to set these fields to 0 if
the user doesn't have the CAP_NET_ADMIN capability? Or always set 0 for
the diag interface. WDYT?

(Not as exiting as the modifications you did so far, but effective...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

