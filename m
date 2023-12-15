Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B330106
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkjMVSxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38029C433C8;
	Fri, 15 Dec 2023 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702664002;
	bh=HZD59L6MhL8SOr0e+neYbGaxzIxqlGS6bmSHJvUo2f4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CkjMVSxJ/s0DujL8O+JVWuESEPvhbYIatXRuoEs0kJsZ0FOOWGKGbrIUIg9EKdeq6
	 4p259GpiyhDgPZUzEmFszCoaeQbagdd0hWrfiKvekrbqWi9HdAMLNaXJouE9cuF2Jh
	 eS8+IfhWpldZANSfap4CtWnyMFqgI81PR6wsF1CGLRtae8c+DxiQfRQ2dm6HyeiyGK
	 8jf8Hoidx/wm/kHALcAejGHpe+Tvg5e45+qJjwOXO+VCilkSuZr08EGgBjs34ODzvt
	 dqqCIpW8r6ueacGdzO4NUTESjLFeD9KdnUjbA4/dsKYBwop/mLdZrLflCRrMSGxNoo
	 bGw1qhr6tChkA==
Date: Fri, 15 Dec 2023 10:13:21 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@linux.dev>
Subject: Re: [PATCH mptcp-net] MAINTAINERS: add Geliang as reviewer for
 MPTCP
In-Reply-To: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
Message-ID: <ea3a3b81-ab0b-1d4a-8a36-c397f2a6497f@kernel.org>
References: <20231215-mptcp-reviewers-geliang-v1-1-3fec5a0f8eac@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 15 Dec 2023, Matthieu Baerts wrote:

> For a long time now, Geliang has contributed to a lot of code and
> reviews related to MPTCP. So let's reflect that in the MAINTAINERS file.
>
> This should also encourage patch submitters to add him to the CC list.
>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
>
> @Geliang: do you mind publicly acking this patch if you are still OK
> with that?
> Cc: Geliang Tang <geliang.tang@linux.dev>
>
> @Mat: can I also add your Acked-by as discussed this week?
> Cc: Mat Martineau <martineau@kernel.org>

Certainly!

Acked-by: Mat Martineau <martineau@kernel.org>

> ---
> MAINTAINERS | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49c1caad5d99..b7e51b7b8760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15076,6 +15076,7 @@ K:	\bmdo_
> NETWORKING [MPTCP]
> M:	Matthieu Baerts <matttbe@kernel.org>
> M:	Mat Martineau <martineau@kernel.org>
> +R:	Geliang Tang <geliang.tang@linux.dev>
> L:	netdev@vger.kernel.org
> L:	mptcp@lists.linux.dev
> S:	Maintained
>
> ---
> base-commit: 84d8fb414b2a78b32e97b1e4888688bca82aecf5
> change-id: 20231215-mptcp-reviewers-geliang-4d826ebffd8c
>
> Best regards,
> -- 
> Matthieu Baerts <matttbe@kernel.org>
>
>
