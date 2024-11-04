Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B7D18C342
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748436; cv=none; b=VMyPDeNrA+lNbyUMcV/2dcp+1MjbTopjkebEvLjW2Kmt20oVRNML+3bqwQOKCnPTWImzauAqHKuZWKatz98ZN2b8qpmxTx6nrqRreDupSB9+adqsnf43jEkTo5DPcgXbBlneLLg7ouENjH06J+XaIdQZmmsJLtgb0q+BTT1jJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748436; c=relaxed/simple;
	bh=vNIyD0ki4si2vCn/2X2j5OFxHSoGGLrMGDH5yaiM2Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqaAONwNO04KKLWW2yS8WnVpSIU1R8Qifl9Roggmoq1X6HDQU9qD8KfdbBdSkucTTjsCU600e2XJ2MJvj6HyTnsdyIPublJ6EsyBjQowH11tYKOQ5uhUE/veGP95d+SFQ5D02DWo5v3kqZlca+RE6L7vj1unj8q7RqTcrMghYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxZPz/Nh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxZPz/Nh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55A1C4CECE;
	Mon,  4 Nov 2024 19:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730748436;
	bh=vNIyD0ki4si2vCn/2X2j5OFxHSoGGLrMGDH5yaiM2Co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JxZPz/NhZDCdVxPb3YSVBB+d+z24ZBd4LRBYCXCMTK2jFl4xcLhnFS3NGzqyvLd+G
	 5h+Jbs9x4ORH/tLWaQnoT7jGi5yQWfKqev0GeR+whPsTmU/px14GzK7goYXukI096l
	 V6T8T6W7Ed5JQpKIEkfy9u1mDko5nml1jNUEwVGaGdyC8gGg6xlr/5tN3bgN9MEWkA
	 KMm5fhLQ6b7RXcXLw24jK5z+80CE9Vc5etCWV6mdcfuQUWSBCmAnbk2Na/BM2X0Z1J
	 OynuaD69/Hs9xsiEV5eIW+vLMRsrEoPHP0B33dVGoQsYmwuaq3p/vosFJzJBlGjQO9
	 kGTR/MQbpA9zw==
Message-ID: <541dbd94-6d3f-4ed2-8d58-3313b9f295b9@kernel.org>
Date: Mon, 4 Nov 2024 20:27:14 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 28/36] mptcp: drop free_list for deleting
 entries
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <9aeee6d70b0b4071765029bc2ac3dd9c2033a85c.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9aeee6d70b0b4071765029bc2ac3dd9c2033a85c.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> With the help of mptcp_pm_remove_addr_entry(), it's no longer necessary to
> move the entry to be deleted to free_list and then traverse the list to
> delete the entry, which is not allowed in BPF. The entry can be directly
> deleted through list_del_rcu() and sock_kfree_s() now.

Maybe clearer to squash this in the previous commit.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 21b2a3b02cfe..e5dfa1a6db31 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -283,9 +283,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>  	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
>  	struct mptcp_pm_addr_entry *match;
> -	struct mptcp_pm_addr_entry *entry;
>  	struct mptcp_sock *msk;
> -	LIST_HEAD(free_list);
>  	int err = -EINVAL;
>  	struct sock *sk;
>  	u8 id_val;
> @@ -312,23 +310,21 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
>  
>  	spin_lock_bh(&msk->pm.lock);
>  	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);

Can you not remove the entry from the list here (if there is a match?)

> +	spin_unlock_bh(&msk->pm.lock);
>  	if (!match) {
>  		GENL_SET_ERR_MSG(info, "address with specified id not found");
> -		spin_unlock_bh(&msk->pm.lock);
>  		release_sock(sk);
>  		goto out;
>  	}
>  
> -	list_move(&match->list, &free_list);

(or keep the del here, no?)

> -	spin_unlock_bh(&msk->pm.lock);
> -
>  	mptcp_pm_remove_addr_entry(msk, match);
>  
>  	release_sock(sk);
>  
> -	list_for_each_entry_safe(match, entry, &free_list, list) {
> -		sock_kfree_s(sk, match, sizeof(*match));
> -	}
> +	spin_lock_bh(&msk->pm.lock);
> +	list_del_rcu(&match->list);
> +	sock_kfree_s(sk, match, sizeof(*match));
> +	spin_unlock_bh(&msk->pm.lock);
>  
>  	err = 0;
>  out:

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

