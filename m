Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311EA1DB955;
	Wed,  4 Sep 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460317; cv=none; b=scUcTqSmeUfVNrkaJhAPMADHHWk3A5RViMBMDMBaLlUlc2GKf16U1mJY2RoV+Z5PRtrrkC7m+kyd2xvi4OffkGMarOYcrG1YfXkq1BuqrLhykzXTeuQIInM4FYIkofaWXk3gJbSdJSZGjn3k3xDppfnpS0rqUZkj+rSUjk3NJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460317; c=relaxed/simple;
	bh=M39b2p+bQQK6HHUPEVY8Ctx/lSrzpdx8OG/iv04+qco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRbBQQRVEEUf9kptnO4aTELg4zBTm6gTjNrQoXFnjphxXYGsnRTI8MGABAsHJQ166hsRdojwnact5FmX3kheJXWV4gPB2XkTNlH4mgnGjGAihW5LjV7j/r8ZrolxNBne8kMDR4LPu/mw1O/fbGwoGwlUXCsG+Srd7Po5bz3v0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rQIF2etM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rQIF2etM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5133AC4CEC2;
	Wed,  4 Sep 2024 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460316;
	bh=M39b2p+bQQK6HHUPEVY8Ctx/lSrzpdx8OG/iv04+qco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQIF2etMS9GiBdahrG9XjZoaF7gbHzJUd4kMFG2NmuwsMS9ugDPJRJlm7+Z+sIyly
	 vOOhjsc7vQA+oe8DB6QoISm7LCqogQmeC0sOcCECOtTJy22xB74P6b9akeGt6POc6i
	 grA7djU12fXlvJkW+1EYbxXXXa8mMtcr/MtFP9Nk=
Date: Wed, 4 Sep 2024 16:31:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y 1/2] mptcp: pm: reuse ID 0 after delete and re-add
Message-ID: <2024090450-engross-unpeeled-a74d@gregkh>
References: <20240904105721.4075460-2-matttbe@kernel.org>
 <20240904110306.4082410-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110306.4082410-5-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:03:08PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 8b8ed1b429f8fa7ebd5632555e7b047bc0620075 upstream.
> 

Applied
