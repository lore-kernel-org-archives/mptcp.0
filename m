Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8B1F953
	for <mptcp@lists.linux.dev>; Tue,  1 Aug 2023 09:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4A1C433C7;
	Tue,  1 Aug 2023 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690881481;
	bh=aYY3RmEsINfZwTMDlD2+0YXuSqhlPQCG0jkTz8yAZpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HGSTdK1kneTwgTr32Gw4ObHFzacOn0kFv9dCq0oUcBEethnng4fCaSKvLTfodJ6uk
	 1RHUUixwnej1U5ubdmimmKNkh4AcHw0oA0Rrd9taxGw5bY2/2j/ynOM+HmJA8mcNwj
	 IXmv2GGcewzB7sJdl63oaG+3Ui+Qbzyv/LTz+AJo=
Date: Tue, 1 Aug 2023 11:17:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] selftests: mptcp: join: only check for ip6tables
 if needed
Message-ID: <2023080151-ranged-rival-e7b4@gregkh>
References: <2023080104-stability-porcupine-fbad@gregkh>
 <20230801090716.2234574-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801090716.2234574-1-matthieu.baerts@tessares.net>

On Tue, Aug 01, 2023 at 11:07:16AM +0200, Matthieu Baerts wrote:
> commit 016e7ba47f33064fbef8c4307a2485d2669dfd03 upstream.
> 
> If 'iptables-legacy' is available, 'ip6tables-legacy' command will be
> used instead of 'ip6tables'. So no need to look if 'ip6tables' is
> available in this case.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if available")
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> Link: https://lore.kernel.org/r/20230725-send-net-20230725-v1-1-6f60fe7137a9@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Backport Notes:
>   - It was conflicting with 87154755d90e ("selftests: mptcp: join: check
>     for tools only if needed") moving the code to modify in a dedicated
>     function + checking the output directly.
>   - I then adapted the code where it was before, taking the same style
>     as what was done in the commit mentioned just above.
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Now queued up, thanks.

greg k-h
