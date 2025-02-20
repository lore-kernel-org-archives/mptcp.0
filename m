Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF8E1CAA9C
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048049; cv=none; b=DQFJlVA2LSGr933UBWV5SEPvJpfbk6JnO+0dqpDQ6I071pfGB0ekU3/wBqoqB4cMrqD7gbtMUV5iRo2T9ey+YnD0poMbKyij/qkinpo3qoSWXNtXS477wqAE14ck0+VjHFPR4OSMxebWGYgxK8Imi8bMkZ2rVbtR+JzbtNFGhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048049; c=relaxed/simple;
	bh=XqaiZvWNoT90Aj7WV22bPQyEk4n17BKkxJyo+ZoKcqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KPOCl4yud4khiHN9bYg9D3D5RMcFgq7BNdy/T0VpJ6gjMmBgOlyNUJlSJ9yeiAgEjziS1QIzUAdHQc5Q3+D45s+a32/ZqLoDMU8D3sfl2QKnd1LATTDOky5Jxlib+4LEkh4PwbtCAaGX0bPmoFc4bgmpvG8xq9m6exs5Hp09eOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ+hHK6v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ+hHK6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A733C4CED1;
	Thu, 20 Feb 2025 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740048048;
	bh=XqaiZvWNoT90Aj7WV22bPQyEk4n17BKkxJyo+ZoKcqY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=aZ+hHK6vVYi11WtsZZKZUiHoCAHrdsAOwMzRGKVTePoIuwkfSXcx2f69t/CVPlhRM
	 k09a2HNtuWecvrhqEMV5mE3nGASblNnume4LxBt6zo/HZ9C3+Ny/C2wR7hRI/v5vVN
	 g5mW11XXvl84nG7F0O3/fppB4XPYOBKn2qrZCskmvVqNE0lzTXTUS70GlVYEn1Tqi1
	 0FdVrooTbyCObayqlFglrAfOL9SpWwrtW0qNSuJlgdlIA2hzGiVmk3BS+kktvPIPxl
	 iVp7XzIqt5JQRhl4BiFl4keIDk2DLPx8QIpnKIf5faHKq7oXcW/kIIxxsoe/lrhZ6/
	 Jsk+JXVfnZ/wA==
Message-ID: <3a050151-d8ce-460e-a1a3-70c81b706083@kernel.org>
Date: Thu, 20 Feb 2025 11:40:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: always handle address removal under msk
 socket lock
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <61cded134e753976259b48a4269f203dcae6c8fa.1739969092.git.pabeni@redhat.com>
 <a103802c-90e2-4cda-86a4-6bde5bb28670@kernel.org>
 <2c71d642-cbd6-402c-8300-59f22533654c@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2c71d642-cbd6-402c-8300-59f22533654c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/02/2025 10:33, Paolo Abeni wrote:
> On 2/19/25 6:45 PM, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 19/02/2025 13:45, Paolo Abeni wrote:
>>> Syzkaller reported a lockdep splat in the PM control path:
>>
>> (...)
>>
>>> Indeed the PM can try to send a RM_ADDR over a msk without acquiring
>>> first the msk socket lock.
>>>
>>> The bugged code-path comes from an early optimization: when there
>>> are no subflows, the PM should (usually) not send RM_ADDR
>>> notifications.
>>>
>>> The above statement is incorrect, as without locks another process
>>> could concurrent create a new subflow and cause the RM_ADDR generation.
>>>
>>> Additionally the supposed optimization is not very effective even
>>> performance-wise, as most mptcp sockets should have at least one
>>> subflow: the MPC one.
>> Thank you for having looked at this!
>>
>> By chance, do you know how syzkaller managed to interact with an MPTCP
>> socket not having any attached subflows? An msk being destroyed?
> 
> I'm not 110% and I don't have the syzkaller log for the relevant splat
> handy, but i.e. a passive socket at clone time does:
> 
> 	list_add(&subflow->node, &msk->conn_list); // [1]
> 	sock_hold(ssk);
> 	mptcp_token_accept(subflow_req, msk); // [2]
> 
> under the msk socket spin lock.
> 
> After [2], the PM ops can find and operate on the newly accepted msk
> socket, but lacking any lock protection and memory barriers could still
> observe an empty conn_list, even given the prior [1].
> 
> The race is tiny, thus is hard for syzkaller to find a repro.

I see, thank you for your reply and for having checked!

I will try to keep this in mind when looking at future potential issues.
(And not always assuming there is at least one subflow in the list.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

