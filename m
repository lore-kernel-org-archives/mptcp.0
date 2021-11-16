Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDC68
	for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 11:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637061702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iKVMcJuwANvoWVimfimsQSQiIxv0c9SfdgSqXcI0oQ=;
	b=LQ+a+OYjsE90EBlORpfoYZCLobEgt07EBJ6MZyTTS6s+AYeJ+DPpnsmkkP7B5tvAlq3Mg1
	DJXEQw6p2qiZy8Akwb/m8LwEu5P7vQwOp0yHuOWaDwBIDN9EtHiqxxtQQebGJs2g76hC0c
	yOJj/HFyiW5i07/3L5liTnpIErQrazs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-TvG8X-2HO2CN3utPK1pPZg-1; Tue, 16 Nov 2021 06:21:39 -0500
X-MC-Unique: TvG8X-2HO2CN3utPK1pPZg-1
Received: by mail-ed1-f71.google.com with SMTP id m17-20020aa7d351000000b003e7c0bc8523so5181548edr.1
        for <mptcp@lists.linux.dev>; Tue, 16 Nov 2021 03:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2iKVMcJuwANvoWVimfimsQSQiIxv0c9SfdgSqXcI0oQ=;
        b=vkXACSpxmFWqKjUQCUtg7IKqIIQUxrefrljTtcaf/w2b11IkYuIUjovD5rrjTJ5K3f
         /zWq8vZo60ZA3UbqkXJ01IKHglInYk54Ga+k8/5TNU/IyLKtE1U3xhnDn4PYPKtd3V4N
         LSvNQoExEMWuON9dJXe1MG3yVV2IZAXwhG4+dxjw3BSfFwrKwFOTTASsxQk8zOgZkZIn
         JYrjMTysM7VG5wVycJQrC/SCUbJIPZPG8rDHq4r09iZ4xz59ZoQmibTv0IOohU6YvDKK
         KLoKefJ3wqWJ0+K8FqpIsPhgxN4LqqQf3IRfcYtvB3HoybYQTur8gzwRfQXJeLZXfcuf
         26AQ==
X-Gm-Message-State: AOAM532L/eu77/H4K8ZhTOUikK/Rgv3VPjWqPdPIUCdmbCftWCEOqvtJ
	9cdoF7oGS/zwRl+A9V9bjsH2cLX96YbvbwQV7whKvjweMiv8yPSOrEAEGq4rIrl5KXIrv3TS9Xa
	UKnpZxth+C/191+k=
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr8618240ejb.51.1637061698178;
        Tue, 16 Nov 2021 03:21:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxu6TjoHUk604AIV15VOzTNBgMnwTaV9l9s/H7tbThTm3LLvP8T63+xWttHBSJ9PdvUg3RUPA==
X-Received: by 2002:a17:906:eda3:: with SMTP id sa3mr8618197ejb.51.1637061697946;
        Tue, 16 Nov 2021 03:21:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-229-135.dyn.eolo.it. [146.241.229.135])
        by smtp.gmail.com with ESMTPSA id de37sm7931537ejc.60.2021.11.16.03.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 03:21:37 -0800 (PST)
Message-ID: <3af4b6588e6d9758a577fe2636c8d4ee46c83699.camel@redhat.com>
Subject: Re: Subflow Creation / Management Issues
From: Paolo Abeni <pabeni@redhat.com>
To: Phil Greenland <phil@quantulum.co.uk>, mptcp@lists.linux.dev
Date: Tue, 16 Nov 2021 12:21:36 +0100
In-Reply-To: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
References: <EF21766C-4DF4-4F06-8076-16391C7D56D5@quantulum.co.uk>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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
Content-Transfer-Encoding: 8bit

Hello,

On Mon, 2021-11-15 at 22:44 +0000, Phil Greenland wrote:

> Scenario 1)
> 
> If we take network links up and down, adding and removing endpoint
> addresses as we do so, everything appears to work well, subflows are
> connected and disconnected as expected.
> 
> However if a subflow fails, for example due to reception of a TCP RST
> from a NAT this seems to cause problems.
> 
> The next time a link is taken down (a link other than the failing one),
> the associated subflow is disconnected as expected.
> 
> When the link is brought back up, more often than not the failed
> subflow (the one stopped by a TCP RST) it re-connected and the newly
> added endpoint address, associated with the interface that was just
> brought up is not used.
> 
> I believe this behaviour is due to an interaction between the
> local_addr_used variable within the MPTCP meta socket pm structure and
> the logic in select_local_address.
> 
> The variable is incremented and decremented on subflow connection /
> disconnection (following endpoint addition / removal), but it's not
> decremented following the failure of a subflow.
> 
> The select_local_address function only seems to check if a local
> address is currently in use before returning it.
> 
> Therefore when an address is removed / re-added a single new subflow is
> permitted to be created (due to local_addr_used < local_addr_max),
> however the select_local_address function returns the first available
> address.
> 
> Scenario 2)
> 
> Following the initial MPTCP flow creation (with id 0?), if a subflow
> connection fails to be established, due to a connect timeout for
> example, no further subflows are established for the connection.
> 
> It appears that the subflow connection success handler
> mptcp_pm_nl_subflow_established triggers the establishment of the next.
> Such that once the chain is broken by a failed connection no further
> subflows are established, even if unused endpoint addresses remain.
> 
> Scenario 3)
> 
> As a continuation of scenario 1, if for some strange reason all
> subflows were to fail, all at once, or over time. I'm left with just
> the MPTCP meta socket. The application believes it's still connected
> but there’s no way it seems to recover the connection. Other than
> adding a new endpoint address, which will trigger one of the subflows
> (again not necessarily the new endpoint) to be re-connected.
> 
> ———————————
> 
> Is there anything on your roadmap that might help address these few
> issues above?

Thank you for the extensive report. There are a lot of useful
information above. I think it would help if you could file individual
github tickets for the different scenarios. Possibly 1 && 3 could be
boundled in the same ticket.

It would be great if you could be as accurate as possible, e.g. down to
the involved 'ip mptcp' commands and/or pcap traces.

This one:

https://github.com/multipath-tcp/mptcp_net-next/issues/235

is likely related to your 2nd scenario, please add there the relevant
info/data.

> I’ve been considering a temporary hack, which I hope would address
> all three. Adding a netlink call, based heavily on your add address
> handler, to walk the meta socket list, and try to reconnect any / all
> failed subflows. Which I can call periodically or in response to
> network events.
> 
> I’d happily attempt to develop a more formal fix, with some guidance,
> but haven’t done lot of Linux kernel development in the past.

I suggest to follow-up on the github issues tracker. I think a solution
for the 2nd scenario should be quite straight-forward, while 1 && 3
will likely require more work. 

The tricky part would be likely do the 'correct' decision later when
the next subflow is created. Should we always skip endpoints that got a
RST in the past? Should we allow a limited number of re-connection
attempts? in any case that will require quite a bit of additional state
to be tracked.

> Apologies for the long email / keep up the great work! It’s really
> good to see MPTCP make it into the mainline kernel.

This kind of feedback is very helpful! Thank you for providing this
whole bunch of info!

Cheers,

Paolo

