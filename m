Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67715C3
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 11:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gofQEgsz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0C3C433C7;
	Sun,  8 Oct 2023 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696763966;
	bh=AuokVfjLM542frsl80PMLQiDT75HsMcHfKChgCJ4T1M=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gofQEgszkfUy94uAVr0d50Yhh4Abxdea5y+QKx0X/j9HtfGSOo3m0IT3GHVOPY8AO
	 1s5B8SpeZXLOw+mp9tboRCMM+6MgSU98fZgtKfdMY/4YGR+sHQOrvF0I2kMomaHyX4
	 BAwI1pQeQjHUkYDMchmOIYLz/HtHXgzjX7IJsIehcOH0eiXRB48mwelf2vlJ6GCCKq
	 7dPGtKAiF8MiEn8EDiiG9osy1SsaXri3B7fc7m6zWJvh2Xv17AK8/re6cPjH52bi8D
	 2jhMpI4jewTIEOibTnmszMjb/Wle+n2pupRK0xzus9j29udBdPjYIToLB3PDVqAXQm
	 hrOxjU67sGUvg==
Message-ID: <5cc54621-7256-4f47-89b3-1ae71e6d0aa9@kernel.org>
Date: Sun, 8 Oct 2023 13:19:24 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v11 3/4] mptcp: userspace pm remove id 0
 address
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1696760702.git.geliang.tang@suse.com>
 <8cc9892f0516f304f146318aeb21a6e935cdec39.1696760702.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <8cc9892f0516f304f146318aeb21a6e935cdec39.1696760702.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/10/2023 12:27, Geliang Tang wrote:
> This patch adds the ability to send RM_ADDR for local ID 0. Check
> whether id 0 address is removed, if not, put id 0 into a removing
> list, pass it to mptcp_pm_remove_addr() to remove id 0 address.
> 
> There is no reason not to allow the userspace to remove the initial
> address (ID 0). This special case was not taken into account not
> letting the userspace to delete all addresses as announced.

Thank you for the next version!

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/379
> Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")

(This should target mptcp-net)

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/pm_userspace.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 6b8083650bc1..ed9db6a4e228 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -211,6 +211,37 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> +static int mptcp_userspace_remove_id_zero_address(struct mptcp_sock *msk,
> +						  struct genl_info *info)
> +{
> +	struct mptcp_rm_list list = { .nr = 0 };
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	bool has_id_0 = false;
> +	int err = -EINVAL;
> +
> +	lock_sock(sk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (subflow->local_id == 0) {
> +			has_id_0 = true;
> +			break;
> +		}
> +	}
> +	if (!has_id_0) {
> +		GENL_SET_ERR_MSG(info, "address with id 0 not found");
> +		goto out;

(here it can be 'goto remove_err')

> +	}
> +
> +	list.ids[list.nr++] = 0;

detail: I think it is best to add a new line before spin_lock_bh() and
after spin_unlock_bh(), to clearly show the block with the "dangerous"
section with lock/unlock.

> +	spin_lock_bh(&msk->pm.lock);
> +	mptcp_pm_remove_addr(msk, &list);
> +	spin_unlock_bh(&msk->pm.lock);
> +	err = 0;

(and a new line here too)

> +out:
> +	release_sock(sk);
> +	return err;
> +}
> +
>  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
> @@ -245,6 +276,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto remove_err;
>  	}
>  
> +	if (id_val == 0) {
> +		err = mptcp_userspace_remove_id_zero_address(msk, info);
> +		goto remove_err;

Here it is best to use 'goto out' I think because we expect not to have
errors most of the time, no?

> +	}
> +
>  	lock_sock(sk);
>  
>  	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
