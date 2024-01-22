Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B57A4A28
	for <mptcp@lists.linux.dev>; Mon, 22 Jan 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705888048; cv=none; b=lalXtWY2XoUlAXWZAGhMpYI1ZEjdq4cD+k/SzQATebp9nJTnxTmbNTJfS8m5OwugjgNm7QJjlJ/7ZPUEH9HB62DN3qEQipIErkKsKTfWurZrAWpxhXiT+Qoj9FCxVar+EBs1v6vvzx4lkfqas/bbjx0TwfFYbepaGw/6TyU/QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705888048; c=relaxed/simple;
	bh=a5BEKvbCIQggB0P6OdyiqiXr+1+faFB8ziCIDk9z8nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nvexqLbmS6B7Y6bcRlmTT6BsdYnYwhRGQzRXLPrsKxWjWjXlqk7lP2BcVKVz0NWoDolGvfIaQlZHWhTW5S2EF3WsfsAw/MNPCDpViCNfjK9p+JkHNDNJ3CwCRecoFZo1sA+AUb8EzPp14eRGPVfQSWrDTQTl3rApb+Wfr/LGb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzBr+VYz; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzBr+VYz"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e67e37661so3569526e87.0
        for <mptcp@lists.linux.dev>; Sun, 21 Jan 2024 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705888045; x=1706492845; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VOS/uBJnH2c7oN9aVh6eSBL5Nld/NqyD2nOGrrgErSo=;
        b=SzBr+VYzsQ/TKDes4Ic3CgwUq8d18CaDwxj/Vfto7u4IGW44nGPV7xNGKrwawOCeOF
         xlPg1ZU07xVRdOmPj2X+EGT8p/SOkDEGR6z86fOMFjeETqr2UGvpwrbs1/K58ZG0DvKF
         7hVKP5Z0uyNFLc9LgZyzu+MrebZiWxXpEAU8sGMrwa3XUVTf4EaOlH7XN8bhrCaMAMCA
         lIPCEdJvAPRwuT5GZ+ZD/y7vfsGRor0BnmXDbzMhUEkWtGxMw4HU3QkIAeqnSSRDEI+V
         1EjRK9tDH5YtFCRZbr2lejD5rfuQWiLRY7WQkCw5aLVrCKyWcSl7ErJNRDv3z6tKOOgx
         EH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705888045; x=1706492845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOS/uBJnH2c7oN9aVh6eSBL5Nld/NqyD2nOGrrgErSo=;
        b=bDBnWUlDvSKWAuLMO1UZ6FqvqvF3yfsnlJfP55wr+f1NGA+U2oZxr/18jF25fX8oMj
         6NypwaompTntDPYuRKvd4MePFb8Vjs6xbMdCPo8Usdo52Lppk1cBFT0DybNhd6w+djxE
         K72oPyTfeG4mOgV8j0w2W+V2vGrMZoOMyscR75prbV1IjObG9Lm72w8NRu4ovW3UYjqK
         f0I2n5yWK+v4tQLS02GUFwsf0CD5MjwrsxDLXH0QHpQP8NWrPqx/bI3pk5cn8hTxr3Xz
         ehGnPcrSRuBiUWnLJ1pRWO0yaSSzAIc6B64H+frB56G86DTk/9ZLwpPWcoPfTLCifvtz
         3IYA==
X-Gm-Message-State: AOJu0YxWchtYTPPktaMVDuPRM7wv2XglT6WmAMgceiQSypnuZ9B+Gn16
	fEIMQLVrm7PFXw0dM4TcnscSJsF1IaRDzx6hBDXQ/IqCj61URd9jylSWPLyb+nR/5JxFvDHkSmk
	MElVv+Nf5T5tT0RHK7WTwm9Hg38Y=
X-Google-Smtp-Source: AGHT+IEO2vtOdaCPIqjRKQp5RGdEU9erVDveJl0ZNyxqyPDbYVQpzGx1VUF3GzqSOAo4jGthIfxrRF9NzOuxTPjQAYI=
X-Received: by 2002:ac2:5fd2:0:b0:50e:aa30:5ead with SMTP id
 q18-20020ac25fd2000000b0050eaa305eadmr1171517lfg.113.1705888044954; Sun, 21
 Jan 2024 17:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-0-f3a4db41c3be@kernel.org>
 <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-2-f3a4db41c3be@kernel.org>
In-Reply-To: <20240118-selftests-mptcp-simult-slack-qemu-no-kvm-v1-2-f3a4db41c3be@kernel.org>
From: Geliang Tang <geliangtang@gmail.com>
Date: Mon, 22 Jan 2024 09:47:13 +0800
Message-ID: <CA+WQbwtkbYkxMkfhs0yUOx5RnJ2_ftNf7i0URMpcBL7qK7GdhQ@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 2/7] selftests: mptcp: add missing kconfig for
 NF Filter in v6
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Since the commit mentioned below, 'mptcp_join' selftests is using
> IPTables to add rules to the Filter table for IPv6.
>
> It is then required to have IP6_NF_FILTER KConfig.
>
> This KConfig is usually enabled by default in many defconfig, but we
> recently noticed that some CI were running our selftests without them
> enabled.
>
> Fixes: 523514ed0a99 ("selftests: mptcp: add ADD_ADDR IPv6 test cases")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index 2a00bf4acdfa..ec70b27288fc 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -20,6 +20,7 @@ CONFIG_NETFILTER_XT_TARGET_MARK=m
>  CONFIG_NF_TABLES_INET=y
>  CONFIG_NFT_TPROXY=m
>  CONFIG_NFT_SOCKET=m
> +CONFIG_IP6_NF_FILTER=m

How about adding this config right after CONFIG_IP_NF_TARGET_REJECT=m?

Since "IPv6: Netfilter Configuration" section in kconfig is always
after "IP: Netfilter Configuration" one.

Otherwise, the first three patches LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang




>  CONFIG_IP_ADVANCED_ROUTER=y
>  CONFIG_IP_MULTIPLE_TABLES=y
>  CONFIG_IP_NF_FILTER=m
>
> --
> 2.43.0
>
>
