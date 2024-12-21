Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393CD40BF5
	for <mptcp@lists.linux.dev>; Sat, 21 Dec 2024 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734773636; cv=none; b=JbBVdBsHzlMdjDCpCNar5YTMxXGDiHsJiUzJUMoIt8maeBfFf0GZMY7YBSQD5Fjb0rs8W8fmsApYYr5sj1Tde0VR8Xy+RkmsUR6ko7on5YXgN25OFqZTBXQNF05Y3MqarsyXHbnracQNmefDERgB/SqSWTcJFcWbWiuW7XzVf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734773636; c=relaxed/simple;
	bh=fPHpSp4A/HChyqZnb//Fw1Z69hGUcQs0iqinkk6tu/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFeKGa9kfqHSj87zF1hDF9mk90lOoOfsZcWx+qz/3/fgI1mJ0MzZVr/oO69keQg23QCTHhZyXHMcEXN793rXbyPPQgMLlI7YBy4+cNFWQH4LI1Uvhb+IddK3keVBFDeWe73acuYeww7UupY/XSZlMD6CoQbJHwFd28GxdpjmFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9b8kbsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9b8kbsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176BC4CECE;
	Sat, 21 Dec 2024 09:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734773635;
	bh=fPHpSp4A/HChyqZnb//Fw1Z69hGUcQs0iqinkk6tu/0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K9b8kbsDnOvGbkzsN2H6SoPxFLkQ6dDXEcus4fbJQEd9gphzokuvKzCLqljQ+ZAuY
	 hbg60mneidRgsli9RiDtmedyfh1Yo3a9CYsi2UjPP3BvhrmExYntjoCIua7wszg+C1
	 FCShh0x/jmyXDN0jFxplKPQWJ8dHnLeKdBK8+802UAAbF5C/DWBWbVghExPCUJmPIB
	 9BR+1qP2ZgzksohtgpD5vDnatkAePOOJxxGAuFkW7PeemDTTLE0C8kEyt4Y93du/My
	 i6vISism/eZgTJDM9eG/OxzNedPh7F9lUbYxTsg0Wc5cSbClB0KQ+THHrN7PZrh9gb
	 2id2fbHrRAXPA==
Message-ID: <c9262b37-bdb6-4513-9f71-2c9fba7d0292@kernel.org>
Date: Sat, 21 Dec 2024 10:33:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4] mptcp: use GENL_REQ_ATTR_CHECK in userspace
 pm
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <a2efcb64bcd072611eac0dff346af2392b3bcb96.1734684556.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a2efcb64bcd072611eac0dff346af2392b3bcb96.1734684556.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/12/2024 09:50, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
> is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
> directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
> if it's NULL.
> 
> So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
> mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
> mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
> and mptcp_userspace_pm_get_sock().
> 
> 'Suggested-by: Jakub Kicinski <kuba@kernel.org>'
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v4:
>  - use GENL_REQ_ATTR_CHECK in more functions as Matt suggested (thanks)

Thank you for the v4!

(...)

> @@ -309,18 +307,17 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
>  
>  int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	struct mptcp_pm_addr_entry *match;
>  	struct mptcp_sock *msk;
> +	struct nlattr *id;
>  	int err = -EINVAL;
>  	struct sock *sk;
>  	u8 id_val;
>  
> -	if (!id) {
> -		GENL_SET_ERR_MSG(info, "missing required ID");
> +	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_LOC_ID))
>  		return err;
> -	}
>  
> +	id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	id_val = nla_get_u8(id);

Small detail: do we still need the 'struct nlattr *' variables? Here it
looks like you could directly have:

  id_val = nla_get_u8(info->attrs[MPTCP_PM_ATTR_LOC_ID]);

Same in the other functions, no? Up to you.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

