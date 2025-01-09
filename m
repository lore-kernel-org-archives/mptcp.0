Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060221A42C
	for <mptcp@lists.linux.dev>; Thu,  9 Jan 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736437935; cv=none; b=qQbennKPKk9ETBVFEVEDrpTotmRtjM28hJm42WQkTqxkERByVE22IXKlmSWb1dWdW0qKf9cozOZw6Bk0D3jDKB6upCL7lPAhO60azorEB0wPo5W17tBJflVGjRv6+TKrmPKstJg4MEy82Dd/bg6pTbfQPJ164TpPSfW2X5Z/Stw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736437935; c=relaxed/simple;
	bh=wCxh7y8vB+wxCnxwzPevcU2yMfPnufF5FYksKIIyiBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AtgVsSs2WrbGzTppHAdk2hZIaiD+IuDzQQL0sxmA1TJ7WAtmAAdxxhyHzKT2K7dpMsXccSSYszxPsAyxkXdZP/g+W3FciLRvmi3gzPj8mFGG8HfVNRGYIHb1NJ6aZ+zF0SL1N/MIk8AWMQv64n4UxAoUJZzKfcWNAvFO/meMjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxaV3w+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxaV3w+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369CAC4CED2;
	Thu,  9 Jan 2025 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736437934;
	bh=wCxh7y8vB+wxCnxwzPevcU2yMfPnufF5FYksKIIyiBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QxaV3w+s8Mqqnq/dQ/zbcl9xCq4obPEOsusyZG9NnX8WPUGTvupz6Q7d0wgQIGWFo
	 fhWx6xpXnl94LMCL2GQ/SekLbxxAVaL+3vTGP9jm/m7eiUWlg86bQjKjZOoMWEa8SZ
	 9QVUmgF3k8yjGCd3szgdzEwFUNA8iMkUQsdAi5w+FRVOYigJLiG7frXrG4IGu8YqfA
	 vXP66VtcgL7qER39/6CXMKj1Z2NZZeGa9/pFaBoEnJZGue8XW1KU7/SlXCheNQPGEW
	 03QRYOE00nt9sdbZIDLFtANcUb+a4QTSmXJhLBzek+ghL98hTiymBjmmTfnb7ecdB5
	 7IxkUJXV13eug==
Message-ID: <e1d9bf9d-89c2-4584-92bf-3d142fa9861f@kernel.org>
Date: Thu, 9 Jan 2025 16:52:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [mptcp-next, v2, 0/3] mptcp: fix the issue of an valid signal can
 not join in
Content-Language: en-GB
To: Gang Yan <gang_yan@foxmail.com>
Cc: Gang Yan <yangang@kylinos.cn>, mptcp@lists.linux.dev,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
References: <tencent_3C9419313E4EE06582D82709B4EA32A2D009@qq.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <tencent_3C9419313E4EE06582D82709B4EA32A2D009@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gang,

On 09/01/2025 14:31, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> When we test the mptcp_join.sh, we find a bug. The 'signal invalid
> addresses timeout' will be FAIL when run in real test environment,
> but PASS in virtme. That's mainly because the status of invalid_addr's
> tcp connection is different. It is TCPF_SYNC_SENT in virtme, but
> TCPF_CLOSE in another cause the bug of 'add_addr_accepted'.
> 
> But in virtme, we can reproduce it through an invalid address
> in the same LAN, this also result in an error in TCP level. These
> patches will fix the issue.
> 
> Gang Yan (3):
>   mptcp: fix invalid addr occupy 'add_addr_accepted'
>   selftests: mptcp: relax conditions in SYN_TX validation
>   selftests: mptcp: add a testcase for invalid addr timeout

I'm not sure how you used 'git send-email', but the 4 emails from your
series are not "attached" to each others. Did you send the patches one
by one instead of selecting them all?

Please next time make sure all patches references the cover-letter, not
to have different threads per patch, otherwise the CI, and many tools,
cannot apply your patches:

https://patchew.org/MPTCP/tencent._5F3C9419313E4EE06582D82709B4EA32A2D009@qq.com/

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

