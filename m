Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFC2FB2
	for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623748160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J8Ls75ugersnLzmZwPQnHmbBGsBiLjGYTsfLaruU63M=;
	b=BOXebwrtgFJJxbjCa17394rKLVOOmpRQywIeQ5bWjH5x9y+U2DevwgiSnOLhOJ0E3e7kgo
	K9vMcTwSz9BWI0q5sBoO3K8Osod+kXX0qbJAIl47UruNiSLF+w6hnhFyUwJKW5RgZwCywI
	if+8LqTBntTwTGj/mZrjX/xgNKkb+lY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-9uRIriYjM2CgYOk3MVhpJQ-1; Tue, 15 Jun 2021 05:09:17 -0400
X-MC-Unique: 9uRIriYjM2CgYOk3MVhpJQ-1
Received: by mail-wm1-f71.google.com with SMTP id n2-20020a05600c3b82b02901aeb7a4ac06so274922wms.5
        for <mptcp@lists.linux.dev>; Tue, 15 Jun 2021 02:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J8Ls75ugersnLzmZwPQnHmbBGsBiLjGYTsfLaruU63M=;
        b=UrFFxkk+YxZBTU65Y+EsBWkAAd6+GTJcJguLhlWC0iXx3kRu6aNA4WSfyPo0J+lybr
         id4ZFZ9DCmrVHuWydcvrcBn3X62rVtf8JTHm8YzydjEdGJulgsVPeVOPaFi6Gf9P3NZD
         xH1ybN8vXLMQKgrRmbLUweE7Tn4no/pyS1hJKYquzNEWiaLDEctvTbo8S1DUFVTq3CZW
         q/A+zbkHGQdeWx59aCbTO/eQdqqbmqK10gAU990TiNmMBaQsQmy77nQUIUcotkb4KLHM
         H1LcmLYrYQzGmz3CrEs0yE71SweFik3l6t0Vxtrd0VdD1v+g+k6TtgNMBWBOdPRd2zsf
         Fajw==
X-Gm-Message-State: AOAM531ZQ2zDmVAWOONfxqsuRI3gfK0cBllsu2wKk+RDyMBYYt7c0xrv
	v+FC1PHBavoNiew9vYJOcFQClckaAdmEtqPVJNf6UiPZIIXKE/LJZqcLh1HFV9QO+pNyMuHb1pz
	gWLwWm8J9u7PJ1uc=
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr23585433wre.402.1623748156240;
        Tue, 15 Jun 2021 02:09:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXvQreg/CydSwHKbpnrYMSjlKrus0kfxXJjI7vEo2NkIVDhTSG62MNj9Whe42wNe+ddDAXuQ==
X-Received: by 2002:adf:9dd1:: with SMTP id q17mr23585417wre.402.1623748156049;
        Tue, 15 Jun 2021 02:09:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id f14sm1621814wmq.10.2021.06.15.02.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 02:09:15 -0700 (PDT)
Message-ID: <de101616524d72d1bd83addd6a717c73edd68703.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix bad handling od 32 bit ack
 wrap-around.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 15 Jun 2021 11:09:14 +0200
In-Reply-To: <1dbd7296-c31f-dce9-69fc-595df927a456@linux.intel.com>
References: <356dce030d0adf2bf6b45888876e2c3f9f553a3a.1623691387.git.pabeni@redhat.com>
	 <1dbd7296-c31f-dce9-69fc-595df927a456@linux.intel.com>
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

On Mon, 2021-06-14 at 18:27 -0700, Mat Martineau wrote:
> On Mon, 14 Jun 2021, Paolo Abeni wrote:
> 
> > When receiving 32 bits DSS ack from the peer, the MPTCP need
> > to expand them to 64 bits value. The current code is buggy
> > WRT detectiong 32 bits ack wrap-around: usaging the 'before()'
> > helper is just meaningless: when the wrap-around happes the
> > current 32 bit ack value is lower than the previous one, need
> > plain direct comparison.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/204
> > Fixes: cc9d25669866 ("mptcp: update per unacked sequence on pkt reception")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/options.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index a05270996613..7db1e219f24f 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -952,7 +952,7 @@ static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
> > 	old_ack32 = (u32)old_ack;
> > 	cur_ack32 = (u32)cur_ack;
> > 	cur_ack = (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
> > -	if (unlikely(before(cur_ack32, old_ack32)))
> > +	if (unlikely(cur_ack32 < old_ack32))
> > 		return cur_ack + (1LL << 32);
> > 	return cur_ack;
> > }
> 
> I think you're right, but I haven't had a chance to test myself (since 
> this is tagged as closing #204 it sounds like your tests are good!).
> 
> While it's a good thing that mptcp_trunk helped us find this problem, 
> maybe this also shows that mptcp_trunk should be more aggressive about 
> switching to 64-bit ACKs? Or is this less about speed and only a 
> wraparound bug?

Without this patch single subflows transfer from net-next to mptcp.org
stalls after a few GB - after the wrap-around. That happens because
net-next misinterpret the ack for the wrapped seq as a very old one.
This patch fixes the issue in my test.

Not sure if the above answer your question.

Cheers,

Paolo

