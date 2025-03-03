Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E213F1F4E47
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999437; cv=none; b=OnYZbV6WCmcu47U+73ToD/Bx82Z/qk6W3TzyDlmpi7V6kv5Y7VgeHfeC8MczI+oGx4GAvX4PgyJpExAICOC/vxOth+wgwBsUABKs9zUsa2C/ZRAXYgcMcJI0sFTXz5j4F7jeoURldYoJsBw9hXcMhIKI7kzGKLePvS06czRT++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999437; c=relaxed/simple;
	bh=94WEAQpTz1yDrfQ3RLBza7uGThn2Ykt+fN+Tr0biKFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RropdVI5lWFuF8Qv7ppWcwiwy7VND45iotUSy0jgj772R+Us+agY5dpTgLIFsQM/QOV9/y2vWRD19qtQwqQ7if4GNmP8JK1WxuLBdlJWrg9pYYKUNF5nSL9sl8xCthJyjwR6MQ+xh+iRA3BOx4u0/puWi9bWGPv/yoAH+UMaRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA5jpcAs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA5jpcAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FE0C4CED6;
	Mon,  3 Mar 2025 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740999436;
	bh=94WEAQpTz1yDrfQ3RLBza7uGThn2Ykt+fN+Tr0biKFI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bA5jpcAsP4JA/ky5EwgnFMm0S9F8nOLfVqc1E3g3LRkYhkjdGTue5hT+bwPqe/SPa
	 5yDxzqWUyGiy7qtrxJaca9sVswlukQC8C27lH8IocNeO8YuewurXyAZbE+o4AQneUa
	 R04UeykgXk2vOXlTX1tLnyJ3x+wBquiRswp7XD6cUDykw3ty2psbaWfc1NGFX+pto0
	 p1NqP/L/xuMCiHu43W/2GT2DO2dZwR+IQkYy81MeL5mAVVyIIUzN1jlbFLAuQgD01d
	 qHoxoju6+FxvXiTN/WwLgF+9g+5xA8aNqJXYWptxnh7uxlDQnwn0mJLi8oft2c1KPc
	 ncun4xsimCpeg==
Message-ID: <483d687d-5377-47fc-bf11-2e18eacce8d9@kernel.org>
Date: Mon, 3 Mar 2025 11:57:13 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 08/11] mptcp: pm: drop pm_type in
 mptcp_pm_data
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
 <599fa718f11e3311f95deaaeac0534889698c66d.1740975633.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <599fa718f11e3311f95deaaeac0534889698c66d.1740975633.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 05:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Now pm->pm_type can be replaced by pm->ops->name, then "pm_type" filed
> of struct mptcp_pm_data can be dropped.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm.c       | 4 +---
>  net/mptcp/protocol.h | 5 ++---
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e8b34f2ecb35..1ce58d16370a 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -979,7 +979,6 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  {
>  	const char *path_manager = mptcp_get_path_manager(sock_net((struct sock *)msk));
> -	u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
>  	struct mptcp_pm_data *pm = &msk->pm;
>  	int ret;
>  
> @@ -989,7 +988,6 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	pm->subflows = 0;
>  	pm->rm_list_tx.nr = 0;
>  	pm->rm_list_rx.nr = 0;
> -	WRITE_ONCE(pm->pm_type, pm_type);
>  
>  	rcu_read_lock();
>  	ret = mptcp_pm_initialize(msk, mptcp_pm_find(path_manager));
> @@ -997,7 +995,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  	if (ret)
>  		return;
>  
> -	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
> +	if (mptcp_pm_is_kernel(msk)) {

The code here could be done in the new init() callback maybe? So what
you introduced in the previous patch 7/11.

>  		bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
>  
>  		/* pm->work_pending must be only be set to 'true' when
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 172450455c2a..56eeee1cbccc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -233,7 +233,6 @@ struct mptcp_pm_data {
>  	u8		add_addr_signaled;
>  	u8		add_addr_accepted;
>  	u8		local_addr_used;
> -	u8		pm_type;
>  	u8		subflows;
>  	u8		status;
>  	DECLARE_BITMAP(id_avail_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
> @@ -1101,12 +1100,12 @@ static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
>  
>  static inline bool mptcp_pm_is_userspace(const struct mptcp_sock *msk)
>  {
> -	return READ_ONCE(msk->pm.pm_type) == MPTCP_PM_TYPE_USERSPACE;
> +	return !strncmp(msk->pm.ops->name, "userspace", MPTCP_PM_NAME_MAX);

Please don't do a string comparison here.

I think it is better to drop msk->pm.pm_type when mptcp_pm_is_userspace
and mptcp_pm_is_kernel are both dropped, no?

If you want to drop pm_type before, then you could compare &msk->pm.ops,
but I think that's something that should be done later. I guess
mptcp_pm_is_userspace() will still be needed, but only from
pm_userspace.c with mptcp_userspace_pm_get_sock(). No?

Same for mptcp_pm_is_kernel(), only from pm_kernel.c when iterating over
all connections.  Except if you use introduce a new macro like
mptcp_pm_for_each_msk() taking in argument "&mptcp_pm_kernel"?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

