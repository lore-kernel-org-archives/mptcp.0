Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31B6FCF
	for <mptcp@lists.linux.dev>; Tue, 10 Jan 2023 15:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8778AC433EF;
	Tue, 10 Jan 2023 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1673365678;
	bh=ss5sVhJFDTAZPEGENJGtCF6+R9cZQ+huXnZOvLeLg8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bL8kTXToFFr/8UpbYLZxNlHIukI78Ewb5zGcDzlJOlAh/hvJlPs38ivlK3rPq7TUa
	 McM1ePhpmHJSIFIUWuKybQIc+T2U19mXu0KTRpZUjN67H8NHC7RBI4hwTtza2S2qeq
	 IorTKqKVOvhLnPjLy7x5726+xKHcP9p6MrjcPVfQ=
Date: Tue, 10 Jan 2023 16:47:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: stable@vger.kernel.org, matthieu.baerts@tessares.net, pabeni@redhat.com,
	mptcp@lists.linux.dev
Subject: Re: [PATCH 5.15 0/2] mptcp: use proper req destructor for IPv6
Message-ID: <Y72IpXaOMXJKqoje@kroah.com>
References: <20230107011959.448249-1-mathew.j.martineau@linux.intel.com>
 <eac12f5d-303a-8318-cc75-4e0870174a9d@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eac12f5d-303a-8318-cc75-4e0870174a9d@linux.intel.com>

On Fri, Jan 06, 2023 at 05:53:48PM -0800, Mat Martineau wrote:
> On Fri, 6 Jan 2023, Mat Martineau wrote:
> 
> > Greg -
> > 
> > Here are backports of two MPTCP patches that recently failed to apply to
> > the 5.15 stable tree. Two prerequisite patches are already queued in
> > 5.15.87-rc1:
> > 
> >  mptcp: mark ops structures as ro_after_init
> >  mptcp: remove MPTCP 'ifdef' in TCP SYN cookies
> > 
> > These patches prevent IPv6 memory leaks with MPTCP.
> > 
> 
> Sorry about the cut & paste error on the cover letter subject line, was
> supposed to be "v5.15 stable backports for MPTCP request sock fixes".

No worries, all now queued up.

greg k-h
