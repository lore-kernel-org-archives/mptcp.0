Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835630CF2
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0858AC433C7
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696351775;
	bh=vk5M6jsyWfUwIjMHQOEyveHa8MXtCV7ecswhjbbPP0k=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BLNWwojcLyYqsG9vNzkx1lje7fDSahkEtwzk5W9hExOWmSB9gwkkI3eupyqejlYqT
	 114yAkUJeRriHqocw1uV0OH8Sv75fksTH2bgu5c/blIJ/CqHkKnv2wMv3pGxlJSQp0
	 geOGT+S2KTC4P6VTTU5lKVLFGqhZ7HQIqwZVpbNH4EbUzFLFR6LyK2QfaX9YJOMkdU
	 qL+TxDwEMaI/ZecVFOyfI3luuBd4qJO8ixrTWMBy9/bFfWKbDs4rOelRTnbXBvnNQD
	 61LZOjV06IfV97Af155PdyDWZHB2ny/x4PKJrsI5TaYO3PdldCfjyho2iM8wE4Qj4j
	 q3IAcY1jeWlIg==
Message-ID: <28d63c96-38a4-45db-8b72-dfba3cf8b7be@kernel.org>
Date: Tue, 3 Oct 2023 18:49:32 +0200
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
> 
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> 
> 
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Mmh, sorry for that, it has been added by b4 when sending the patch
because I created the topic before changing my user.email config. I can
fix that when applying the patch.

Cheers,
Matt
