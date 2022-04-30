Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67377B
	for <mptcp@lists.linux.dev>; Sat, 30 Apr 2022 00:51:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCF8C385A7;
	Sat, 30 Apr 2022 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1651279876;
	bh=jX7eUrV7j+cvceaJXIqx4fZhKDwK71UIqUl97mqcCaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uiZLnOT+8Gfpz4nY6Rf7e3JHwqIQAOFaMlj5qzM2gGCZ6UNukZCzxSN/ZnWwn2jlv
	 79vRMZ8O8+7CyXBiWHxwPQPqEzaQfAh40uIA0Tkoev6fd1pA+IcpQkDl4rJx9sE7u7
	 bzds8J30t3gpJHHlHDPJejX3Vw20yTgGS5nf6hHlvZctjWgFtm5yoQ4CX7ExqQMRbM
	 dfgonwmz6NlCzMuHYVkaHzg06Iy16gMxuta/HsdfsdbaAtNYYwOwEaGleD/jxmcgIW
	 9CeVb8fQqIcYgiv9vtVeOh9Fv9Ec56cEZtxbHZv6eL9rWjj+zOsYv1jRILnLDcEk5a
	 gCQHy8OggYNUA==
Date: Fri, 29 Apr 2022 17:51:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 0/6] mptcp: Path manager mode selection
Message-ID: <20220429175114.2500d3a9@kernel.org>
In-Reply-To: <23ff3b49-2563-1874-fa35-3af55d3088e7@linux.intel.com>
References: <20220427225002.231996-1-mathew.j.martineau@linux.intel.com>
	<20220428185739.39cdbb33@kernel.org>
	<23ff3b49-2563-1874-fa35-3af55d3088e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Apr 2022 20:39:01 -0700 (PDT) Mat Martineau wrote:
> Sure, no problem. If you'd prefer a pull request for this feature as a 
> whole I could stage that.
> 
> Here's a tag (note: do not merge this as-is, the committer ids and full 
> history aren't suitable) -> 
> https://github.com/multipath-tcp/mptcp_net-next/commits/netdev-review-userspace-path-manager
> 
> The last 26 commits there cover the full userspace path manager kernel 
> code, with the first 6 of those being this series.
> 
> Userspace path managers makes use of generic netlink MPTCP events that 
> have already been upstream for a while, and the full series adds four 
> netlink commands for userspace:
> 
> * MPTCP_PM_CMD_ANNOUNCE: advertise an address that's available for 
> additional subflow connections.
> 
> * MPTCP_PM_CMD_REMOVE: revoke an advertisement
> 
> * MPTCP_PM_CMD_SUBFLOW_CREATE: initiate a new subflow on an existing MPTCP 
> connection
> 
> * MPTCP_PM_CMD_SUBFLOW_DESTROY: close a subflow on an existing MPTCP 
> connection
> 
> There's one commit for each command, each with an obvious title ("mptcp: 
> netlink: Add MPTCP_PM_CMD_<name>")

Thanks for the explanation, applied!
