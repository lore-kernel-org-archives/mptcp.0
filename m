Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3A171D5
	for <mptcp@lists.linux.dev>; Wed, 15 Nov 2023 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WoRc2t6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53530C433C8;
	Wed, 15 Nov 2023 11:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700048904;
	bh=mmc4JX/CRpX6FwatmFBZtFjdtRaFTI/8bfBatxCgHv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoRc2t6x7CH3kohQhGSzeeJ27dl3SnRZXBga8gOx4yLsWK8u5e9n+iYAP1fruiBQi
	 0/oZEdKCvF7a4ux3kvbvOAag8YPBIasSu37UICT/9WJ3QVRcfzZ1VNk7eWw/mPMqug
	 deYUYz2HSh+i1b9bu2S9GnHCcy9zmsSUFjvcHj4c=
Date: Wed, 15 Nov 2023 06:48:22 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>
Subject: Re: mptcp: commits to backports from 6.7-rc1
Message-ID: <2023111519-atlantic-legwarmer-5c6b@gregkh>
References: <a7a3675a-4531-4559-bea2-c7689317764a@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7a3675a-4531-4559-bea2-c7689317764a@kernel.org>

On Tue, Nov 07, 2023 at 12:22:19PM +0100, Matthieu Baerts wrote:
> Hi Greg, Sasha,
> 
> This is to let you know that 3 patches from MPTCP tree have been applied
> in Linus' tree and don't have their "Cc: stable":
> 
>   - f4a75e9d1100 ("selftests: mptcp: run userspace pm tests slower")
>     - for >= 6.5

Does not apply to 6.5.y, but did apply to 6.6.y

>   - 9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
>     - for >= 6.5

Now queued up.

>   - 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
>     - for >= 5.19
>     - note that the 'Fixes' tag is missing:

Did not apply to any stable queue :(

We'll need backports if you want this applied, thanks!

greg k-h
