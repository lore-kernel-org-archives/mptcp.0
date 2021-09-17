Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05623FC3
	for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631899868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEhlSynRz4N3FlqjKloHS3Kh6FbRHHHviXrUI8c+7hU=;
	b=La/oUu1y450HncR6ZrR0YLrD8Lo0qf67NyXPqf9RC2+kgzZe+k4W9/L+2DtUXLxTEn2aNt
	1BmE3BFkx+cTUrY/070W6OQG089Z13ESuSiieowYx/NWPTWZB2WNuViizdjnrnIcfPkfsf
	h/GVHC/Oc0BZkdCzFEht7reSvfos5zY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-UTCX1VJlMQ-4f0VUtPs-Vg-1; Fri, 17 Sep 2021 13:31:07 -0400
X-MC-Unique: UTCX1VJlMQ-4f0VUtPs-Vg-1
Received: by mail-wm1-f71.google.com with SMTP id l27-20020a05600c1d1b00b00308ef9d8a98so3312455wms.9
        for <mptcp@lists.linux.dev>; Fri, 17 Sep 2021 10:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=aEhlSynRz4N3FlqjKloHS3Kh6FbRHHHviXrUI8c+7hU=;
        b=LqYafL3qR1MXELat8XPnsq8DWuuX/uZiZyMqJLouELWy/nAjW6Y2OEyTgwqsOiliSY
         DpOWcBa8Vdtdd1MXXLN/nbl5rHzshT9BK3ldJ/mXipN8u0uw3Ttp8RhBKiMCGdaFHWMk
         h9CKFzIsonT8K/GvVUxx+pT1AmgvgXHgUnPfz8x7Pq3FSyjxiGc7qg1zqcfH1XRZ3GiW
         ij6yykcDwGX6AlvoJJ+AshuEhJyYPHJyJZsDOXZQweBDvveSyDsmPYhDU8nf3yAx71Qo
         bc/qvSMDXXr/D+dhuZy2W8RUtBlAwork8umXCUl/dA8Jp2zx6n1f0GCv5Wx2FVb3Kf8z
         fBkA==
X-Gm-Message-State: AOAM531EXfQp/UGp5zCF2jVC5K37gd8jCyAuQSZMzJq88AmQauUfe+5T
	vbg+NcRi5aVZUk7T7J8g+1SPe0ZVFpPITKR/VYKpe2mftOpfZGsQLDbML/chMHannlIp0ruD2n7
	7kYyXv/mtAID+S6Q=
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr16611807wmc.3.1631899866388;
        Fri, 17 Sep 2021 10:31:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzVIUlMhzaUcH8l76E4hgTLORUq4B9hZOc19zV/fBmI/JkObBLUeLEOY5d8c74bW5TKIB7kQ==
X-Received: by 2002:a1c:f60c:: with SMTP id w12mr16611785wmc.3.1631899866185;
        Fri, 17 Sep 2021 10:31:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-134.dyn.eolo.it. [146.241.244.134])
        by smtp.gmail.com with ESMTPSA id a72sm11730585wme.5.2021.09.17.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 10:31:05 -0700 (PDT)
Message-ID: <ef20848328710215a2d237dbbab18ca953737c5a.camel@redhat.com>
Subject: Re: [RFC PATCH 4/5] Partially revert "tcp: factor out
 tcp_build_frag()"
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>, Mat Martineau
 <mathew.j.martineau@linux.intel.com>, Ayush Sawal
 <ayush.sawal@chelsio.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Date: Fri, 17 Sep 2021 19:31:04 +0200
In-Reply-To: <CANn89i+e7xVLia3epGLpSR70kxuTMyV=VtKGRp3g0m56Ee30gQ@mail.gmail.com>
References: <cover.1631888517.git.pabeni@redhat.com>
	 <aa710c161dda06ce999e760fed7dcbe66497b28f.1631888517.git.pabeni@redhat.com>
	 <CANn89i+e7xVLia3epGLpSR70kxuTMyV=VtKGRp3g0m56Ee30gQ@mail.gmail.com>
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

On Fri, 2021-09-17 at 09:41 -0700, Eric Dumazet wrote:
> On Fri, Sep 17, 2021 at 8:39 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > This is a partial revert for commit b796d04bd014 ("tcp:
> > factor out tcp_build_frag()").
> > 
> > MPTCP was the only user of the tcp_build_frag helper, and after
> > the previous patch MPTCP does not use the mentioned helper anymore.
> > Let's avoid exposing TCP internals.
> > 
> > The revert is partial, as tcp_remove_empty_skb(), exposed
> > by the same commit is still required.
> > 
> 
> I would simply remove the extern in include, and make this nice helper static ?
> 
> This would avoid code churn, and keep a clean code.

I thought you would have preferred otherwise. I'll make the helper
static in the next iteration.

Thanks!

Paolo

