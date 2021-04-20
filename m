Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB42F83
	for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618920277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKGAflKD57t3s9fOUr4KWXh5mLGzQJlJzkiWP2Qfr0A=;
	b=eSgpxJQnTfYtMA0BWNZ11lsWj6JdcXgjP77n5C4cxFE+OHIvaLlC7XGWrqRU+Voqz2g3e1
	TMJ/Ld+PHqAS5dxuCm+KKmomIGYB+PUFJ+X95sWEO8P34uXOlxFXRFBAlG3kaX+0JEWiqH
	EmmPm0Z58sJboDoNHsYaMcnE9trfAcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-HI2S2mn0OcGGSfeNz2W5jg-1; Tue, 20 Apr 2021 08:04:35 -0400
X-MC-Unique: HI2S2mn0OcGGSfeNz2W5jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A591107ACE6;
	Tue, 20 Apr 2021 12:04:34 +0000 (UTC)
Received: from ovpn-115-47.ams2.redhat.com (ovpn-115-47.ams2.redhat.com [10.36.115.47])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B3F92B9FA;
	Tue, 20 Apr 2021 12:04:32 +0000 (UTC)
Message-ID: <1536d28e48503b9308f4f406e545ad0699c5714e.camel@redhat.com>
Subject: Re: [PATCH] mptcp: fix pr_debug in mptcp_token_new_connect
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	Florian Westphal
	 <fw@strlen.de>
Date: Tue, 20 Apr 2021 14:04:31 +0200
In-Reply-To: <5533e6e3-b94b-4fdf-a4b9-a4fcda4ec09e@163.com>
References: <5533e6e3-b94b-4fdf-a4b9-a4fcda4ec09e@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-04-20 at 18:08 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> After commit 2c5ebd001d4f ("mptcp: refactor token container"),
> pr_debug() is called before mptcp_crypto_key_gen_sha() in
> mptcp_token_new_connect(), so the output local_key, token and
> idsn are 0, like:
>   MPTCP: ssk=00000000f6b3c4a2, local_key=0, token=0, idsn=0
> 
> Move pr_debug() after mptcp_crypto_key_gen_sha().
> 
> Fixes: 2c5ebd001d4f ("mptcp: refactor token container")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/mptcp/token.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 8f0270a..72a24e6 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -156,9 +156,6 @@ int mptcp_token_new_connect(struct sock *sk)
>  	int retries = TOKEN_MAX_RETRIES;
>  	struct token_bucket *bucket;
> 
> -	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
> -		 sk, subflow->local_key, subflow->token, subflow->idsn);
> -
>  again:
>  	mptcp_crypto_key_gen_sha(&subflow->local_key, &subflow->token,
>  				 &subflow->idsn);
> @@ -172,6 +169,9 @@ int mptcp_token_new_connect(struct sock *sk)
>  		goto again;
>  	}
> 
> +	pr_debug("ssk=%p, local_key=%llu, token=%u, idsn=%llu\n",
> +		 sk, subflow->local_key, subflow->token, subflow->idsn);
> +
>  	WRITE_ONCE(msk->token, subflow->token);
>  	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
>  	bucket->chain_len++;

The patch LGTM, thanks.

Paolo

