Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF54B3382
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444798; cv=none; b=ZjdJNCahyVfrFDi8KP6dj3OiRre0mTDM+Zljk1fKE0EQsGdKm1YWUHAyo51sPGTF1IVREnyI866ClInQMIGkiU/fDaBmmN5PnHzJAvXKmMMCx6PWE9ojPo4g8ahzcNCJBrnLmyka80UTzKDe+wwtK8rNRH46hnmQiRPv3wWaisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444798; c=relaxed/simple;
	bh=zLyKl17DAY502ydfq09Rvs+jvptSVtnuRH4ltx1yX2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPXqjCPAiYlKcxGyVnwau1p+Y+42FZXwwll3c9/Nfw8vhjkiw1ls4CcQ5IUrg2TE/MMUvHi65L/P9TqAB59AXrIYqEtcgcKDnbt1pKXzGMDlvOW4hS7jYKp2/GGj+LD9ZQwWdGUiYDtKTcBuNJ03ckDJVCEARaLyX8NXb3uxA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyNMEsjq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyNMEsjq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519881F00A3A;
	Thu,  3 Sep 2026 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788444784;
	bh=ACw6fPO7Q3c0UtFXLT3zNNHxZu+s6UpYc9EkqyC982Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CyNMEsjq+Hlu1CtR74gsAd90X9ByPjRKXxNbBL0zjKK9mcGTp15MaLkjsGq7CKCxy
	 ehrMAMgSOe2vrg5n+Qbp1UhI7nqWhF/CWqtZzNxmHYn5YZwsD1msuoLhH5Wli0Txay
	 +1HPvl7Z0HwMRc/ZDgdQW9bsUESQDuPiROZTqZdMO1ZKjl2ZJ5765zh4I7F+EsTm7E
	 DEElmTGMuOeziVGIPe7fe9f9LCCK7pBgEiaSCdy4yiltfpzrfFBdkC9EgeP1azHQt6
	 hHV82R8H/dfhYbWVPwv8m2uumxsxSyJRJ35gzfkd68uMD0Kb9G9FgFneODbFQ+cBm2
	 P1QwKQMVjhwGw==
Message-ID: <e962d225-caf9-4be6-af80-e7cc0f34a2ec@kernel.org>
Date: Thu, 3 Sep 2026 16:13:01 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 3/3] mptcp: pm: userspace: cap
 extra_subflows on Netlink subflow creation
Content-Language: fr
To: Tao Cui <cui.tao@linux.dev>, mptcp@lists.linux.dev, quanyeyang@proton.me
Cc: geliang@kernel.org, cuitao@kylinos.cn
References: <20260903131416.1112393-1-cui.tao@linux.dev>
 <20260903131416.1112393-4-cui.tao@linux.dev>
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
In-Reply-To: <20260903131416.1112393-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Tao, Quanye,

On 03/09/2026 15:14, Tao Cui wrote:
> From: Quanye Yang <quanyeyang@proton.me>
> 
> mptcp_pm_nl_subflow_create_doit() also increments the u8 extra_subflows
> counter without any limit: a client with CAP_NET_ADMIN can create more
> than 255 extra subflows via Netlink and wrap the counter back to 0,
> with the same effects as the MP_JOIN path now bounded separately:
> the underflow guards warn on the next subflow close, and
> mptcpi_subflows_total reported to userspace is corrupted.
> 
> Refuse the subflow creation with -ENOSPC once the counter has reached
> U8_MAX, and clean up the local address entry in that case as well.
> 
> Fixes: 77e4b94a3de6 ("mptcp: update userspace pm infos")
> Link: https://lore.kernel.org/all/20260902-mptcp-pm-extra-subflows-v1-1-68540a866e5a@proton.me/
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/629
> 

(no empty line here)

> Signed-off-by: Quanye Yang <quanyeyang@proton.me>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/pm_userspace.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
> index b94fbb483bf9..3371e17d01b9 100644
> --- a/net/mptcp/pm_userspace.c
> +++ b/net/mptcp/pm_userspace.c
> @@ -417,6 +417,12 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	local.ifindex = entry.ifindex;
>  
>  	spin_lock_bh(&msk->pm.lock);
> +	if (msk->pm.extra_subflows == U8_MAX) {
> +		spin_unlock_bh(&msk->pm.lock);
> +		GENL_SET_ERR_MSG(info, "too many extra subflows");
> +		err = -ENOSPC;
> +		goto delete_addr;
> +	}
>  	msk->pm.extra_subflows++;
>  	spin_unlock_bh(&msk->pm.lock);
>  
> @@ -424,9 +430,11 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
>  	err = __mptcp_subflow_connect(sk, &local, &addr_r);
>  	release_sock(sk);
>  
> -	if (err) {
> +	if (err)
>  		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
>  
> +delete_addr:

Can you not have the label inside the if-statement?

    if (err) {
        GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);

  delete_addr:
        (...)

> +	if (err) {
>  		spin_lock_bh(&msk->pm.lock);
>  		mptcp_userspace_pm_delete_local_addr(msk, &entry);

Maybe you can add something in the commit message for the reviewers:

  The same error path is followed after
  mptcp_userspace_pm_append_new_local_addr, which should probably not
  delete the local address unconditionally, but this is a pre-existing
  issue that will be addressed separately.

>  		spin_unlock_bh(&msk->pm.lock);

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

