Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A1514F7
	for <mptcp@lists.linux.dev>; Tue, 16 Sep 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016006; cv=none; b=tm3xGWSU4onCRB/fIWMeP/XslR04jUnxZoU17XH4gwpV7SKM8dhOiNZlw2UxaxoWtZBw33+MRL/LtJH7BqxGfrWVJ0DX5CftP/j9gp12btOTZxLKSobKyXpbIMqfreX++wt6kBtYulKItHeu9lUmkaC5DkYfLrVjCECJe/rD9k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016006; c=relaxed/simple;
	bh=jG3mAhGCWEZ2qnMvdy83MlhfsasttHX+KUJnjSWAzAQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PqJOPwll1qheVuCKYJZsxJAg95w01c2LJkEBLF/7rTk+lzI5Pil88iuuenXK6hZIRdXdO7THLHXWjs3xnjoOT+jCsT+1e0lu4HmBQax0mcZ2mgz2N74TVmzZXskdF01z1ltRpt3YRamZtfXSVDPD4ePt3x0DY6ZFyGrS2+2Jqas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1DHhXq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1DHhXq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE8CC4CEEB;
	Tue, 16 Sep 2025 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758016005;
	bh=jG3mAhGCWEZ2qnMvdy83MlhfsasttHX+KUJnjSWAzAQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=d1DHhXq16uRyR4huV9YPR78PUuWZQcLRaJ6pf6N6+P3Bpcl+uUsNNwwoR3MIoCyeC
	 DutmQA0pesM6HS/ExXxEQnFn1cN3XXiZmqxG6WeEFV/8o+ch8L+Jx8ry7tpdJdvgsy
	 zEgCX6sJgwqTxheifFTexMZALeQr88HZh36iV3AQ55MY0WkiZR/yrQ7ISwaCe81NhB
	 zO6Ds2Im16+PkAz3+py91VC5IOMZpFMEaMBl0cRTH/G7qzji0cD5aMeGGe0XhpW1Up
	 DOFBkUS7p7m27c2clrs73kwIKcogHA44GFSc9KKm59+K7/Imvc7Bru4TPC6UOOAEgU
	 fl8B/FNo1qF+A==
Message-ID: <27a4b87484020388b4c2f8ea9855012f95dc7fd4.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: use _BITUL() instead of (1 << x)
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 16 Sep 2025 17:46:39 +0800
In-Reply-To: <20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org>
References: <20250916-mptcp-pm-addr-flag-bitul-v1-1-5805a6ddde27@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for this patch.

On Tue, 2025-09-16 at 11:04 +0200, Matthieu Baerts (NGI0) wrote:
> Simply to use the proper way to declare bits, and to align with all
> other flags declared in this file.
> 
> No functional changes intended.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  include/uapi/linux/mptcp.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index
> 95d621f6d59810126cbc37b1d6baf896a40dd9bc..15eef878690b8556af21be8d959
> b6a2c9fe617d3 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -34,11 +34,11 @@
>  #define MPTCP_PM_EV_FLAG_DENY_JOIN_ID0		_BITUL(0)
>  #define MPTCP_PM_EV_FLAG_SERVER_SIDE		_BITUL(1)
>  
> -#define MPTCP_PM_ADDR_FLAG_SIGNAL                      (1 << 0)
> -#define MPTCP_PM_ADDR_FLAG_SUBFLOW                     (1 << 1)
> -#define MPTCP_PM_ADDR_FLAG_BACKUP                      (1 << 2)
> -#define MPTCP_PM_ADDR_FLAG_FULLMESH                    (1 << 3)
> -#define MPTCP_PM_ADDR_FLAG_IMPLICIT                    (1 << 4)
> +#define MPTCP_PM_ADDR_FLAG_SIGNAL		_BITUL(0)
> +#define MPTCP_PM_ADDR_FLAG_SUBFLOW		_BITUL(1)
> +#define MPTCP_PM_ADDR_FLAG_BACKUP		_BITUL(2)
> +#define MPTCP_PM_ADDR_FLAG_FULLMESH		_BITUL(3)
> +#define MPTCP_PM_ADDR_FLAG_IMPLICIT		_BITUL(4)
>  
>  struct mptcp_info {
>  	__u8	mptcpi_subflows;
> 
> ---
> base-commit: 7064ceb50d7f26c7190bfe6d2ff76a3b6afa27c1
> change-id: 20250916-mptcp-pm-addr-flag-bitul-da35c20cfa3c
> 
> Best regards,
