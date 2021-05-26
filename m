Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E4370
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622042604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtFCqLj3Jkq8gVcN0ULqvqWR/taIyAiEdqDilsx+gIE=;
	b=MwoKqkZ53R2BK/39dZ6kzhUVx7adjpDGFxlfpcCVNWD5baKkTHRIan0JC4A43vtyVq/k0F
	jFf8/vi9mjzsh1peoENfMfyqx17/RZj9RyzHcyYtOVL7hFjXnEjDdAk+4wtPHlXlZzmKPi
	vfj/hxEjwDTjLI20QDOk9VRl6iPBsQs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-fDCVRTGrNaixs_Atdvthww-1; Wed, 26 May 2021 11:23:22 -0400
X-MC-Unique: fDCVRTGrNaixs_Atdvthww-1
Received: by mail-wr1-f72.google.com with SMTP id 2-20020adf94020000b0290110481f75ddso503438wrq.21
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 08:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MtFCqLj3Jkq8gVcN0ULqvqWR/taIyAiEdqDilsx+gIE=;
        b=hKSE+2YrpnnSM2by1F4x7GXnUI/6/8iqYKZuTPpK1jKiAD3BeDDIGeyp62ufaAk2UH
         oXDsnSUk/y8vc3i5eI5rNor16jzPD/o0bmWoriE9FswHDocGbdaCCTEzel1xYbbP3uTd
         +QAUQS9ckJHIZ0L8yB0Wb+hFaQXVOQQ5HoMiosMeY/1/JdDcmiUnnuqQm2lHOAqHZn67
         RvD0YNGNnCX/gAImEv+v8DpSzLNC75CR7MweJUyHIA/E8NeBV+zbF950X2dwcpsxBeN/
         /ZB8BExFBiaDa3Aa016wYUF9A/jSfBUqlUOg/lq4x+gWK0joKmXaw0C8lmHvK6GcGmbl
         Dp5A==
X-Gm-Message-State: AOAM531xnjcEMBW0wTqvH1dfMHn9BGOpuc2/l+Ut79UIa6nyT3IMua9e
	Hu0/iDdyiSvLVpdaVWEOK6Df+nOXlp4axwCwiapOqTerdslom622LnNgNNXXE20rnGep0NOOQ6B
	CRVY9OP/CEm1XqfA=
X-Received: by 2002:adf:eb82:: with SMTP id t2mr33615563wrn.337.1622042601355;
        Wed, 26 May 2021 08:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXl1W30rfjivVEWyWkjdPEWwlx14qF6i4mz3fMyFxcLI0S7056rfOyuyiEwU4GLhpUmjov9g==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr33615535wrn.337.1622042601115;
        Wed, 26 May 2021 08:23:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id r11sm21309197wrp.46.2021.05.26.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 08:23:20 -0700 (PDT)
Message-ID: <6a39f2e90415355d478c8691331257974512d7eb.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: drop tx skb cache
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 26 May 2021 17:23:19 +0200
In-Reply-To: <32a776b7dd322f114e385ca406f5ca879c7831cd.camel@redhat.com>
References: <8dd3343ea83a7a631acfe4940a9dea841b32c52a.1621613936.git.pabeni@redhat.com>
	 <e9657dbd-f455-61e9-2118-e2b2443fafb@linux.intel.com>
	 <32a776b7dd322f114e385ca406f5ca879c7831cd.camel@redhat.com>
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

On Wed, 2021-05-26 at 13:06 +0200, Paolo Abeni wrote:
> On Fri, 2021-05-21 at 15:57 -0700, Mat Martineau wrote:
> > On Fri, 21 May 2021, Paolo Abeni wrote:
> > 
> > > The mentioned cache was introduced to reduce the number of skb
> > > allocation in atomic context, but the required complexity is
> > > excessive.
> > > 
> > > This change remove the mentioned cache.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > > - drop unused field skb_tx_cache
> > 
> > There's also a size_goal_cache field in struct mptcp_sock that's now 
> > unused.
> 
> yep, will do in v3 (sorry, I lost track of this review)
> 
> > I like the simplification! Do the self tests trigger enough memory 
> > pressure to test allocation in that scenario?
> 
> Will ensure that before posting v3

Well, we have problems under severe memory pressure, but that happens
even with the current export branch.

I'll send a patch

Cheers,

Paolo

