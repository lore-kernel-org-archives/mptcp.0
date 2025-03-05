Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82920469F
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175316; cv=none; b=uXyJmqQvBUy3KzK9M2lGdZ50532rqxId1bscbIkWrUOvntgeJZaoUwUZvhH14fgPUJqgfgPai5uQHH3TnI2vGM+n7SjhdpiR1AgRKtXKO+Uz+MdP1N3zb9Bq1WnArqxjB7dmRtM7GE++Hi3oj+f+8O/PaBVHzRw28KLnnd+i95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175316; c=relaxed/simple;
	bh=4igxAqimbyXg37fB1gsOKxqKnZOvrKIGm5xJUEq1mzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ex/bIyfvKDKyCy1fgATY4X/6T2lv5f6fumagd7TfpXBdGAkgTaFLHi3EN22Ao1zyOYy9yRbBUVliCcZEm/GncxE8kdMp17L7XRPjejx6ofJQt3pXDRPz3aj47zLVzQoXxYtmhmEUSee5opZn0Fm3Rgr0+hl50CQ0HF6EEbYqgLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONJVV9o6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONJVV9o6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17570C4CEE2;
	Wed,  5 Mar 2025 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175315;
	bh=4igxAqimbyXg37fB1gsOKxqKnZOvrKIGm5xJUEq1mzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ONJVV9o6jXIVsHl4Q9y2z3//6bweP9JpT3Dh28xv54xePyQhHBWz4dSJJbJJIgZ2x
	 mVzCTM0FyUTj67DPHMVSf4DU3+QyExLyE+auVATYOaO2zV9jIjjUA7vyUDNfXx0XX/
	 Nait5ot2Mn2qsfmSZ4F1aKfFdyaAv/WDs9im6h7sBYUciTRqseVrY7u+Eean0idHlN
	 rbZKJoXUL6Xu7R5Np1cUejwB334UNpiTtq7js5p2QecOYSNZPoOtoSFmREzlJ82ScA
	 sSv65hNP9+glpZXMhL1wLJvutNQaMyU+x5PBDo0XLe7DH5wxCltiMXZjDiZWlHfyb9
	 J5Lt8/f2AGkLw==
Message-ID: <9614d184-bddf-41fb-866d-9357904c7070@kernel.org>
Date: Wed, 5 Mar 2025 12:48:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 04/12] mptcp: sysctl: map path_manager to
 pm_type
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <c83ba5bf407386ae9160ce1e570a93d3eb74e3b1.1741088339.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <c83ba5bf407386ae9160ce1e570a93d3eb74e3b1.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/03/2025 12:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch maps the newly added path manager sysctl "path_manager"
> to the old one "pm_type".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/ctrl.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index d425fcbd036a..a158a337cdb5 100644
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
>  	char val[MPTCP_PM_NAME_MAX];
>  	const struct ctl_table tbl = {
> @@ -211,8 +214,14 @@ static int proc_path_manager(const struct ctl_table *ctl, int write,
>  	strscpy(val, *path_manager, MPTCP_PM_NAME_MAX);
>  
>  	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
> -	if (write && ret == 0)
> +	if (write && ret == 0) {
> +		u8 pm_type = MPTCP_PM_TYPE_KERNEL;
> +
> +		if (!strncmp(val, "userspace", MPTCP_PM_NAME_MAX))

(detail: please use '== 0', that feels more natural than "not strncmp")

> +			pm_type = MPTCP_PM_TYPE_USERSPACE;
> +		pernet->pm_type = pm_type;

Should we not already cope with the future BPF PMs?

  if "kernel":
    pm_type = MPTCP_PM_TYPE_KERNEL;
  elif "userspace:
    pm_type = MPTCP_PM_TYPE_USERSPACE;
  else:
    pm_type = __MPTCP_PM_TYPE_NR;

Please check that this doesn't cause issue to display "pm_type" to 2
here -- note that we should not change the current mptcp_pm_type_max:
the userspace **cannot** set "net.mptcp.pm_type=2".

In other words, please check that this is OK:

  # sysctl net.mptcp.pm_type=2
  sysctl: setting key "net.mptcp.pm_type": Invalid argument
  # sysctl -q net.mptcp.path_manager = "$BPF_PM"
  # sysctl -n net.mptcp.pm_type
  2

>  		ret = mptcp_set_path_manager(*path_manager, val);
> +	}
>  
>  	return ret;
>  }

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

