Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4E37B40C;
	Tue, 15 Sep 2026 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513288; cv=none; b=SDA6FGgQmib0+rk2Gg3yW8poU4+k2MA1vJW8trDSYD2Y0Y11KNME4bgUfR8BHBY01mYicN4soNi6MAUJJTJZAc+eIJzV8Qmh9Dk7CzfHA1uSGewK9xWRdhegplTULOgKisBRVtzma5z6o1Bq4toqez4WTXQVZHq9KdD6mnPEy2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513288; c=relaxed/simple;
	bh=9/ZCW1pc1T7tbT5c1bgh5mBTD0aHJSgWwQ3R1a+4r2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dA+eYvFEnhr8a9Ko1TLhy07U92JccYDodYwWjqA4FrWQVL+Jv9Fw8QyeGIPuTMSB9uKOFp9LJhEfRCJMaqyB/r8kwrEsP/xckl0+aSY9gpVi6DtPwFR+7QGS+pTuRwwoDKGxYui+ZfiNf8fnjpnaYH6BcnUhCMhzBloedqe+qCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOn0FusC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOn0FusC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E91F000FF;
	Tue, 15 Sep 2026 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513286;
	bh=+xV62T4oXSMO61RNHQ9wRO76LUr710Z+cpUFXis5420=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AOn0FusCUcIpG2ZtsA2M6YcH2aWR19d8c+v2ctl2nPRno4dCha2ZfYiPZf5lOpOgm
	 DNCp98IhDgUOJ7NFATt7G6lqeBW2jAVBPH5R1i/YQIs81qj7TOEP6dghi8dJyRe10N
	 UvqPMSbCsUM2YWuwkMNxqjiGFOvxme4J6z8PKbw+IvDjFnWxvsU1S4i2GJ+YbJdaeF
	 stMtXNP6srgQmV6AZFt5OdTVMrXKqF3ArOOo9k9eLhlPVtwxxtULHcaeD29gKexkDS
	 9TzSpUQRL4fUJgMugKNYR67viAJFd18zcknF4Hns+Vu1aINPFeX1YZgj0NF5My4Ub+
	 3Vz4+yIMmx+Og==
Date: Tue, 15 Sep 2026 16:01:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>, David Howells <dhowells@redhat.com>, Matthieu
 Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 mptcp@lists.linux.dev
Subject: Re: [PATCH 0/2] Drop redundant tcp_rate_check_app_limited calls
Message-ID: <20260915160125.29be79e7@kernel.org>
In-Reply-To: <cover.1789368148.git.tanggeliang@kylinos.cn>
References: <cover.1789368148.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 15:14:21 +0800 Geliang Tang wrote:
>   bpf: drop duplicate check_app_limited in tcp_bpf_push
>   tls: drop duplicate check_app_limited in tls_push_sg

you can't have 2 patches in one series targeting different trees
