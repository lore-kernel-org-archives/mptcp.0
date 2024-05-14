Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB51625;
	Tue, 14 May 2024 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715646582; cv=none; b=M+WwV7ua8h7tjutT49Hm8yufli4JlOz5dapG1Rmk28boMWG6CJ2BvkzVUgRtL63P+3XYMqYYwYgCQx0Tpr1pyvJQynwDBS6pjvmKOrWSu/BFVdj12W2EpGLc9dNfESHrmvWYST1XI50B1cq86lRXtdneDaCGzrYWSIHsX/Kv7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715646582; c=relaxed/simple;
	bh=edxKrIcX/tWini2op1ZeRVAJxMDEO9ut9l/DC6r+nAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBX6i3FpqiyKiuitY3FPPZqTLTUdMAa6RyKJV46BgVyGPvHnCZJq5bITAwV2c3srXePO6WqwFoOXTfmgF3Uzc4px4TxUMgaL6B+mRODfAIQi8ouy+0Nm7bW4+UxMYdmspGlhb7BKEh+BsuO1AFrx3rNlhKuOL3mBrFETGvKZ2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4Vg1eCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4Vg1eCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8782C113CC;
	Tue, 14 May 2024 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715646582;
	bh=edxKrIcX/tWini2op1ZeRVAJxMDEO9ut9l/DC6r+nAc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4Vg1eCa+uqwO6oESjTnKIyzmvwiR6ktp5gmallKcveP8FrADKCpzoPAuvu2zCt3F
	 ILzEPJt2MSp1R8Y8QHO5rIb4dpNIp783qKG+X4ODxch14JVcN7QrYki/y4sCxll9Fu
	 KXHhL6y/vb+eWEith5pi7Dbq++GRySoh+zvWbz97KFyHk98wTN/x/NPrfboADy0aai
	 ph87lpudRrhGSgasmrQUsCFn8pGP0Cy7xZ/Ezxr1Q/abDAEM5jI4sx/3kT9QisRUsr
	 5r+LZEmW3dO3yZuTmo3KEY0BD9FuIwmw9wgWLZ0XenhJIpYRHgoHP/3v3keMH71qhm
	 DNCNGmEbG87Dg==
Date: Mon, 13 May 2024 17:29:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev,
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Detal <gregory.detal@gmail.com>
Subject: Re: [PATCH net-next 0/8] mptcp: small improvements, fix and
 clean-ups
Message-ID: <20240513172941.290cc5cd@kernel.org>
In-Reply-To: <f60cac35-5a2b-16cf-4706-b2e41acfacae@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
	<20240513160630.545c3024@kernel.org>
	<f60cac35-5a2b-16cf-4706-b2e41acfacae@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 17:24:08 -0700 (PDT) Mat Martineau wrote:
> The conflict here is purely in the diff context, patch 2 of this series 
> and "tcp: socket option to check for MPTCP fallback to TCP" add cases to 
> the same switch statement and have a couple of unmodified lines between 
> their additions.
> 
> "git am -3" handles it cleanly in this case, if you have time and 
> inclination for a second attempt. But I realize you're working through a 
> backlog and net-next is now closed, so that time might not be available. 
> We'll try again when net-next reopens if needed.

Your -3 must be more powerful somehow, or my scripts are broken because
it isn't enough on my end.

If you can do a quick resend there's still a chance. The patches look
quite simple.
