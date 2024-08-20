Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EA18E352
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143998; cv=none; b=jA3HUU7bdnx5Wg+CjwvZjHO8ngCr/gcSFI3kKTH/xvnzB/8A4x4DjeKRiP0AHrev2rfqIf8Dwfws8yWqiOahobFb8vA8BJ+Ak9EovzpyKFxmP7G+pJtmEmAnQ5n1vDhQRgGbpA/PvKL96kVJ5ZFNS7OivSXKAirrx4YBIQ42P6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143998; c=relaxed/simple;
	bh=Ifm7OZ/Ng/3c7z9yjn4n0OPWVsfq1oZhAJdwJWx/HV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ7vTZud28pGZ3eavVkDNjUwysy5Qc8rnrimiYVw/LzKFpaAGI4J1kIQW47jw0qeEI3LTEfmOMhoa2b+DfN5qppo8TZDq4X/wtJ24qdafHsf8Ll9bSIwB+ENWj+YFR//8HKgBeBYIFdqj3QY9tKoOo9Uadpue3bxbR7ctPKwqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qExhcKoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qExhcKoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B1EC4AF09;
	Tue, 20 Aug 2024 08:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724143997;
	bh=Ifm7OZ/Ng/3c7z9yjn4n0OPWVsfq1oZhAJdwJWx/HV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qExhcKoq8ggL0bi9d/pOKsDUgPNH4+l+rBhsKM187P9EtVKFiypLg+CoYg44IwZGG
	 xnMBQUvjVS3ohpGXIx+YYeRZjH48TF6AEyHX7RUnC+p7ZeA56mmRpYF0DexXD9d4Z1
	 16BrEtvM6fut1/tw59jqKDfMwSbDLPo1iNqpC/fYfwQ73XiAe1yPrCkYZ0bvFUi5/d
	 APfG/s5GAX8NS7B9mUZ4HgcHilwvQIkntpf3QnbuDFKJq5eQF1/EfVStknsCEODWSO
	 NWmEqS0UhdpxkP3dishELsdIdWYGj7MFI4KakrlLyimG++c0m1p7vJkS1xBsM74NKF
	 03GECd1XGRKBw==
Message-ID: <02ff5460-4170-48c1-a01a-b6842525efcd@kernel.org>
Date: Tue, 20 Aug 2024 10:53:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/2] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
 <1c6d49faee85ac8e046b79c3aa060a1170d4d54d.1724142917.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1c6d49faee85ac8e046b79c3aa060a1170d4d54d.1724142917.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/08/2024 10:44, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Close client_fd as Martin suggested.
> 
> Please update my email address of this patch squashed to as:
> 
>   From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> since BPF CI complained about it:
> 
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Geliang Tang <geliang@kernel.org>' != 'Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>'

Good point, I will try not to forget about that!

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 9d4e3c1d4e7b..69fdcb28249d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -383,7 +383,7 @@ static void run_subflow(char *new)
>  {
>  	int server_fd, client_fd, err;
>  	char cc[TCP_CA_NAME_MAX];
> -	socklen_t len = sizeof(cc);
> +	socklen_t len;
>  
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
>  	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> @@ -393,9 +393,12 @@ static void run_subflow(char *new)
>  	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
>  		goto fail;
>  
> +	len = sizeof(cc);
>  	err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> -	if (!ASSERT_OK(err, "getsockopt(srv_fd, TCP_CONGESTION)"))
> +	if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)")) {
> +		close(client_fd);

Probably better to keep the traditional way of dealing with errors: by
having only one exit path. In other words, can you replace the 'goto
fail' here by another one: "goto close_client" (vs "goto close_server")?

>  		goto fail;
> +	}
>  
>  	send_byte(client_fd);
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

