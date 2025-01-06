Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2291E505
	for <mptcp@lists.linux.dev>; Mon,  6 Jan 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736156903; cv=none; b=krTxxklyW332ziGPNJ+etOOiY67xxE/ebH04iLyANPSbxXFMXzGrUo/BktlIOPIUvM19Bmf+ospzHvyRbx068mCaWHtafAJdIDIW8y/VDVSqllBo+ipVMI7GZ5Iac7jlogzXzrX078p8oA5gcc2wXAIdUKnhAu3Fwq2U/ANOw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736156903; c=relaxed/simple;
	bh=y1ShWcyGo876pNfYt6T2f5acX/i+oDFlaQXxupwXLnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2cGl8WKslqiGFXa490pJ4rfHF1FxWdszhme5vfK7SSyEIvvACmJkrfWvhk8fRnLffYVuvJfqUpPhhlTo4U8GTCcB0zIRKHYauaCt8actZyA16TQg+goCElw7XmBvQjcNwdcT0R7o41PPmi2dbvibau9qujBPs8qt7RPNwPFEOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/JUhqqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/JUhqqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182BFC4CED2;
	Mon,  6 Jan 2025 09:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736156902;
	bh=y1ShWcyGo876pNfYt6T2f5acX/i+oDFlaQXxupwXLnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q/JUhqqHqrZYBwv6QUP3tVobacAUUBYl7mA3WF0A/V9PH2Th4S8zNMX8oOHBKFDkW
	 djrVbE+j858gQOCdCd8xXhHHqF5bX+KGiI9mL9A8FvL8ygEBcUSHLkmgBq6B411O30
	 yvas7u4FVHcfBHdNYJlJAR6iLyxJesQPQzbeNf4mnAU5yHo31wDslwHrZZIjzt8BB7
	 SNb1AJHHMo80oGlXngJcfm4EBAnGspDsaIGGogI8HgoRseZORQ7sCHMJLeM9K9aDr0
	 TUK4bHA7ZCk8NgePYwV+S6QknmHkq0DlRi5bnTN4KHsP5YCifDKTY0zy5JW7+jCEJf
	 7WCs3NJT9XShA==
Message-ID: <72e4b271-3d16-419a-a4ba-94fb027deac2@kernel.org>
Date: Mon, 6 Jan 2025 10:48:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 06/11] mptcp: drop info of
 userspace_pm_remove_id_zero_address
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1736150983.git.tanggeliang@kylinos.cn>
 <ee4732a33038d9d16df114dd278278112219c5ca.1736150983.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ee4732a33038d9d16df114dd278278112219c5ca.1736150983.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06/01/2025 09:16, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
> is to set an error message into it.

Can you add:

Plus, this helper will only fail when it cannot find any subflows with a
local address ID 0.

(Because if there were different types of errors, you could not drop
'info').

> 
> This patch drops this parameter and sets the error message where this
> function is called in mptcp_pm_nl_remove_doit().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 0f703e06d771..a6580942e628 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -259,8 +259,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> -static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
> -						     struct genl_info *info)
> +static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
>  {
>  	struct mptcp_rm_list list = { .nr = 0 };
>  	struct mptcp_subflow_context *subflow;
> @@ -275,10 +274,8 @@ static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk,
>  			break;
>  		}
>  	}
> -	if (!has_id_0) {
> -		GENL_SET_ERR_MSG(info, "address with id 0 not found");
> +	if (!has_id_0)
>  		goto remove_err;
> -	}
>  
>  	list.ids[list.nr++] = 0;
>  
> @@ -336,7 +333,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  	sk = (struct sock *)msk;
>  
>  	if (id_val == 0) {
> -		err = mptcp_userspace_pm_remove_id_zero_address(msk, info);
> +		err = mptcp_userspace_pm_remove_id_zero_address(msk);
>  		goto out;
>  	}
>  
> @@ -345,7 +342,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  	spin_lock_bh(&msk->pm.lock);
>  	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
>  	if (!match) {
> -		GENL_SET_ERR_MSG(info, "address with specified id not found");
>  		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  		goto out;
> @@ -362,6 +358,11 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	err = 0;
>  out:
> +	if (err)
> +		GENL_SET_ERR_MSG_FMT(info,

Can you not use NL_SET_ERR_MSG_ATTR_FMT() here?

> +				     "address with id %u not found",
> +				     id_val);

Detail: in fact, I don't think it is needed to specify the ID in the
error message to send to the userspace: the ID has been specified by the
userspace, it knows what it has set. Up to you.

> +
>  	sock_put(sk);
>  	return err;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

