Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B83FC5A7;
	Fri, 26 Jun 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491577; cv=none; b=a708+akEdUCDxpIzQocam8ylWUwJR6lkAsSTbrbOgU6utI+e/CXfMX6iGAI3B6S7APhitEvuKoDGWFXYbe2sYxCrtPBgT8RlL73wRHW09M+stZ0mTGC6KxzR/9RynoK5BSLHNUZFz41BDIz5imV6/KDbwuyECSMUwJX/xsi97yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491577; c=relaxed/simple;
	bh=tG6J2GY+4jXTir/Fox0Z0bwsDCMHan1veiHDMjutll8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9PKW7HpokfOkcfIFdg3kIjxL3QWiGutwSADRgIvXVH8fbhHnmG3QIGllg+ABlt199bFq8DgnRmmq8ZIp5YHJSwxhqpP7BVgaXBkNhG/KHMZS6DEFNH5dtcqPraJkCUmyMBI6QmrJNBVxmUsa8b/rDEJgxi3nVkOjyrcbV0II9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY9TLwMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY9TLwMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB5C1F000E9;
	Fri, 26 Jun 2026 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491576;
	bh=7s3t+HgFUoid2HXcYb60+6re4RXT2/C56sdjNS8djm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GY9TLwMyro/2WA0H9oXIsm3mscusHmvezbIXGXWhgkLKQK4EcdlHgc91WmtZCiOPl
	 V9k7kQ6iZs9+c5iTtRC66YvCdBF89ifHBy58rnny+YvTVGCg2XQhLM3eqWHGeh0y74
	 3Ut4ZKdDhlhL7P8MikZ4Vt1ObGon2RqVStPd8zMPfDEb5v+6RmbEgIpPxsHxYceVRw
	 madmhuNkZC+OC11CpCntxKCU9XhBLyItA5D9lWLzDC2KRMIVInT1sUBFZKMLhIIIRo
	 25j/qUzX5JxxzoMGapW6YL4MT3KT2FNy1UeY6Mk4hfFf6VquLT1AGYAMT8cEpMeMrQ
	 /kywlUh8OKy2w==
Date: Fri, 26 Jun 2026 09:32:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima	 <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca	 <sd@queasysnail.net>, Hannes Reinecke <hare@suse.de>,
 Geliang Tang	 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan	 <yangang@kylinos.cn>, Zqiang
 <qiang.zhang@linux.dev>
Subject: Re: [RFC net-next 00/17] MPTCP KTLS support
Message-ID: <20260626093254.19ee6485@kernel.org>
In-Reply-To: <a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
	<20260622090059.5d1813dd@kernel.org>
	<a0358bb3aa8e2d45bd1e74851416728c3f08ddff.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 15:56:53 +0800 Geliang Tang wrote:
> On Mon, 2026-06-22 at 09:00 -0700, Jakub Kicinski wrote:
> > On Mon, 22 Jun 2026 18:43:20 +0800 Geliang Tang wrote:  
> > > Subject: [RFC net-next 00/17] MPTCP KTLS support  
> > 
> > Please no. We have a ton of unfixed bugs and may have to revert some
> > of
> > the features we dropped back in. I'd prefer to avoid large new bug
> > surfaces until we reach an LTS release.  
> 
> Sure, I can wait. During this time, I'll go over the implementation
> more carefully to make sure there are no issues on the MPTCP side.

The two things that I'd be most interested in understanding better are
1) perf impact on all the pointer chasing and indirect calls you're
   adding
2) what's your plan on implementing HW offload? I understand that _you_
   may not care, but if you follow the ML you'll discover that sooner
   or later some well meaning person will slop code such support.
   We have pretty solid (by kernel standards) documentation for the
   offload. Please read if you haven't already. And then you should
   hopefully realize the huge issue with the layering you chose...
