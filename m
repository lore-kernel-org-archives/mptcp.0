Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82966E4
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 17:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663782089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hImlA0XVILJxSfyriap+rWo56t4zIGphnS0E2wGO3HY=;
	b=YnsyCW++kXxTGJUC68kwJYB0eYFcEi5jbvk05dFCaKzFQ1Sf0gHKXwyIN2Qg7V/7TK4svX
	jhZ+hkBn4rgq876hKoom3PbTxFbxIuaarUlY4sxoozHNOYtx9Oa/gV12JFjaGLT3G5/0Rn
	IMFNQCqaohEbM1+OweMwv9uav5x89Nc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450-_NYsBzu3O96DmahF2Gk3lQ-1; Wed, 21 Sep 2022 13:41:28 -0400
X-MC-Unique: _NYsBzu3O96DmahF2Gk3lQ-1
Received: by mail-qv1-f72.google.com with SMTP id f10-20020ad443ea000000b004aca9fabe98so4756733qvu.18
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 10:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=hImlA0XVILJxSfyriap+rWo56t4zIGphnS0E2wGO3HY=;
        b=MRwbZgj2eP2B2DqIr446qTrCcW8hIodaKeFbF/Ct8bdMQ/GLNM++Nnsu2VleXoWqb1
         tJzCjad6HxvIlBhRplJjPHGJHgbLZwLRlsodIxSUUE1B3rBKAeHjEMJwZObxoIwUqufK
         gJ1oGN8bb8qjGrhguyJpMYoWHYHVrfnyOkXfVPnc6mbL2bYgBkD+VSgTinqL+x08V4so
         mmSEDOjvedwhk+6xu4FB/QNeTqe1Rt/dEIkcfH4BegdBgYltZNu9btcgCTOlEJZyk8q3
         /lym4/PsMQpaGKiRJQQJMciZCxmHiCFb7DVlsUOQE+8ByTImvaG9f4aDOQ1Zoevs3y5w
         NL4g==
X-Gm-Message-State: ACrzQf1+QiKJVAD83XHoyYFMJQxbvF5pUHOo8ingP96wTQMGhGjhboy3
	lSV79pBlFxAZbtYgWvRDsubgEKaYNZOHG3bRJv1qoajzUGtgv5pm5NJJsnbDtiCw646fstOoNxy
	e4NWDSPLVtdZuUL0=
X-Received: by 2002:ac8:5b4d:0:b0:35b:b5fa:5e24 with SMTP id n13-20020ac85b4d000000b0035bb5fa5e24mr24863931qtw.163.1663782087804;
        Wed, 21 Sep 2022 10:41:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5dIv8jeXUJG7LBXdwBOxD9bJ1IhNeB9pHcttNc18/nNYudz501zGS1ItmqHewmr//LIKav2A==
X-Received: by 2002:ac8:5b4d:0:b0:35b:b5fa:5e24 with SMTP id n13-20020ac85b4d000000b0035bb5fa5e24mr24863909qtw.163.1663782087488;
        Wed, 21 Sep 2022 10:41:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id t15-20020a37aa0f000000b006cbc6e1478csm2103552qke.57.2022.09.21.10.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 10:41:26 -0700 (PDT)
Message-ID: <199358242e294a6463cb4f785fb3c5c54603bb8f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v1 3/5] mptcp: handle defer connect in
 mptcp_sendmsg
From: Paolo Abeni <pabeni@redhat.com>
To: Benjamin Hesmans <benjamin.hesmans@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 21 Sep 2022 19:41:24 +0200
In-Reply-To: <20220921152539.1851441-4-benjamin.hesmans@tessares.net>
References: <20220921152539.1851441-1-benjamin.hesmans@tessares.net>
	 <20220921152539.1851441-4-benjamin.hesmans@tessares.net>
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

Hello,

On Wed, 2022-09-21 at 17:25 +0200, Benjamin Hesmans wrote:
> When TCP_FASTOPEN_CONNECT has been set on the socket before a connect,
> the defer flag is set and must be handled when sendmsg is called.
> 
> This is similar to what is done in tcp_sendmsg_locked().
> 
> Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
> ---
> 
> Notes:
>     v1:
>     - error case use latest patch from Paolo (propagate fastclose error)
>     - I believe the use __mptcp_nmpc_socket(msk); is correct here (instead of
>       msk->first but would be nice is someone can confirm

Yep, AFAICS it's correct. 

And patch LGTM.

Cheers,

Paolo

