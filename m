Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380533314BF;
	Fri, 26 Jun 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460622; cv=none; b=gJVMFmkbf4o+I55bgFmIaYDcpFGao5qM5jOcrmjadeeEf5uaujG5V+Bvk8GXQLUeNkfVniYHEJWuubn8KP0aKEdG71afLXsbHTWxsYOFZwQ6gRHCz+M8pJziT8F37r6p1Tiv0qRWV1IsTQShJuoRci8Efho5wi+wCSRW6Murcvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460622; c=relaxed/simple;
	bh=2dZ+Glog+01+bX6LN1nISAt9iuBFt4THcKeuav/sEdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B55pOPpiZrSxfHx86FxcdgeQ/47niWHbO59Wfwri3kvG4g0nt6qn7GoSjoTEI4RQ/uHCdjMekE01MmzgLEzuXmveNGWwc8HH4TXffWudgpnG5mGB3jTKfkCoWJ7tmQ9XdPvuPjmQ4x80y1DjyWC3OCMyR0rLYkMgEYyNwFC8u1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXhebV7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXhebV7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332BE1F000E9;
	Fri, 26 Jun 2026 07:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782460621;
	bh=GN5MvdROi0tOUKfD0W+kRWQmAmHuLI14vqAQY7OLfyE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aXhebV7X4mdJGnIv2koajjnqKaGEoWcmmDke0BYFoX7iLI7PhMjXXGKdKBjybLfv4
	 g3HwOoxiZAAFd1OyoRmrpdAK5DOpRkhsjbXgpU7sC4RQOxmEGieShfDuXfUZw7tSUQ
	 K5Ihb3zN7UAhwY/FeS9O0C9K3XHW6QnkEChs+N/yP2Es8sag+zTJVIxj3M72x2LXg1
	 4M731l0jV8loXDtCPnKuztIA0atwsmxWRW4lpn9gsopdOW4XK8V/qrB6sO8tb4Lz/1
	 J8n03XoyKVhuNF5jGKUzCUVMNNQqv4aciTUh1PciAdg5tQ4rewtkudv/mR8HKk0zjQ
	 5uCME/vGixSrQ==
Message-ID: <a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca	 <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang	 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan	 <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Date: Fri, 26 Jun 2026 15:56:53 +0800
In-Reply-To: <20260622090059.5d1813dd@kernel.org>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
	 <20260622090059.5d1813dd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Mon, 2026-06-22 at 09:00 -0700, Jakub Kicinski wrote:
> On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:
> > Subject: [RFC net-next 00/17] MPTCP KTLS support
> 
> Please no. We have a ton of unfixed bugs and may have to revert some
> of
> the features we dropped back in. I'd prefer to avoid large new bug
> surfaces until we reach an LTS release.

Sure, I can wait. During this time, I'll go over the implementation
more carefully to make sure there are no issues on the MPTCP side.

Thanks,
-Geliang
