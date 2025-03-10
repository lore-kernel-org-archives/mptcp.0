Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3111DE3A6
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648783; cv=none; b=eDVmQSssBgfYuJJRE/qE1HFxtyG4LPXrTWm2fOk7Zb86gqklQMsIIBko8SYGngGz7XrPFUOKfMNli1COaauR7wtoumlpdxCkwgkKkhqWMwqgqguZxLDwl/Ux86oY4mbncoMLlsXKFc1gVUvleSQNHPGj74vTiIY8QufcNOueoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648783; c=relaxed/simple;
	bh=ZUVZOqGvLBP4rHRTY9YR31bKuMVXQ0jyawyzYab7wYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPBnRIXXDZTpBVwNHdsmamNq26Z6o2RXGh8fTIzCuIR/vAurDYDbgx8mBuIUW/Aeoe7EmBKSFvFltWBn3R4Xh/O1blADE7wQUtGKjQM3IqNwHpfm+ZEIwcRGF4XtnJdAWc6pmSPPVbS38qZiQYc0uT/1WHRvF+6l2H5rKWntRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfadvgtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfadvgtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD8AC4CEE5;
	Mon, 10 Mar 2025 23:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741648782;
	bh=ZUVZOqGvLBP4rHRTY9YR31bKuMVXQ0jyawyzYab7wYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dfadvgtdK2Ilz3t2XkxKr7UpNCnRz/eDr8bCm+1Ino1BFQTJu+nGIF9Oy7ZdqpQmo
	 mXsdFkodwKiJA9qCWfhbytr/ARjY1P2R3NlLw9D7TA4ocOxGixx2Km7sm30EQh9uCD
	 61GSVfwSH67fYuyZo3Htz6VO7ZJsqGyRqtyeYIv1XRxM3zFpAHicYLOHDt/55zhGk3
	 XWkRch524iy/M6CIpQRShXoUm+D78ya9vpfjEc5lBXWE82EPaF6+XkpcaqNu9yDiFV
	 uQu2NshjGrFDRwtqqffcDdup9XL4oBcEN3ebIn3xTH01wdiG2Vawntvo+F1KszdiVC
	 ksr/u2o34KOsg==
Message-ID: <d3133a7a-110d-49a7-93eb-b49c49c765bc@kernel.org>
Date: Tue, 11 Mar 2025 00:19:30 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v10 09/12] mptcp: sysctl: map path_manager to
 pm_type
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
 <a38a4f3b6cc2ac7082401a22bc33eb0d844f0b37.1741258415.git.tanggeliang@kylinos.cn>
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
In-Reply-To: <a38a4f3b6cc2ac7082401a22bc33eb0d844f0b37.1741258415.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2025 12:01, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch maps the newly added path manager sysctl "path_manager"
> to the old one "pm_type".
> 
> 	path_manager   pm_type
> 
> 	"kernel"    -> MPTCP_PM_TYPE_KERNEL
> 	"userspace" -> MPTCP_PM_TYPE_USERSPACE
> 	others      -> __MPTCP_PM_TYPE_NR
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/ctrl.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 1f405be6bc00..6a35e6bb0a63 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -200,6 +200,9 @@ static int mptcp_set_path_manager(char *path_manager, const char *name)
>  static int proc_path_manager(const struct ctl_table *ctl, int write,
>  			     void *buffer, size_t *lenp, loff_t *ppos)
>  {
> +	struct mptcp_pernet *pernet = container_of(ctl->data,
> +						   struct mptcp_pernet,
> +						   path_manager);
>  	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
>  	char pm_name[MPTCP_PM_NAME_MAX];
>  	const struct ctl_table tbl = {
> @@ -211,8 +214,16 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
>  	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
>  
>  	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
> -	if (write && ret == 0)
> +	if (write && ret == 0) {
> +		u8 pm_type = __MPTCP_PM_TYPE_NR;
> +
> +		if (strncmp(pm_name, "kernel", MPTCP_PM_NAME_MAX) == 0)
> +			pm_type = MPTCP_PM_TYPE_KERNEL;
> +		else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) == 0)
> +			pm_type = MPTCP_PM_TYPE_USERSPACE;
> +		pernet->pm_type = pm_type;

This should be done after mptcp_set_path_manager(), and if there were no
errors (ret == 0), because if the name is not valid, the path-manager
will not be modified, so pm_type should not be modified as well.

BTW, did you check that setting "pm_type = __MPTCP_PM_TYPE_NR" is OK?
Can we display 2, but not allow to set 2 for pm_type here? In other
words, please check that this is OK with your modifications:

  # sysctl net.mptcp.pm_type=2
  sysctl: setting key "net.mptcp.pm_type": Invalid argument
  # sysctl -q net.mptcp.path_manager = "$BPF_PM"
  # sysctl -n net.mptcp.pm_type
  2

>  		ret = mptcp_set_path_manager(*path_manager, pm_name);
> +	}
>  
>  	return ret;
>  }
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

