Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881015A3
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656921765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TzgzOHVH2Xk2RXLzSWOLJEnA1DJer0yI53caeV/E3s=;
	b=BmaObMXjTMcDYEnibVLBdbghRt+5jcHzf6D/9A/drPUbCuMKjw8xi5gP9RL/Vp+yfBuzRN
	KHk3zKWIoSyNx40cxM/QYcqqw7V59AwzsXHwY3v0M0CF798QEwbuqKv4mwfgF8XRq4a7FB
	ej+rS2xSM3DEZK+RQW+HFziaH7lames=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-LBA7rOhAOZGv2vmPkLyjOQ-1; Mon, 04 Jul 2022 04:02:44 -0400
X-MC-Unique: LBA7rOhAOZGv2vmPkLyjOQ-1
Received: by mail-wr1-f71.google.com with SMTP id f20-20020adfc994000000b0021d4aca9d0eso1159973wrh.0
        for <mptcp@lists.linux.dev>; Mon, 04 Jul 2022 01:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1TzgzOHVH2Xk2RXLzSWOLJEnA1DJer0yI53caeV/E3s=;
        b=Xz1tCElnMchToHTfg/J/RoTukmb45qYZ0PKecn8121DKGx1D+U0Uz/Axf/auhKcEDP
         vBzXSNXVBthUCWE20bktj1CMyEe+cgyarPEQCJdemP/ULd5Mo9VAJdj0NgKL377GthgY
         u+G+ggfcwcsv1f2UNJGxhd9+qjokEe6X/j71OLqYYjZ7yXsk08FvyGD56Ld5fc9WIH4f
         1ondMKflDTHG2CJzpBPiw6jeJIn0ajpA3m2khpboWeoGRa533ICtlcNisb8SCkV92YWG
         H/XK7vpweujsuvXMqLV00tIW9kiYg8bUjkUcAIAEk347cMyZdZdoU6e28wKKUJdlBtVk
         dT7g==
X-Gm-Message-State: AJIora93kJDZhKytuCZBpP6AABKOrkvdtxFCMgIpfdIizt6mPtDdyYBQ
	flWGYdM6C2RqQfXGii75kH1hPtmO4cyjTGrUqiv+4jY9yw0OHwKOJoRV72Rn5cNu8tfaU3HDygH
	HbJQ1SBwlpXXVWuQ=
X-Received: by 2002:a05:600c:3481:b0:3a1:918d:6719 with SMTP id a1-20020a05600c348100b003a1918d6719mr14468373wmq.35.1656921762701;
        Mon, 04 Jul 2022 01:02:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uOspG0M9VoTuG0fHMuf3fQ0JXBZAELdEIft9L2rAyhBvuP/Jj3m8F7Qo+BJTRivlIzXt0Gig==
X-Received: by 2002:a05:600c:3481:b0:3a1:918d:6719 with SMTP id a1-20020a05600c348100b003a1918d6719mr14468351wmq.35.1656921762400;
        Mon, 04 Jul 2022 01:02:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-106-148.dyn.eolo.it. [146.241.106.148])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c35d000b003a0375c4f73sm19029693wmq.44.2022.07.04.01.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:02:41 -0700 (PDT)
Message-ID: <15406f2f64a2650e1ffa919bee02fee763400eaf.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/6] mptcp: fix local endpoint acconting.
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 04 Jul 2022 10:02:41 +0200
In-Reply-To: <1dc71764-4046-79c3-c6f-5c736d2d64c0@linux.intel.com>
References: <cover.1656669391.git.pabeni@redhat.com>
	 <f0f5893c05f19d5076a9d03c84b65495f488fbf2.1656669391.git.pabeni@redhat.com>
	 <1dc71764-4046-79c3-c6f-5c736d2d64c0@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-07-01 at 17:04 -0700, Mat Martineau wrote:
> On Fri, 1 Jul 2022, Paolo Abeni wrote:
> 
> > In mptcp_pm_nl_rm_addr_or_subflow() we always mark as availble
> > the id corresponding to the just removed address.
> > 
> > The used bitmap actually tracks only the local IDs: we must
> > restrict the operation when a (local) subflow is removed.
> > 
> > Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> Looks good to me. Ok to apply this one to the net branch, separate from 
> the rest of the series?

Works for me, thanks!

Paolo

