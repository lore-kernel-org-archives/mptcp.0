Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E607A729
	for <mptcp@lists.linux.dev>; Fri,  2 Feb 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865575; cv=none; b=lY4/FRZSxunSmb+3gSORQ+E5DM73lzc1+b2E0LRwbnDAgM0409g2kk9CYRILFKppLUYJ/0KLUeZdoyFl/GNmORFAtdeLtrhRf1RhCfiwoJSRnsdFjVGvIE0NzhXOyRYRzaAsqd0WlQu0v0y02PGAbP/JSZ9+W28EitzQEZDv0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865575; c=relaxed/simple;
	bh=rKDaiGXzt+R/kGS+DqFZ3xwikgd90dW9FPGjCGpgprQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtB6Naz4OsA8Zx9HgJNa0MCCUL92DUFVpaHTSuoXX+K+iSmBdUUI5ep2EVuCq28K1owqh6vxxlY+yDH+QpxIdyuWf6tGWN1aPsVun9EGRyULujNlBDj7PdrdCIWHUgC/SLPEeOsBxS2qqQk1+FXugnu8d8fxwUoFuGYbGnYCtqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+qQ0v9s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+qQ0v9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088C2C32788;
	Fri,  2 Feb 2024 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865574;
	bh=rKDaiGXzt+R/kGS+DqFZ3xwikgd90dW9FPGjCGpgprQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s+qQ0v9sxC4tZVvURZ1vm1Z0XGd7hcgJRd2WoMQshJjBHmtIfycCukpFvRXlIDXaf
	 OsyN1i9/jGiL6cUOWuqLmwL2u+ofj1RXHG6vSW9DwsKn8hB7X4pFHCt/nJ2b4lIeI7
	 oNr/rvBe5WyWTlFAzn4EVO1/J3rsBXFRL8mOZql9gY7DX3HNxngbV99LSaGjdrSUgN
	 FAsX45ZY177OM1GeXRmCogZdzgJo5XwDj9RkSama+MedWlTt829BZOOwNcCobZ2IkT
	 Lzdwa6toI99h7BIcj5lu6KvSB20NcT+VTme8Clc6cDDmn9I2PURllPYlVKRZekF3Db
	 vKGmv3egDPSqw==
Message-ID: <17a9d134-54ec-4986-8196-95ab1419b7b0@kernel.org>
Date: Fri, 2 Feb 2024 10:19:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net] MAINTAINERS: update Geliang's email address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>
References: <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <eb152068d96e0980d010272f5190da7807f35c13.1706749536.git.geliang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 01/02/2024 02:06, Geliang Tang wrote:
> Update my email-address in MAINTAINERS and .mailmap entries to my
> kernel.org account.

Thank you for that!

(...)

> diff --git a/.mailmap b/.mailmap
> index 04998f7bda81..327e7eddd146 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -191,10 +191,11 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
>  Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
>  Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
>  Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
> -Geliang Tang <geliang.tang@linux.dev> <geliang.tang@suse.com>
> -Geliang Tang <geliang.tang@linux.dev> <geliangtang@xiaomi.com>
> -Geliang Tang <geliang.tang@linux.dev> <geliangtang@gmail.com>
> -Geliang Tang <geliang.tang@linux.dev> <geliangtang@163.com>
> +Geliang Tang <geliang@kernel.org> <geliang.tang@linux.dev>
> +Geliang Tang <geliang@kernel.org> <geliang.tang@suse.com>
> +Geliang Tang <geliang@kernel.org> <geliangtang@xiaomi.com>
> +Geliang Tang <geliang@kernel.org> <geliangtang@gmail.com>
> +Geliang Tang <geliang@kernel.org> <geliangtang@163.com>

Should we add your @kylinos.cn email address? I see that you are using
it when sending patches.

I can do that when applying the patch, no need to send a v2.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
