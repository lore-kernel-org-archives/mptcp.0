Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7714265
	for <mptcp@lists.linux.dev>; Tue, 19 Dec 2023 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mc4rvzni"
Message-ID: <ee8ef80dfee65b05d9d62c8daab3b286af0c905e.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702980114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oitzhLxMInRngqOQe032XHHxqvwYEtGD3G00bHTDCA=;
	b=Mc4rvzni679KLXd/XKRnpkHU+sJI72x9vMGswgDVx/HFg8PACLOxXy6/4Y7kWbkhjZ75/A
	dqwawR7T93NkBtRO/A/s6i8+hGa9ctWvK06OrGOxPp2NtHVVtymRKq7XYsc61fF/oO28jY
	l5u3lMofJPisgYbwOLTRMvh13XBP494=
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Geliang Tang <geliang.tang@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Tue, 19 Dec 2023 18:02:51 +0800
In-Reply-To: <20231219092705.4120179-1-matttbe@kernel.org>
References: <20231219092705.4120179-1-matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 2023-12-19 at 10:27 +0100, Matthieu Baerts wrote:
> This fixes a compilation issue that we have in our tree after having
> synced with upstream. See the Fixes commit for more details.
> 
> Fixes: 4cbb270e115b ("bpf: take into account BPF token when fetching
> helper protos")
> Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
> ---

Thanks, Matt.

Reviewed-and-tested-by: Geliang Tang <geliang.tang@linux.dev>

> 
> Notes:
>     to be squashed in "bpf: Add bpf_mptcp_sched_ops"
> 
>  net/mptcp/bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 6b61dd54e69f..dfcaaf0e07dd 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -35,7 +35,7 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id
> func_id,
>         case BPF_FUNC_skc_to_tcp_sock:
>                 return &bpf_skc_to_tcp_sock_proto;
>         default:
> -               return bpf_base_func_proto(func_id);
> +               return bpf_base_func_proto(func_id, prog);
>         }
>  }
>  
> 
> base-commit: 5763f7d7b0e50d486c63e51c0495459f2eb93d2d

