Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83FF2C9D
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 18:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFF1C341C8;
	Mon,  6 Dec 2021 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1638817045;
	bh=kgixWDSqMcZnHwfXTjwAEg6St2LR2wH+ynRHOH3oFrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DHlUIgjf4DhGeR5A5picVsZ7O7NSgF2Sc4GF4PiI/wvdxdRpzqUW81XA3o7HlW7Ha
	 w7uxD//nyeZOZj7g+GK2A/RhOrhSt9fRJiC2Z138+kKbkI77ur+CKkWBXtmqNrZ1Pk
	 1IngkEm/sxfGrbxyJi1dkBMsQiATc5PxDU5Aqr6sMAsZXeb2QE8ielRUfBv8aRaGF9
	 8fXVd7DJoScMmq6vEskFbarGrHdydSPCRKWId4+4lx83mwxdix8Ud7g5SwET6ATOI4
	 Jo/T4ulWl6l2XW8d/HL24+LqpFM+QsGqIYcEDNbUF6CDx9ChpIEhJsvoZNV64WO8Qi
	 Gq31h1wVu9bcw==
Date: Mon, 6 Dec 2021 10:57:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+1fd9b69cde42967d1add@syzkaller.appspotmail.com
Subject: Re: [PATCH mptcp] mptcp: remove tcp ulp setsockopt support
Message-ID: <20211206105724.0bf71c56@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <2297cabb-be69-98ef-f4fc-d9472c7820cc@linux.intel.com>
References: <00000000000040972505d24e88e3@google.com>
	<20211205192700.25396-1-fw@strlen.de>
	<20211206075326.700f2078@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<20211206075515.3cf5b0df@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
	<2297cabb-be69-98ef-f4fc-d9472c7820cc@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Dec 2021 10:44:16 -0800 (PST) Mat Martineau wrote:
> If you could mark this as "Not Applicable" in netdevbpf patchwork, we'll 
> apply it to the mptcp tree and resubmit to netdev with some related 
> patches.

For sure, I was asking because technically I added the code that hit
the oops to tls a week or so ago, so I wanted to make sure it's not 
my fault ;) Marked in pw appropriately now.
