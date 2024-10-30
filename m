Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479A1B373A
	for <mptcp@lists.linux.dev>; Wed, 30 Oct 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312436; cv=none; b=ux6Ny97A/OArT+wUtVpURXyPDc2e6hNwtogVsMuuQgu9X6awW6n5Y8Ppbuko9neAcm+tS/AuqlJsQtY/HdeIfmEjmo8R3/EW3RitVQNkwfAYPwA7fsE6HjSNdUh5UQ/PZG30kTyoskXdLb6j4R0P6kVJjB+ffp0fDJIRUxLBMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312436; c=relaxed/simple;
	bh=VUmo5mUrYRR29MHKka33ZKdJ8Q4Xh+PcXr/uUw8BfOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyTva6wcnwKRqmU3w8kQjcJfrBbrRP3lvM0Jf8XIZuu70Myw6z819pjwtco4orQ8pXTYq7/LkwMVvOYSfiVaQ6Q3T9KBJGeBcZyF1+/JgLdKLcRvBsGtwvRSXTsPRZbPnqAzerZR4NDFE/iJeF93lXXxod029vB3PyQp0v6Hf7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6G7HYH5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6G7HYH5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683ABC4CECE;
	Wed, 30 Oct 2024 18:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730312436;
	bh=VUmo5mUrYRR29MHKka33ZKdJ8Q4Xh+PcXr/uUw8BfOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J6G7HYH599JYedfwmeB043KRDGSCdDDDMQjAcSdSOzdmU6/+K7tXaZ1WDMIb9J5fl
	 Oe1bfYyrp2AyAA1Jk0K+wRO8QJiA66VjBROeYUAk099U/c8bydiFmYYZte2SDhnxUW
	 k2jJtmCiik26z5crpW/WuKV6z0VJfekMB/XEkC5jr8uzjCWRCaHF87VsAOlnGuWU2t
	 +NiexSzYEqe9+y+FpOUhkrvyHsigbbvYa4e3SJ0ttxPbU4Mc5a6cdsbgM8pRlRBmS8
	 ++QhiTObUbgLL8NdrIaBvFHZnt2YwAEeJhrtIFscRjZEg14cbJqfgKH8Rx/UpHcXPw
	 5LMiOww2rYlow==
Message-ID: <293210ee-ef7c-4ad7-a46d-82beb1dec193@kernel.org>
Date: Wed, 30 Oct 2024 19:20:33 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 03/36] mptcp: add mptcp_for_each_address
 macros
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729588019.git.tanggeliang@kylinos.cn>
 <b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 xsFNBFXj+ekBEADxVr99p2guPcqHFeI/JcFxls6KibzyZD5TQTyfuYlzEp7C7A9swoK5iCvf
 YBNdx5Xl74NLSgx6y/1NiMQGuKeu+2BmtnkiGxBNanfXcnl4L4Lzz+iXBvvbtCbynnnqDDqU
 c7SPFMpMesgpcu1xFt0F6bcxE+0ojRtSCZ5HDElKlHJNYtD1uwY4UYVGWUGCF/+cY1YLmtfb
 WdNb/SFo+Mp0HItfBC12qtDIXYvbfNUGVnA5jXeWMEyYhSNktLnpDL2gBUCsdbkov5VjiOX7
 CRTkX0UgNWRjyFZwThaZADEvAOo12M5uSBk7h07yJ97gqvBtcx45IsJwfUJE4hy8qZqsA62A
 nTRflBvp647IXAiCcwWsEgE5AXKwA3aL6dcpVR17JXJ6nwHHnslVi8WesiqzUI9sbO/hXeXw
 TDSB+YhErbNOxvHqCzZEnGAAFf6ges26fRVyuU119AzO40sjdLV0l6LE7GshddyazWZf0iac
 nEhX9NKxGnuhMu5SXmo2poIQttJuYAvTVUNwQVEx/0yY5xmiuyqvXa+XT7NKJkOZSiAPlNt6
 VffjgOP62S7M9wDShUghN3F7CPOrrRsOHWO/l6I/qJdUMW+MHSFYPfYiFXoLUZyPvNVCYSgs
 3oQaFhHapq1f345XBtfG3fOYp1K2wTXd4ThFraTLl8PHxCn4ywARAQABzSRNYXR0aGlldSBC
 YWVydHMgPG1hdHR0YmVAa2VybmVsLm9yZz7CwZEEEwEIADsCGwMFCwkIBwIGFQoJCAsCBBYC
 AwECHgECF4AWIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZUDpDAIZAQAKCRD2t4JPQmmgcz33
 EACjROM3nj9FGclR5AlyPUbAq/txEX7E0EFQCDtdLPrjBcLAoaYJIQUV8IDCcPjZMJy2ADp7
 /zSwYba2rE2C9vRgjXZJNt21mySvKnnkPbNQGkNRl3TZAinO1Ddq3fp2c/GmYaW1NWFSfOmw
 MvB5CJaN0UK5l0/drnaA6Hxsu62V5UnpvxWgexqDuo0wfpEeP1PEqMNzyiVPvJ8bJxgM8qoC
 cpXLp1Rq/jq7pbUycY8GeYw2j+FVZJHlhL0w0Zm9CFHThHxRAm1tsIPc+oTorx7haXP+nN0J
 iqBXVAxLK2KxrHtMygim50xk2QpUotWYfZpRRv8dMygEPIB3f1Vi5JMwP4M47NZNdpqVkHrm
 jvcNuLfDgf/vqUvuXs2eA2/BkIHcOuAAbsvreX1WX1rTHmx5ud3OhsWQQRVL2rt+0p1DpROI
 3Ob8F78W5rKr4HYvjX2Inpy3WahAm7FzUY184OyfPO/2zadKCqg8n01mWA9PXxs84bFEV2mP
 VzC5j6K8U3RNA6cb9bpE5bzXut6T2gxj6j+7TsgMQFhbyH/tZgpDjWvAiPZHb3sV29t8XaOF
 BwzqiI2AEkiWMySiHwCCMsIH9WUH7r7vpwROko89Tk+InpEbiphPjd7qAkyJ+tNIEWd1+MlX
 ZPtOaFLVHhLQ3PLFLkrU3+Yi3tXqpvLE3gO3LM7BTQRV4/npARAA5+u/Sx1n9anIqcgHpA7l
 5SUCP1e/qF7n5DK8LiM10gYglgY0XHOBi0S7vHppH8hrtpizx+7t5DBdPJgVtR6SilyK0/mp
 9nWHDhc9rwU3KmHYgFFsnX58eEmZxz2qsIY8juFor5r7kpcM5dRR9aB+HjlOOJJgyDxcJTwM
 1ey4L/79P72wuXRhMibN14SX6TZzf+/XIOrM6TsULVJEIv1+NdczQbs6pBTpEK/G2apME7vf
 mjTsZU26Ezn+LDMX16lHTmIJi7Hlh7eifCGGM+g/AlDV6aWKFS+sBbwy+YoS0Zc3Yz8zrdbi
 Kzn3kbKd+99//mysSVsHaekQYyVvO0KD2KPKBs1S/ImrBb6XecqxGy/y/3HWHdngGEY2v2IP
 Qox7mAPznyKyXEfG+0rrVseZSEssKmY01IsgwwbmN9ZcqUKYNhjv67WMX7tNwiVbSrGLZoqf
 Xlgw4aAdnIMQyTW8nE6hH/Iwqay4S2str4HZtWwyWLitk7N+e+vxuK5qto4AxtB7VdimvKUs
 x6kQO5F3YWcC3vCXCgPwyV8133+fIR2L81R1L1q3swaEuh95vWj6iskxeNWSTyFAVKYYVskG
 V+OTtB71P1XCnb6AJCW9cKpC25+zxQqD2Zy0dK3u2RuKErajKBa/YWzuSaKAOkneFxG3LJIv
 Hl7iqPF+JDCjB5sAEQEAAcLBXwQYAQIACQUCVeP56QIbDAAKCRD2t4JPQmmgc5VnD/9YgbCr
 HR1FbMbm7td54UrYvZV/i7m3dIQNXK2e+Cbv5PXf19ce3XluaE+wA8D+vnIW5mbAAiojt3Mb
 6p0WJS3QzbObzHNgAp3zy/L4lXwc6WW5vnpWAzqXFHP8D9PTpqvBALbXqL06smP47JqbyQxj
 Xf7D2rrPeIqbYmVY9da1KzMOVf3gReazYa89zZSdVkMojfWsbq05zwYU+SCWS3NiyF6QghbW
 voxbFwX1i/0xRwJiX9NNbRj1huVKQuS4W7rbWA87TrVQPXUAdkyd7FRYICNW+0gddysIwPoa
 KrLfx3Ba6Rpx0JznbrVOtXlihjl4KV8mtOPjYDY9u+8x412xXnlGl6AC4HLu2F3ECkamY4G6
 UxejX+E6vW6Xe4n7H+rEX5UFgPRdYkS1TA/X3nMen9bouxNsvIJv7C6adZmMHqu/2azX7S7I
 vrxxySzOw9GxjoVTuzWMKWpDGP8n71IFeOot8JuPZtJ8omz+DZel+WCNZMVdVNLPOd5frqOv
 mpz0VhFAlNTjU1Vy0CnuxX3AM51J8dpdNyG0S8rADh6C8AKCDOfUstpq28/6oTaQv7QZdge0
 JY6dglzGKnCi/zsmp2+1w559frz4+IC7j/igvJGX4KDDKUs0mlld8J2u2sBXv7CGxdzQoHaz
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <b6b53fd730a0edd0024963468d078488ad5e67aa.1729588019.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 22/10/2024 11:14, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Similar to mptcp_for_each_subflow() and mptcp_for_each_subflow_safe()
> macros, this patch adds two new macros mptcp_for_each_address() and
> mptcp_for_each_address_safe() to iterate over the address entries on
> userspace_pm_local_addr_list of the mptcp socket.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 12 ++++++------
>  net/mptcp/protocol.h     |  5 +++++
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index 2cceded3a83a..00a7f9dd90cf 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -41,7 +41,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
>  	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address(msk, e) {
>  		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
>  		if (addr_match && entry->addr.id == 0 && needs_id)
>  			entry->addr.id = e->addr.id;
> @@ -92,7 +92,7 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
>  {
>  	struct mptcp_pm_addr_entry *entry, *tmp;
>  
> -	list_for_each_entry_safe(entry, tmp, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address_safe(msk, entry, tmp) {
>  		if (mptcp_addresses_equal(&entry->addr, &addr->addr, false)) {
>  			/* TODO: a refcount is needed because the entry can
>  			 * be used multiple times (e.g. fullmesh mode).
> @@ -112,7 +112,7 @@ mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
>  {
>  	struct mptcp_pm_addr_entry *entry;
>  
> -	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address(msk, entry) {
>  		if (entry->addr.id == id)
>  			return entry;
>  	}
> @@ -127,7 +127,7 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
>  			     inet_sk((struct sock *)msk))->inet_sport;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	list_for_each_entry(e, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address(msk, e) {
>  		if (mptcp_addresses_equal(&e->addr, skc, false)) {
>  			entry = e;
>  			break;
> @@ -155,7 +155,7 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
>  	bool backup = false;
>  
>  	spin_lock_bh(&msk->pm.lock);
> -	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address(msk, entry) {
>  		if (mptcp_addresses_equal(&entry->addr, skc, false)) {
>  			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
>  			break;
> @@ -642,7 +642,7 @@ int mptcp_userspace_pm_dump_addr(struct sk_buff *msg,
>  
>  	lock_sock(sk);
>  	spin_lock_bh(&msk->pm.lock);
> -	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
> +	mptcp_for_each_address(msk, entry) {
>  		if (test_bit(entry->addr.id, bitmap->map))
>  			continue;
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index b4c72a73594f..ce3b12778b3f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -354,6 +354,11 @@ struct mptcp_sock {
>  #define mptcp_for_each_subflow_safe(__msk, __subflow, __tmp)			\
>  	list_for_each_entry_safe(__subflow, __tmp, &((__msk)->conn_list), node)
>  
> +#define mptcp_for_each_address(__msk, __entry)			\
> +	list_for_each_entry(__entry, &((__msk)->pm.userspace_pm_local_addr_list), list)
> +#define mptcp_for_each_address_safe(__msk, __entry, __tmp)			\
> +	list_for_each_entry_safe(__entry, __tmp, &((__msk)->pm.userspace_pm_local_addr_list), list)

If it is specific to the userspace PM, maybe best to declare them in
pm_userspace.c, no?

Also, the name is very generic for something so specific. Maybe:

  mptcp_for_each_pm_userspace_local_addr(_safe)

Otherwise, if we see "mptcp_for_each_address(msk, entry)" in the code,
it is really not clear what you are looking at I think, no?

> +
>  extern struct genl_family mptcp_genl_family;
>  
>  static inline void msk_owned_by_me(const struct mptcp_sock *msk)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

