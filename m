Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627B0248198
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933682; cv=none; b=JiIW8EoNonXn4/rLSr7XNrI4DvnpnnNGW8azful0MKoepHdogBaACPMP9CSYX44vAyY2+tfTpMHdOpdHdz1oKZogYbKoqyvl+b1Vl+BZriBP1rxhKF2EMQ8KSMt6yecfsZw83h9VUBmQTDDEnlWW3wALyThxgHxxHelZwnCfwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933682; c=relaxed/simple;
	bh=D8HlOSbR1Z01X5miZOtKLSY2uWfX977uAP9OoMi2H0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Px2s6BumB95q19U8GdHvShbJMIKnXRjNyPbSdhb1vRre6SqgrSTnlUkS/U/mYnGmsGMhlc4NWAp5l21ZG6UF061/ft+fX0HvwpqAQIjAq9D9etOEqwzH0TU4oBLzvffUbt6KwW/z0bZuAsfmvEY5LZwvctNejlC/YCfkb3Smetc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuho8cAM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kuho8cAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEFAC4CEDF;
	Wed, 15 Jan 2025 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736933682;
	bh=D8HlOSbR1Z01X5miZOtKLSY2uWfX977uAP9OoMi2H0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Kuho8cAM8kpAnW5cM4j8XPMSRq7UnNKaU5BsudLVSKk2SzIffjUwJGXuBItAdbkQM
	 vzHVYHMLQz9G6O11bN44tNRHwqKTAf/0tEMSn83Z8J+Om2VpPLw7AwoY55XpDCXWUg
	 sstTlaBZAlL14rylWndyz5YZtToJ11vhgKEsk6ZZS1YplODTp6NYNSOWnqJQx/L/Nu
	 qAkyxVnzAhXu2PmylnN3iL7wRIjcNt8Lr1sdso1e1dqSCfCWxKp3KPVaaLUVE42CMb
	 SNRT0DCE87kMlhRxBtuiosVkdh4oaGrRgMcjyVm6yX4Ta1fLz1XxosVDbebEJSKbI5
	 sVayDJV1xdsIQ==
Message-ID: <a19b0b2cffee4210cb46dad03f39548d189dd747.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests/bpf: Drop cgroup_fd of run_mptcpify
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 15 Jan 2025 17:34:37 +0800
In-Reply-To: <43488d28-e219-4646-af25-61c40b229074@kernel.org>
References: 
	<38e34a835050f35b7f14f7938b20f86a97ac0836.1736926065.git.tanggeliang@kylinos.cn>
	 <43488d28-e219-4646-af25-61c40b229074@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Wed, 2025-01-15 at 10:31 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 15/01/2025 08:28, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > The parameter 'cgroup_fd' of run_mptcpify() is useless, drop it.
> 
> (detail: s/useless/unused/)

Thanks, please update this for me.

> 
> The modification looks good to me, thank you!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Do you want to send it directly to the BPF maintainers, for the
> bpf-next/net tree? We don't have other changes that are ready to
> send.
> 
> Or I park it in our tree, and we send it later (no urgency I guess)?

Please merge it in our tree and send it later together with other bpf
patches.

Thanks,
-Geliang

> 
> Cheers,
> Matt

