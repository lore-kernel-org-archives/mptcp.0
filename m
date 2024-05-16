Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468729A9
	for <mptcp@lists.linux.dev>; Thu, 16 May 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715839479; cv=none; b=SaAkIV3zV8CM3Wu0g0SAJAeWKxqiUtYX6KqnIPt+NMLWMyoUqsako2XHzluvRnZLPYObIjwqQNNYiIP3C8Rk7vRzBGzPdf/YCBVo/FwR0CeUgfKUEUqFGS2SNWuiRaiMQmpS9sOqysvFmV/Yf/6iKqnfEIjb7d75eWJZlPXZEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715839479; c=relaxed/simple;
	bh=CEBR2AI/RUR7y5F7UD3rQVB+NMk08+tr4rKmQF1mO8A=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uU8knmZT3tDR3GDGt9U2HFQmaGR8wijG51JGD0KQtKqY98vQjYPdKhiPsXxUZkM8u/TzcaWQvsAhC/qPvfKWjicgnUeno0fZCf3K+bATWogFo+KLtsxl7/larfICB3rziyy8lKiduhgjySpeTj1hFQQFmrhgpy6O3VhcwTj50ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbSnizPo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbSnizPo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB427C113CC;
	Thu, 16 May 2024 06:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715839478;
	bh=CEBR2AI/RUR7y5F7UD3rQVB+NMk08+tr4rKmQF1mO8A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KbSnizPoecYpYziaS0R6XPGoiRhRyB3m8y63pEpyu5hN0DSbPlFrp7N4yevKoCXbt
	 JubU2q56xd76i/OPBC9SmEdFzge/xUpk2uYy5qaU1SJ00843alWAtCsGBo9KcfJhe1
	 z8OAXfwG6XmWHwtzkcRwvQ/TFJs+XZXlz4maTb/yjxCALI21cSSj0kFQXq+dGewKn7
	 CGmotTjrHhy3eYMrqRMoZzJgeKgCaKWDZFSrcABHyf33BjM/ZNHkqElJlbmMay8E3C
	 I/SWzFZLqn9uOQBtk8xI4HlOeS9v4gXJokIy1BRbYZS+diy2JHKE4e/hK2kalF6sT/
	 I/zko4yo5zQGA==
Date: Thu, 16 May 2024 08:04:35 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <870a08b4-a987-41a6-b048-b1e480eb3e93@kernel.org>
In-Reply-To: <cover.1715822527.git.tanggeliang@kylinos.cn>
References: <cover.1715822527.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] fixes for create_netns
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <870a08b4-a987-41a6-b048-b1e480eb3e93@kernel.org>

Hi Geliang,

16 May 2024 03:26:28 Geliang Tang <geliang@kernel.org>:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Since create_netns() is updated in "bpf-next add netns helpers" series,
> some mptcp bpf patches need to be updated.
>
> This series epends on "bpf-next add netns helpers" series.

In this case, do you mind sending a v3 with the Based-on tag in the
cover-letter, please? See:

=C2=A0 https://github.com/multipath-tcp/mptcp_net-next/wiki/CI#base-patches

So with:

Based-on: <cover.1715821541.git.tanggeliang@kylinos.cn>

Cheers,
Matt
