Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619CF1DC1BB;
	Wed,  4 Sep 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460419; cv=none; b=REA6WND38CsSNFNOexz4V7EN19jFLBA1SCbjlDDxJ72dc4BdZE6Trb4aUMjU+axWRrH/B3XfccdD+4t5JXrpcqrC//OE0q/EpSaiZacjL+V4kGCvH1+JSRe54UJ1xM8MITF8av39Q/AcqxBTlvfyMtFWndFa7aqaI8qYNmqMUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460419; c=relaxed/simple;
	bh=gytM6Pt6hSf5XjQGDfYF/eLGCSZPGJ06p/Y3RLNwUN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNiJ2+FAXGYY0sLaEKZPE/93FnM7ioeUtCx4+15Lgg+CliXFwU2QTMUTfo/CaHB1gULgeNzMKU0sEh/q2M52fRK4CDxwOeeTkdT1AX51i3AkyNCLW0haHsOUeLxoc/calQz8W0PjTaALcImQfN+jjzQkR178iglTF3XAGZyYDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ny0klevX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ny0klevX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA051C4CEC2;
	Wed,  4 Sep 2024 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460419;
	bh=gytM6Pt6hSf5XjQGDfYF/eLGCSZPGJ06p/Y3RLNwUN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ny0klevXSwVDSLEOenUVNs8hEHbhs+ebRHbmg6X/HIUwSNj1O76sle9J1cxXZe3nA
	 OZuD67LKJO0qFxahuzmj8p1tmsacUTVQf/efzIrbob6mJG1jjboaClnZjNbygxrLBu
	 uoCHxfsiwALnw1h9rsBIn4Ru59cvlncdrIGH59VA=
Date: Wed, 4 Sep 2024 16:33:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check re-adding init endp
 with != id
Message-ID: <2024090457-frisk-voltage-9069@gregkh>
References: <2024083019-resurrect-iodine-5ad6@gregkh>
 <20240904110830.4089238-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110830.4089238-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:08:31PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 1c2326fcae4f0c5de8ad0d734ced43a8e5f17dac upstream.
> 

Applied
