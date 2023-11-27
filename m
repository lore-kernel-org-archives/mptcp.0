Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44273C46C
	for <mptcp@lists.linux.dev>; Mon, 27 Nov 2023 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm/uMaF8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6CC433C7;
	Mon, 27 Nov 2023 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701109014;
	bh=v2mYzDBec4K/B6qNKk/sKclmwsg2+U1pEsG6CitU9AQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Nm/uMaF8s78VZ6dChO5VCLxGp+ngwQYf+EYJ3CvY9Z3K++D20/xmdQHvBr++sB36k
	 MkU+ofrvWnz7ahixRgOmvtjxLKtNwYBg9c46+XBWEsFRe9FoZHmEQdUUfx9ODLhKRA
	 iy6yFzWp4VJjIGzh/c7ie1zDXxvJTjQ96gpHtKxeOeeCPcZkLppa7ElInW+bS2BORJ
	 MXiRJSwpCT0+Vcp4y3DRT4WuzmINQOYuufs3XGSpdu2wd/YlpstbOTOxqaPNlTQoOQ
	 FKAT3QPJP7UKNeOjE7szbst2EVK/eUuzlCai9W4xz1KCr28eJBcZAOmbZSpYgkvLRk
	 zWo80UwdC0vug==
Date: Mon, 27 Nov 2023 10:16:53 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] mptcp: fill in missing MODULE_DESCRIPTION()
In-Reply-To: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
Message-ID: <4dcca91b-ed31-72fc-5552-7754c420b612@kernel.org>
References: <20231127-mptcp-module-desc-v1-1-d2209921bf9e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 27 Nov 2023, Matthieu Baerts wrote:

> W=1 builds warn on missing MODULE_DESCRIPTION, add them here in MPTCP.
>
> Only two were missing: two modules with different KUint tests for MPTCP.
>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> net/mptcp/crypto_test.c | 1 +
> net/mptcp/token_test.c  | 1 +
> 2 files changed, 2 insertions(+)

Looks good:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> diff --git a/net/mptcp/crypto_test.c b/net/mptcp/crypto_test.c
> index 017248dea038..220414e5c850 100644
> --- a/net/mptcp/crypto_test.c
> +++ b/net/mptcp/crypto_test.c
> @@ -70,3 +70,4 @@ static struct kunit_suite mptcp_crypto_suite = {
> kunit_test_suite(mptcp_crypto_suite);
>
> MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for MPTCP Crypto");
> diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
> index 0758865ab658..bfff53e668da 100644
> --- a/net/mptcp/token_test.c
> +++ b/net/mptcp/token_test.c
> @@ -143,3 +143,4 @@ static struct kunit_suite mptcp_token_suite = {
> kunit_test_suite(mptcp_token_suite);
>
> MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for MPTCP Token");
>
> ---
> base-commit: e7a5909d8593c93796bd85913fda617a08dfce7b
> change-id: 20231127-mptcp-module-desc-f74500c2fd86
>
> Best regards,
> -- 
> Matthieu Baerts <matttbe@kernel.org>
>
>
>
