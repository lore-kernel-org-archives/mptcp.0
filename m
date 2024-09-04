Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E554738DF9;
	Wed,  4 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460467; cv=none; b=FLiM0CVeir8msR1qkA3wgo8qQKNU0SAP5KtlwLzP3BkojshwBZMhAnmIeaodK8ALQkGDGkCalc1/ODNvTHD94c1hGSaZpCGUtWL048DShiTbVMaMndJ8VcHbrNuJge7rsIQ+Rwh50jDKVBYjQW3d6kj/0xhZOOTIZbIqmeRVptw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460467; c=relaxed/simple;
	bh=keWLFj7j1dwiXvzm1S4LQOLyjRaEK7mn9v5obS6BD9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSgsROlKHOmKvHNU0wUJzCk8RkNHCEq5l7EcB0uDN+suv7wvHlBFkxp9dfLe8xn/Shnt+4w4SofPrQopJEtMBJYSYmCI9z8vss+uS+mzcGkSXss/QSfSe8SlqTXC2cUxIC9AKqr51XMc5Qvy2VGZ/iBw9zl2ye0TwO1jIPbp++I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmimWTyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmimWTyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53708C4CEC3;
	Wed,  4 Sep 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460466;
	bh=keWLFj7j1dwiXvzm1S4LQOLyjRaEK7mn9v5obS6BD9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hmimWTyM+vRvD3v90id0Lva6OJbmx2zUXcQ7ec8XsLXa7D7HTpkV1cazWiHoSsbLY
	 8AH0cO+yEQAwd5iRYu0OsK6MtiANPIiIqUhNbFTvFjTpzBBkkrqrYh1LMeHmoWygu3
	 qBM6QzSC6v9Wc3mRN6j2icy3RzlZVTSZKOXJ8HTM=
Date: Wed, 4 Sep 2024 16:34:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y 2/2] mptcp: pm: fix RM_ADDR ID for the initial
 subflow
Message-ID: <2024090418-backfield-dolly-e335@gregkh>
References: <2024083045-mosaic-sniff-fe02@gregkh>
 <20240904111014.4091498-3-matttbe@kernel.org>
 <20240904111014.4091498-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111014.4091498-4-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:10:16PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 87b5896f3f7848130095656739b05881904e2697 upstream.
> 

Already in the tree
