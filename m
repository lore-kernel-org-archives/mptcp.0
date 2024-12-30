Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52443AD2D
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735576262; cv=none; b=OnmOyuq8tbuaMTdwNDf7yYqDcNRJJM7yisaCHz47a6IY5EwR17PRE0iy+ixdtMhSCcBDQf2J8E553hmqRTZ+UE32t1hHXhQi5kZs9+6ZE4tUfkF/RShPiLQbm3JdFa2AQGMo1gMI2PefV1s7tCx9CAHzUCe7wUCTyWxzyvbucCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735576262; c=relaxed/simple;
	bh=VDAnh5UbqSqiP2OsUZgyZ5vyAKvOS3aCPtfeeu8Ce2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWFuCEmgoVYmkY+CwM4oot7RfbaZ5FmIzGFAc8qexqa6pky/cvO4fExCKdhmj3lpiARTLD2Pwc72BLb4oC3s0Dv1VBNuWYFBG16XWuYORmQ5rI+tSKhfk64uL2pzpOov5uZUtz3tTRuZhiVnmAfYst6CRcmcsau1/uSa9eq5vn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD97opdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD97opdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EC4C4CED0;
	Mon, 30 Dec 2024 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735576262;
	bh=VDAnh5UbqSqiP2OsUZgyZ5vyAKvOS3aCPtfeeu8Ce2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FD97opdYGtCtrV9fv0ZHnEKbDjlIJ/FV3ZvNj45i6xI66KFlb+j2MzksNYwJCG1oW
	 Mxi+K7JRG1PqZPnAVk18MKYC5cA93e6zUkftjjqfEHexm0uqXdMYq/7p3iwyBwzgVC
	 mOWmyFVJwKQn9Tg7w9iXL20iP/Ib1I8nBhNoOCz3rNbNWJqjNfctK6zmj34W3ZASMM
	 PEXs+HUXCqxe0AzF0ZXK9WsQYMycspt2X/JCFhH/1O/TDE3IXGRAKPZEbpOR4pKP1K
	 m2O3IVV1XUoa9RUhs5eFAvoOiNPb666jw7D8//3FDbhQBL+acm8rjySvknzDyZHq33
	 dSmHrVfXGOiaw==
Message-ID: <0a9019be-238d-4b02-ae7e-b510503ff6ac@kernel.org>
Date: Mon, 30 Dec 2024 17:30:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 7/8] mptcp: add mptcp_pm_addr_id_bitmap_t
 type
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1734074788.git.tanggeliang@kylinos.cn>
 <789602f25f9fc73043f85417b6e147c49d894b66.1734074788.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <789602f25f9fc73043f85417b6e147c49d894b66.1734074788.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 13/12/2024 08:35, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to defining types such as nodemask_t, dma_cap_mask_t and
> cpumask_t to simplify the use of bitmap, a new type for MPTCP
> userspace pm id bitmap, mptcp_pm_addr_id_bitmap_t is defined to
> easily modify dump_addr() interface of the path managers to accept
> an mptcp_pm_addr_id_bitmap_t type parameter. It also allows this
> parameter of dump_addr() can be modified by BPF program when
> implementing this interface of a BFP path manager. Because a
> dump_addr() interface that accepts an 'unsigned long *bitmap'
> or 'unsigned long bitmap[]' parameter is difficult to implement
> in BPF program.
> 
> In addition, this also makes it easier for us to implement similar
> logic to mptcp_userspace_pm_append_new_local_addr() in BPF path
> manager, because there's no way to use DECLARE_BITMAP macro in BPF
> program, and it's not easy to reimplement it in BPF.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h      |  7 +++++++
>  net/mptcp/pm_userspace.c | 14 ++++++--------
>  net/mptcp/protocol.h     |  3 ---
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 814b5f2e3ed5..220b1f60e8c1 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -120,6 +120,13 @@ struct mptcp_sched_ops {
>  	void (*release)(struct mptcp_sock *msk);
>  } ____cacheline_aligned_in_smp;
>  
> +/* max value of mptcp_addr_info.id */
> +#define MPTCP_PM_MAX_ADDR_ID		U8_MAX
> +
> +typedef struct {
> +	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);
> +} mptcp_pm_addr_id_bitmap_t;

Why do you need to declare it here and not in protocol.h? Is it for the
future BPF PM?

Maybe you don't really need this bitmap if it is only needed for the
dump interfaces that are probably not needed with BPF?

Then maybe there is no need to change anything here?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

