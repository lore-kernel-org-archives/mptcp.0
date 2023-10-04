Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CAE1B266
	for <mptcp@lists.linux.dev>; Wed,  4 Oct 2023 15:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3A4C433C9;
	Wed,  4 Oct 2023 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696434964;
	bh=TY1KsD/zA6NXRJaDfxHZ3SuExovxpoyuZHB2EUsE5rY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=P801Hd0ecjul6zXH8P3Akm7zkdpyqevqXuQ7MG6xGbCr8svupJCuO/BcVc3FYDmfH
	 BYumUete0uFCv1wsnRlWmiOrGlLcQFtIB6oLYgSYUtlfy96KhzN5YHdqyc5sFkx5O0
	 tSn6DrVjDWNbeUu+yAOGDzUj0dA5aSix02U5lKjhnZsDMat24Ai+5+yieJtCRPfIiT
	 uXBb1bVULg8gmIpyRoaKYmTonHOhbgJDwjMP2DyvE5d2egDfoeELPZxB8arpQlMKRa
	 0L24qWC2GOAEfPWpTxqGNNDRuyYLLiJ/5T0JdiLSyVYWhkq/2ugQh9arqzODuZsHQm
	 Qe7BnVUh5K1CQ==
Message-ID: <3f41e4a0-dade-44fc-b336-b9643444f6d0@kernel.org>
Date: Wed, 4 Oct 2023 17:56:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2] ss: mptcp: print out subflows_total counter
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1694763508.git.geliang.tang@suse.com>
 <3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Organization: Tessares
In-Reply-To: <3ca520a2ce84c33ad8f9421add0b717091173a22.1694763872.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 15/09/2023 09:45, Geliang Tang wrote:
> A new counter mptcpi_subflows_total has been added in mptcpi_flags
> to count the total amount of subflows from mptcp_info including the
> initial one. This patch prints out it into mptcp_stats output.

Thank you for the patch! It looks good to me:

Acked-by: Matthieu Baerts <matttbe@kernel.org>

I guess this can be sent to iproute-next when the corresponding kernel
patches are in net-next.

Cheers,
Matt
