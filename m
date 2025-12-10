Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C42AD3D
	for <mptcp@lists.linux.dev>; Wed, 10 Dec 2025 01:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765330223; cv=none; b=LoHb4iUjl+zyvfQx0neDN55Ib44nHljjEHKlm+tdGKuOmdmC7lnyEXvhY39I/NbJhOyfnFygLPunoZnQ+OVQj2Q+7oJMnWxUcSXiQ0P6JNul/fCEav4K69uj26tIiEu7/GT9qGhY+C6jeg1pTtDKog1nrO37gMlWxjeAp9AXpxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765330223; c=relaxed/simple;
	bh=Rl2XXOPRmOtz/wEIC6qws5TStoxU59gJRVmzNyrvHZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gymO/HsnckJj8SoTbCGRy4IAiMI6jyV6oigDPmiuphMQaY9nCiNQw58tBCZJPNFD+VyHSW1Vl+3K0OgK+LKR0zVGby/LHrC9BTw3jRxl7vvcBQDyYZLSYdmT5KlF4IuuF8gjKm5HFV410HRsJTeHx8cEmx7wQ29kgppFIcCLkH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsaSIA33; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsaSIA33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADE1C4CEF5;
	Wed, 10 Dec 2025 01:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765330223;
	bh=Rl2XXOPRmOtz/wEIC6qws5TStoxU59gJRVmzNyrvHZg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HsaSIA33dmakRvBnJkZvQhzS8KJnrY4UUlQGC14MwIdfhQl3al5Blue4lfo8czZQ1
	 1/KDnT3VPBaMRc+xpR4Ztdo6vZOkMEwS0fb0piNVqqtg6sTtG0xJH3TJ5QU35+fNO8
	 dCeMUr3i1vi1EIctG9UOF0dg/4BHZB29utCQ/jjrvdFYQKM7h49oH3qYBconUo991y
	 HAqIa4YGLfEMIldXhiC1uuHKotgr2T1vnyb8OKVo2yqYliFITxhXXNJfUjLf6NypVt
	 V1JfWaEQv/sL6acKMQ4OF4Q9M6fYljacruu3n8GFn0MrckmcrRNlNg2UdxafHZzoBg
	 6sPh21EEPyClQ==
Date: Tue, 9 Dec 2025 17:30:22 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v15 0/6] implement mptcp read_sock
In-Reply-To: <1dbb7691-d529-950a-665a-0f91646e658e@kernel.org>
Message-ID: <533ee452-e740-8979-2046-413c2d334ccd@kernel.org>
References: <cover.1765023923.git.tanggeliang@kylinos.cn> <1dbb7691-d529-950a-665a-0f91646e658e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 9 Dec 2025, Mat Martineau wrote:

> On Sat, 6 Dec 2025, Geliang Tang wrote:
>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>> 
>> v15:
>> - Patch 2, remove the maximum length limit as Mat suggested.
>> - Move tcp_recv_should_stop() helper out of the series as Mat
>>   suggested.
>
> Thanks Geliang, series LGTM:
>
> Reviewed-by: Mat Martineau <martineau@kernel.org>
>
> (except patch 2 which I will ack separately)

Actually, patch 3 :)
