Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB92168
	for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624617530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWK9fNTV4SzzmMRjmNalbaAJKoO9K/DqhfP4qbh1Syc=;
	b=caxbD6r5L1WhUPESTgEH5QIS8O34VnixJV7A7GeXJMv9Z98g4RdVTwGTxHA0UJxEoPQSWz
	jcQBgjZkZ1Af6xYXQ2xcRmhUHzzux+c4BosaFWISg6trmRRaTX3hESdXsSXBkbGhzQ8swQ
	bHH4DGXtVqGemr/RBNc9MU0vjra4ckI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-4rtkehFyOLCUxFsGed50PA-1; Fri, 25 Jun 2021 06:38:49 -0400
X-MC-Unique: 4rtkehFyOLCUxFsGed50PA-1
Received: by mail-wm1-f69.google.com with SMTP id j18-20020a05600c1c12b02901dce930b374so2558514wms.2
        for <mptcp@lists.linux.dev>; Fri, 25 Jun 2021 03:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lWK9fNTV4SzzmMRjmNalbaAJKoO9K/DqhfP4qbh1Syc=;
        b=IfFHKT6IvzeuxQgTv8fotZEmmPruk0aN97BSbNxBfJBdUUzuP7Jhb+5dN06eEDuW7/
         yxxliF6fU1q0QicPrAqCelo9rjydO/a/BuiykGIHKGVrGTZwyaNdsUdYQoU+uEanRqNj
         Y3drlRY0PrijQ2ouKcK4YKl4LPKAGJHWZ4PEZRWLIjiFAo6ykdJ1fCln0C2/jaAilu/q
         SqFahsrg138H75QEqpoPAmvT+0TwYMWgEeierYLzrqbCDyCil6msoGwBj035ZgKr/shl
         /BTsE1ED0PlDbwFn3tAon+mDNNi6Z+Qa6FqT21WVjyoLuG+l2zcPboDi35Z37yGD+a/1
         ILdA==
X-Gm-Message-State: AOAM532m0nm6ny1tYk9q+ivPofDe+c1HD/RQAwztDdR8CV27HzxwfSPE
	v1KuYOh7sAqLQPeSY03IGXL6lBpPPsRZjwERhvBezfIo+14X/YiSXurkjKJhUyMn5NjRhckZ+J1
	I0LnomZXUEFSTM/s=
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr9616254wmb.124.1624617528298;
        Fri, 25 Jun 2021 03:38:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrh4ryKMb4CLFPeBbCunAK8cGyzofsFV6pQZvBOY44SutoXveHuy3iegwveZYWjqlHIXjo6Q==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr9616247wmb.124.1624617528166;
        Fri, 25 Jun 2021 03:38:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id v5sm10948933wml.26.2021.06.25.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:38:47 -0700 (PDT)
Message-ID: <7098df8ab1e07082636b7f794d7c47f2207fc680.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v7 4/5] mptcp: avoid processing packet if a
 subflow reset
From: Paolo Abeni <pabeni@redhat.com>
To: wujianguo106@163.com, mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com
Date: Fri, 25 Jun 2021 12:38:46 +0200
In-Reply-To: <1624609559-6786-5-git-send-email-wujianguo106@163.com>
References: <1624609559-6786-1-git-send-email-wujianguo106@163.com>
	 <1624609559-6786-5-git-send-email-wujianguo106@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2021-06-25 at 16:25 +0800, wujianguo106@163.com wrote:
> @@ -1035,12 +1037,14 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>  	return hmac == mp_opt->ahmac;
>  }
>  
> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
> +/* Return 0 if a subflow has been reset, else return 1 */
> +int mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>  	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>  	struct mptcp_options_received mp_opt;
>  	struct mptcp_ext *mpext;
> +	bool subflow_is_rst = false;

Additional small detail: please use the reverse xmas tree order for
variables definition.

Thanks!

/P

