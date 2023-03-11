Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DC47B
	for <mptcp@lists.linux.dev>; Sat, 11 Mar 2023 05:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612B1C433EF;
	Sat, 11 Mar 2023 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678513359;
	bh=vBsyiOrtuUZnDxuciAPgUxX3KyQyRTvAK3jxbBTUy3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bpi6GngOzA4nmdKPwHkLJV/d/NGsxv7qgNil8rQ3KiyYlBukFWDGj/RHbOITnta54
	 78+oFobyxO2bgPGkn15n1ZuJ8OpAgDli564I6N6Kp2Vr76UHEv7ntU9GOlLwBlb7il
	 1kAypYdqeaGZaO8IXezKW+qHvrg1kb+5iug9TRyCEVQZyWZvCiVu0sWE8rhzjapoQd
	 ElER1+jVwm6yqhFkFC1c+fzOUSHrzeRi7i5FuOh/4/MHk7oyH3nmhjoEVIYHTyPt7s
	 PeHky/4fZ43DE9E0MPMSOQCc2dR3AKcqGPPJZcxEjWdEwvqR3D6BtbKJynxmI4lIZq
	 vACICT7MccIOg==
Date: Fri, 10 Mar 2023 21:42:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mat
 Martineau <martineau@kernel.org>, Jiang Biao <benbjiang@tencent.com>,
 Menglong Dong <imagedong@tencent.com>, Mengen Sun <mengensun@tencent.com>,
 Shuah Khan <shuah@kernel.org>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Christoph Paasch <cpaasch@apple.com>,
 stable@vger.kernel.org, Geliang Tang <geliang.tang@suse.com>
Subject: Re: [PATCH net v2 0/8] mptcp: fixes for 6.3
Message-ID: <20230310214237.7ac422ed@kernel.org>
In-Reply-To: <20230227-upstream-net-20230227-mptcp-fixes-v2-0-47c2e95eada9@tessares.net>
References: <20230227-upstream-net-20230227-mptcp-fixes-v2-0-47c2e95eada9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 09 Mar 2023 15:49:56 +0100 Matthieu Baerts wrote:
> Note that checkpatch.pl is now complaining about the "Closes" tag but
> discussions are ongoing to add an exception:
> 
>   https://lore.kernel.org/all/a27480c5-c3d4-b302-285e-323df0349b8f@tessares.net/

I've also complained about that series. One day we'll be a grown up
project where foundational tools are properly maintained and changes
to them reviewed. One day...
