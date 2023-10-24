Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7404B3B2B4;
	Tue, 24 Oct 2023 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqyuiEUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC6C433C9;
	Tue, 24 Oct 2023 19:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698177597;
	bh=52wsup4chWcy8hWdeJ3lf2le043MI/8JJSxspHzfSPk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqyuiEUL4xctJpoUMmdwBhrUSY2OgtgO57Aa6WSbaIrRzUDfwriA1E+qQSA4bpZNW
	 Kabij32y7KKSNo0XB9kGT056GVpqO/01uPAHIcwtwLJuTtYqEzquWHobxsQHWW+mjx
	 VXgKfKhwLY/okjMOD8fz1N/irnAniV+iY2d5rl6wORmsjaTRbuZS37Yz+F9u1nes07
	 VY8ZHKnLBUsJx94kPJ7JVRrXv6uRHdWWk7pscNLdBbtxzVlzyXwJs2Dg3i7roo0AMl
	 sdhrHDEIde3Z2c+5R1F/FQaa15UxEuuJkuZg8xWeF786lTIbwe3aQDiJuOAl2TMkvn
	 NfxBvEiJAQMLg==
Date: Tue, 24 Oct 2023 12:59:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts
 <matttbe@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, Simon
 Horman <horms@kernel.org>, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
Message-ID: <20231024125956.341ef4ef@kernel.org>
In-Reply-To: <20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
	<20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 11:17:09 -0700 Mat Martineau wrote:
> +/* for backward compatibility */
> +#define	__MPTCP_PM_CMD_AFTER_LAST	__MPTCP_PM_CMD_MAX
> +#define	__MPTCP_ATTR_AFTER_LAST		__MPTCP_ATTR_MAX

Do you want to intentionally move to the normal naming or would you
prefer to keep the old names?

We have attr-cnt-name / attr-max-name for migrating existing families.
We can add similar properties for cmd if you prefer, I think that they
were not needed before.
