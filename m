Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74C13C687
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659417; cv=none; b=QuVQC0A+QPTU7akDYLcvgxb4Tv1K6Xe3i6HjpBfI3R86n7E3ING11Ix8ZxbwcUUztnlkdm6QCA43YFeeiTr7JPosCEweNuDf1Kqkwz+CiMT/Ge8qcyrl5OFqoq/lYMk4QarTBb0tpmgdGt2zJ8NiHFcc6DeQdRgA0V+Qh97S53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659417; c=relaxed/simple;
	bh=5ETrNRzDKeu7DhipKGrwf42Mbr9bCIcUJr5ELoQRugw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj5lhOy/gT4NIZyULXR8LccYpELwoUCgStcap/mY+zFcFl3Ts3sO7VkhsXD/IRtpsUaT0xbCJBecDne/S9LDSDemqBszg8FUbZzKtvpgkupWpLi1t6tGgY66K0MISjGC/Iew7NsVga8VcniD/Fnw5DHFd9YcdXghBJm3sGjPkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5GUsvwl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5GUsvwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C204C113CC;
	Thu,  2 May 2024 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714659417;
	bh=5ETrNRzDKeu7DhipKGrwf42Mbr9bCIcUJr5ELoQRugw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5GUsvwl56iztATkxcOtFOEpHAQZbot9FjqYmaVUaD7d5H9kvqqoc+1ytry09aES/
	 kjgusqvzqOsRm1SGtI6gxXDMdgjKUHmiqaNQBNF1OS22D7pXOJO80oy9B5BPz5KuBL
	 bz1t3waSrXddKbQPSQpYSoyKPW/+3Y5+6Tf05DgGIsPtG4Acw+T6YhHZuNWe81jcXK
	 0ehQ0fefnUgmW3r4ySJ3dSqhwuKhFCqVRc+ro4Hb60MRhYawb87HMpM1DY3Cp2HxBC
	 XpMb8qFh1J5AtG6qtQqiMmNMzerNnXtMe08LNc3qmN4649oIk3ncTX21jUXv6AIMvP
	 yDxNS7ZgXpSHQ==
Date: Thu, 2 May 2024 22:16:53 +0800
From: Geliang Tang <geliang@kernel.org>
To: Gregory Detal <gregory.detal@gmail.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/2] mptcp: fix net.mptcp.scheduler behavior
Message-ID: <ZjOgVXcBcSj3gI5l@T480>
References: <20240430-sysctl_scheduler-v1-0-8187148850df@gmail.com>
 <bd99d542-0397-45e1-826c-93f514376c67@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd99d542-0397-45e1-826c-93f514376c67@kernel.org>

Hi Gregory,

On Tue, Apr 30, 2024 at 04:00:17PM +0200, Matthieu Baerts wrote:
> Hi Gregory,
> 
> On 30/04/2024 14:06, Gregory Detal wrote:
> > The sysctl is accepting any input. This patchset ensures only
> > existing scheduler can be set.
> > 
> > Moreover, this adds an helper sysctl to list the available scheduler
> > similarly to tcp_available_congestion_control.
> > 
> > The first patch of the series is a fix for mptcp-net.
> 
> Thank you for this fix, it makes sense! And thanks for the new sysctl
> entry, it will be useful!
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks for these patches, all tests passed.

Tested-by: Geliang Tang <geliang@kernel.org>

-Geliang

> 
> @Mat / @Geliang: because I did a review "internally" with Gregory, do
> not hesitate to have a quick look to have an external point of view :)
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
