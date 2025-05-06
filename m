Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842B306CDE
	for <mptcp@lists.linux.dev>; Tue,  6 May 2025 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498717; cv=none; b=pwSOAMvGsjj2/rlX27QAQmItc9RojF9/4CDSCTCPKnz2f+WGb+Vh/xyDlF41pBB2gngIXdOJl54WjKYo6S/C1LEQmOA5tk53yCWwy5N4hoHtsdHEsjPI7GJAbxtFqJPQLhzxBVcUKbEovUxbbYzG75z7eJ1AsL/j95evfHAGxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498717; c=relaxed/simple;
	bh=8A3rGw7jXl8SuLaZYIcSRXeArS/uT+Yt4r6duHFiIuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1sCzCwG3jJi844ifAnowTqErGHJJZ8zUu2LqgtDIJ/BaUGnKP7akcibCOjSnIvBS7A5GwAIa/yO/gpWbu/U0S57aukCKu4sj1AgNRsjDNjFyrjMmwP3woNC+yOlp4XC0J5sTyPrKRH4ks23GoSJ1b2pZVZhHg8iHfrGCk7jVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XavdtrZN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XavdtrZN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF9CC4CEE9;
	Tue,  6 May 2025 02:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746498717;
	bh=8A3rGw7jXl8SuLaZYIcSRXeArS/uT+Yt4r6duHFiIuQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XavdtrZNeaVoLbklhntPjtqppBuwgW1DWwrJP2y/KSnekumKki+Wat3iVr7mAXgbW
	 aVFBbAxnhBVyyFPv7J5bdbTTeCyWQJop4z2MsV1viuUlXF/e9MclqFwZWURVDJLRMt
	 6RoNQ/5lbBRLCM1/WtENalsIgZNPCFWpaJEOQiGModNOZpm+UfQTYQUjGoKKkyDCs6
	 udMIS1YsV6XxsyWBg0Bg74ag8kn61Ld7uwnX0DGRUp1lnZYUFk5vrDAKJeYj1JYMjf
	 ocqdy8zRbo2IM2r1tqMyCDmuHEm+CyQFvbyjtaO0Qbd6w85CohHn+Ipek42W5gIA+N
	 ilX5jArLcyFAg==
Message-ID: <f16b6cd464fa11198a4dcec027c98e9fb486c94e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: drop redundant tcp_getsockopt
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 06 May 2025 10:31:51 +0800
In-Reply-To: <b30d3d1d-3fbc-4760-8cd9-2587928b377a@kernel.org>
References: 
	<2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
	 <b30d3d1d-3fbc-4760-8cd9-2587928b377a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2025-04-29 at 12:22 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/04/2025 09:13, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > tcp_getsockopt() is called twice in
> > mptcp_getsockopt_first_sf_only(), which
> > makes the code a bit redundant. The first call to tcp_getsockopt()
> > when the
> > first subflow exists can be replaced by going to a new label "get"
> > before
> > the second call.
> 
> Thank you for this patch, it looks good to me:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Next time, for such "simple clean-up not changing the behaviour",
> best
> to attach it to another series where you modify code around to be
> inlined with Netdev Maintainers recommendations.
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches
> 

Thanks for applying this patch for me.

I just read the recommendations about cleanups, and this patch doesn't
belong to that category. Anyway, this patch is somewhat related to the
two patches for "TCP_MAXSEG socket option support" and can be sent
upstream together.

Thanks,
-Geliang

> New patches for t/upstream:
> - 51e97964d659: mptcp: sockopt: drop redundant tcp_getsockopt
> - Results: 3b2cc77f0a4b..59ef7029a603 (export)
> 
> Tests are now in progress:
> 
> - export:
> https://github.com/multipath-tcp/mptcp_net-next/commit/7e2300b7bcc95b8957358cd66407d3eeebc94ebc/checks
> 
> Cheers,
> Matt

