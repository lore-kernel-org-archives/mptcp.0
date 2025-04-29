Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145020FAA1
	for <mptcp@lists.linux.dev>; Tue, 29 Apr 2025 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931615; cv=none; b=alb7rfERSFRwVFArlMjRuuuLqlWYtUOyeizfINLYOfTdXX24HkPt+rPocoy4xwtZrUrlkdu9P+Yct1Tz2QKUuEBRteGkrNgWKqQS2jBpJNYj+Q5Xyj1ueFCHZZ7oQ0VMVjzuxtOcwbZNJuRNu9JGjWuuU30BtDF/Y6KgU18dgds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931615; c=relaxed/simple;
	bh=G8izE4MQVzFey34Y9bzN2VM88eNVQHsOnDrNz5QexwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=thoD2DbJj/7OLvKUxI44HpEtPw3E8Lfqccsz/Orhb5qWswou8jvhOe1jeQmXelvv+M/HVdEmtJGcgLv0ceqMNwQNIx/2HrTvreaLW45PgcSY37Y30ywoBOTH3geWjTF5BGZqpY4kDP0rtsenuTMZ3bLSOAMDKcPMz1PT3Zkfoi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gt4PynJ4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gt4PynJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07685C4CEEF;
	Tue, 29 Apr 2025 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745931615;
	bh=G8izE4MQVzFey34Y9bzN2VM88eNVQHsOnDrNz5QexwY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=gt4PynJ4d2jil/KDptNmAVIfOaQfzjHKUB5bIWR5LE7uEML4cJhKA0QhJV8WMkF+c
	 uwcXJhmS7Q4s39VJpuKbdWJtNQUqIy63ZsJ5ZTc5MiP6cdsc6xgkorFZj+39XP6U3z
	 RpQZjY9ITnxWqh7D34dVa8//jnHVRxdNsfF2oMPAvYhobWK10S7ZJzsdFCB7+AG6Mz
	 yA5CbrVb2wyp0K98Eu9LbMtpPfgRNW7UOt94OYw843IcYyQFFBhCHVbTXa/aRqZnZh
	 DqfkmayUb5LgyvNgv7mfdE8qOs1dwXIG447xlLky/yLwTVYTZ79DdqtKFEop9a1A70
	 KyKsKE3VD+jMA==
Message-ID: <a52ed69c-fb50-4a1d-954e-289515f98d20@kernel.org>
Date: Tue, 29 Apr 2025 15:00:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 0/5] Add 'dump_subflow' test in selftests
Content-Language: en-GB, fr-BE
To: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev
References: <cover.1745395366.git.yangang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <cover.1745395366.git.yangang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 25/04/2025 08:18, Gang Yan wrote:
> The 'subflow_get_info_size' is called only in 'inet_sk_attr_size', and
> the only calltrace is that 'tcp_diag_dump_one'->'inet_diag_dump_one_icsk'
> ->'inet_sk_attr_size'.
> 
> So It's necessary to add 'get_subflow_info' in mptcp_diag.c to cover this
> function. Given a specific TCP connection, it is possible to judge if
> it is a MPTCP subflow by 'INET_ULP_INFO_MPTCP' and print 'subflow_info'.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
> 
> ------
> Changelog
>   v2:
>     - Fix the CI compiling error.
>   v3:
>     - Set idaig_ext when 'r' is declared.
>     - Declare iovlen to 0, and adjust the increment logic.
>     - Squash patch 3 into patch 4.
>     - Rename 'subflow_addr' to 'subflow_addrs'
>     - Remove the comment and declare [ad]ddr on the same line.
>     - Set id.idiag_cookie[0/1] when r is declared.
>     - Remove the 'id.idiag_if = 0' because the default value is 0.
>     - Squash patch 6 into patch 5.
>     - Add the example of output in commit message.
>     - Adjust the input of 'mptcp_diag -s' to "saddr:sport daddr:dport"
>       to save a few lines in diag.sh
>     - In diag.sh, use "mptcp_diag -s '$subflow_line'" instead of
>       the old version, and call 'ss' only once to ensure the safety.
>     - Fix some error/check/warning problems in CI.
>     - Put the link of issue into the commit message of patch 5.

Thank you for the new version. It looks good to me, just some details
that I can include when applying the patches.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

> 
> Gang Yan (5):
>   selftests: mptcp: add struct params in mptcp_diag
>   selftests: mptcp: refactor send_query parameters for code clarity
>   selftests: mptcp: refactor NLMSG handling with 'proto'
>   selftests: mptcp: add helpers to get subflow_info
>   selftests: mptcp: add chk_sublfow in diag.sh
> 
>  tools/testing/selftests/net/mptcp/diag.sh     |  33 +++
>  .../testing/selftests/net/mptcp/mptcp_diag.c  | 228 +++++++++++++++---
>  2 files changed, 229 insertions(+), 32 deletions(-)
> 

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

