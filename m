Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2982FB4
	for <mptcp@lists.linux.dev>; Thu, 27 May 2021 10:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622110886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oEUqipkLl1FNMYPP2vz0n3OCmqL4juLys6BqKfiX6So=;
	b=Q9ckD8Kl4tgp0vRWFdVxyYRs69W47SOlOnnZhp4nDfAIyEAUepviwyUaPzX+Q1rLZFAkZu
	3d49J9mBk+LkzPsChiI0RXCGLhwXc/ionksNWzfA6qEZABwo6K8S1RlCBcPWeaFHn2M5fF
	r/kQufVhXFFCOUXOQTmeO4g6l7hpOJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-mJTTVDMoMFq9yFbIeM9Y3Q-1; Thu, 27 May 2021 06:21:24 -0400
X-MC-Unique: mJTTVDMoMFq9yFbIeM9Y3Q-1
Received: by mail-wm1-f70.google.com with SMTP id c13-20020a05600c0acdb02901959ebbf314so309361wmr.9
        for <mptcp@lists.linux.dev>; Thu, 27 May 2021 03:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oEUqipkLl1FNMYPP2vz0n3OCmqL4juLys6BqKfiX6So=;
        b=TrbDW/PU+1C1XJ3Yq8VgjT57kggjCDytbJ0sWyuwvVPKwbIxAVAj5X+Nt9SekaOe1V
         U1o7zVQGidueRpddku2HlIIn6JgaSIBNZdbNAQNpFzItjsxTpyZWIvS4+Pr5sD3LeAc9
         g50UFAEZOtpBH0OP6zKFA8v0Vgn74nJDDKuOHyzv8zHRJWeJEkzsYEzoDf2zb7Z47CL6
         L4mIvzzgbzZhG+dWdjDKlCX7aYZcry8OZpqdYXoL8tZ7Tt3YUPkhp9tsSl5n+Ay8/GPB
         YbN/yxYKGVbm+5dYUUpKKmDsm2zjkFrxbeYCAH2SUjMPHOoa77vp7uEOSI7/2G//+e54
         A7Ew==
X-Gm-Message-State: AOAM533cwuTXhqhiVwIbDkCGn/3pBVhbp5GfsPWPk/CllU5OlUM+vTwc
	ZfhfoqjhmyER2CqUkBvG8Y9P+FJYe6bxH25zqt9xJBG+r+WS0IH/DgHXO7G9fbQ4vD/Z78Uw4MP
	aRAss8yiIIudTVAc=
X-Received: by 2002:a5d:4910:: with SMTP id x16mr2558244wrq.112.1622110883165;
        Thu, 27 May 2021 03:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO1hhQWKkUITol7c311g22T7qTM8hc4zSljtlIm8cS67mlWBGgDYtSrVJ7AAiLKE2UXR9F3g==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr2558229wrq.112.1622110882957;
        Thu, 27 May 2021 03:21:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id q1sm10052078wmq.48.2021.05.27.03.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 03:21:22 -0700 (PDT)
Message-ID: <332ec1a360c4e0c7c3465c7c36262ab0f6d4ecd3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: use fast lock for subflows when
 possible.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 27 May 2021 12:21:21 +0200
In-Reply-To: <1a3dec37-9b54-e6ba-ca36-db5ed7f6ebb4@linux.intel.com>
References: <f18ab6d96263347de227dadcef3aff102f682ab9.1622045130.git.pabeni@redhat.com>
	 <1a3dec37-9b54-e6ba-ca36-db5ed7f6ebb4@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-05-26 at 21:19 -0700, Mat Martineau wrote:
> On Wed, 26 May 2021, Paolo Abeni wrote:
> 
> > There are a bunch of callsite where the ssk socket
> > lock is acquired using the full-blown version eligible for
> > the fast variant. Let's move to the latter.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > The previous patch demonstrated that using lock_sock()
> > were the fast version is available can have worse side-effect
> > than slower performances.
> > 
> > This tries to address the topic.
> > ---
> > net/mptcp/pm_netlink.c | 10 ++++++----
> > 1 file changed, 6 insertions(+), 4 deletions(-)
> 
> Looks good to me, thanks Paolo.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

I'm sorry, this get mangled, some more needed chunk slipped in another
local patch. I'll send a v2 with more fast_lock()

/P

