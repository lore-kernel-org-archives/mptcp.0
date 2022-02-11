Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906D42F26
	for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 11:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644578488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfboOC8/Z5K9IF/RZtKq5KVQT7+984fLmI6c8T1OuWs=;
	b=XX8F6g6Lg22qQUMVK+5QIqcJdiqRmJq2/w4NYqZAdCd72oy8coM/gmyu95XwhTLqpeLgEp
	p7iGGYu1UyZBzkJQ5QTltOaeQOS6HxISHuyGX08W0sS9MYcYbH/6tUQwGjuXRU9v629dN1
	ztw1Ji3vxNCJLtZgxy3L8I6/9wcn1Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-7lwtjm4SMmCFQ0xAbi54WQ-1; Fri, 11 Feb 2022 06:21:27 -0500
X-MC-Unique: 7lwtjm4SMmCFQ0xAbi54WQ-1
Received: by mail-wr1-f70.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so3740510wrg.19
        for <mptcp@lists.linux.dev>; Fri, 11 Feb 2022 03:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FfboOC8/Z5K9IF/RZtKq5KVQT7+984fLmI6c8T1OuWs=;
        b=7WNF+D+ta8v2qLrDDbW2aVCvL122M0qGTf1D2ftFFWTM9E4turFvNiVpy4zTB3HDm5
         MJfUlUAMX+oUS2gNvRko6zWfiNEyN+/a40b2X8yoYOxBWeixhGYm7lL1Sun56yCpybrP
         kHN1YJ9YfIcme8gopvUyHU0z6I/WXkAAiWjUTXI/bGBcKLdpxeGNS6X2gBGlDVtHtuUi
         aWRuclEW1Kqo/FNEAmwZDXxnmxMOROt8cAYenunrE09h6cNsHVFgJdrXCgGpO7Smcn6S
         K4bJK56qUke0Fp61gWCgyCo+WJASZczp0OXvtB4MQ89Jcx6SvViDOUSDusWDMlPqYMDU
         gTVg==
X-Gm-Message-State: AOAM531WK1CUJMyStmgRDAo1Naf0NlUNPpITirR6efZ0kbpJU55lSYFw
	/DY/if0XX5uRxm2yz8HI4KfBDeKhZdjkuP8azp8R2J+W9E009IE9Lw6YVS7Gg+qMzcDBVDl8QfT
	5x/kpSQLAAI+dgU4=
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr1791605wmp.180.1644578486182;
        Fri, 11 Feb 2022 03:21:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdiJ5zvVgFKqgjJ2/FcxUu9zv+q8iJjF6w2ktAL3/V1p6oHshVdKjhTsdK6m2a7IKdRehk1g==
X-Received: by 2002:a05:600c:4a09:: with SMTP id c9mr1791586wmp.180.1644578485940;
        Fri, 11 Feb 2022 03:21:25 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id m5sm4129886wms.4.2022.02.11.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 03:21:25 -0800 (PST)
Message-ID: <f06dce026857ab6b48fdc2215ef3af0bf11d5bbe.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Fri, 11 Feb 2022 12:21:24 +0100
In-Reply-To: <2fca6a8-62b3-9f8-d08-62bf352c071@linux.intel.com>
References: <20220210152949.19572-1-fw@strlen.de>
	 <20220210152949.19572-4-fw@strlen.de>
	 <2fca6a8-62b3-9f8-d08-62bf352c071@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Thu, 2022-02-10 at 18:03 -0800, Mat Martineau wrote:
> On Thu, 10 Feb 2022, Florian Westphal wrote:
> 
> > Currently mptcp adds kernel-based listener socket for all
> > netlink-configured mptcp address endpoints.
> > 
> > This has caveats because kernel may interfere with unrelated programs
> > that use same address/port pairs.
> > 
> 
> It looks like they still interfere with each other, but now in the 
> opposite way: TCP listeners can now be created that interfere with 
> MP_JOINs (and the MPTCP side loses).
> 
> Since mptcp_handle_join() is only called if the listener lookup fails, if 
> a TCP listen socket has been created for an address & port advertised by 
> MPTCP, that TCP listener will be looked up, process the SYN, and send a 
> regular TCP SYN/ACK. The peer will then reject it due to lack of correct 
> MPTCP options.

Uhm... I think the above could only happen with some misconfiguration.
e.g. the user/admin runs on an announced address, on the same port of
the MPTCP service (or of the mptcp endpoint), a different service.

IMHO one important point is that the behavior is consistent: TCP will
be always preferred, with no races - modulo bugs - and user/admin will
be notified of the misconfiguration by the fallback. 

It should be also quite easy to clearly document.

> Seems like a few more TCP changes are needed to handle this listener 
> collision well for both TCP and MPTCP, and without too much overhead. Is 
> it too expensive to look for MPTCP options in every incoming TCP SYN 
> header? Or to have the MPTCP PM code setting a "check for MP_JOIN" bit on 
> TCP listener sockets that match advertised addresses?

I'm all for the latter option. We can either walk the endpoint list or
maintain an additional small hash to make the lookup faster.

/P

