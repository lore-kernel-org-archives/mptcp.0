Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE81F0E2C
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998457; cv=none; b=cVTDHsl0R9UxmaxXJq30rcN6FN7fbleHvcu5+mDaVf2SxE/9JF8GiAteTsw/uso8vPvXWjyeN/yOiF4tVDVo5pxmYHXiGy1cq5EsRoFFlCLkBa/98Tqeas8QUgjL6Sd/SDpj6C+Sj9gFKzqScUuYfUwrb/G+aWONStsshmiG8n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998457; c=relaxed/simple;
	bh=h1m2OmNENpFF27pn+QS76tyFqMwJMqxVyqbS4vScfTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejruyqJ7wFadqziJ9eFo1RMLvKBc60VvKOvkcKZ4SMECTRwjVCpolkyfyYn3aye69PNtXQcrCilhwwP80/w1v/GvJffUSYAHMy6LlebT5ACDDLBaxIs9Ewuo3pm3XqejFPtOIR2cQ9xFkcC2BhJHdXUVapPvmkl9iiajnlDDePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+4W/zXZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+4W/zXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B7C4CED6;
	Mon,  3 Mar 2025 10:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998456;
	bh=h1m2OmNENpFF27pn+QS76tyFqMwJMqxVyqbS4vScfTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i+4W/zXZPgxn0HzHs9Z6FHJPkCdXm5CLLRAsz3L16SYTKFHFU1RqHfeurK1K2lfeY
	 zj5jzHUBRTUa+CzoOUhBIvLHc/Cx396tE7ImolTWFmzWY96fNuI9zY+4D9LsHiTJOx
	 fXCej6rJ4eqyyAIKLsPats3ohFT8F3fO5wn6FzFZTBIXG21L4ZHRU1klZ7QCZ1W5ZF
	 45xubRVilnzJ6q07fd4+KWV2Et9Frtn/6rPR0iFE7UgnJ1z8nupM710wnRN4cPFXuf
	 C+Hu6UxE/f94DRgZ/EVP8MQty19LhxV3Qzv6omprmmECX2BYIJFH2hEhtgBUk27XPe
	 QS4qmMusUioXQ==
Message-ID: <4a3aeb25-5fc4-4e31-aa74-c2203c3ada2d@kernel.org>
Date: Mon, 3 Mar 2025 11:40:53 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 03/11] mptcp: sysctl: map pm_type to
 path_manager
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
 <8840912119ce5a1180550745d496087ac7e81fa0.1740975633.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8840912119ce5a1180550745d496087ac7e81fa0.1740975633.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 05:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new proc_handler "proc_pm_type" for "pm_type" to
> map old path manager sysctl "pm_type" to the newly added "path_manager".

Don't forget to add a selftest checking this new sysctl and the mapping
are correct, e.g. in userspace_pm.sh. See my previous comment:

https://lore.kernel.org/c49517d2-38e2-4848-9fb9-1c7748689cec@kernel.org

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/ctrl.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index d64e6b4f6d1d..32f13ab7db0a 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -217,6 +217,35 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
>  	return ret;
>  }
>  
> +static int proc_pm_type(const struct ctl_table *ctl, int write,
> +			void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct mptcp_pernet *pernet = container_of(ctl->data,
> +						   struct mptcp_pernet,
> +						   pm_type);

Out of curiosity, do you plan to drop pernet->pm_type later on?

When all the mptcp_pm_is_{kernel,userspace}() will be dropped, I think
we can also drop it from the mptcp_pernet structure. At that point, we
could then read info from "path_manager" and write in ctl->data 0, 1, or
2. But only when we will no longer use pernet->pm_type.

> +	unsigned int val = READ_ONCE(*(u8 *)ctl->data);
> +	const struct ctl_table tbl = {
> +		.maxlen = sizeof(val),
> +		.data = &val,
> +	};
> +	int ret;
> +
> +	if (val > mptcp_pm_type_max)
> +		return -ERANGE;

You might not need this if ...

> +
> +	ret = proc_douintvec(&tbl, write, buffer, lenp, ppos);

... you use proc_dou8vec_minmax() here and ...

> +	if (write && ret == 0) {
> +		char *path_manager = "kernel";
> +
> +		if (val == MPTCP_PM_TYPE_USERSPACE)
> +			path_manager = "userspace";
> +		mptcp_set_path_manager(pernet->path_manager, path_manager);
> +		WRITE_ONCE(*(u8 *)ctl->data, val);
> +	}
> +
> +	return ret;
> +}
> +
>  static struct ctl_table mptcp_sysctl_table[] = {
>  	{
>  		.procname = "enabled",
> @@ -261,9 +290,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.procname = "pm_type",
>  		.maxlen = sizeof(u8),
>  		.mode = 0644,
> -		.proc_handler = proc_dou8vec_minmax,
> -		.extra1       = SYSCTL_ZERO,
> -		.extra2       = &mptcp_pm_type_max

... you keep these two last lines.

> +		.proc_handler = proc_pm_type,
>  	},
>  	{
>  		.procname = "scheduler",
Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

