Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523342FAE
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 10:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622025736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RshO0dfv1PPJiGXYkWGwnCFKywXuNW7+t7tcLuLYNM4=;
	b=OedBF2uhu1hm0edPvWKZcAFsrHOMZl9IoS2ifEdiKvFWRWUGA5c5U7wnbYY8sYhuqlgsbK
	ii6fUKTbqBNnB2yYb44Kc9KzzcxeDU7n75ZD54JVMQEWhyr3f28oMo5gQPyWD6GXG/VBjs
	giWRx/T1OvI0hS+ZyC+FPEPTyK/Pzhk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-GAp10yc5O161cjKiCASobA-1; Wed, 26 May 2021 06:42:14 -0400
X-MC-Unique: GAp10yc5O161cjKiCASobA-1
Received: by mail-wr1-f71.google.com with SMTP id f15-20020adfdb4f0000b02901141a0606bdso190839wrj.17
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 03:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RshO0dfv1PPJiGXYkWGwnCFKywXuNW7+t7tcLuLYNM4=;
        b=ldOtLQyBmUNo7S5VOVVVNCeCQyzyGSSDmkaDT/ccsmZKnxKbwOcOD9dfsqd2ELe5Qs
         nk56md9FTjC7xawgc8zpeSOMIJLx/7m9Gu1Yp2DLMFIt7ggKBkSD8vBURek46Ey21gsl
         +7Xm/restyJ9MIa1t2LEbhcyRmfH8IKtZRvkocGBbORU64iwRMilAUcARoJwKQh090J9
         auYbD9TUpCiH3xGiol1FtSBsRtHcp+V1yDR2QuJX/GUAsXnohX1ax04SIV4LoJud1Y02
         gFJVpiZ4pJCQbazJhS4KPR081oZsB9OCNtf5l8/QHOa/AjojEVXAH0ye9RjF63goQkZB
         +VZw==
X-Gm-Message-State: AOAM5313BVTw52KixlRyaZuhNAraURRkE0ZE4F2HMgigu8Wewl7TgGA9
	Qu3GQKypqbV8ZeX79mkHUwH1w/4FFZsPt2kU38BO+WD+vuOPp2nwrRJ8UEZVoujgVr9lLm36uCi
	8vFGWjFBA6+/Jdew=
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr28097717wmq.83.1622025733001;
        Wed, 26 May 2021 03:42:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZtQa/YYI/fzeXkIdCa1+hFIgio0Y4AHZAR9EoWto4q2f4lTU2XatiItF/6fbMydZYi8Zf1g==
X-Received: by 2002:a05:600c:4fd6:: with SMTP id o22mr28097690wmq.83.1622025732748;
        Wed, 26 May 2021 03:42:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id a11sm19952004wrr.48.2021.05.26.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:42:12 -0700 (PDT)
Message-ID: <e3a303f94c9d2c186db80514c0d5e715f583b6b9.camel@redhat.com>
Subject: Re: [RFC PATCH 4/4] mptcp: cleanup mem accounting.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Wed, 26 May 2021 12:42:08 +0200
In-Reply-To: <f6cdc34e-67a2-ada2-1c49-b07e3af18145@linux.intel.com>
References: <cover.1621963632.git.pabeni@redhat.com>
	 <db1629617d1d6bc841f12a56a781e29a6ba6317f.1621963632.git.pabeni@redhat.com>
	 <f6cdc34e-67a2-ada2-1c49-b07e3af18145@linux.intel.com>
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

On Tue, 2021-05-25 at 17:12 -0700, Mat Martineau wrote:
> On Tue, 25 May 2021, Paolo Abeni wrote:
> > @@ -296,7 +281,7 @@ static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
> > 
> > static inline int __mptcp_space(const struct sock *sk)
> > {
> > -	return tcp_space(sk) + READ_ONCE(mptcp_sk(sk)->rmem_released);
> > +	return tcp_space(sk);
> > }
> 
> Minor - looks like __mptcp_space() isn't needed any more either.

Exactly! I *guess* there is also some other additional follow-up
cleanup, but I stopped here to avoid this thing becoming too big.

Anyhow I can add the above as an additional patch.

Cheers,

Paolo

