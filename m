Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FF3201
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655474511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELs17cfd1lDhoVsTo2eAIIwhzEnPSQSuQQJV/iUsSyo=;
	b=LNUG4tfcagBF9oelU5OeqkCsUq06wqwt3PS9ZuhC3c73jI0+S3/8ohvLHwlDEnk/6KzDUJ
	uTuBkzIYXHOd5BFzLp3zJcbtYRDseN0q1q4ExUP1CHd3F9pGkQTTUZRy2FHvdIUtAAtv0K
	QRndp17zFgxwRCysaoTtjoGjMuNktWw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543--Mf2WHAXMlSG21D6J-WeYQ-1; Fri, 17 Jun 2022 10:01:49 -0400
X-MC-Unique: -Mf2WHAXMlSG21D6J-WeYQ-1
Received: by mail-qk1-f198.google.com with SMTP id bm2-20020a05620a198200b006a5dac37fa2so5042391qkb.16
        for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 07:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ELs17cfd1lDhoVsTo2eAIIwhzEnPSQSuQQJV/iUsSyo=;
        b=MVGQxQF3GpcG+fJbyZryHCrdgdpBfnAZhuO4jPdtSA85aWVIq6GQUtWzPbPHowp8oc
         gWtwZh7Rurq5f2aHBthphVFUl7tcoQhq5gw9dQ62AVLxs1yTcQrb+pfK07RlgQXVCJ98
         DNJDauigTMd15LFOagM6JJquk20FFjIM0sLzZU28UVR5RU6lLMGctwDjecy0nIuLjJxn
         WnbHFmchgv1WJR+oyAjYHS0U0YyK2Fo2sIw+6ZYH37NAbEHiQ3GyQAWGL+31i95AxmLQ
         JXG+zMcVUhYO+6x1YKmyq7TNLGs0Lr3CWOHxB5JESpHwCPcEGC+HcjGPUu5zBfbDpJ6x
         J35Q==
X-Gm-Message-State: AJIora9c/kzQh07jwo2gHUPmBPT9UWmRAdP861Lr+Pv61W6/1377P2T5
	rpBuZEXVKJBlnX4HGUQia2Bed7xKZo31akhKOKvZrJQYtCGzDc0LBU9idbN8O/JCPCRQUZiysqV
	Pi3e4Sywy6sTagxXhwK+vWRrQ7sUCa5cMHk+UAL8JM8dcdj2PHeKuU8tBSVLOPgT/
X-Received: by 2002:a05:622a:1c8:b0:304:ea29:2cc1 with SMTP id t8-20020a05622a01c800b00304ea292cc1mr8565496qtw.261.1655474508860;
        Fri, 17 Jun 2022 07:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFLZIW6hvaKNqAP9Lorm2rK+uiNfN5K19TrTD6gA6AtazoO5VujhgdqFUIeXnnKqEJzFU2kg==
X-Received: by 2002:a05:622a:1c8:b0:304:ea29:2cc1 with SMTP id t8-20020a05622a01c800b00304ea292cc1mr8565446qtw.261.1655474508302;
        Fri, 17 Jun 2022 07:01:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id v1-20020a05620a0f0100b006a787380a5csm4751099qkl.67.2022.06.17.07.01.46
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:01:47 -0700 (PDT)
Message-ID: <3c73bf6e5c29fd1639a2ce0ccc93b06f5a49a335.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3 3/6] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 17 Jun 2022 16:01:45 +0200
In-Reply-To: <7b8fcd495f785d51cf87149826b0ce07cbdd1da0.1655460262.git.pabeni@redhat.com>
References: <cover.1655460262.git.pabeni@redhat.com>
	 <7b8fcd495f785d51cf87149826b0ce07cbdd1da0.1655460262.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-06-17 at 12:05 +0200, Paolo Abeni wrote:
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 98b12a9c4eb5..c82a9a6e0267 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1158,6 +1158,33 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
>  		return !subflow->fully_established;
>  }
>  
> +static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	unsigned long fail_tout;
> +
> +	/* grecefull failure can happen only on the MPC subflow */
> +	if (WARN_ON_ONCE(ssk != READ_ONCE(msk->first)))
> +		return;
> +
> +	/* since the close timeout take precedence on the fail one,
> +	 * no need to starte the latter when the first is already set

Typo here ("starte"). It would be great if it could be addressed
without reposting the whole series... A later squash-to patch could be
ok?

Thanks!

Paolo

