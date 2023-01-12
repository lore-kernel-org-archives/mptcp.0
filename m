Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E16AB6
	for <mptcp@lists.linux.dev>; Thu, 12 Jan 2023 12:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF0BC433D2;
	Thu, 12 Jan 2023 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1673527847;
	bh=sadXOzPmXim6CcqW8Jclh+ryrYj8qf5UA8P2plWNoLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hz99nnYt9L62v2GjapupKW5y8UVfQk2DWRCtPQizCbz0cpAb8FwyomdO+/4Ji+4w4
	 kz8PpgJvNeBRscslzaZFkQzh1UbERX1PsbjmQHxDCk0fIIHOAOByLKKTwgALfbdL4J
	 rxYjSmCfObP1+pHNT7RogC7Of+4d++woPttJbCFA=
Date: Thu, 12 Jan 2023 13:50:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org, matthieu.baerts@tessares.net, pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: Re: [PATCH 5.10 0/4] mptcp: Stable backports for MPTCP request sock
 fixes
Message-ID: <Y8ACJJeUzvn3j9Rx@kroah.com>
References: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107014631.449550-1-mathew.j.martineau@linux.intel.com>

On Fri, Jan 06, 2023 at 05:46:27PM -0800, Mat Martineau wrote:
> Greg -
> 
> Here are backports of the MPTCP patches, and one prerequisite, that
> recently failed to apply to the 5.10 stable tree. They prevent IPv6
> memory leaks with MPTCP.

All now queued up, thanks.

greg k-h
