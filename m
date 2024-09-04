Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9511773D;
	Wed,  4 Sep 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460453; cv=none; b=VfB99ecGbyS/u3IMDD4qDLoTVrAkhE2IQ5N7gerVU8IFENY8Uxz/Lvm4HtUotDtsTzF13lZwwFdcBhEGpMjFrZrtMtOh7CO1MsVOxfGko/RXjk7mPIzb8x0mzlD7lfzk31nTCGJfxGW+kAZ+LYPEUqh+kcCVPmdmA03BOtwHlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460453; c=relaxed/simple;
	bh=13aFPTMnmuhiKv/uWoLnHBNyjR1SadB6h+QvKx4Efis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxncpex5m+E5pcR7K0xPZIkdKb2D9cf2dpkpgY/l6h68RRVLsOjFD4pZQqoNk/zPuayLdRlWzN39DrVqZVyBBMgUPjiQYanIJ9iwHc6bKJ+jcGs1M4soVlZ4FnLM1EbgiLBA0jDQdBuMUS7SfOae7UdGM1K8m3u2Vcbr2QZBCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWaGbQy1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWaGbQy1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33385C4CEC2;
	Wed,  4 Sep 2024 14:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460452;
	bh=13aFPTMnmuhiKv/uWoLnHBNyjR1SadB6h+QvKx4Efis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWaGbQy13bvygOuDmm79QFbs1hc+8ZRXhM9qiTiv1G5AETO4kNblfOlHMmq98oDUv
	 9cC7loz90qRP9JNlw4y/V3OjaA4BrEZ32zjMKgC8MD6V1pDdlCK5ufRMHtkreeDs4z
	 B/+p5KBKX+NnwyjM0R4UIioUp+adkpdo+Zejz2/M=
Date: Wed, 4 Sep 2024 16:34:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.1.y 1/2] mptcp: make pm_remove_addrs_and_subflows static
Message-ID: <2024090401-ride-diffusive-629a@gregkh>
References: <2024083045-mosaic-sniff-fe02@gregkh>
 <20240904111014.4091498-3-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111014.4091498-3-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:10:15PM +0200, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> commit e38b117d7f3b4a5d810f6d0069ad0f643e503796 upstream.
> 

Already in the tree
