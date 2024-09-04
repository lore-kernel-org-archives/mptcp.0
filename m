Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C101DC04A;
	Wed,  4 Sep 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460422; cv=none; b=fHKbeVx21sFTiwhvEetEozYyoC9D+xdHTsOzu5mCgCml2t763zEKuX44vYIfICpmfm3qaPQZpcpUhSqGBxWSd/0j0ijsn0fuLHMcO0Ys/OJei97WOnlHbZOqzfAgjx3XMCkw81T9NzLjNIjnsnNFenRFGRUI2WbqQXZcKn5bS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460422; c=relaxed/simple;
	bh=OxWXSAViw33U1McaQAc/EUng4PuB54PX23LWg7VURy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9L6JTGGQmYdBUTooc/wt4N/bNJOXv9EmRSNNpk812D3SdDFLr4iDGfCfsGGenqS4uXMLaX1vio9nsllMzt6SHv6XqXeEO///m4ehocdvCvOqNe3Rs7YnshKGnA1cvTD3foPOHsiaDfdjPzX94jZ0yD+6wcEpWT1m6gKjPZZdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gavkMZ35; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gavkMZ35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B54C4CEC2;
	Wed,  4 Sep 2024 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460422;
	bh=OxWXSAViw33U1McaQAc/EUng4PuB54PX23LWg7VURy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gavkMZ35O/kPq7QiptebuyRKqZDY66r8O0gULeZgRYtgUSMhCX/iOnBoLKtCTpCGS
	 E36wHaizZtB+XU9Gdh+5VSRFJB7AXvLe28q7YteAsC8lUP61bIfsG1jYtS5fQvwkCB
	 UwTLtjmeVw3iffxw6vnkRWDezonG2SYU5QS0YgQE=
Date: Wed, 4 Sep 2024 16:33:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: check re-using ID of
 unused ADD_ADDR
Message-ID: <2024090403-prognosis-arose-a0ff@gregkh>
References: <2024082626-habitat-punk-904d@gregkh>
 <20240904110705.4087459-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110705.4087459-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:07:06PM +0200, Matthieu Baerts (NGI0) wrote:
> commit a13d5aad4dd9a309eecdc33cfd75045bd5f376a3 upstream.
> 

Applied
