Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E63FB00
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1bQyUpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70273C433C8;
	Fri, 27 Oct 2023 23:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698449228;
	bh=Buh2L4iH/pnkVg7TEz8yEZU6OePmbwGub2ypuDCOnHY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=M1bQyUpOQ4MvFbt+2Aho45+zHre+Hyp4uraeS7sHh4wbDz+yrD1Mk5eJFMhmNR8OM
	 mIehq1Wn5AqXpnD45m6IdcbMqVSpu+v9/z+v1wc89/sYQtIBnDr1jWP+sHx0DYFZCI
	 GTyyc9+oUoBSzyvhDZyhMQXO4vUAuhRgNQ17xriXq97yp4ithnqCMwu8oeFl8qvhSZ
	 90qdbSAOaVRedhR0NyO0CBB4mSQE4pBM7rh0CbIMXe107CptgYK8vIT2onxFQZV835
	 ay3pWBuaXof7qghX4nNp1UwYYIpyHpRvLY8ZbD8USm9bWCJhUZWah12dVeJ2bw7rCv
	 QgKoRl9EMGPKA==
Date: Fri, 27 Oct 2023 16:27:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
cc: mptcp@lists.linux.dev, matttbe@kernel.org
Subject: Re: [PATCH mptcp-next 1/2] Squash-to: "Documentation: netlink: add
 a YAML spec for mptcp"
In-Reply-To: <a7bddec718e2702960829e550875401c4ef0e0f4.1698395496.git.dcaratti@redhat.com>
Message-ID: <da8df25f-84f4-9346-49f0-ccedda967b1a@kernel.org>
References: <a7bddec718e2702960829e550875401c4ef0e0f4.1698395496.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 27 Oct 2023, Davide Caratti wrote:

> add cmd-cnt-name and attr-cnt-name to generate _MPTCP_PM_CMD_AFTER_LAST
> and __MPTCP_ATTR_AFTER_LAST respectively.
>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
> Documentation/netlink/specs/mptcp.yaml | 2 ++
> 1 file changed, 2 insertions(+)
>

Hi Davide -

Thanks for sending these directly to netdev, I see that the changes are 
already merged:

https://lore.kernel.org/netdev/12d4ed0116d8883cf4b533b856f3125a34e56749.1698415310.git.dcaratti@redhat.com/


- Mat
