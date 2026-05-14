Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0640D3016F7
	for <mptcp@lists.linux.dev>; Thu, 14 May 2026 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774470; cv=none; b=LrMisiYTda8ZL0D6IsxGoT4Ip+shpcYzCJcn9/7/4qYclOs6wDty9N2koSBTarMtt8hbmpE352pYQH2zCO4wZMphZG6rG2va3+Cq1jJIla8imoISt3SShijWjod8Py4QYqa3wzTqERbk8Is3ascg0qtjE6cb2360b97vayB6Gg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774470; c=relaxed/simple;
	bh=sKyjS8n1Oh33TpV8I1JJVdQ/GoJ11xHty/L3htORroI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QRGuQdbno/F2JJ1R2VuJX2tP4BVbWpGExRfyO8Hd1vHiDcu1UP0e9hMpqVGpZulKoLQEG880eTIKtS8I4ZOJTtwxyJUpkkDlZ1PJNGJExPSx3XpAz4CkyAVU81CpbVobt+0j5kHjCYMJfgvTbnAQEydjg5fZyAvKUc4Zdqk3MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asopOsjp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asopOsjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3339DC2BCB3;
	Thu, 14 May 2026 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778774469;
	bh=sKyjS8n1Oh33TpV8I1JJVdQ/GoJ11xHty/L3htORroI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=asopOsjpZuZlFgftgKCvd0Wsi+knTW7cINfKXqa/giQ6oGmioeNcKWcBzFCYfRwnV
	 e6ASCVJ52C4ishzdJ3eFSY9jE6I6SW311DETKI0XGKcNX4dk+lygh0wolduOT+J8OY
	 R9h9YQ1I5ApV+KUtigenlYJBKfDXN3cK6JtZnD6Y77XDKyJTk3hzcQPLsHLIZee7Y2
	 7MLlrKaGwX1p8lnNByR4y9qn0TKMUYbjGHvqPmReofq4witA3XLD3caDBRE3EhM0WG
	 csgPaI3CtN7Jzkuj8oxh2UbgqTH3NiQfQsWfRPbdg2y56YF5SGurJFjyj4MNMu1DFa
	 wnT/JewTJCToQ==
Date: Thu, 14 May 2026 19:00:57 +0300
From: Matthieu Baerts <matttbe@kernel.org>
To: Tao Cui <cuitao@kylinos.cn>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	mptcp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Message-ID: <b31d2b3f-dfb3-4453-b7e3-61bbbfdd890b@kernel.org>
In-Reply-To: <20260514070218.1534d72b@kernel.org>
References: <20260514132925.410184-1-cuitao@kylinos.cn> <20260514070218.1534d72b@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: pm: fix extra_subflows
 underflow for userspace PM
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <b31d2b3f-dfb3-4453-b7e3-61bbbfdd890b@kernel.org>

Hi Tao,

14 May 2026 17:02:20 Jakub Kicinski <kuba@kernel.org>:

> On Thu, 14 May 2026 21:29:23 +0800 Tao Cui wrote:
>> To: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
>
> Please don't CC maintainers without CCing the mailing list associated
> with their area. If you're CCing core networking maintainers you should
> also CC netdev@

Indeed, thank you. And if you are using the mptcp-next prefix, please
don't cc the netdev mailing list.

Cheers,
Matt
