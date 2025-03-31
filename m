Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BAF4FA
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743384540; cv=none; b=UTS/WlygHsGs8qOw/Y+DbO7S5Q//r4YVydOWRyYLLqLfkIZNIePZuztsRtjYjx7MU2s0LiWhmnhuuzxfaL59f3uLEiS4e0BCf/6JoyM/tMoao0lX1zUCWDgjem4HE5osVtv4hIIdnS52e/Yg/7NXOv1XxvP2dJdW7NafD4y9CII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743384540; c=relaxed/simple;
	bh=qcLH77ld2LEGv4pCw+i/ZwSkrZd7Xtqx6eUcAmHPTVE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CPL/+4kr2+kEGGRDlXZXulr8cPaU28vhjbUCZ2XaofnxeNjnwO+1JJbXdYDes7oXq2CrqVFY3A5GbnKo0motIYB62hVHS9XqVRumcU6MtGxwj2qozCjprbcIDtKnRdNdfjDsfk2DhOeHJ6ZiUUwy1cjdzfb+Ebb0Ui94rbx3gg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVd9LMzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVd9LMzA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55308C4CEDD;
	Mon, 31 Mar 2025 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743384539;
	bh=qcLH77ld2LEGv4pCw+i/ZwSkrZd7Xtqx6eUcAmHPTVE=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=jVd9LMzADVDlDNIwphw/1OOOyMsy2aP6q4JMhvb4GS9QupW1kzRNswauVRjhbX8AX
	 cgebLUD+QyjQUnWFirnwPAfAFf/yQHEGqO22qarM1i8Jdp4DJ2XQpi7hSneRxRP4C2
	 yn3qlLZ+GDQoKJfFA9sEQTXxPDvfMoNQI71hzdaNPABP/28+td5u425BXl2pmN05Rq
	 ayg4hM+4HwJn+cGcgBT7oxjoai0AKBpbBP6OuRkNUvSiMwWNBSTnEMCnRwJWEo6kAb
	 DeFvu7xv8BMiIz27woC3UT5LHa1kfxhTh7q0h+D6hafY1qMaC3iBScU/y5YhJ/mDRw
	 Dx5TH9StKjrHg==
Message-ID: <449562cc90538984f6d1df916d645af01163bb72.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 1/5] mptcp: only inc MPJoinAckHMacFailure for
 HMAC failures
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Mon, 31 Mar 2025 09:28:55 +0800
In-Reply-To: <20250329-mptcp-mpj-reject-v1-1-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
	 <20250329-mptcp-mpj-reject-v1-1-2396d5666e8f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
> Recently, during a debugging session using local MPTCP connections, I
> noticed MPJoinAckHMacFailure was not zero on the server side. The
> counter was in fact incremented when the PM rejected new subflows,
> because the 'subflow' limit was reached.
> 
> The fix is easy, simply dissociating the two cases: only the HMAC
> validation check should increase MPTCP_MIB_JOINACKMAC counter.
> 
> Fixes: 4cf8b7e48a09 ("subflow: introduce and use
> mptcp_can_accept_new_subflow()")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Note: this is a fix for mptcp-net
> ---
>  net/mptcp/subflow.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index
> 409bd415ef1d190d5599658d01323ad8c8a9be93..24c2de1891bdf31dfe04ef20771
> 13563aad0e666 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -899,13 +899,17 @@ static struct sock *subflow_syn_recv_sock(const
> struct sock *sk,
>  				goto dispose_child;
>  			}
>  
> -			if (!subflow_hmac_valid(req, &mp_opt) ||
> -			   
> !mptcp_can_accept_new_subflow(subflow_req->msk)) {
> +			if (!subflow_hmac_valid(req, &mp_opt)) {
>  				SUBFLOW_REQ_INC_STATS(req,
> MPTCP_MIB_JOINACKMAC);
>  				subflow_add_reset_reason(skb,
> MPTCP_RST_EPROHIBIT);
>  				goto dispose_child;
>  			}
>  
> +			if (!mptcp_can_accept_new_subflow(owner)) {
> +				subflow_add_reset_reason(skb,
> MPTCP_RST_EPROHIBIT);
> +				goto dispose_child;
> +			}

This can be merged with the previous check

	if (!owner) {
		subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
		goto dispose_child;
	}

as:

	if (!owner || !mptcp_can_accept_new_subflow(owner)) {
		subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
		goto dispose_child;
	}

WDYT?

Thanks,
-Geliang

> +
>  			/* move the msk reference ownership to the
> subflow */
>  			subflow_req->msk = NULL;
>  			ctx->conn = (struct sock *)owner;
> 

