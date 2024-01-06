Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01161374
	for <mptcp@lists.linux.dev>; Sat,  6 Jan 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmmJRIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17733C433C8;
	Sat,  6 Jan 2024 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704504173;
	bh=gXMHBUjE0wF78t4oQ84dl8bM7hmYjSc0xOLBGsEz8Qc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dcmmJRIxYSMrDdOpoFUFJaBb2+p6XSwB7hoP+lCUpeBeqQDEBEoxu4e3poumu0f3s
	 lmu84Q3cj1AMFVx7l8DVeYCaIn22jlayrzb4mAL4DnfjZg8jfGUA7k2EDCubtdWUtb
	 hmoWjDfr37o/HVjm/ps15RbfITut/VLTsAoJZxNZlhwygXx/R6J9KBE49c7YMZgEKe
	 Mb1WXDgyc2T5uzyaG9bR/kbRXGUx39y0EgGDuQYMYR690r+mmjaZQlsnPujfw7k56J
	 +Nw/qffbHdgk+KOU664l+8JSyNDN21FzOpb65p8U795ahTa+mCCjUuR4eCWPArwuct
	 JyQMDj7xwoGlg==
Date: Fri, 5 Jan 2024 17:22:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 11/24] mptcp: check userspace pm subflow
 flag
In-Reply-To: <264d927f841e3ce0f3258e6cc9c78de167e08e81.1703904325.git.geliang.tang@linux.dev>
Message-ID: <110caf18-dc9e-671e-f258-d85bb2617d58@kernel.org>
References: <cover.1703904325.git.geliang.tang@linux.dev> <264d927f841e3ce0f3258e6cc9c78de167e08e81.1703904325.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Sat, 30 Dec 2023, Geliang Tang wrote:

> This patch checks MPTCP_PM_ADDR_FLAG_SUBFLOW flag when creating a subflow
> by userspace PM in mptcp_pm_nl_subflow_create_doit(). If it's not set,
> don't create the subflow.
>

Hi Geliang -

I took a quick look at mptcpd and I don't think it sets this flag. Why is 
it important to add this check?

- Mat

> Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
> ---
> net/mptcp/pm_userspace.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 98237108ddcf..b9f5dfe922f9 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -371,6 +371,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
> 	}
> 	addr_l = local.addr;
>
> +	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
> +		GENL_SET_ERR_MSG(info, "invalid addr flags");
> +		err = -EINVAL;
> +		goto create_err;
> +	}
> +
> 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
> 	if (err < 0) {
> 		NL_SET_ERR_MSG_ATTR(info->extack, raddr, "error parsing remote addr");
> -- 
> 2.39.2
>
>
>
