Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E522CA6
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 01:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAFDC004DD;
	Tue,  7 Dec 2021 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1638840318;
	bh=/fRcVEtHg0+X2X0zmGLuXeYDJyyUQMx6rAgnFoFhZW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OuHSwx/Ee0QDeBaK5LUg/lwctUWUAcyX59u522QMegsgv61GjKrv2J1QD2WP+V4Xf
	 ZbYI+8+puFCaWUBL3GmJwAtmqXGj/Zjs6lQ7NwONBHkFCjdtVvbscTtjp6gIpX+dHz
	 jwtPUJtOSsS+litie4JWGaP9bu8v+3Gz5FUQoLtQgQDGZ1C0ttJhRsn3lRVk+3ZZUH
	 wMpKGS0txSt3G9FyG0f+LMTCoCono7cYbhIJtlJ3uMafpMoErcLM6AnSPIxDOZAZvs
	 QYJDQjEgz79OMb3w1dHm6NhEgDfqesoJiHwXy+qcIk3M6hAinSfMPPcpX+cigMQ+oF
	 aP7Tssar9V59A==
Date: Mon, 6 Dec 2021 17:25:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
 davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 06/10] mptcp: getsockopt: add support for
 IP_TOS
Message-ID: <20211206172516.6b1877e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20211203223541.69364-7-mathew.j.martineau@linux.intel.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
	<20211203223541.69364-7-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Dec 2021 14:35:37 -0800 Mat Martineau wrote:
>  	if (get_user(len, optlen))
>  		return -EFAULT;
> -
> -	len = min_t(unsigned int, len, sizeof(int));

Ah, there's the min() gone. Okay.

>  	if (len < 0)
>  		return -EINVAL;
