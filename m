Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D677082D
	for <mptcp@lists.linux.dev>; Fri, 19 Sep 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275396; cv=none; b=gRu8NqKqYvYYsyupbqlr4Da3tW3qcyNgE/WRd1RXCWP0QZShHzH3nvmvXgSm4oLTICguKtaheH4KDXtXVtleuUTK5OgKbdUKi+3sJEo5sMVBKX5tqSoaeyJ6Eo8/58T9Qb41kAq8S9RVOCg7SI1EghuiofdyYMhnKSH+D8gCwbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275396; c=relaxed/simple;
	bh=nAt9dszM+Lf1AcZKWAdC6psl36zFE+TOELWM+KTGkrQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lr+jkvfi607+2n3qpLuaKfvtTzyoqT6n4wtpeXCGFeOY+V8HJVfRduhdgccJRUUGQKcbdQADwbSiNEo2yt0qhIeaNmyw+Wl0q2tT1V/3bpNW/vOqYdWvNmP+2ggEjpXghtwbfx9pepx8pCvDgYkvHys+4Pjv0OY7Bf1ccVNPC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMh5GvLc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMh5GvLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE95C4CEF0;
	Fri, 19 Sep 2025 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758275395;
	bh=nAt9dszM+Lf1AcZKWAdC6psl36zFE+TOELWM+KTGkrQ=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=fMh5GvLc7cBMkDI2YIE5Xn5w0cAvqHWB+uppsEyYFTQNvgF7Prk9yEDuqiGr3TFh2
	 SLU/KNEe98ivdpKb+RGP84/XhyUH/iRbrZ5T8XAt92iWhRQ0KiwJdfpTOg8eaxOXYC
	 V/moRubAEYLZxt9Z4n6T87hiSMAfQHozuB+gK8cS9yRiMg0bqE3ZpG0FZgmo2QLA0L
	 m31D2GX17B0dsnWaubsgjoSL7C11YLtBjeehiKQY6bxUsbnKchQFQDeeVFWyP6zcJq
	 uiTecweBaZmn36yBoV07mp038fzeK8bEhRsvuhtrHwANRJD1mysmse9GYQzDXuGV2v
	 uGo0LrZotCIKQ==
Message-ID: <39d0e388979ed690e9dcb68939f1c355518c6f3b.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 01/12] mptcp: leverage skb deferral free
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 19 Sep 2025 17:49:50 +0800
In-Reply-To: <93b5f3f52220e59b5d22611b6fc0858353890105.1758214563.git.pabeni@redhat.com>
References: <cover.1758214563.git.pabeni@redhat.com>
	 <93b5f3f52220e59b5d22611b6fc0858353890105.1758214563.git.pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thanks for this patch.

On Thu, 2025-09-18 at 19:14 +0200, Paolo Abeni wrote:
> Usage of the skb deferral API is straight-forward; with multiple
> subflows actives this allow moving part of the received application
> load into multiple CPUs.
> 
> Also fix a typo in the related comment.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/protocol.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7933291e991ce..9d95d24781509 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1943,12 +1943,13 @@ static int __mptcp_recvmsg_mskq(struct sock
> *sk,
>  		}
>  
>  		if (!(flags & MSG_PEEK)) {
> -			/* avoid the indirect call, we know the
> destructor is sock_wfree */
> +			/* avoid the indirect call, we know the
> destructor is sock_rfree */
>  			skb->destructor = NULL;
> +			skb->sk = NULL;
>  			atomic_sub(skb->truesize, &sk-
> >sk_rmem_alloc);
>  			sk_mem_uncharge(sk, skb->truesize);
>  			__skb_unlink(skb, &sk->sk_receive_queue);
> -			__kfree_skb(skb);
> +			skb_attempt_defer_free(skb);
>  			msk->bytes_consumed += count;
>  		}
>  
