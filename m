Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B346EA4
	for <mptcp@lists.linux.dev>; Tue, 24 Jan 2023 05:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A98EC433D2;
	Tue, 24 Jan 2023 05:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674539082;
	bh=DVvU+AMG8FnLPnXiv5r86FMhbmfceKftwrgLoYZRhyQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6qDq9xuwh7okndzqjFv0WHCt9a9piGD8q4dJfdjh0AImDcEFi84iXKXShIPtlo57
	 SzNHCxKR+uBHPluUpKUPiQjTSFGZoGXt4BALGMoYjVIvJWQI4G7A5BFW/SKrJEYwxf
	 fPu6pqpNZrkg2X/XQYyIatGiKh43jWqzg8+ngrMyAk7c1rWTb7Hz0SFIRistOIGCi5
	 Ca5j0VeEWa6hz95mg0IVcf4obcAPOwPbTekbeG0VQpAx6mDuc8c5UXfgMFK0lzkAUD
	 +zPEZHD42uAXRAN1Ffe6rp3n9GU/MK7YhmWh5hW2L1nrIYYWHqMmp6reC3Cm6KwLWT
	 bHUIbqtU3CKQg==
Date: Mon, 23 Jan 2023 21:44:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net] MAINTAINERS: Update MPTCP maintainer list and
 CREDITS
Message-ID: <20230123214440.42de75e5@kernel.org>
In-Reply-To: <20230120231121.36121-1-mathew.j.martineau@linux.intel.com>
References: <20230120231121.36121-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jan 2023 15:11:21 -0800 Mat Martineau wrote:
> My responsibilities at Intel have changed, so I'm handing off exclusive
> MPTCP subsystem maintainer duties to Matthieu. It has been a privilege
> to see MPTCP through its initial upstreaming and first few years in the
> upstream kernel!

Thank you for all the work!
