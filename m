Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEA18C926
	for <mptcp@lists.linux.dev>; Mon,  4 Nov 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747589; cv=none; b=ee8V/zXuDTU4Xnx3wm0A1qJ2Nb/KT8pQUkC/Nnv/hSsuLEQJgNI8kuhEyNWiX5j5PcSN7iziyVWvb6l/9pOOla+Zvv51mfXCV2gOQPHVBYNzeGQPM/L/hBZaNfStxrb7/rBu7OM6+n0EWyXcX33Abc4BuI3CoGkkhspvG8Ljc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747589; c=relaxed/simple;
	bh=XF1ZE634gKk9ype/9/LKPN+LVz9WTaSENBRonuEt98o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkT36WyOUAZH3ib6iemFZrriLj1I5UnjZEX5jLSG1DNHsvNULoCO6/6zgsYcj89S5giyU1utf0dytWQ4aTQ2rAzkU253Nq4/gufgnvQhL6C5gBQ8fpG7z7rC8eJ7+Wg7eBGNtXJANVsMJVuaNm+TWgwbKNURUFzvaLDGQpX7/Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDWVzEAN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDWVzEAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B9CC4CECE;
	Mon,  4 Nov 2024 19:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747588;
	bh=XF1ZE634gKk9ype/9/LKPN+LVz9WTaSENBRonuEt98o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BDWVzEANLSbFq1j8V+Y1YcAN/TFfQD45UZkk6Bc9y67P5ZwBWD1AgYMSZkDMyidC1
	 kqAsLBJEgnnX91+hR0nNDsibNHbKWkuGoGSnVgpx6OEpeIySWEi3QP+9zfYNv1B5IG
	 Dl3EA/NSNr8QB0LS/aQ5uLQY8K/IvhD2kCpSytd9KHh5ORqorcoMiwRt6G3DHqg+qT
	 3HK4QM4BHFALVHsDKVJ9HN/Ssm5PbVp07AUTfS78QDSH5+euHyeb6RtmsT2SVnovqX
	 J420lOcCQ0rdCYmYl8qmNlkWL3zOPYDRKtcNRh2CYDZKPnYZc72qOG6fC1TTIU3YfH
	 Gqrzqz0pxycKw==
Message-ID: <0cf4c951-4a66-4ad3-b403-2b966d657f1b@kernel.org>
Date: Mon, 4 Nov 2024 20:13:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 24/36] mptcp: drop struct mptcp_pm_add_entry
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <c1a57a18940b94c6db9ce423fe3d84e050397589.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c1a57a18940b94c6db9ce423fe3d84e050397589.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> There is no need to add a dedicated address entry type "mptcp_pm_add_entry"
> to represent ADD_ADDR addresses. Additional fields for ADD_ADDR addresses
> can be added into struct mptcp_pm_addr_entry directly. This makes the path
> manager code simpler.
> 
> Here "union" can be used to merge struct mptcp_pm_addr_entry and struct
> mptcp_pm_add_entry into one. Then all mptcp_pm_add_entry can be replaced by
> mptcp_pm_addr_entry.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d9badf270b15..9dc01140af23 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -243,9 +243,19 @@ struct mptcp_pm_data {
>  struct mptcp_pm_addr_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
> -	u8			flags;
> -	int			ifindex;
> -	struct socket		*lsk;
> +	union {
> +		struct {
> +			u8			flags;
> +			int			ifindex;
> +			struct socket		*lsk;
> +		};
> +		/* mptcp_pm_add_entry */
> +		struct {
> +			u8			retrans_times;
> +			struct timer_list	add_timer;

This will increase the size of the structure even more. Please make sure
it is not used in an array (linked to my comment on the previous commit).

> +			struct mptcp_sock	*sock;
> +		};
> +	};
>  };
>  
>  struct mptcp_data_frag {
> @@ -1028,10 +1038,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
>  			      const struct mptcp_addr_info *addr);
>  void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
>  bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
> -struct mptcp_pm_add_entry *
> +struct mptcp_pm_addr_entry *
>  mptcp_pm_del_add_timer(struct mptcp_sock *msk,
>  		       const struct mptcp_addr_info *addr, bool check_id);
> -struct mptcp_pm_add_entry *
> +struct mptcp_pm_addr_entry *
>  mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
>  				const struct mptcp_addr_info *addr);
>  int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *loc,

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

