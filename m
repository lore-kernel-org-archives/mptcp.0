Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8863929402;
	Wed,  4 Sep 2024 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460472; cv=none; b=nyJCXVViXU/JPe+ap/kuw8BtMl7kpWkwjI7szT0ZJ8dMFCr7+RzfpNvO1d+2d+6G5c+rpBIodarDdcHCIhXg5Z39bhp2n4eZNRlKJNHKjDV4S1iHgT/ZuqAK5sy853DlOqdeg7rFjH0RN2YvWx8i+hPtbiZnU7XAwhi6WQFvWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460472; c=relaxed/simple;
	bh=YRf3axGn2AqO6nbVxWbBQaDrekm6bT1Jy3djYzY+tbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVsVSixuk16vTRQDLmD8IlrDkd5oc7UVXqB9B76gdZMifDtAe5wy+WUNG6Apd1dvvf3EFqo5fOKQQpZSN96M7j68PjFgZMCDhcMIUGkttco6s3yOm7/7Af/DVe49xMeCpQrlPo68gl/EeDZTZ/oUftjFgBrsZ+Wnq8mWzrl34b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uGOWldoU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uGOWldoU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C424BC4CEC3;
	Wed,  4 Sep 2024 14:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460472;
	bh=YRf3axGn2AqO6nbVxWbBQaDrekm6bT1Jy3djYzY+tbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGOWldoUYtfrIQ6/LpRJ7PoMmLScQLmwGW7Jary6Ddv6WbGEkJu20Ty/4fSiSxhHe
	 V3GG9XKwIpYwF1MmO/9YnyQhWTa4tPNJYP146Dxy9u7WrX43cCB9Hn7jiV3pAEbCf2
	 VYk7r9DlFB5ft9lNvUBddI2a9ZluB3jyEK3s5IZo=
Date: Wed, 4 Sep 2024 16:34:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] mptcp: avoid duplicated SUB_CLOSED events
Message-ID: <2024090425-sneer-driver-0763@gregkh>
References: <2024083028-coauthor-moving-1474@gregkh>
 <20240904111113.4092725-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111113.4092725-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:11:14PM +0200, Matthieu Baerts (NGI0) wrote:
> commit d82809b6c5f2676b382f77a5cbeb1a5d91ed2235 upstream.
> 

Applied
