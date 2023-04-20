Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39BC15DA
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 01:11:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37332C433EF;
	Thu, 20 Apr 2023 01:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681953084;
	bh=aWpynGCqmUP+VoZfK4M4QoEqrKAm9+CWhno2Gk2xz4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cHUjq/oeWNUY/+XoMTXKJ9eWacOtC6nAJuYL+TzSMO1daoMueSdK2Dju5WK2k0Y3M
	 kSbuYnaiDk1AVxcOHjIN/HjPotAQ8MrKG9I8k5PH8YOSAUxN1cIAjUpqz09Fg8BuRn
	 wtgTi6jtFqX43X+p8fTe/lr4X/QzkVnagalk3v7Pq04UuLldaSHyXzTBlLSVs34BmY
	 D4S2XgV6TS2pUyKeoGmbzogkImBFM4f4EHrJ0IBtbk6PWfXz8wcREyasqpxQyPJdgN
	 DDt4+RkftJyXa/YqYvMUoaKomlvzAIceCBD5k6YlywTqH0zec7LlpQEE3vaNjkaZMT
	 sYDSQ7k/We2TA==
Date: Wed, 19 Apr 2023 18:11:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next] MAINTAINERS: Resume MPTCP co-maintainer role
Message-ID: <20230419181123.15028d0f@kernel.org>
In-Reply-To: <20230418231318.115331-1-martineau@kernel.org>
References: <20230418231318.115331-1-martineau@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Apr 2023 16:13:18 -0700 Mat Martineau wrote:
> I'm returning to the MPTCP maintainer role I held for most of the
> subsytem's history. This time I'm using my kernel.org email address.

Small world, welcome back :)
