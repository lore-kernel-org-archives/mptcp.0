Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8E3FCC
	for <mptcp@lists.linux.dev>; Fri,  1 Oct 2021 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633080928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62HnbEByMpo+5iYUyz8UqEO7WQkRy8RAvP2IpsNVBck=;
	b=JLV5ddK0lo9q4xDV/TjgnKNouH9f4jfrMtR1o+il3V9VXKZwU24pE9nkKCuBbWKBFXHaaT
	NqbI8Wqe8iJRlIIzhvm/q6j9Icvc9+mvHBlvWT10Ab8OWNQuQNKXHzFS2sRjW9Lm59LnLL
	NVIa1tYve1+l7kAMfIQ52T1X1jGk06M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535--m3bMdDsMbSL-i0GKKpUDw-1; Fri, 01 Oct 2021 05:35:27 -0400
X-MC-Unique: -m3bMdDsMbSL-i0GKKpUDw-1
Received: by mail-ed1-f70.google.com with SMTP id ec14-20020a0564020d4e00b003cf5630c190so9835758edb.3
        for <mptcp@lists.linux.dev>; Fri, 01 Oct 2021 02:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=62HnbEByMpo+5iYUyz8UqEO7WQkRy8RAvP2IpsNVBck=;
        b=EGOgLt8z6jIiO1hQgY1EZjNYG9m772RFs+xC4b5u4CFxSDgIl9uyeLuWGjsWld+KK3
         KnJqXkNcbe4kts7cjelxrotuo/gQTAhtSyT7SQZhFiRVphX6+nJw1Pz/zuYcjTcAkBtU
         xoSB8gJPMzj1x7J0TILEpq6N7A15dHWIWMmC+sozU2K5E62679to9V5161HKpdmdhGif
         XK4Iu3FSO0Csfo6th8j0lEmmBmDXO+cyhgpRNTt1K2316RiXs8xUBwsuvEz1gZ3ofr2L
         OZThMZbffgUtHxCEsyJEHr3a5IIrjPs+D7Ks7YFoE6jVtMocpWOIuPrWqAjlBFK/kOaz
         /o6Q==
X-Gm-Message-State: AOAM532l78qB6HE/asU3Y+0g5sGcASNVkk3UwXdWVzXJR8dPlr9qCEU1
	NoAwqCx/WkWMfOk0/fM01HXVKsjgAn9IyjkIHR2sbG+HWsPjAsLOvkN/Vh74cxDp1WViYab6l3t
	28wry3rxB57/UdrY=
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr5255982ejc.23.1633080926226;
        Fri, 01 Oct 2021 02:35:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR64401oRxVuEAIm4flgW54utF5jUXZZC1wDHVcs5AUPGuc3oGx2MuvnH0BRPHxu3M1GMk6Q==
X-Received: by 2002:a17:907:7704:: with SMTP id kw4mr5255970ejc.23.1633080926060;
        Fri, 01 Oct 2021 02:35:26 -0700 (PDT)
Received: from localhost ([37.162.39.158])
        by smtp.gmail.com with ESMTPSA id h9sm2730106ejx.78.2021.10.01.02.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:35:25 -0700 (PDT)
Date: Fri, 1 Oct 2021 11:35:21 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: pabeni@redhat.com, Stephen Hemminger <stephen@networkplumber.org>,
	mptcp@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] mptcp: unbreak JSON endpoint list
Message-ID: <YVbWWcM4wAVtbiED@renaissance-vector>
References: <b526544bc745535f72c76752bbd850df5a0ac2e4.1633004460.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b526544bc745535f72c76752bbd850df5a0ac2e4.1633004460.git.dcaratti@redhat.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=aclaudi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 30, 2021 at 05:19:25PM +0200, Davide Caratti wrote:
> the following command:
> 
>  # ip -j mptcp endpoint show
> 
> prints a JSON array that misses the terminating bracket. Fix this calling
> delete_json_obj() to balance the call to new_json_obj().
> 
> Fixes: 7e0767cd862b ("add support for mptcp netlink interface")
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---

LGTM.
Acked-by: Andrea Claudi <aclaudi@redhat.com>

