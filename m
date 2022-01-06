Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FF52C80
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1641462494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BpQ53z9hedC9ug4eIID91V7XLOtQbrcmzWzKFqi4bWc=;
	b=W/VfQ/Fn1G7oLRFhNd3kRK99ymSN6NBrOHFvFxw9OBXadEqxY7h76PACzaxE7wP+lEf8s8
	e8v2cIBx+gv8zbdjuQFuNKR6p3Q1oGVejnEgfjuHQLiT+cZcW0oGMo4Xizc/NannYF2tua
	UgG58PhwWxlnJ4KQCyYCxLYKdnanL4c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-JPiTO9F1NDSpXe0HMWEG8w-1; Thu, 06 Jan 2022 04:47:13 -0500
X-MC-Unique: JPiTO9F1NDSpXe0HMWEG8w-1
Received: by mail-wm1-f72.google.com with SMTP id b20-20020a05600c4e1400b003457da1c91eso152022wmq.4
        for <mptcp@lists.linux.dev>; Thu, 06 Jan 2022 01:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BpQ53z9hedC9ug4eIID91V7XLOtQbrcmzWzKFqi4bWc=;
        b=IUn3ZCM2skIqEUhPyOWDY38IjKuJsumalTPmi5aDNeZRlXVuRrn/gkoX2x/Opc2qWW
         mvjfdx/Vea3ELxUxSDxL1H2aVIPiZ3a1KL2JWngGfi58IXW6EvVGxZH0U0Jose4eyoT9
         Ci9KlEnUn0mEHeT2XXfZDrap5TFvX1/YGmMe+SKcum/L6KaoVwaKBWwW7P92lFsWFZLg
         kcUXODRbW4zNPDcgy8F7m6bjQKvlCTz8pGPZoKI4SbcZhDVrEUHZmt7MAJrh28a38Zgm
         ILfs7degm+r8zEc+Jlq9mRAQQPcPkFEwThiiAJQ4n0gfA7dML8i2wl+PEVOjWwa13fwX
         0SGw==
X-Gm-Message-State: AOAM531YNbjVvX3FcivSQiQ+Pfa6v5eujjNhr7GLeg5zUu3uj+uG7rUw
	kcmiLthdLG6PoGWPw1VqeUYUuqujG8UxZc7ssJlvZD7EaTJ6OuV5PToFNR3zvnPpqbzXysjCrx7
	hqPpcqEQHWD7v3sM=
X-Received: by 2002:adf:fac4:: with SMTP id a4mr49493038wrs.66.1641462431982;
        Thu, 06 Jan 2022 01:47:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNUqLr9V2SDyWVYFHFmHeIDts9mtqve/3q44hRR/TvSuNyg/VfRJYYSQ5b+wd1F1H8Vy+Zpw==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr49493026wrs.66.1641462431816;
        Thu, 06 Jan 2022 01:47:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-97-184.dyn.eolo.it. [146.241.97.184])
        by smtp.gmail.com with ESMTPSA id b2sm1737133wrd.35.2022.01.06.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:47:11 -0800 (PST)
Message-ID: <c03a4a9825e05d55db7c204e7d3b1517861f65d3.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 0/8] Clarify when options can be used
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, Matthieu Baerts
	 <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Thu, 06 Jan 2022 10:47:10 +0100
In-Reply-To: <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
	 <CA+WQbwuF4REjgiEveFYs6=Dz9_fzMQaqorNepNJMBjfr_fWt=g@mail.gmail.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Thu, 2022-01-06 at 10:58 +0800, Geliang Tang wrote:
> Hi Matt,
> 
> Thank you so much for this new version. Good catch on patch 2. It works on
> my test and all looks good to me...
> 
> Acked-and-tested-by: Geliang Tang <geliang.tang@suse.com>
> 
> ... except patch 6.
> 
> I thinks we'd better to drop patch 6 ("mptcp: allow sending both ADD_ADDR
> and RM_ADDR"). Since ADD_ADDR suboption is too big, we had made a lot of
> efforts to let ADD_ADDR not to be sent with other subopthins. I thinks it's
> better not to let ADD_ADDR sent with others by ourselves.

+1

/P

