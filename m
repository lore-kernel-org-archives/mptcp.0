Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D2168
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628786007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKI1rfuSRDpdoGo0LEczCDJ0iWCTKHuMlGWZ2fW7Mzw=;
	b=SdBvAmz1nOXwmFiFtNSiJdBZSqh7NOeG39s8Sch5CcEiZnJaZqtUQfD+xzexthoU+/aJJ/
	gYJRfy+3Rnb6IiYUYSKAIjMpIkke0cGq7UPIkZ1YDFFskyTSYMXm5EzQs9flTt1ZiGRR8D
	wm+YoxtzuKmD0u5CIoz1g/oCBfj75Jg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-4hidp11aPlGNb_NgTMMHNA-1; Thu, 12 Aug 2021 12:33:25 -0400
X-MC-Unique: 4hidp11aPlGNb_NgTMMHNA-1
Received: by mail-wr1-f69.google.com with SMTP id e17-20020adfa4510000b02901550e0550f3so2011900wra.11
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 09:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZKI1rfuSRDpdoGo0LEczCDJ0iWCTKHuMlGWZ2fW7Mzw=;
        b=beNoxC3Cki8uv+gnMaOU0fBprq2IyT3iCB4bQtVDEMfnsntOmUVyM314Q0bOIVJT4b
         aT77bn17qbAhrAzFJ8lBbomB6rgdp8O6KF3adb+i4TcPFLRDO0h8EmTppDYP5PyBkYNm
         09LPOoHhLk3OtD6VUR7Y+7cLlgAWBf8gpWFbpL1BRnTSfSW+kc/fnciHKRlgNLM6YNco
         X78YAo4e1/0baJmbp8ukA1Hy2Ru1js+9IlVtExj3Qw4SbNJAX4OxVCgKEuKDef6TbKSz
         nhXSpdXetFSSrTYbNYMszmk0kyFWxjLR7jufnhSRFDZKuPA8N6pvHwJq4GHjZZu3VU7J
         WkNg==
X-Gm-Message-State: AOAM531ZxDE+Ia7eI2o9LLI+yuwoeYOzChbBygbRMlZ3aUtprXBYArD4
	CrkKaafz8EMF81CcpQXCeK6dlgMJ0oSBOpHfL0uJvO4hAJmTs7yph1/ZSEw5qlQEBfhm4cmBFP2
	YiJvx9QF9E4D+YPo=
X-Received: by 2002:a5d:4742:: with SMTP id o2mr4386844wrs.296.1628786004779;
        Thu, 12 Aug 2021 09:33:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRiFm+ZGa8P8Efh4gQIOuz7RvXlcGnUMDmJ9bsfCPBmcxTTlzWc+OZrrCoRfc+c+3jpn/ziQ==
X-Received: by 2002:a5d:4742:: with SMTP id o2mr4386827wrs.296.1628786004600;
        Thu, 12 Aug 2021 09:33:24 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-224-77.dyn.eolo.it. [146.241.224.77])
        by smtp.gmail.com with ESMTPSA id 129sm3225332wmz.26.2021.08.12.09.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 09:33:24 -0700 (PDT)
Message-ID: <1674eadb3729d5c1b0a7b25b4113e31162b25d39.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: full fully established support after
 ADD_ADDR
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Thu, 12 Aug 2021 18:33:22 +0200
In-Reply-To: <20210812162757.282366-1-matthieu.baerts@tessares.net>
References: <20210812162757.282366-1-matthieu.baerts@tessares.net>
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

On Thu, 2021-08-12 at 18:27 +0200, Matthieu Baerts wrote:
> If directly after an MP_CAPABLE 3WHS, the client receives a valid
> ADD_ADDR from the server, it is enough to prove exchanged MPTCP options
> are valid. Indeed, the ADD_ADDR contains an HMAC generated using both
> the client and server keys.
> 
> It was then OK to enable the fully_established flag on the MPTCP socket.
> 
> But that is not enough. On one hand, the path-manager has be notified
> the state has changed. On the other hand, the fully_established flag on
> the subflow socket should be turned on as well, not to re-send the
> MP_CAPABLE 3rd ACK content with the next ACK.
> 
> Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>

I guess you can drop this tag, as you come-up to this patch by yourself
;)

LGTM, thanks!

Paolo

> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     Once applied, we can close issue 221. But this patch alone is not enough
>     to fix issue 221, hence no "Closes" tag.
>     
>     Because the PM was not notified, I think it is best to send it to -net.
>     Before, I think we were overriding MPC ACK options when sending the echo
>     ADD_ADDR so the issue was not visible.

Ack!

/P

