Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8563502A8
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761441; cv=none; b=d1Q/+rkFTNwSrvF7e1p4YTSpgIj8ZNR7l3SUgMt/fTqEx3IIN2xLD+QzvYQRqQZyEm83GGRX++rj+K8r1a82jT8FheHhToZAxgiUKi86bFnP+Z/AAViMTd1r0+oGOyKLVP1kdCytdgP2lWKKcPhed9q0QqCQ8x/Veo+CI16VRoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761441; c=relaxed/simple;
	bh=g9U3qztN0pry8UwueeCorZKUGRlPkry1erJztR0Ye/Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCYlEkR9T+bRZnywt3nW8KTPZpcTioRwkmEtlIDv9vKsO93NCpagS8IyQNwaFvuXhUWT/i+i4UUb3t6mKVScsSOZEfw6s4gy4pJN3dkrxdXI7A36mhHNbdBZKMIGvZ0G6bNWfPL8VXuADIRBxYw6ZbqycdBp857IQniOLLq5fP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmrexIij; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmrexIij"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B0BC4CEF7;
	Fri, 30 Jan 2026 08:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769761441;
	bh=g9U3qztN0pry8UwueeCorZKUGRlPkry1erJztR0Ye/Q=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=rmrexIijKfntcyrTymWzbvHia4xpr68KZLV92C+8zJOeb1/tPA4GXYmEyOBc9/m3L
	 nn7CDHjHgXG7A6tS3MA440XxWXhbOGy0ffbw/4dJKxOR/AFcw7lT77CBI4LB2Ruq5k
	 hdJp9xOD2d6s5vSZwgRKV12pPK9fUMajXDMQ7Q9OfDaQTwyp861PgDMPooYeFNWLpa
	 gpJ7Js4QpOzns5nUW5+E0Lzj3humIzWkpDZfssbPmUdTu4NP9Wm+PatptCTqMZRgwT
	 EyLQIEFIsg5WNOdmPhXUwAE25GQoO72rWKfe7qprnEC+q+DaVPmv2U2fFGwsPONNBg
	 lo2rRcR30HJlg==
Message-ID: <171922c0a17599ea1bdfad779c2289d4365bad34.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: implement .splice_read"
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 30 Jan 2026 16:23:57 +0800
In-Reply-To: <20260130-mptcp-splice-return-kdoc-v1-1-3363209d2e57@kernel.org>
References: <20260130-mptcp-splice-return-kdoc-v1-1-3363209d2e57@kernel.org>
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

Thanks for this fix.

On Fri, 2026-01-30 at 08:37 +0100, Matthieu Baerts (NGI0) wrote:
> Fix kdoc warning reported by NIPA:
> 
>   Warning: net/mptcp/protocol.c:4424 No description found for return
> value of 'mptcp_splice_read'
> 
> Validated using:
> 
>   ./scripts/kernel-doc -Wall -none net/mptcp/protocol.c
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Looks good to me.

Reviewed-by: Geliang Tang <geliang@kernel.org>

-Geliang

> ---
>  net/mptcp/protocol.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1b87b3b0d089..c88882062c40 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4425,6 +4425,9 @@ static int __mptcp_splice_read(struct sock *sk,
> struct tcp_splice_state *tss)
>   * Description:
>   *    Will read pages from given socket and fill them into a pipe.
>   *
> + * Return:
> + *    Amount of bytes that have been spliced.
> + *
>   **/
>  static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  				 struct pipe_inode_info *pipe,
> size_t len,
> 
> ---
> base-commit: 9eafdb3251fecf25d365143d1a7da2dca70f181f
> change-id: 20260130-mptcp-splice-return-kdoc-6d92ca94c461
> 
> Best regards,
