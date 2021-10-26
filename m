Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E82C2C9F
	for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1635266949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GTFQ6MOOOrCTGQzE/5U6dDAbJXgUBbOtBQgo+MfcFsg=;
	b=SbPaE63oYK6tqpAluSlG227kRqHw0PtAg8tGKJK6SotnIoQcUqutLmNYFe+HDVY+XhGq+N
	zhaTXCavb6wkrRor4utr/HlcX4gfLzbVF883+i6F3PsV+GbFCcAcD0RmjsMHZ7Ngt5P6Fu
	XC/XmlGqnvzDMDls89fV2uoCbEMWvNs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-T7J_26HTO_ObrXaj_g8VBA-1; Tue, 26 Oct 2021 12:49:08 -0400
X-MC-Unique: T7J_26HTO_ObrXaj_g8VBA-1
Received: by mail-wm1-f69.google.com with SMTP id k6-20020a7bc306000000b0030d92a6bdc7so1182419wmj.3
        for <mptcp@lists.linux.dev>; Tue, 26 Oct 2021 09:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=GTFQ6MOOOrCTGQzE/5U6dDAbJXgUBbOtBQgo+MfcFsg=;
        b=XOJezXZIb/RQbgLpir3STKPeDjh1n0+1jlAgrfMtG7lAMXeEHRc5eZSvdbW8Bcf4gr
         HB0kZXmWI7j5F21OfMaXZFQT43yk5Ap8Y5YGYAWzPjOHcG29HbYrUeLQD5m3tlTUdZDA
         OgoxRadikBxmEU4Ipt3aIEpAWdluercq3UGgez3o7UtydAMI5c612oQ5CP+f42/ObQh3
         dT3Rtj4+t4A+PndZEysxOSRkpOWydhc4HqHud1Hmj1oSwnlyK6MZ81l0YZQHDPPSHnJz
         lRqT9sztadqdQbU8KXA85JRWhyvlWMS/hdPtIKzGQzIDuuAAzxDN+aP9+Xrtef4wLu8R
         +IYQ==
X-Gm-Message-State: AOAM533wmb6oFNjxi3Xjg6hbj2wju+rua1eRYaYyebRrp8QkQKtXkZV8
	ZdbZOL7YIL6gB6BMT62kTS4sxgbC9+3nauDpelah0lKgZ+OFwA4eMBtkDMCTc7ioNIWqXossrOb
	LslrgvZjpko/zrBXwW7K3U3SWTHpGlHGHOZeDcVLO7S5Hbf3wO6lXmJ6osJrB6de/
X-Received: by 2002:a1c:720f:: with SMTP id n15mr27994386wmc.173.1635266947126;
        Tue, 26 Oct 2021 09:49:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOvAjkD8IXcXrIQ+WKbfBouqBZzD/X4yvIZDkP4pkqYN57wA87kAKyG694HIkwz9fR90d4fw==
X-Received: by 2002:a1c:720f:: with SMTP id n15mr27994344wmc.173.1635266946811;
        Tue, 26 Oct 2021 09:49:06 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-240-164.dyn.eolo.it. [146.241.240.164])
        by smtp.gmail.com with ESMTPSA id i6sm10074238wry.71.2021.10.26.09.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 09:49:06 -0700 (PDT)
Message-ID: <8db4b664f4fe0e102df6da03e57459c3a8c61677.camel@redhat.com>
Subject: mptcpd and (default) routes
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: "Othman, Ossama" <ossama.othman@intel.com>
Date: Tue, 26 Oct 2021 18:49:05 +0200
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

Hello,

I'm still experimenting with mptcpd. It looks like the current
'addr_adv' could be improved.

Currently it creates endpoints as soon as new non-link-local addresses
are available in the host, and that in turn causes new subflow creation
using such IP as source.

In a client system, usually we have this sequence of events:

1) <interface X goes up>
2) <dhcp start>
3) <interface X get new ip>
4) <new [default] route is added to X>

Just after 3) mptcpd creates the new endpoint and the kernel tries to
create the new subflows. The kernel can try to create the subflows
before the route (required to reach the server from the relevant
interface) is available.

A possible solution would be let mptcp listen even for route-related NL
events and let the 'addr_adv' plugin create the endpoint only when
there is a new address and a default route using such address/the
underlaying interface.

There are a couple of downside:
- the above condition is quite restrictive - e.g. a network specific
route could be enough, but we can't do a generic check for that. Adding
a configuration flag to enable the above check should suffice/cover
this point
- will be quite invasive for mptcpd

Are there any other options?

Apropos, I don't see any routing related code in mptcpd, so I guess
even the out-of-tree kernel could be subject to some similar
race/critical scenario?!?

Thanks,

Paolo



