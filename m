Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAB271
	for <mptcp@lists.linux.dev>; Wed, 19 May 2021 09:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621417924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9W9c/1Dn2WiNbOZuvbRy8UUgAC+UWPQJM4Qu1gaMJsI=;
	b=fcYHxQxZtb/WmmdYTpUBh4KJmq/pll59CnFTzxzbmHUF6WK5YN4q4DgbUP5XO1ZOF+J9Y3
	i79ROMmMcjQHrK6ZPvkbRTlAw979TYSDSDL7254ZdxpjsR5zb/qNvbWKWVNJz4KLXkMldP
	ju0uENwajucwQYTAljI8aaFSS6tS0F0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516--_d4xRuuMbm4Yev6337k_Q-1; Wed, 19 May 2021 05:52:02 -0400
X-MC-Unique: -_d4xRuuMbm4Yev6337k_Q-1
Received: by mail-wm1-f72.google.com with SMTP id l185-20020a1c25c20000b029014b0624775eso1335844wml.6
        for <mptcp@lists.linux.dev>; Wed, 19 May 2021 02:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9W9c/1Dn2WiNbOZuvbRy8UUgAC+UWPQJM4Qu1gaMJsI=;
        b=jnXHFY1Az5mRRsDTwE2JsFwl1OEnCrQGOKrFsagjfUgdLbFD6g+qW9eW4mK3p3Olw2
         umwwuPoyaLIZZ+FqEXqXaPV9lbEVEZkViCdOdWKRSQot9yMo9Km6AL8ljsZtfCOrAHct
         dQZJS24Cm8vVInu9Zh6/vB7KHqRqFJA7xg5vZM7Xwqc91dJHa3QrH9s0aD/CyB4Okh4f
         Ga8vxCNgj4EnYGIPQeF2c/wgmkjS+gtXJ5iGaWTG7zpR0N79uk6SV5NchdNbwsx0sc/j
         BDgjaiOCKiaccOK1UutO/jJmiKUOh/s2OkCjouKx/a9Pz24rngOOo87WwJRrqh4upbpd
         bxpA==
X-Gm-Message-State: AOAM531xoi5KG6CsqUVyFomVWkkpOCPKbzDPXVYeWFYXXAh0h3Zu3Ur4
	fqyYvAZfN4wyc+adNWQjOtcbgIFzEz4CbeGEeInzSj7D1Jwpktbe/voKq8hhOIeg5qFo0QrFvAO
	uS28cqk6oA+W4Q9I=
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr5568541wrm.224.1621417921252;
        Wed, 19 May 2021 02:52:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeqxqB9KU07dR/qrPCOoUf2VnZgtVfWmHShldK5cpnpmZ+GMDunKlLgY7Tpd23xtPuwmc14g==
X-Received: by 2002:adf:dd4c:: with SMTP id u12mr5568524wrm.224.1621417921034;
        Wed, 19 May 2021 02:52:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-104.dyn.eolo.it. [146.241.245.104])
        by smtp.gmail.com with ESMTPSA id l14sm25618345wrv.94.2021.05.19.02.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 02:52:00 -0700 (PDT)
Message-ID: <ef31d1b4b0456a02f0e8515c449ea4fd4e7c1611.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v6 mptcp-next 0/6] add MP_CAPABLE 'C' flag
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fw@strlen.de>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Wed, 19 May 2021 11:51:59 +0200
In-Reply-To: <dd9d31d-134-8b8b-7f40-f34e4be75956@linux.intel.com>
References: <cover.1621002341.git.geliangtang@gmail.com>
	  <10c0783f0b81ab279dbbf202033295e7891c18d6.camel@redhat.com>
	  <11169a25-2e4-a879-2c92-bad09a28a18@linux.intel.com>
	 <ccc1707df9391e1552ac67f6b358e879ab3aed0a.camel@redhat.com>
	 <dd9d31d-134-8b8b-7f40-f34e4be75956@linux.intel.com>
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

On Tue, 2021-05-18 at 12:07 -0700, Mat Martineau wrote:
> On Tue, 18 May 2021, Paolo Abeni wrote:
> > The in-kernel path manager is want to be as simple as possible. As soon
> > as we start allocating memory on peer req it's very easy to be prone to
> > DoS. Memory accounting and limits could save us or at least mitigate
> > the problem, but they will add more complexity.
> 
> My assumption was that high-connection-count servers would probably have 
> their limits set in a way that ADD_ADDRs would not be accepted anyway. 
> This is the use case where clients may be behind a NAT and the server is 
> accepting MP_JOINs from the client (but the server is never sending 
> MP_JOINs), and the server is possibly sending ADD_ADDRs to the client. The 
> configurable limit is already there from the existing in-kernel PM code.
> 
> I do agree with "as simple as possible", but the RFC requirements are 
> constraining that. Even though the C bit is ignored in Linux 
> implementations so far, I don't think it should stay that way. The current 
> code always tries to connect to the initial subflow, so we need to do 
> *something* different to remember an alternate peer address. There are 
> other options (like remembering only the most recent ADD_ADDR), but given 
> the configurable limits we have it doesn't seem that different 
> memory-wise. What's important is implementing this RFC functionality well, 
> so it's really helpful to explore the alternatives here - and your 
> understanding of the resource issues and DoS tradeoffs is very useful.

Uhmmm... I start feeling I misunderstand the RFC WRT to 'C' bit
handling.

"""
		 The third bit, labeled "C", is set to 1 to indicate
                 that the sender of this option will not accept
                 additional MPTCP subflows to the source address and
                 port, and therefore the receiver MUST NOT try to open
                 any additional subflows toward this address and port.
"""

To avoid creating additional subflows towards the MPC server
address/port, we don't need to store any additional information beyond
the 'C' flag: net-next uses that pair only for new subflow with
'subflow' type (yep, the type name is not very self-explaining :(

We just need to forbit them:

---
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d094588afad8..2ae9fac00623 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -451,7 +451,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
        /* check if should create a new subflow */
        if (msk->pm.local_addr_used < local_addr_max &&
-           msk->pm.subflows < subflows_max) {
+           msk->pm.subflows < subflows_max && !msk->pm.remote_deny_join_id0) {
                local = select_local_address(pernet, msk);
                if (local) {
                        struct mptcp_addr_info remote = { 0 };

---

> > Just does not seam worthy to me, I really think we should start with
> > the bare minumum to respect the RFC itself, avoiding as much complexity
> > as possible:
> > - setting C always to 0 on server
> > - when the peer send C==1, cache the MPC addr/port, and do not attempt
> > other connection to such endpoint.
> > 
> > I'm not even sure the latter step is strictly necessary.
> 
> For the former, it is certainly simpler to always send C==0, but sending 
> C==1 from a high-connection-count server behind a load balancer is the 
> primary use case.

I *think* it would be far better (and possibly not that complex!!!
@Florian: WDYT? ) implementing an MPTCP aware load balancer. The MPJ
syn pkt carries the remote token, so it's possible for the load
balancer to make the "correct" decision.

> I think the "MUST NOT" wording of the RFC does require the latter step 
> (server or client), and that implies a minimally functional in-kernel PM 
> would need to track some other address to connect to.

This part is unclear to me. Why should the kernel cache more
addresses? 

It's already capabale of using as many ADD_ADDRs as the peer provides
with the current options handling. Sure, there are some constraints.
The stricter one posed by the current implementation is that the kernel
fully processes (up to subflow creation) a given ADD_ADDR option before
using another one.

That is useful to avoid transforming an MPTCP client in a DDOS tool
controlled by an (evil) MPTCP server, and sounds like a reasonable
tread-off between complexity and flexibility.

Looks like we have some topic for tomorrow's mtg :)

Thanks!

Paolo

