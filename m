Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FC199A7;
	Fri, 27 Oct 2023 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1gClgTE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9B0C433C8;
	Fri, 27 Oct 2023 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698422005;
	bh=m6BIqjk1bkg9jVIxLcjUdMfRL7FScMR85P60IBS6QMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1gClgTE7ys3BJwDb1lig46oyR/vfm8J/EiC/Hn3KT6qJCcZkwDl6IXgJ6sUi/t9h
	 BhE6cgPkWbLRIzPKn9qg9Vz2N71xv/bbwxIsnqj/l8Ib8OwoVAx9cr9OKF2UhKN8kG
	 yQnxSw7vjx4TnklmhHn+mJGqN7kr2Ybyj24UqhFn5tEVNMcMDRk5OruW0sxNpg8iuU
	 ECB1lEFZdMe7qLQenb3E9VEm7ZJwDdnIF6pVFwPf9CYVlU3GVM7OrGioS+n8QSmv5h
	 BI6Efe96F2ZNNjsGyst3/cQO82T88xTHNIxas8zOn4gLiBy9Rn4P5WLA2g1E3NlKOY
	 g5MvN9xNXtoRQ==
Date: Fri, 27 Oct 2023 08:53:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, Kishen Maloor
 <kishen.maloor@intel.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID
 0
Message-ID: <20231027085321.51319d84@kernel.org>
In-Reply-To: <9138af81-6312-9a96-076e-6b164285c34b@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org>
	<20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org>
	<20231026202629.07ecc7a7@kernel.org>
	<aa71b888-e55b-a57d-28cc-f1a583e615f9@kernel.org>
	<20231027084324.42e434bb@kernel.org>
	<9138af81-6312-9a96-076e-6b164285c34b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 08:45:53 -0700 (PDT) Mat Martineau wrote:
> > No need, I can strip when applying.
> 
> Thanks Jakub, appreciate this!

What's the reset of the stuff you have for 6.7, tho?
The net-next PR comes out today, unless it's really trivial cleanups
and/or selftest changes it's probably already too late :(
Assuming MW doesn't get postponed.
