Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF2199BC
	for <mptcp@lists.linux.dev>; Wed, 10 Sep 2025 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475497; cv=none; b=DTYXzYqsjV0tFUqAOD+MO0CRxD9xKCRUvnptiZxXshDR+W31NFc6/wXNH6XDvjh52Gm+IVek2bSy8eFJee0xtfXYi9niMZqaQbRxu/nYOULGagsvuSC34VHPOXJ4/e+kigZMOcVoWL0NTN8ccuQIJksKA5GlozCQ0GqBwBHq19U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475497; c=relaxed/simple;
	bh=BsbebbnxIeXfKXykvT8nQSa+mOlxrkCC60x8eYdSCQw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XJPDdzl9cM5JdET/jhJtX5fvuyXE6T73gK4igru0INRt9xmRQmqNWu8Ehc6sPwdFemThDqOvWUL6UIbRUo9XgFJuvNcTKaEZjq0aFIPiGrqu3Ex3AjthIhKv78VkJV3HdLvEpBMcYRdDsh65BopIY9fdKkhL5pNPUoSu54zoM9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7SKxJ8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7SKxJ8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9961BC4CEF0;
	Wed, 10 Sep 2025 03:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757475496;
	bh=BsbebbnxIeXfKXykvT8nQSa+mOlxrkCC60x8eYdSCQw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Q7SKxJ8z2RMIovEva+V7anhUOlhMyCyNVPdsmPWyR+k9LT/FWdmWK5e2vsEdPTwcx
	 MzoCbMB6ZJU5T2HEZHvJ1CebvarwbDcos2BwRCpO2eqSfkXaCHnCEdoQrJLN5wkdI4
	 0m8AwGsBkjZLhoQXONIcvC9WKlaD980A2Kgul38q8itM90jBRdnWe7HUpIP3mGVgO5
	 NJ08eM9TenlYjNS2QqKHBvJ5a9Dv63R3WH3JFCUKT5yw7MTgIipFNz134LCeCE7Da4
	 ABohxPSj2k+dXxwmwRx+iP7466wKj3bdWs14yzQit0vTMe+2tM8TVRm98OMdLIumzG
	 xemY8/U+bLZiA==
Message-ID: <b46a064d54f6418fe1d61250921674510beb4652.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] mptcp: remove unused returned value
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 10 Sep 2025 11:38:12 +0800
In-Reply-To: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
References: <20250906-check_data_fin_ret-v1-1-2c8100bc20eb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Sat, 2025-09-06 at 16:13 +0200, Matthieu Baerts (NGI0) wrote:
> When working on a fix modifying mptcp_check_data_fin(), I noticed the
> returned value was no longer used.
> 
> It looks like it was used for 3 days, between commit 7ed90803a213
> ("mptcp: send explicit ack on delayed ack_seq incr") and commit
> ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
> 
> This returned value can be safely removed.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  net/mptcp/protocol.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index
> 1c26acf6c4145896ecbb5c7f7004121c66a20649..f3dda47ad1d70b5c6a326c17dbe
> 6d244c5638ca2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -530,11 +530,10 @@ static void mptcp_cleanup_rbuf(struct
> mptcp_sock *msk, int copied)
>  	}
>  }
>  
> -static bool mptcp_check_data_fin(struct sock *sk)
> +static void mptcp_check_data_fin(struct sock *sk)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
>  	u64 rcv_data_fin_seq;
> -	bool ret = false;
>  
>  	/* Need to ack a DATA_FIN received from a peer while this
> side
>  	 * of the connection is in ESTABLISHED, FIN_WAIT1, or
> FIN_WAIT2.
> @@ -572,12 +571,10 @@ static bool mptcp_check_data_fin(struct sock
> *sk)
>  			break;
>  		}
>  
> -		ret = true;
>  		if (!__mptcp_check_fallback(msk))
>  			mptcp_send_ack(msk);
>  		mptcp_close_wake_up(sk);
>  	}
> -	return ret;
>  }
>  
>  static void mptcp_dss_corruption(struct mptcp_sock *msk, struct sock
> *ssk)
> 
> ---
> base-commit: e9091ee333eb716a0933dcb08617228dcd3d3623
> change-id: 20250906-check_data_fin_ret-6d284170880a
> 
> Best regards,
