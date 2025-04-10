Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261B1876
	for <mptcp@lists.linux.dev>; Thu, 10 Apr 2025 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305678; cv=none; b=t6ls6trlM4EPwE2mIOlPRFGAzE7hNH82y34fv537oGk+qopQqiUNq/RuunSp5udnY1jOJEcU2kKrLqwQt345sT3j6bDwmM2qtCCBi8dBc3ccfrFOBwtlbyhn2JdX7ZHV4v8Uk6H4bz0AHLa6rFEOkrxPfizjYeu7QN4azzO8Pp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305678; c=relaxed/simple;
	bh=29B5W8u+el20aJsOPty8AowN66cqjTb6KKEXH9E8aq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usl7tBC4HmMpQQnimIIfA5n7UlMJ5SRTyyEMZMvwem0XwJil2gc3OHilW/h2zJPjiYrojbBeSadFxaGqfIiUy7SsJrIoXYgxk9dUFiMEs9jfE3bYydPiVES69qBk6IKnUaOP+g28aW3d3V89cl6M6XUC9w0Ity/pRbTEeo2xl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2IFqCyL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2IFqCyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03883C4CEDD;
	Thu, 10 Apr 2025 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744305675;
	bh=29B5W8u+el20aJsOPty8AowN66cqjTb6KKEXH9E8aq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H2IFqCyLGXsIWLCD3kL8zBlTmWD7F0lKZgOxFPb4ELDkCybd+I6CO1AnlUR36BHyf
	 RELNXg16Sad6VHOWBLGxk5xAvJAZz5xHMKL5WblaP5AKcNG4A8flEJmdfDDByQgF2C
	 yOJAAXx0LFZ3EW0gKVcUUz9elKVfRmxLuIZbFvgYY4UuLPlv/KKkNMIeNiQvp5cIle
	 wmIuXWCyD00y/Hb782JhVXFUFJ/H3PqYIx4xGH32tWxmK+ysbd+Eo6xpZlZPFPZ2p1
	 4g/rQnLGSeECSMg7XQA88y46tQgzrdlyQA5/susxrH5FyKJ8BB6ysg9+xVJfOsHgVs
	 8RXuq/GAnjzng==
Message-ID: <59036e3c-24da-4236-82dd-b0cc2c747581@kernel.org>
Date: Thu, 10 Apr 2025 19:21:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: diag: use
 mptcp_lib_get_info_value
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e34e86805f3fe69e0aec08c83c596c49799573c7.1743666387.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/04/2025 09:46, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When running diag.sh in a loop, chk_dump_one will report the following
> "grep: write error":
> 
>  13 ....chk 2 cestab                                  [ OK ]
>  grep: write error
>  14 ....chk dump_one                                  [ OK ]
>  15 ....chk 2->0 msk in use after flush               [ OK ]
>  16 ....chk 2->0 cestab after flush                   [ OK ]
> 
> This error is caused by a broken pipe. When the output of 'ss' is processed
> by grep, 'head -n 1' will exit immediately after getting the first line,
> causing the subsequent pipe to close. At this time, if 'grep' is still
> trying to write data to the closed pipe, it will trigger a SIGPIPE signal,
> causing a write error.
> 
> One solution is not to use this problematic "head -n 1" command, but to use
> mptcp_lib_get_info_value() helper defined in mptcp_lib.sh to get the value
> of 'token'.
> 
> Fixes: ba2400166570 ("selftests: mptcp: add a test for mptcp_diag_dump_one")

Applied in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- f2405c27bbf0: selftests: mptcp: diag: use mptcp_lib_get_info_value
- Results: c7abceef96b5..60b01f3eddf6 (export-net)
- Results: c9648c9d9f4c..244c301d3de6 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/6d6923e5c2c0de07b702491eab14aa7288cded9c/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e236c593b8bd23ed60fc7c001dab703df232b089/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

