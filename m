Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66262D
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 04:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AF1C433D2;
	Fri, 17 Mar 2023 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679026327;
	bh=v2zEYx2quVdWHyE4m+BHJg7VxqG48NX5bk+PdK53SKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rTSWDI3mfJKKGhHTdkEc6wbjHhJWQdrojAI6fGLlVIBxOwZuxZ88Bxq+ezuuv4ggK
	 Jg5tehC3W8eVEAqeXLgCOXp1J/eO7kRKt0t2vDtAhkqWRH9cu4Pn6LmbqL9vCdRQD2
	 Qx0J7xash3y8rRx6b1VF0MeshXqX1QyAZW1r289UtrJyebpkQMToi5Ttkh5DOKWvTN
	 y45+dK5DkApDUS3C4V+ZgBnQHmCeoIrTFPWKFnStlKUKVXGgRHKPSgfc00rfK+uW49
	 y6GZ/2XtlgkGAPurMnSvWPAknf2A81DbYqqUdwe+bGcpKw5MBA/EoUhCp2+fnwju3j
	 bHBIBlrOcKNmQ==
Date: Thu, 16 Mar 2023 21:12:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kristian
 Overskeid <koverskeid@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] hsr: ratelimit only when errors are printed
Message-ID: <20230316211206.1c01b585@kernel.org>
In-Reply-To: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
References: <20230315-net-20230315-hsr_framereg-ratelimit-v1-1-61d2ef176d11@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Mar 2023 21:25:17 +0100 Matthieu Baerts wrote:
> Recently, when automatically merging -net and net-next in MPTCP devel
> tree, our CI reported [1] a conflict in hsr, the same as the one
> reported by Stephen in netdev [2].
> 
> When looking at the conflict, I noticed it is in fact the v1 [3] that
> has been applied in -net and the v2 [4] in net-next. Maybe the v1 was
> applied by accident.

Ah, thank you! I didn't even notice that the version which went into 
net was v1 :S
