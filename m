Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA12D5C8E
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769781414; cv=none; b=YzhnTpN+ED4bySwR38x8GM9dmOMBs4rKCM6izmYJH2wfIoTJbU5wTj/p40boiOW5uOaO7Y0Hp8kPY4EB8VzvaPImZrne60m44lQzr8r4/q4U40GZT/9N0nFSdyFEjwnKou7343mkGuHQnbOSprZe0Qmp+Fd0sbYikso7Sj+g54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769781414; c=relaxed/simple;
	bh=2w59xjeAqvV8quWGqeEp9YcKKXMV434sEq5BRvXnvCU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VGfX4BeXX5QyF1VwJp1r+qXszX6upMHHAW6dFZrG+kcp2goCSAihbQ9jU1jadYLbUIsl6RxDRJbUjNhWOKNo+2cFRbWyWovtntIJxY1WcSGqqsJDLaAMfhCaynm/6rX9YpFEy8DkgU5VhzLqfo5T6Z28IrC9k1KLo+DDC7IEh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0A0MiIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0A0MiIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C46C4CEF7;
	Fri, 30 Jan 2026 13:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769781414;
	bh=2w59xjeAqvV8quWGqeEp9YcKKXMV434sEq5BRvXnvCU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C0A0MiIOo0IYFjfdr8c95nKmrFMrjEfD24HDDIZqtuzQ8+G6h/1jZMYy1IoQ3ZQPo
	 ol4LPGG0uXWj+WgEK9mTaZ3HD0RLNuL+J+os/mkSf6W+xQcxuHwHckqfLddyXTrgmW
	 IFFVCc05owxgDJkT5udEJUCgu//iJm6FScI6LhzKlTySoYDIixVZJr3ncRTc+0i36P
	 9BdiuQ6Pgt1Mi7yclVWlmn2X2WuyzW7f+54Q4OtMum2wy/9yAFRseti+4IguHvIoFU
	 vkCwI0pvwxPVY+FiB96LJa8vbGrLU4RvBpOj0GUzZc365EZwHdvM4LW6h2pPkjEvbT
	 RAgVV01w9iEug==
Message-ID: <64366afe9fe353882f70b1d4bb17d0a15e3e6ac5.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add splice io
 mode"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 30 Jan 2026 21:56:45 +0800
In-Reply-To: <732e23f4-979e-4bc4-bae4-1cbf01aa21ec@kernel.org>
References: 
	<c24b6414ed2ec128f8ed00be9aa84e0a33c484e8.1769769757.git.tanggeliang@kylinos.cn>
	 <732e23f4-979e-4bc4-bae4-1cbf01aa21ec@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

I just noticed that you also submitted a squash-to patch to fix this
issue. Your patch is better, so I've changed the status of this one to
Rejected.

Thanks,
-Geliang

On Fri, 2026-01-30 at 11:50 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 30/01/2026 11:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Check the return value of splice().
> 
> Thank you for looking at that.
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > index ff1a298d3469..aaa2248ac76e 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> > @@ -947,14 +947,16 @@ static int do_splice(const int infd, const
> > int outfd, const size_t len,
> >  	while ((bytes = splice(infd, NULL, pipefd[1], NULL,
> >  			       len - winfo->total_len,
> >  			       SPLICE_F_MOVE | SPLICE_F_MORE)) >
> > 0) {
> > -		splice(pipefd[0], NULL, outfd, NULL, bytes,
> > -		       SPLICE_F_MOVE | SPLICE_F_MORE);
> > +		bytes = splice(pipefd[0], NULL, outfd, NULL,
> > bytes,
> > +			       SPLICE_F_MOVE | SPLICE_F_MORE);
> > +		if (bytes <= 0)
> > +			break;
> 
> Please check [1]: that's not enough: it is important to print the
> error
> to be able to find out what went wrong in case of error. Also, the
> two
> splice() should return the same value, and if "bytes" is 0 here,
> that's
> not normal.
> 
> [1]
> https://lore.kernel.org/mptcp/20260130-mptcp-sft-no-ignore-splice-err-v1-1-af0a458b6ec8@kernel.org
> 
> >  	}
> >  
> >  	close(pipefd[0]);
> >  	close(pipefd[1]);
> >  
> > -	return 0;
> > +	return bytes < 0 ? bytes : 0;
> 
> The returned value is supposed to be positive (that's the exit
> returned
> value). Also, I don't think you are supposed to have bytes > 0 here,
> no?
> 
> >  }
> >  
> >  static int copyfd_io_splice(int infd, int peerfd, int outfd,
> > unsigned int size,
> 
> Cheers,
> Matt
