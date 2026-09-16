Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2114E66B8;
	Wed, 16 Sep 2026 10:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554664; cv=none; b=HYSDIHmGE/gZwpQr3Iv1Ph3qJAh0d8wKUBOgL5m9+6vbwbyUo4lgv4kViB/T6T3KS1/0O+TGxdF+yx2wFs2P58EBmtDNRP+hrbqgscfQ+7cd6FgTfmH3lQeDfpnWW4yEi6Jh80KSK2bSpz4PDqujvBTn04zhM3cQpx0L1SsW+bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554664; c=relaxed/simple;
	bh=GEP+hGb2iE1o7wcjDbQ4fv1FVBbBCEuBYvDsihslWMo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nG12+PAZmqikaPQl7qWHmS9f1/9pupjiGjgSaNSHfBMX4aQOQUVRpi1dOFdTjHkJNrU6D6gVB/QPrSQp4te/k1PQ/hYq6byT+3pvaQJXBvjnkregxfv7JZAg90pwkiNpJbe7NDo5bB1zzjgj/Js/qd9gECOylSXdBrK2XxBfpVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6cnAa0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6cnAa0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC101F00893;
	Wed, 16 Sep 2026 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554659;
	bh=Fmnr5/uLooqS/bMx64dP7eD2bGWt7k9KQuKfroU6rHE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l6cnAa0aiCoTjAionrqVVA/hr8u1j6Bmvr3eKrdGXALmvXhb74KaaAlHE7Z3q1FYE
	 8PATwhrc/j1bB1F4uarHZkonOznndDJWvYFw83VYvueP7K7VJhLhU7XcIznP5MRpJo
	 lPrzahY5xRRSds59RgxtX2435BAoGzLasUQKOysTKhg/7MoaEWS/eZ/eYM3O6p+0x8
	 JRnV1gwaDdjahBcHx+1hT0/tauzOW2R/SPbHUqfZV2Ll0YTIovY9RKRq3vaWToRxQM
	 ixt8Z2G4ZzHqMTSpssWoF5eFWZKphGjLH9s916mN7JresUSJRDfU9F7eXmVQSQOiy3
	 G5HMDspPrOnfQ==
Message-ID: <f6e80b4e6f1f83294c7332b28d1fdfff42c503bf.camel@kernel.org>
Subject: Re: [PATCH 0/2] Drop redundant tcp_rate_check_app_limited calls
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki	
 <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
	 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni	 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina
 Dubroca	 <sd@queasysnail.net>, David Howells <dhowells@redhat.com>,
 Matthieu Baerts	 <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Geliang Tang	 <tanggeliang@kylinos.cn>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, 	mptcp@lists.linux.dev
Date: Wed, 16 Sep 2026 18:30:51 +0800
In-Reply-To: <20260915160125.29be79e7@kernel.org>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
	 <20260915160125.29be79e7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

On Tue, 2026-09-15 at 16:01 -0700, Jakub Kicinski wrote:
> On Mon, 14 Sep 2026 15:14:21 +0800 Geliang Tang wrote:
> >   bpf: drop duplicate check_app_limited in tcp_bpf_push
> >   tls: drop duplicate check_app_limited in tls_push_sg
> 
> you can't have 2 patches in one series targeting different trees

Right, my bad. I'll send them as two separate patches in v3, each to
its own tree.

Thanks,
-Geliang

