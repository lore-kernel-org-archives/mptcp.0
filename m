Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F43B2FB7
	for <mptcp@lists.linux.dev>; Thu, 13 May 2021 00:38:23 +0000 (UTC)
IronPort-SDR: 7O9E5QFuiaa9ioTn/R8N+ouaATsKVh1b2KvaoeUmKE4H1l8lIVfccL5xr2x4NPwy7gvv2TtZvD
 DbiH0rjACRsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="285341847"
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="285341847"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:38:17 -0700
IronPort-SDR: fzJgNZaHWNXiireq7Mu00Wi/1sV9v3JjGxNbSR7qXDgh98hBNNWJSPHzEmuTWLG0dL0KmnNxYM
 8GnV2fAhD4yw==
X-IronPort-AV: E=Sophos;i="5.82,295,1613462400"; 
   d="scan'208";a="437434330"
Received: from bsirota-mobl.amr.corp.intel.com ([10.209.18.175])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 17:38:16 -0700
Date: Wed, 12 May 2021 17:38:15 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Jianguo Wu <wujianguo106@163.com>
cc: mptcp@lists.linux.dev, Florian Westphal <fw@strlen.de>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH] mptcp: generate subflow hmac after mptcp_finish_join()
In-Reply-To: <79d42988-47da-dc8b-8416-4d4e76510f08@163.com>
Message-ID: <81606e5-c169-3461-e710-b06b8426d5aa@linux.intel.com>
References: <79d42988-47da-dc8b-8416-4d4e76510f08@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 May 2021, Jianguo Wu wrote:

> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> For outgoing subflow join, when recv SYNACK, in subflow_finish_connect(),
> the mptcp_finish_join() may return false in some cases, and send a RESET
> to remote, and no local hmac is required.
> So generate subflow hmac after mptcp_finish_join().
>
> Fixes: ec3edaa7ca6c ("mptcp: Add handling of outgoing MP_JOIN requests").
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
> net/mptcp/subflow.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>

Hi Jianguo -

It looks like subflow->hmac is not accessed by any functions called from 
mptcp_finish_join(), and the selftests pass, so this looks ok for the 
export branch.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


Mat


> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c896803..554e7cce 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -433,15 +433,15 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
> 			goto do_reset;
> 		}
>
> +		if (!mptcp_finish_join(sk))
> +			goto do_reset;
> +
> 		subflow_generate_hmac(subflow->local_key, subflow->remote_key,
> 				      subflow->local_nonce,
> 				      subflow->remote_nonce,
> 				      hmac);
> 		memcpy(subflow->hmac, hmac, MPTCPOPT_HMAC_LEN);
>
> -		if (!mptcp_finish_join(sk))
> -			goto do_reset;
> -
> 		subflow->mp_join = 1;
> 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
>
> -- 
> 1.8.3.1
>
>
>

--
Mat Martineau
Intel
