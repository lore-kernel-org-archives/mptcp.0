Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018C370
	for <mptcp@lists.linux.dev>; Tue,  3 Aug 2021 15:21:53 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5429D60555;
	Tue,  3 Aug 2021 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1628004113;
	bh=vwcPVijXM8FYKwUQsl2R7tN53aZe12iOT+B9pkuKNEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OLl8FDJu4AZTA3i92j1sTJrYgFWY8msKvMlAZnNL94y0HLdywLqtbLKHswAKEdtL2
	 ib/ZBwnJr6mWMRyFBFCBSQYNftlKwXGu22l7fjCC2GlVVCRyI9x3n4Ql6bG1Et3ge2
	 yOAbDKFiVNOgnSHwQZV9KEL9WRWrx2uUlTZ/WaY1N5RKalSo5SSD6etIra1xG64NnO
	 ab+G7TjZrrBwrj7HtjAKHiUFS+AvyLmFkndl6+hVEhuKQd/U3hI+VxPH2NoB9VyHcx
	 dhcuhmkxj1tlIRgDwu/KxvxEPXvwH5nb18I0927TiOP9htt9wRVMQ764+ylTkQwaXc
	 fV+3eQPRH1Owg==
Date: Tue, 3 Aug 2021 08:21:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Geliang Tang <geliangtang@gmail.com>,
 davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net] mptcp: drop unused rcu member in
 mptcp_pm_addr_entry
Message-ID: <20210803082152.259d9c2a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210802231914.54709-1-mathew.j.martineau@linux.intel.com>
References: <20210802231914.54709-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Aug 2021 16:19:14 -0700 Mat Martineau wrote:
> From: Geliang Tang <geliangtang@gmail.com>
> 
> kfree_rcu() had been removed from pm_netlink.c, so this rcu field in
> struct mptcp_pm_addr_entry became useless. Let's drop it.
> 
> Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

This just removes a superfluous member, right? So could as well be
applied to net-next?
