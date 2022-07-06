Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E267C
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 20:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0582BC341C0;
	Wed,  6 Jul 2022 20:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657138829;
	bh=c6QiCdISE1NdcEkQHwXP8KeavXttI26LFixoqrYBkjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dI5KXpdeYJb6gfK34XFqR1IH5ZWg8Gtbn5y2GspkMQljnxhyFvaN8GrqmX+aVZHNs
	 2zBGACXDNnebbTdBIhB1ONPbrlGHXo+B+GI85EW0I1T1OCu3l/bCbw6+9MqWfbWkqg
	 YpgJXYnNlL29qNJ1+vbX8cOAL5+ia0iPj6RPeFPbjxMJ+jT4Ohl6smPFdCvyidKAdu
	 Xbr755aBaQpZfLa6D4b6E19c4ezPvnUShv1QE5n6k7nXD7FET6KQa3PFb3Wmtj1C/U
	 vXmcPIG3BVtK55n1Dd78jU2EwBexLn0IJKk13/Gw9fndiRNcFLrtrFyhJ3d5GQE7MY
	 7ayhNnXPVEfhg==
Date: Wed, 6 Jul 2022 13:20:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, geliang.tang@suse.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net 0/7] mptcp: Path manager fixes for 5.19
Message-ID: <20220706132028.32028102@kernel.org>
In-Reply-To: <a61724-7676-bf55-491a-9ea8599ca5a7@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
	<20220705180024.4196a2bf@kernel.org>
	<a61724-7676-bf55-491a-9ea8599ca5a7@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Jul 2022 10:14:21 -0700 (PDT) Mat Martineau wrote:
> > Is it possible to CC folks who authored patches under Fixes?
> > Sorry if I already asked about this. I'm trying to work on refining
> > the CC check in patchwork but I'm a little ambivalent about adding
> > this one to exceptions.  
> 
> Yes, I do try to do that. Note that Geliang changed his email address, so 
> the check script flags his old address though he is cc'd. This is the 
> recurring source of most of those red 'fail' blobs in patchwork for MPTCP 
> series.
> 
> Does your script use the .mailmap file from the kernel repo? Maybe I can 
> ask Geliang about adding an entry there.

That my next TODO item. I'm planning to include a local alias map as
well because I have a suspicion that chasing people to update .mailmap
will be a hassle.

> (I did also forget to add my coworker Kishen to part of the series this 
> time, sorry about that)
