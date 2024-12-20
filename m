Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BE19F116;
	Fri, 20 Dec 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724448; cv=none; b=F12s1Rh4YacseaaSDYe8XRWAU94cANPIVjueRXU2eqzYguXRyUxSpzwHeHAJHqaYoCNf8phctdSUchJZhkp0tA4dhNO/Ki75OtUP/P6+yzu2L3I7/xU04SknPUU7IN/OZ5OdQdqrK5Xlcjuh2NkRnXSTkfMOY3dLM5kdyjTt5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724448; c=relaxed/simple;
	bh=iACJDKqFAo+D3M0VhhAhIu7S9OkMmQ2XX53xkoUPKmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjIfg3atIGfZpfK6UmZAulKBS8XIF04HvRj2V3J+/vRZBIOmrMmKkrDPFzrEiVIGId252qq1A/bLWkEItt54DF8jfnen8nSSFklqcJIeEKVjn3lQrY6Hwvlo7WsX/gox1Vuw3tX19yUYhNe9AHkJEYue7nJw5D5nibUtwsnUUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5X8Nsir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5X8Nsir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B571C4CECD;
	Fri, 20 Dec 2024 19:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734724447;
	bh=iACJDKqFAo+D3M0VhhAhIu7S9OkMmQ2XX53xkoUPKmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h5X8NsirlOJ05ROFJLRskeGZ2/jzNb9w/opoQGcO7IIeXH9yuLMgZGoE00BFUFuMU
	 n+SbBShXakMiPQCTaODhbxqu/uB7IA1UvmEkO1IVN5v0zUqiVfBma21Jcc/6+Q1OYV
	 tLOfIFNCpqrwFH5l23+WBrTIUPfMn2PELWm3yQbqruDGoMhLqQ4XXIsK1GYZQ+Rncz
	 up/Np9kxsu/FhXPgw/Z77LhV2A7VPgvT9EPmfLPifBr6OKpFIG9RdH6HZLMla5wnVL
	 cGtmVqkErW5ipmcFOHsNAlAYXKB9S0+eEDpeszgY71sK+LIazWia0rh00krxodXitd
	 I++xfMChRTgOg==
Date: Fri, 20 Dec 2024 11:54:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kishen Maloor
 <kishen.maloor@intel.com>, Davide Caratti <dcaratti@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net 0/3] netlink: specs: mptcp: fixes for some
 descriptions
Message-ID: <20241220115406.407a4c82@kernel.org>
In-Reply-To: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
References: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 12:45:26 +0100 Matthieu Baerts (NGI0) wrote:
> When looking at the MPTCP PM Netlink specs rendered version [1], a few
> small issues have been found with the descriptions, and fixed here:
> 
> - Patch 1: add a missing attribute for two events. For >= v5.19.
> 
> - Patch 2: clearly mention the attributes. For >= v6.7.
> 
> - Patch 3: fix missing descriptions and replace a wrong one. For >= v6.7.

I'm going to treat this as documentation fixes, so perfectly fine for
net but they don't need Fixes tags. Hope that's okay, and that I'm
not missing anything.

> Link: https://docs.kernel.org/networking/netlink_spec/mptcp_pm.html [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Please note that there is no urgency here: this can of course be sent to
> Linus next year!
> 
> Enjoy this holiday period!

Thank you! You too!
