Received: from mail-43167.protonmail.ch (mail-43167.protonmail.ch [185.70.43.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DC377ABF
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788406963; cv=none; b=H70yLgyTEQTPRMRgBgmXHzDIqZ9jEjuSFUTlkXD7UdBnOYTbTxVKDY4bPKMyF2VVh4SVHi0s3MnZxT8anl5uDsZZrq0ZZ9tKgOY4MsapciG2oaclBM1brmd1cALtNVQlcOpMS1yK/FknVSV8iDcHd+VV8wwscooU9J3bEKn26pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788406963; c=relaxed/simple;
	bh=pF32HpEr0VEQiOeaaNPuUj2GVjEPlslKTeCqAgA4h0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPhuY3RYzFbbTZPyGLeL1erFlwwNXGfk54b46hOUzDUGIRyPc1cnNRKi/obYbnA7eCgFDZ6/3hswjGa5drR4Ww6qwj2IosyMiMr7/uaILv0Xs1U96jal7XuVud3okEfBEyjU5W7BrQj+43MVxV2LfGyaQvFROoJQ0d+V/iHz3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZK4xQF0D; arc=none smtp.client-ip=185.70.43.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZK4xQF0D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788406945; x=1788666145;
	bh=pF32HpEr0VEQiOeaaNPuUj2GVjEPlslKTeCqAgA4h0M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZK4xQF0DAYyjLQReuqgxIi5nBv5VQVlEU+hWr4bJ7wGqXX+7AH3WY4B0H8+Q5K+Hk
	 PMEY9sVLKkMF8zCyZMp2wyjWzADNOJ55grv4vdI2pmG7Cg8mwWHy1+7A/JqAm5Hfi1
	 Z5DOYS46jqnL60jl5S/JazUZujHd/W1c2wlsjW+hR6QPZ2jmnOMKP+4BGWmMnFMEEo
	 l0Uk50eOp9hVIYJsHghALY9f5cMko2EE6IjIVArGVMVkQ1m3nT/Zd6QP3crE9XhnTv
	 pPEs3ncT8kUozhxIQvrsdvU1gjNErdNAp0nI1ChMwHFiZ5WtCn0lyFzwO4OoB0Dt4N
	 SM398F/rDvt+g==
Date: Thu, 03 Sep 2026 03:42:21 +0000
To: Matthieu Baerts <matttbe@kernel.org>
From: quanyeyang <quanyeyang@proton.me>
Cc: Tao Cui <cui.tao@linux.dev>, mptcp@lists.linux.dev, geliang@kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH mptcp-next 1/2] mptcp: pm: bound extra_subflows admission on userspace PM
Message-ID: <U6pTh6EPoeSgwE2EHl9q6Urj4YiZFTfOINajSmMtooO9YzNmfQXdeB4pXt8P9Nh6FjtZrqjgs50Rlkxdm5Hyfgz65nUYNcmwmV76PVrTeUY=@proton.me>
In-Reply-To: <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
References: <20260831093206.689827-1-cui.tao@linux.dev> <20260831093206.689827-2-cui.tao@linux.dev> <c8c4f667-5d25-4d94-8627-387d4091c8c4@kernel.org>
Feedback-ID: 206494642:user:proton
X-Pm-Message-ID: 7b81dd23e2a63199b17f27dd79e891fc91b158f0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Matt, Tao,

On 02/09/2026 18:36, Matthieu Baerts wrote:
> So, at the end, we can re-used the same version as Quanye. Would it be
> OK for both of you to have a Co-developed-by tag here?

Fine with me. Please reuse `ret` and drop the comment in v2, with
Co-developed-by tags for both of us.

On 02/09/2026 18:52, Matthieu Baerts wrote:
> Maybe a goto could be used here ... to here, not to modify the rest
> of the code?
>
> Would it be OK for both of you if this part of Quanye's patch is
> added to Tao's v2 series with Quanye as author?

Also fine. Please take the Netlink extra_subflows cap in v2 with me
as author, using a goto to the existing error cleanup instead of the
else-wrapping I sent.

I will not send a competing series.

Thanks,
Quanye
