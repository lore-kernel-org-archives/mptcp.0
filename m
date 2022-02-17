Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DA33B2E
	for <mptcp@lists.linux.dev>; Thu, 17 Feb 2022 04:54:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945CEC340E9;
	Thu, 17 Feb 2022 04:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1645073697;
	bh=5GooNLBD6ckBJ5bkk1+HCUOtWhMpEGXWkBXp2YL1zuU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SQczxZWtOhKVIdgH4tlaLeKCFHIG31DbcVkNgyAm1EUqdLmw5px0Z2aSQdZL5tOR6
	 jOJkvFLBrYono5lWASBZgZSRJq9+xMYvC7pez+uJT8TTBuPTn1OTZsiT3xl5pEtNO/
	 6uhayWGg+ytMb9p1u+Bt6zjAtY6OBltfszzOTe7iDxmy+aYVWO4K9lTGAmPjhqZzB4
	 1+wXmHqrs6T9a6T8JBjZiJxrp2nrmAjd6u9fL/npyqLC0DiDJGD557o25BS37zTZcJ
	 UoDnLXFlCFcwbSsvFQx1OIh0Nr7P3MZC8jiB6AD5q747DoesJMyjGyE86+EHCBmZV4
	 Gi5tj53JXDv7Q==
Date: Wed, 16 Feb 2022 20:54:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/8] mptcp: SO_SNDTIMEO and misc. cleanup
Message-ID: <20220216205456.307d4dc6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
References: <20220216021130.171786-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Feb 2022 18:11:22 -0800 Mat Martineau wrote:
> Patch 1 adds support for the SO_SNDTIMEO socket option on MPTCP sockets.
> 
> The remaining patches are various small cleanups:
> 
> Patch 2 removes an obsolete declaration.
> 
> Patches 3 and 5 remove unnecessary function parameters.
> 
> Patch 4 removes an extra cast.
> 
> Patches 6 and 7 add some const and ro_after_init modifiers.
> 
> Patch 8 removes extra storage of TCP helpers.

Applied, thanks!
