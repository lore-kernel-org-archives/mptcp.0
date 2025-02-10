Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD025C6FF;
	Mon, 10 Feb 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217089; cv=none; b=V88aPUpKWpp64lGXVGlLCqwmeHRhUCaDR7uuJVldFI/mAnYedsM08qjjoqYgOyxWUYyscJtf9wkheNFn7GCb1LRuQS9IbX8lCBialBG8O/OFcwP9gIsRROLn5jN3UcWbk41Syg+0kfIRK8Z4LPosVW1MvgChQvi9hhJvAhjTNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217089; c=relaxed/simple;
	bh=dROdXaPuHrNQ+Zxf6EiDV4F1pq7Hu8WNfuv3veVuO98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YS5sLnNfaJUxkBNwCszCld+jzBxQS69E4z6dBmXP1B842fsUGLCQsKIhxvNyZ3vlUjtyipFZJF5zOruq2qjcz6g8Fvq5RrnmSizyoZR+lW6uRGpYowISCudBNbJ+WMfJJX8gnGDaG6cigHlo0gEmXdyGAGgtb0fXmVfRNumLlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK53ghdH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK53ghdH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71E2C4CED1;
	Mon, 10 Feb 2025 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217088;
	bh=dROdXaPuHrNQ+Zxf6EiDV4F1pq7Hu8WNfuv3veVuO98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RK53ghdHE+attK6oMYcrFHpDvI2xJGLacBqBU8T+P390QMWObrFGwN2PIOZ4c0GkC
	 F1HBfD2jW1by1ZSjwaAFERZqLaJ/Bg2ddmNIP5d355P/xpuFP732KmKP2lCE6EF5RY
	 Aj2xjwR2L8b1v583N4GnhXNU/tsFHb4PGFGUTv/cmfkCq7htPbjR3eG6SG3jMrGbHD
	 518f0ECyguaJFoLQ8U6A2aiVSwuGsH9VY8RjvHX6GJ9eR7/GD8GcUFMxCqoT4S5Y2v
	 kFoBIw2KOZluBKRpsEeBzreOeicT+ihSA5HFVz1enzLcBWWse6Pd5ijoyMtXM6HJfR
	 +kXAtP3eUBVtQ==
Date: Mon, 10 Feb 2025 19:51:25 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/15] mptcp: pm: use NL_SET_ERR_MSG_ATTR
 when possible
Message-ID: <20250210195125.GV554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-8-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-8-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:26PM +0100, Matthieu Baerts (NGI0) wrote:
> Instead of only returning a text message with GENL_SET_ERR_MSG(),
> NL_SET_ERR_MSG_ATTR() can help the userspace developers by also
> reporting which attribute is faulty.
> 
> When the error is specific to an attribute, NL_SET_ERR_MSG_ATTR() is now
> used. The error messages have not been modified in this commit.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

