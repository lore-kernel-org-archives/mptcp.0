Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE18D154426
	for <mptcp@lists.linux.dev>; Thu, 31 Oct 2024 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361508; cv=none; b=Yq27EFwSNPH9fS9iBIMQQ6w3dUog7YMEWEcXQThUD0WF2Ad7hv+Yj4Vgiy8RcqKWqj/9Dr4f4y2fF0SYKV0/rLKDGRSnbC5OEWM/2cCVeHyZBLxCaDcVPLiI5xFWS4E6xgvaQ7ze9qy4hKOkf5Ex9YOXrpM+LkVhrmmwy4uMcW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361508; c=relaxed/simple;
	bh=CCB6SWBVxxtxlJfODzhrVejpvSQCU1oc41MfZ7pSKBM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NxyjEu6HYF0v2reoitzMj+4K7Qib8X3LzzpZJU3ZZ9vwwh7NkDEan2edeqZD6vf3DDIROC1ixilI6xmZXn+jgBlUhN8AJioHOrHd7P6z38KDVU2bVi/sAdQjgP79LSPtPWaAXUPAQ82WTBFFQSuAlLF9jDRTF4D/xRN1lCpnnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edWUlL+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edWUlL+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197D0C4CEC3;
	Thu, 31 Oct 2024 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361508;
	bh=CCB6SWBVxxtxlJfODzhrVejpvSQCU1oc41MfZ7pSKBM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=edWUlL+zarieGVCCBB7KiUizVn7Z0nqbfBPlZ3/6Fv7c5GEo1N/3ZdNFS6mHnckt9
	 D6A0jSv0lluCFqnooeXR7RVtqkAXv6FsSA5rhGPgQT3b9e5zF9M9o9pe82krM+DVFr
	 Z4+xx70WrpfjN8+Gav1Sd5psxeApMDjmc70yLnifdeYRG+xZxuwgvk8ysYTZXtYWzp
	 XZ8RmobHJKN3e9SkE2qkZJuVHpZy5HG6Fme7im68wvWAjN+cE20+dErQlbVvf81NUh
	 RCn7A+hsXqOV4Yyb2tzTt4bw9kmzR2b2IMGRy7OVSH9veH6pz3dYdz4ixnFND33Uxr
	 yYWIJE0nxNFPg==
Message-ID: <00cbea0123cece1f64b198a9f8109075f6f74f59.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 07/36] mptcp: make three pm wrappers static
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 31 Oct 2024 15:58:24 +0800
In-Reply-To: <18ade37f-5557-4ff0-ae1f-1b4cd6b66e97@kernel.org>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
	 <6a0fc4027e27a2bdbbaea2997a5489399ea0fc7d.1729588019.git.tanggeliang@kylinos.cn>
	 <18ade37f-5557-4ff0-ae1f-1b4cd6b66e97@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 2024-10-30 at 19:31 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (I'm still reviewing the series, thank you for your patience. Please
> wait for me to finish it before sending a v3.)
> 
> On 22/10/2024 11:14, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Three path manager wrappers, mptcp_pm_get_addr(),
> > mptcp_pm_dump_addr() and
> > mptcp_pm_set_flags() are used to switch the interfaces between in-
> > kernel
> > PM and userspace PM. These wrappers are defined in pm.c but only
> > used in
> > pm_netlink.c. It makes more sense to move them to pm_netlink.c and
> > make
> > them all static.
> 
> These three helpers are calling userspace PM code, that looks
> "strange"
> to do that from pm_netlink.

I agree.

> 
> I didn't check, but would it not make more sense to move all the
> _doit()
> functions calling these helpers to pm.c? Also, do we still these
> helpers
> you were moving? Can we not instead remove them, and move their code
> directly in the _doit() functions if you see what I mean?
> 
>   int mptcp_pm_nl_get_addr_doit(...)
>   {
>       if (info->attrs[MPTCP_PM_ATTR_TOKEN])
>           return mptcp_userspace_pm_get_addr(skb, info);
>       return mptcp_pm_nl_get_addr(skb, info);
>   }
> 
> (in pm.c)
> 
> WDYT?

I prefer to drop this patch and keep the code as is.

Thanks,
-Geliang

> 
> Cheers,
> Matt

