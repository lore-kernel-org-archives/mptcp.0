Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDA2F22
	for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670864599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pFwLfjn4M82+beG/9ywtRyGj20/ygWkDftLRU7UE0NI=;
	b=OlLRR5zz3uTrU04xSCzWNDT/XNcR8LRifkH1kBNYA+v1gvuWVF5tIR5fohQQ2GEP9JdKEp
	betathVPrga5Fl7NfpJXLHeuNFIltyM69QGF8Af5pvwaWrcvO3mZxh0GuTIAb3KOs3w/lY
	8TMjTO3LHA5+gX1z1u2PfAqyQfllMjo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-8vr__OavN2GbTpdeTS2U-g-1; Mon, 12 Dec 2022 12:03:17 -0500
X-MC-Unique: 8vr__OavN2GbTpdeTS2U-g-1
Received: by mail-wr1-f72.google.com with SMTP id e19-20020adfa453000000b0024209415034so2399415wra.18
        for <mptcp@lists.linux.dev>; Mon, 12 Dec 2022 09:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFwLfjn4M82+beG/9ywtRyGj20/ygWkDftLRU7UE0NI=;
        b=pE00jVyrrVcysXW4bzUVUBhhxumk3rCuGohgTIillzoMOk7HGeLzDk/PYvv5i4IxCk
         l2SlmJJzKzHE+jNJ96CMiT+XNyxX5+lTLR4K/DJ2r88/3gK6EiAjQikcTPVowds9H/j2
         XrWJ0ZceLlhrxtH+Ir3wl4uQZXkQuIDoGDKJdI+QXsQimP0t9f52vRYu/uFmApi3kqyW
         JShgkxD54gLbVPghiCMvY6VqkABkoVFos0+mM4caKRRpuy4iUNGnVhK61dYH/Uen50fp
         IW4Zq7RccEWQryP/G/bCmPdpmT6UeiO5/pMf7qHVIe16EnmkrYq6c0Rcn0oBHyCaIx9R
         GgzQ==
X-Gm-Message-State: ANoB5pnMSZS2h7HlBZ08oFsdTXrQS5KoLjCzVZdTnL9AOPlGRT7R9ofe
	LISFU/7u76/Xg/yirjeJp7olflxKCXzjlJuzrnC8fu22y7nF8nePn4kH1OKOSo6rs+W/0puLeu1
	7sGptUAV8S/JReR8=
X-Received: by 2002:a5d:4586:0:b0:242:1522:24a0 with SMTP id p6-20020a5d4586000000b00242152224a0mr10760332wrq.47.1670864596756;
        Mon, 12 Dec 2022 09:03:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6gwCv4fpAi6OAPQuCNHfQaPkCCRYnQLBfunnSfrdPoeUBy+IwKSoo7uhcdjqHZH+/+eP2Urw==
X-Received: by 2002:a5d:4586:0:b0:242:1522:24a0 with SMTP id p6-20020a5d4586000000b00242152224a0mr10760314wrq.47.1670864596545;
        Mon, 12 Dec 2022 09:03:16 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-87.dyn.eolo.it. [146.241.97.87])
        by smtp.gmail.com with ESMTPSA id l5-20020a5d6685000000b0024194bba380sm9378505wru.22.2022.12.12.09.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:03:16 -0800 (PST)
Message-ID: <2fd384f250890912c039a23b2992b02fd4e313b3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp
 socket in use
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Mon, 12 Dec 2022 18:03:14 +0100
In-Reply-To: <20221208024543.113633-3-imagedong@tencent.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
	 <20221208024543.113633-3-imagedong@tencent.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 65430f314a68..54064146175f 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -175,6 +175,9 @@ int mptcp_token_new_connect(struct sock *sk)
>  	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
>  	bucket->chain_len++;
>  	spin_unlock_bh(&bucket->lock);
> +	sock_prot_inuse_add(sock_net(subflow->conn),
> +			    subflow->conn->sk_prot,
> +			    1);

Whoops, sorry for not noticing the above earlier...
Here it would be better rename the mptcp_token_new_connect argument to
'ssk', and add a new local variable:

	struct sock *sk = subflow->conn;

and replace the '(struct sock *)msk', 'subflow->conn' above with 'sk'. 

Side note: the kunit crash is due to build_icsk() being too naive: it
creates a completely zeroed inet_connection_sock, while after this
patch mptcp_token_new_connect() requires that the sk_prot field is
initialized, too. 

The issue could be addresses with an addtional chunk in token_test.c.
Note that for token's test sake, sk_prot could be initialized to any
available/already exported proto.
---
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 5d984bec1cd8..3bffe8d0d36f 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -36,6 +36,9 @@ static struct inet_connection_sock *build_icsk(struct kunit *test)
 	icsk = kunit_kzalloc(test, sizeof(struct inet_connection_sock),
 			     GFP_USER);
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, icsk);
+
+	/* be sure the tocken helpers can dereference sk->sk_prot */
+	icsk->icsk_inet.sk.sk_prot = &tcp_prot;
 	return icsk;
 }
 

