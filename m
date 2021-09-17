Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1772F80
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631899730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IRX1cmUc1GC0I7v6XkLpxR1/n2INUJQ0FPY/9UWsls=;
	b=F8s1QnSf1la2P9GkaMyj0V88mtry+DTuXlyYV/MuCtxIkTN7t8HTgc3fyXIZh5u3eiMGLl
	SnPoRdNiu26vWiCl4pQstcvGUm2teeU6eniU++ZnIOCEdUD/57KiYjjCpiBEo9lQHXCbyC
	Y9AtjocAVNcR49I/5wJEhHQIkJRUpOA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-JlZEqlelORa8VpUJ8nkVcw-1; Fri, 17 Sep 2021 13:28:49 -0400
X-MC-Unique: JlZEqlelORa8VpUJ8nkVcw-1
Received: by mail-wm1-f69.google.com with SMTP id v21-20020a05600c215500b002fa7eb53754so1904226wml.4
        for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 10:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3IRX1cmUc1GC0I7v6XkLpxR1/n2INUJQ0FPY/9UWsls=;
        b=1en7+wvz/qoBL8w5JIuPB9S+9nfK2i5RSs/PkdwsafgyDhFFN+y1memdinHOsVAbzS
         aOjoYiPIOC7C8JdGYOef1dpzxVLs7NZoS1B5LTtWoLCCkRNQy5YRt50/qQrjvg6juMtl
         OgrY22tOpr8AVMcndVyUq6frtXV0Om0E/HvWqe90W55VtRKBU0bst6WgbS5OZGr2/G7B
         urBAMvKQ3tQ7rI3CzK+htgzMWX1bIDcdgmi9nM5voxxB5/CagLlwujQZxoc8C81f8b3G
         HReQ7nmcsacbNciXF1ObgjXYPGacSjCScIvyUkooS1vS+rHsrR8lXFuU/LkGct4EIl0j
         stAw==
X-Gm-Message-State: AOAM5313oi3HOfghkFo2oQx0j0b123ycA78NXADcauIy8CVUlUdcQSs2
	0YTLhrH6nSi3si68UVqDOmr1VK6oHMuoo6Y7nXjTLgEbcxSwfiT/dTTjhcWbwWOnMPZFrjfriwh
	G308BreMPgW3iBro=
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr1364221wro.99.1631899727780;
        Fri, 17 Sep 2021 10:28:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxniqIFXAelxLq2YgBdQk87/U3PVNKwu+CMo2ZSw+eAmh/dOxt56bsCiIunhEKJO9oRh6UuXA==
X-Received: by 2002:adf:ecd2:: with SMTP id s18mr1364206wro.99.1631899727526;
        Fri, 17 Sep 2021 10:28:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-134.dyn.eolo.it. [146.241.244.134])
        by smtp.gmail.com with ESMTPSA id z2sm6751959wma.45.2021.09.17.10.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:28:47 -0700 (PDT)
Message-ID: <c8fb99f0f01ccbf125b4263d954703a6b4f13b5e.camel@redhat.com>
Subject: Re: [RFC PATCH 2/5] tcp: expose the tcp_mark_push() and
 skb_entail() helpers
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Date: Fri, 17 Sep 2021 19:28:46 +0200
In-Reply-To: <CANn89iJOtSJ8JFCThtxjRpZQ9Q44LTs-dDxypEA6Hkho9KdxWQ@mail.gmail.com>
References: <cover.1631888517.git.pabeni@redhat.com>
	 <07fd053d2c2239e70b20b105ff6f33d299dabea7.1631888517.git.pabeni@redhat.com>
	 <CANn89iJOtSJ8JFCThtxjRpZQ9Q44LTs-dDxypEA6Hkho9KdxWQ@mail.gmail.com>
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

On Fri, 2021-09-17 at 09:43 -0700, Eric Dumazet wrote:
> On Fri, Sep 17, 2021 at 8:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > They will be used by the next patch.
> > 
> > Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > 
> 
> OK, but please rename skb_entail() to tcp_skb_entail() :)

ok, with that will also drop patch 1/5 - no more needed.

Thanks!

Paolo

