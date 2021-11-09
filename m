Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE82C85
	for <mptcp@lists.linux.dev>; Tue,  9 Nov 2021 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636468742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xi8s0kFkwXH2j+ktWQ8Ld+GAgSJ8AY3VwclIXoV4sjA=;
	b=Gkfg8TVv4bIZJM/7ggBqxzn3rEkJ0d6bP5bE4fXNAtgxyfYYeQZvhQ5rJH8vC6ccQFwa3h
	UkL5dJwM28ClcfbH/4mgNc2WTh/qS9t1UCmN5CUJ5epTQuxKtOQgN5IiGanJ989FUFgCmV
	DFGPzDfTZPrn1X5VNzhBmoe+AGWDrCk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-3Uil5p3bMf-JGWNdQzfrVQ-1; Tue, 09 Nov 2021 09:39:01 -0500
X-MC-Unique: 3Uil5p3bMf-JGWNdQzfrVQ-1
Received: by mail-wr1-f72.google.com with SMTP id d7-20020a5d6447000000b00186a113463dso4849162wrw.10
        for <mptcp@lists.linux.dev>; Tue, 09 Nov 2021 06:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xi8s0kFkwXH2j+ktWQ8Ld+GAgSJ8AY3VwclIXoV4sjA=;
        b=lcb4CFo5ujkwkFIrXubIHY9UujXTpwCqiD1I4FJde0309U5d88xohRcQEJciuuVpYa
         bH8JsPgkuViDLzdrKsW+a0K02qJ190iPdcg2+6nUmo6dO8EoCZvZ9bjqzHTgkxruAEvQ
         Bq1p1uoj+KQh+XPo+MMWMJa4bZFJG1zqiEYAZtPR22v3gHvtcg68XoTjET5f9XxsG33N
         a1kLtWN/ox9Pe230Oe+As96Scyzq5K6qvn4w1wUAH6Vspr4OHwBFseONfKqooU470pXj
         br1NrSofbK8hjMNqGJwJcgbqCzr6V9UDN4+/3kKdR16Da8INnligH9Bzia/Lx5URehZh
         cfCw==
X-Gm-Message-State: AOAM531iMA/zBw3ABtro8AR8SUGRVl9VGkYeexB7fIszc7e5vcPeTwkk
	PT1KIQdnI3Amfc8JgqnHuP1pUUzNl8MhDCgOivKFqI57qXVmcbYFGw/CE9ZcV+3LTtfNXLUcl2m
	M7FBOd573mVCLaDE=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr10234934wrq.264.1636468740174;
        Tue, 09 Nov 2021 06:39:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXSrM6knl0P75NIpaILfSzCvTSIbJko5oC9o0k90iGYDkOhDsz5l0BPR0tFaFHKRm6iN94Ow==
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr10234902wrq.264.1636468739899;
        Tue, 09 Nov 2021 06:38:59 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id i17sm2769292wmq.48.2021.11.09.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 06:38:59 -0800 (PST)
Message-ID: <baf882f708dc67063449424e2319a0c74a1b86b5.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] mptcp: never allow the PM to close a listener
 subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 09 Nov 2021 15:38:58 +0100
In-Reply-To: <340eb5be-4fa9-5cd3-1224-3e37e4d538ae@tessares.net>
References: <cover.1636107361.git.pabeni@redhat.com>
	 <f9e8db7159b3e0db8dc5b642abdfa9019ada435b.1636107361.git.pabeni@redhat.com>
	 <340eb5be-4fa9-5cd3-1224-3e37e4d538ae@tessares.net>
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

On Mon, 2021-11-08 at 17:56 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 05/11/2021 11:49, Paolo Abeni wrote:
> > Currently, when deleting an endpoint the netlink PM treverses
> > all the local MPTCP sockets, regardless of their status.
> > 
> > If an MPTCP listener socket is bound to the IP matching the
> > delete endpoint, the listener TCP socket will be closed.
> > That is unexpected, the PM should only affect data subflows.
> > 
> > Fix the issue explicitly skipping MPTCP socket in TCP_LISTEN
> > status.
> 
> Good catch!
> 
> Should we add a "Fixes" tag and have this backported in stable versions?

We need this patch to be in the same series of the following two - or
at least to enter the tree before the others. I did not had the Fixes
tag to allow this patch to target the -net-next tree as the following
ones.

BTW I'm working to add self-tests here (mptcp_connect based [!!!]). It
looks like tha a good disconnect() implementation should use FASTCLOSE
to shutdown the MPTCP-level connection, so I'm going to add the tx part
of it, too.

Cheers,

Paolo

