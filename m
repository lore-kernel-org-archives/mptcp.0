Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD081EA80;
	Wed,  4 Sep 2024 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460311; cv=none; b=quHKNTBi8I3xJzWd+cUcasam+IyiJ263JWGPxsycGmBj7D+JGYz5fwB366DW5uzd3ENDwIXo6q4e8BaKysIbdxI3msgM14qW8Coaks33k6smmX8JBBjf1HUBXAGKlaJK3/rHbfjPpT7Wzpq7L4wUymLMGtXDcArn+wigHUTqGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460311; c=relaxed/simple;
	bh=CloeWDmPpSUWzKtyx+1J0eGVJb7l1Q9aoU1/tKUj6mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwWcgtn5zbXDfElf+LKLHxvl6uCFa1bEjq8x9/I58A6LyGkfk4sHMtc84et/q7NRO2p2m20v4RL+/cV7yxTjrcP0H1EQT5nLRux4h+ZnoL9JTc8OBEAFEA2ox9rL06PnqAQ2nq1Ng1+bFVPOueRK/b+CedaYEGjoyCBLvnsIO9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OjXYRLuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OjXYRLuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F312EC4CEC2;
	Wed,  4 Sep 2024 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725460311;
	bh=CloeWDmPpSUWzKtyx+1J0eGVJb7l1Q9aoU1/tKUj6mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OjXYRLucS7f22AtA3r772zb1lIqlVPqQU8NRVq2pA5dg5grJanI0I45kjMISWq9q3
	 SfV8Q8DCoK4liK9IJ8Qm1+jX3b1TYfH8l4V/yoUJXb3c8O0DaJptEFvw79Sw18PfA7
	 /dTxVo1GoDx1Km7vdk5uGjqDjpsvV1hGZbkjvBfo=
Date: Wed, 4 Sep 2024 16:31:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.1.y 2/2] mptcp: pm: fix ID 0 endp usage after multiple
 re-creations
Message-ID: <2024090444-lunacy-treble-a700@gregkh>
References: <20240904105721.4075460-2-matttbe@kernel.org>
 <20240904110306.4082410-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904110306.4082410-6-matttbe@kernel.org>

On Wed, Sep 04, 2024 at 01:03:09PM +0200, Matthieu Baerts (NGI0) wrote:
> commit 9366922adc6a71378ca01f898c41be295309f044 upstream.
> 

Applied
