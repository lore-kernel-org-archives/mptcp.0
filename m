Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF463D;
	Wed,  4 Sep 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460576; cv=none; b=SxVqiDAGhrhyxWhhfovD3XpYXEZO6gLmkTaHCKgUP2ZEKFs81NYZ4Wvdlv1mKBCWT0xUef9uOjAsYBvQ1xSQtCasPZhKxYRFanrPLhYXJeK2VVsq0YFf6jdI6rvdtBRYeBeazRHfZblm4/yKl35DI8ik/llrvVUIcrcQeb4iTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460576; c=relaxed/simple;
	bh=9ixwuu6wBRkIckFLNZCWRTRo0B5HAUeq4nt82Yn5jQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpsYTV4zsEbfWssow89tTAY5qjikkg69fggBD4K6sIOyX0OW+K10dBkCWdvm3cuxK/lnUGBF91c0E9qKeU3Uwgxf431dw1r35taOntARPeicjWbykNV5bfxVWbVl1TPBAkNJKoylaG5tzPGYJVA4Wt+yd0frMlv7WfquFj0JDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YvYtZdFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YvYtZdFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D362FC4CEC3;
	Wed,  4 Sep 2024 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460575;
	bh=9ixwuu6wBRkIckFLNZCWRTRo0B5HAUeq4nt82Yn5jQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvYtZdFiYfeuJNKPNoVLl2y2Va8YoCILyV/kdk/BdoWNHWPO7RbUm3Aft6s3juMLn
	 tqCvIbU6SM0aapeLShdYiSISD4VvbGmgps9ZPuPw3ukgrR65rBuazEgKr6XchXELuA
	 vQxJDbaLsYwWCRuUfEiiCIuA7+KQuuWJu0s6av8Q=
Date: Wed, 4 Sep 2024 16:36:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: no extra msg if no counter
Message-ID: <2024090408-mortify-yearly-c5ef@gregkh>
References: <2024083033-mounting-headsman-336e@gregkh>
 <20240904111233.4094425-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904111233.4094425-2-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:12:34PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 76a2d8394cc183df872adf04bf636eaf42746449 upstream.

Applied
