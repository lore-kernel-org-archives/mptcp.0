Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5170
	for <mptcp@lists.linux.dev>; Thu, 20 May 2021 21:56:38 +0000 (UTC)
IronPort-SDR: lx4Vt9YnnTGr8iiIBTFRu8po2Q81JFbU+BEzRbCfVKJPyng/sHJN1cJwEmKQZ1CRLl7X4U11+g
 +StYBGSylZrQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="188476098"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="188476098"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:56:37 -0700
IronPort-SDR: x0vu/2B1YJa/um6VYujWefqoleKdP9uiHCyDSwgBOBxB/oMS7AbEeUWpDyI7j2JPckfQKM+hEO
 9AAhyWUOfcBQ==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="628370343"
Received: from srfejes-mobl4.amr.corp.intel.com ([10.209.82.208])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:56:36 -0700
Date: Thu, 20 May 2021 14:56:35 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: generate the data
 checksum"
In-Reply-To: <ae2099811b8395f7718855c5c7d412b26d960c95.1621321549.git.geliangtang@gmail.com>
Message-ID: <17b67263-42e6-3420-7a8e-de37d87e6fc3@linux.intel.com>
References: <ae2099811b8395f7718855c5c7d412b26d960c95.1621321549.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 18 May 2021, Geliang Tang wrote:

> Move this line "__wsum csum = ~csum_unfold(mpext->csum);" from "mptcp:
> validate the data checksum" to "mptcp: generate the data checksum".
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 38ce8d50e665..58253bd09f93 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1311,7 +1311,7 @@ static bool mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk)
> static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
> {
> 	struct mptcp_ext *mpext = mptcp_get_ext(skb);
> -	__wsum csum = csum_unfold(mpext->csum);
> +	__wsum csum = ~csum_unfold(mpext->csum);
> 	int offset = skb->len - added;
>
> 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
> -- 
> 2.31.1

Looks good, thanks Geliang.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

--
Mat Martineau
Intel
