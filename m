Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB214266
	for <mptcp@lists.linux.dev>; Mon, 23 Oct 2023 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FhLG4K4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739B3C433C8;
	Mon, 23 Oct 2023 10:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698056593;
	bh=JQL7NUyL5GQlB8D87WonISz32bnyXVvvCpb+z7AEHxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhLG4K4KhiYwruJKUjgRDRTA+O+KtCRl/hW1962fb7XOdUPvY7X5o6pydiGJTC8yA
	 eJ4bqPKBgzOygLJNomkjqid72j3LLdzCQ74AQ0Hb5PyogqyxXrNsfFpvn5NkJK6EER
	 HNMqPN4jsQqqiRZ7l4QtbpXF4+KXe+ieGPBMlzQU=
Date: Mon, 23 Oct 2023 12:23:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: no RST when rm subflow/addr
Message-ID: <2023102357-tibia-overlook-ded1@gregkh>
References: <2023102046-haven-jargon-a683@gregkh>
 <20231022213229.3394813-1-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231022213229.3394813-1-matttbe@kernel.org>

On Sun, Oct 22, 2023 at 11:32:29PM +0200, Matthieu Baerts wrote:
> commit 2cfaa8b3b7aece3c7b13dd10db20dcea65875692 upstream.
> 
> Recently, we noticed that some RST were wrongly generated when removing
> the initial subflow.
> 
> This patch makes sure RST are not sent when removing any subflows or any
> addresses.
> 
> Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
> Cc: stable@vger.kernel.org
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> Signed-off-by: Mat Martineau <martineau@kernel.org>
> Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-5-17ecb002e41d@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---
> Backport notes
>   - No conflicts

All backports now queued up, thanks

greg k-h
