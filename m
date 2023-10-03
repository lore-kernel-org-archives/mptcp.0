Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1530CF2
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 17:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59558C433C8;
	Tue,  3 Oct 2023 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696352448;
	bh=tRCDOIouY5wyM44jl/uNXTaDeJ6LXVtgGJxFHWOr75k=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=I+qLdNsaHQnStArroWMH6ZWssgZQBF8KtLYjPgDmrThQWMrtBDOtuWft+bEua4yQQ
	 CXXzJnIH6is9rzhbzKb3fyS6+sMLO2+FBfoFWoZqsqTffFxIGUIJQ+dtZEt0uCQbaL
	 ptbcTiAhD8QzGyqjPO/YTw5m45rQEUvGm9uKfJuMPCY/rRHK8oiHCTJsYI1th4eljC
	 Axsc8udFeDWzDzY0QNkY1Rhl2zBG3qjfnzoiOojJ6/Gc/l8snSf7gQoqqV3aseSDd7
	 5z8GvwQz+awgkQg6bvU5LHFWLnSjZO56XvkwELONtT4F7xJtZnMR62FJgrnSZ6J4dd
	 Q8LFGSuyh6n4A==
Message-ID: <1062d675-bf2d-49c7-8d15-a6af2cb8cf0c@kernel.org>
Date: Tue, 3 Oct 2023 19:00:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] MAINTAINERS: update Matthieu's email address
Content-Language: en-GB, fr-BE
To: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: Tessares
In-Reply-To: <20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 03/10/2023 17:29, Matthieu Baerts wrote:
> Use my kernel.org account instead.
> 
> The other one will bounce by the end of the year.

I just applied this patch not to block Mat to send other patches for -net.

@Mat: feel free to add a RvB tag if needed (I can add it in the tree as
well if you prefer).

New patches for t/upstream-net and t/upstream:
- 07a08ce3dd39: MAINTAINERS: update Matthieu's email address
- Results: d6b1c4fef06f..1d5658e7aeb2 (export-net)
- Results: ad8e597b726a..5475e96c3d7a (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20231003T165758
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20231003T165758

Cheers,
Matt
