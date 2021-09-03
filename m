Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71272
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630689511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TUiVDQxciKeAEZvszhQCh3ytTH/NQeKgzLN19Mjnzk=;
	b=KXiz0dQ99fxLj/w6CnHmluFs0HXNQC4CQg5Gawrp+2k0Ulxsk91j0ARuQrzNM8+Tp4yfdl
	ax2Z1CkGq3NY8Hu4fbmMiJG7TNz2Ej1/nHeijTolOBZ6o7UCGt507cSYCjgONUBm93s4d2
	2Oz0ZfCdr+CaxI687K5+7rBfpE3jukI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-sB0eEXgtMu6aNcaUyBvu-A-1; Fri, 03 Sep 2021 13:18:30 -0400
X-MC-Unique: sB0eEXgtMu6aNcaUyBvu-A-1
Received: by mail-wm1-f72.google.com with SMTP id p5-20020a7bcc85000000b002e7563efc4cso12319wma.4
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 10:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8TUiVDQxciKeAEZvszhQCh3ytTH/NQeKgzLN19Mjnzk=;
        b=pt/FwQAswPntWpTI3Vx/rTiqUqOR6QvB1GlYSUfk+UyULPtfGu35YuxFLQWNgF+mks
         RttqmpcIsdgGWBz6J2psTwmc2VWjWJFYhzp4zppvHEq+6b4mB1180mftN2DZgsMpYQEV
         4qkKn52t+TClAhg84b/MZXnIP4MxSOvTHFdFANxLa1+LQigKpMuGhBpmJeuEKDX3Ihlr
         8Wt+TNmQtyqRiSxweLSXZaLJ80V/4/CuYYeCGwQBee5hMkugotPGwfNAnm2H/ej/3/AL
         2clIOJG18kpWaZ/HWlXTn2J7ORqF5/7GhoHROh/L+cnAzbUEg0hnxGn7SZrL0wUkruRG
         zRKQ==
X-Gm-Message-State: AOAM530KojMWtLgbt3x63vfKtn6brREgsa//Czb8PzqUrKjEBvfp2iEk
	WdSfSfUl67/mNubuC3MikEyF1RRMRRz3eb0VRvDTjtwzWDkwYx50HR0UcunOZG7OHEzZhfmSSRG
	ldjQoi9ekfNchmnc=
X-Received: by 2002:a5d:554e:: with SMTP id g14mr186514wrw.48.1630689509528;
        Fri, 03 Sep 2021 10:18:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhk1sRsh8U8CRZkVduw0cs7nTPdPOSY9QjVCOYJDz90qVxz9bWToEUVd4yUZXOgwXg5gRpYg==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr186489wrw.48.1630689509254;
        Fri, 03 Sep 2021 10:18:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id t7sm5866933wrq.90.2021.09.03.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 10:18:28 -0700 (PDT)
Message-ID: <fc52b567c60d4908a148dee8fd08c3d6b3ff3454.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Fri, 03 Sep 2021 19:18:28 +0200
In-Reply-To: <f01b372a-7145-3df4-6958-0eba522af05b@tessares.net>
References: <cover.1630595171.git.pabeni@redhat.com>
	 <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
	 <f01b372a-7145-3df4-6958-0eba522af05b@tessares.net>
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

On Fri, 2021-09-03 at 13:28 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 02/09/2021 17:52, Paolo Abeni wrote:
> > We want to revert the skb TX cache, but MPTCP is currently
> > using it unconditionally.
> 
> One one small detail if you have to resend a new version: for the title,
> s/relaying/relying/
> 
>   mptcp: stop relying on tcp_tx_skb_cache

I guess/hope a repost is not needed, would a squash-to patch and/or
direct edit while merging be enough?

Cheers,

Paolo

