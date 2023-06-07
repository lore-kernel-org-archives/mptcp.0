Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83B63B5
	for <mptcp@lists.linux.dev>; Wed,  7 Jun 2023 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686156680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YT6nTMBFmvz1z0u9NH6m0nF6Xtd6hiypqMLIETwg1to=;
	b=R8xomKSR2/kPpO0yVMpFEGHxjpjseyOlg6EFtd2APi4b9q/Fiwc7aSF0aTjWsCAApj+3m0
	4t9nxcIIQwlWeg5tWQZPoX/pvQCO+i19ktWCzScXqD+zjELRpPSvrKxrGvIoIQQvu4eHKA
	2lYxaiRo3YNZW4XYvnnOGfNa28pIlIs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-rx7tvskyNXWIflHczCArsA-1; Wed, 07 Jun 2023 12:51:19 -0400
X-MC-Unique: rx7tvskyNXWIflHczCArsA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30ae86cb43bso644324f8f.0
        for <mptcp@lists.linux.dev>; Wed, 07 Jun 2023 09:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686156678; x=1688748678;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YT6nTMBFmvz1z0u9NH6m0nF6Xtd6hiypqMLIETwg1to=;
        b=ThqdsnHkgyGyve50lImxZv0VkFIt9DpUNK8JAbC29FB8uhPip98VG6+jDSdinQC76S
         WdeF3bBLYXUjMSDRhiS7TlNQFNC7gsCDtJV87aubn+aK1KxGKuIfgN3xfnrFLsU7nfhH
         7XxH8HpR14KaIghwyvNd56Ni8RrM/4HXIJePYkIes5fAotmtV5i9dDBypns69h+sWKjG
         wg/LL0CdnKwzQqwzw0MYUz/1baWMnDLVgy7fNvrWEdaMvNX/OBdq1iijfefObK6DX8CV
         hU506KJLxH8iA6B+xWeCLWdYO6Q1LkHjcwRS94XEfMCmG1OCAIEJzIRLgHoz7dkkioQ5
         ObOA==
X-Gm-Message-State: AC+VfDxetfillA39HnGEZnuIM/9YPRzDUyu3rPH48fQc5hcG5mLXTUCw
	ePgs2CUR5EW6jygKdYAWgoisYkqPVgOra1SIRYWNzpjRLRVQNN8UhrSrI7GTcJKmTpP0XDMZIJK
	Q1jlpQ1DoYAb8XQYYxpeVpTw=
X-Received: by 2002:a5d:6552:0:b0:305:f3c1:184e with SMTP id z18-20020a5d6552000000b00305f3c1184emr2260630wrv.3.1686156678143;
        Wed, 07 Jun 2023 09:51:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6P+066cFHbUPyC0csgcRGkE0Bbr6kno5ZrBmahI6K95AX5toIqENc5wMwl2NgJMrz4HF5aoA==
X-Received: by 2002:a5d:6552:0:b0:305:f3c1:184e with SMTP id z18-20020a5d6552000000b00305f3c1184emr2260619wrv.3.1686156677842;
        Wed, 07 Jun 2023 09:51:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-199.dyn.eolo.it. [146.241.247.199])
        by smtp.gmail.com with ESMTPSA id h8-20020adfe988000000b0030ae5a0516csm15976333wrm.17.2023.06.07.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 09:51:17 -0700 (PDT)
Message-ID: <06db7e43fa61a58c0a45a9ed8fda84e32b987d7f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v7 11/19] mptcp: rename __mptcp_set_timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 07 Jun 2023 18:51:16 +0200
In-Reply-To: <77d5821d9815607ba1ca392e9bfa100675bdf404.1686127032.git.geliang.tang@suse.com>
References: <cover.1686127032.git.geliang.tang@suse.com>
	 <77d5821d9815607ba1ca392e9bfa100675bdf404.1686127032.git.geliang.tang@suse.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2023-06-07 at 16:38 +0800, Geliang Tang wrote:
> __mptcp_set_timeout() is needed to export in BPF context for bpf_burst
> scheduler, but the "__" prefix cannot be used. So this patch renames it
> to mptcp_set_timer().

I'm terrible at picking names, but I would go for mptcp_set_timeout()
instead.

Cheers,

Paolo

