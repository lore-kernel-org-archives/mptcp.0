Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360E725C6E6;
	Mon, 10 Feb 2025 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216979; cv=none; b=Al2FD5mbjZlD8ktTYT0bFBFwoYCyFdocWCP0Vj1o7wrLkDS+wX8HZskZIvOf8kN9hB3zvkq5arflEXcCpzUJykiD3FRopmgGGpnkw9GlCrJ2O2Txhj9vIKDCKUJ+MuisDMZY7Nifh26NJY9jF8boDEImGJ7tgws4Bfo8wt6T9jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216979; c=relaxed/simple;
	bh=c4vYdPVZ5YgT0MdemLVqYg7VHU0O2sy2pLSvvNiGypM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uri78Px7ciTVyD6GDgAEYOBygnSRxTQhZ2rP5C9qAVGFG7Qcmpr2LraTCBd0IpjrWtfeNx0FiCRMe7IKNPwWwR2Cj9OpYhUYSntFrw69QwnZjBkZCBIEVPV6YpZY1JCp1iIYgImHyVvE+4DL030kUKsd+k/ZvbY2Qbdd5/8Ymro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I42w9mww; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I42w9mww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A37C4CED1;
	Mon, 10 Feb 2025 19:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739216978;
	bh=c4vYdPVZ5YgT0MdemLVqYg7VHU0O2sy2pLSvvNiGypM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I42w9mwwx2B7q21loC7v5mDrqRAyEsxWuzkNlw32W7wEU11nX7mLbFjMmbwcIGXx1
	 IoRnJbXUvziFY0C6f9j9U9xOPaWTS/pFHPXoVeyi4pw4OJAJwY0ezmcR86J7mihsOj
	 2FaplryfB/J5kbRJUWzULI/1Qo8ppKbW+6dx6UwgYPb9WN1TPpVuuWnvT2Mo3B8lPy
	 Yf5Nrx9fgqoiyTpytKSxK41jSH/c/0lPy9zIZZuJGdP6drYFbfYWKDkrXxzFMIdzbF
	 Zkz840sfkWF/mAu37hOGw++vQzagHJPTaI8DS8vv06K8ZoHbzLwLVA9wWqOtUxrasY
	 hac4Gxfi7UuQA==
Date: Mon, 10 Feb 2025 19:49:34 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 01/15] mptcp: pm: drop info of
 userspace_pm_remove_id_zero_address
Message-ID: <20250210194934.GO554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-1-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-1-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:19PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The only use of 'info' parameter of userspace_pm_remove_id_zero_address()
> is to set an error message into it.
> 
> Plus, this helper will only fail when it cannot find any subflows with a
> local address ID 0.
> 
> This patch drops this parameter and sets the error message where this
> function is called in mptcp_pm_nl_remove_doit().
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

Hi Mat,

A minor nit, perhaps it has been discussed before:

I'm not sure that your Reviewed-by is needed if you also provide
your Signed-off-by. Because it I think that the latter implies the former.

