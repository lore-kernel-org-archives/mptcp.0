Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F254F360
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400315; cv=none; b=uHM5h2GZNRx4Fc46p5evnHdWxpk2fSwH6eBgxF1rPgOsn6SCTQNM12xnsOuPaCuVmpGU77rrFfA66HAtIikEPmXQmD+xrrGTVHZePU7le1P3RnfLjiTSYnhq8qt7CEAgQtEuamao4igvxhPY/WO5+m/BBWmsZHx/ng2y1WlroaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400315; c=relaxed/simple;
	bh=gIX9OjJ1I1nfYqZhZs9K4BNeg4cEU11PvZnD/e0tA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3R+uZmPP4r42r1wAyJ8s11fLafMADvpjlbWhEgN+ct8OMtv6BuTTQeK+gbhgXC290BiLaNDJCBJDD8x+q57WTsbvGZyegPIjSKvV2POae1WM+uoPqhLO4wLqQUsCh3UAZPYqxsSYKUrZkY5cD5S4C1ikzGuaDD9k/MFuXnZIQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTSltS/s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTSltS/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE34DC4CEC3;
	Thu, 31 Oct 2024 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730400314;
	bh=gIX9OjJ1I1nfYqZhZs9K4BNeg4cEU11PvZnD/e0tA2s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tTSltS/sBsfm6Y32IGuPbtB5u5IiTtAmreIqtt1mj2WFwZSeRLdkzO4Slu6Nroaku
	 gSNOmseUtbuQBCmsqNTt4TvZs4p4m1k93hVy3cRpJUFyVKcOHz3YHsUTvtfxraq9UV
	 /bLpI/imm8X5LNshgHJF1kmcy83N0EyinH+RBKBhXWipqtCy4YkTSMGLC5Ni7hp1vK
	 F2uBys2d1l7d+dEyGT8nGqmo8uTcsdUl3ypppGWr2KtupbHknMiSfyMoOIBVcwTKDO
	 R+Th3N73gJSQM2mrShjNjd9sSRY/GAtJGLpQOQe132VuzwU7ngmfgfF2ubZuHe/DAn
	 dmd/Rr78hPg2g==
Message-ID: <cbd9eaa2-e236-421e-82e9-784ae7054dca@kernel.org>
Date: Thu, 31 Oct 2024 19:45:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 13/36] mptcp: add struct mptcp_id_bitmap
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <344964d66ab0250ae027ffd46a0e6782d572c33d.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> A new struct mptcp_id_bitmap is defined to unify all bitmap type of address
> IDs for both in-kernel PM and userspace PM.
> 
> This type can be used to easily refactor dump_addr() interface of the path
> managers to accept an mptcp_id_bitmap type parameter. It also allows this
> parameter of dump_addr() can be modified by BPF program when implementing
> this interface of a BFP path manager.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 8282a6355765..4358a9a21270 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -211,6 +211,10 @@ enum mptcp_addr_signal_status {
>  /* max value of mptcp_addr_info.id */
>  #define MPTCP_PM_MAX_ADDR_ID		U8_MAX
>  
> +struct mptcp_id_bitmap {

This name is too generic, while here this bitmap is specific to the
path-manager and its PM address:

  mptcp_pm_addr_avail_id?

> +	DECLARE_BITMAP(map, MPTCP_PM_MAX_ADDR_ID + 1);

Sorry, I'm not sure to understand this modification: why do you need a
specific structure with only one field? I didn't check the next patches
yet, but I saw that at the end of the series, the structure still only
has one field.

Do you require this dedicated structure because of a limitation of BPF?
Can we not use a typedef, a macro or something else to avoid all these
modifications here?

> +};
> +
>  struct mptcp_pm_data {
>  	struct mptcp_addr_info local;
>  	struct mptcp_addr_info remote;
> @@ -231,7 +235,7 @@ struct mptcp_pm_data {
>  	u8		pm_type;
>  	u8		subflows;
>  	u8		status;
> -	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> +	struct mptcp_id_bitmap id_avail_bitmap;
>  	struct mptcp_rm_list rm_list_tx;
>  	struct mptcp_rm_list rm_list_rx;
>  };

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

