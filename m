Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE03819
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 04:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717271; cv=none; b=SR9/25SELjRz1JXdm6GfMch9uc87cEqFTkfRQlr2LdmnfIVOq54H71YFrH+Klom09a5XboTNnj/RBBrqTSff3y2ZSeWImvs1WyI+qjRP5Rcco5JpX9SS3QJFM2HbyMjRKzs6M9jfjS+Q95pEWUMolaummT+WaKJZtijoKL3ClC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717271; c=relaxed/simple;
	bh=1LxczMEMh8kuSG5Te0i7EPfQ5NlXPh7/kRl0N3WWQcU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tHRipb9VIFIoGXr66HUVhSpRV/KpwEFbJQBEgL5AGv6yNm1LrdzZml1KLxY+3FjtPQ1lQGlI+8eyBcUDPRxfPtZGDS/NSEi9lYw7JThHQ5gpsUNFe3rP9PEQbeEJJv5FKD5dhaw5tVl+wbr477slXKqGPq/p5P8M5XRPkTKLCj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/j/TKhj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/j/TKhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F7FC4CED6;
	Fri, 28 Feb 2025 04:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740717271;
	bh=1LxczMEMh8kuSG5Te0i7EPfQ5NlXPh7/kRl0N3WWQcU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=S/j/TKhjL5x8QQE7UXMARz5q6opyXIQptvR0IWHO81gugpSdnVsnsDPYKN9Am8tj9
	 W4+bYB2OaMCQf5R3movi1Rh0bafi5BqZZLrosSWgizM/4tlFyCLq6qaPPaWGuIQPcP
	 Q9zEctJqOtQmKH3q2FIoLq6DFijLjRTWlCAUyOt0SaWh16b9BJQYODyxdcTTpsNdhX
	 c4KHlRGdjPNtD+GlztbqD8Y1weAYQq9jjUIGKjDfZVgVVrqQV8fm/edXdc7By6AtBx
	 eNKINNQx7lqMupHp8pxQS+Q7guurctZs3TUpuJNIL/jGB19JkeeYTTzINi2QJ6VVXZ
	 Pghii6xl1B3OA==
Message-ID: <82b2ca9acad0162a981f5b349813e8c98ce96b4b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 7/7] mptcp: pm: code reorganisation
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 28 Feb 2025 12:34:16 +0800
In-Reply-To: <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
References: <20250227-mptcp-pm-reorg-code-v1-0-cb4677096709@kernel.org>
	 <20250227-mptcp-pm-reorg-code-v1-7-cb4677096709@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


>  void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct
> sock *ssk)
> @@ -567,38 +936,13 @@ void mptcp_pm_subflow_chk_stale(const struct
> mptcp_sock *msk, struct sock *ssk)
>  	} else if (subflow->stale_rcv_tstamp == rcv_tstamp) {
>  		if (subflow->stale_count < U8_MAX)
>  			subflow->stale_count++;
> -		mptcp_pm_nl_subflow_chk_stale(msk, ssk);
> +		mptcp_pm_subflows_chk_stale(msk, ssk);

mptcp_pm_nl_subflow_chk_stale() is renamed, a separate patch is needed.

>  	} else {
>  		subflow->stale_count = 0;
>  		mptcp_subflow_set_active(subflow);
>  	}
>  }
>  
> 
... ...

> +}
> +
> +static void mptcp_pm_nl_set_flags_all(struct net *net,
> +				      struct mptcp_pm_addr_entry
> *local,
> +				      u8 changed)

mptcp_pm_nl_set_flags_all() is renamed, do this in a separate patch
too.

Thanks,
-Geliang

