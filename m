Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECA72
	for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 08:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634631154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qyZXIS4f61Jt0uxYXYkDio8KV0Ao86yHHOg8jKN138=;
	b=QybHypYoz527wexR4639gq1TAG5abRbczOyc9TzkJGK6Td2cCyQpuUNoWWNAq5/xTLoE4P
	A/HNtLWhD9FPcaGebWU4zavzp6GJnoq6iYe3HxG0hx3KeCF4s2RuCbVZmt2S0ZgAPjI+hX
	PYrfIU62JdandWRX73+RXWCDaSi3TDs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-HTh_1Nq-Mb-jblv6BPHLOg-1; Tue, 19 Oct 2021 04:12:30 -0400
X-MC-Unique: HTh_1Nq-Mb-jblv6BPHLOg-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso16857149edn.4
        for <mptcp@lists.linux.dev>; Tue, 19 Oct 2021 01:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9qyZXIS4f61Jt0uxYXYkDio8KV0Ao86yHHOg8jKN138=;
        b=n7rojGV/q4gv+yPB05vKM7m7O17uRtZ3BthfNVSfyr1xVerUBTFURrBRrZIu0CCA0i
         Vk0bcWA0ic2kYC++7nJW1eCHfUUkycegykSxsVZLXve1d+2vj+PqAxH8qB0S5o9xNM++
         ysPYI8SOWVfa63vbxVqIc0hyKNpl/mDeLOxdxzVYc/Zu/k2r0J42Qo9Tl91mNxaJlEUq
         QU+gFF1b9uUJ8N+1aaGwD1aReB4fDd9+ZnPCPW3qdOASFWJ/36g3PAFBdmYO7CfQKfNf
         f4wnp7GYU2vaXQ5d33cnM3Zv+/dQ/+IY92M9dEfgR+xNcCdeGSBvBrBrgqxOc4yJDR2z
         XG4Q==
X-Gm-Message-State: AOAM531kucKrI3rotUIb++Zzx4ax8TgASpwcKm01cyariwIxVYNK90JX
	c/6E2EIKwUMLZSRttf48bjpXFPDI5brKxEwqNEwALJ9IX8RM0I4Dh2Jiz+efqVbN/R8Kbt3a+XQ
	UCWUHcfgYuPJkDBA=
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr35745679eji.126.1634631149559;
        Tue, 19 Oct 2021 01:12:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+4+tHWboorI0EUTcOKOntHcPGDfV6dtW2CZ3YdiztdYApO0RZXMHWWxNa85LuM3Ws20Xo3Q==
X-Received: by 2002:a17:906:2f16:: with SMTP id v22mr35745656eji.126.1634631149367;
        Tue, 19 Oct 2021 01:12:29 -0700 (PDT)
Received: from localhost (net-188-218-17-84.cust.vodafonedsl.it. [188.218.17.84])
        by smtp.gmail.com with ESMTPSA id h18sm9840420ejt.29.2021.10.19.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 01:12:28 -0700 (PDT)
Date: Tue, 19 Oct 2021 10:12:28 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Poorva Sonparote <psonparo@redhat.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: Re: MPC+Data bug progress?
Message-ID: <YW597FiQlpiwZlrq@dcaratti.users.ipa.redhat.com>
References: <3f242ebc-3674-9468-f2b0-9fd756d54048@linux.intel.com>
 <CADppAWA7Mo-BwbE97Z1K=Ex3aK-_cbet6z12ObXVHj1wxEgxxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CADppAWA7Mo-BwbE97Z1K=Ex3aK-_cbet6z12ObXVHj1wxEgxxQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 18, 2021 at 06:13:36PM -0700, Poorva Sonparote wrote:
> Hi Mat,
> 
> Due to some change in circumstances, I don't think I can get this fix out
> in the required time frame. Can someone else please pick it up? Sorry about
> this.

hi Mat, Poorva,

I can try to send a patch for this targeting kernel v5.15. 

-- 
davide

