Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141C2C80
	for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634807973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O/dEnibUQIJlaw49LNrQKP5yKf2NgVM2MRyp6BpqAnA=;
	b=gNeHKaSNHw/px5FY/C/fPIySfoDCInVxzB4wY5e84Qz742HLJJ4Vsow/22mnbGFk1UJD3S
	4v+eaaerpMiAYE2A8+4JNGO/B1wjNRj3J+I4RW8lSc3G4TfeH3XVsFKNVJkbLFdmo42fJM
	vvGWnJz6byzISnrs89JdgwtfonUyY/4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-OhtEAuQEPQix-OKRoiAIDw-1; Thu, 21 Oct 2021 05:19:32 -0400
X-MC-Unique: OhtEAuQEPQix-OKRoiAIDw-1
Received: by mail-ed1-f71.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so20651452edj.2
        for <mptcp@lists.linux.dev>; Thu, 21 Oct 2021 02:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/dEnibUQIJlaw49LNrQKP5yKf2NgVM2MRyp6BpqAnA=;
        b=hjLeZZRKnONFmodUPcULak1urDEutri7PDEnwhTPpeRtCTXkjECasEkbNYebA+5bFF
         gv+R5POnBobAwacMUz31pjwGPpL6eixAZ3VyaHrqqvEDxx1JPndFcHpKAY7OsbYh4bCi
         8qiNKA2hE8cZTt0NgICEgeqlFFyTpxXwqMDfCA6YJd5fdi15A9rzotEqYzG3BUWlbH0u
         QYvCRcN4zL7RyGBcXC2rP4crSDeJqPIAr8lBAtzycklqFJh1SlRVtTZQ461r2FctvvSZ
         hOiW8UeE2CcTrytl0fx75Ksmx1GkGjZgeu6L7iD7zX0YWAAR06wVXLxOnY67StgfIEUN
         tx1A==
X-Gm-Message-State: AOAM531VVu6WfYAiU6NTcFIwhkxN4Nhjihwrb0ittyc6yUp2PhB7FaCP
	1BmnUvaZWDqdvjOWMW+mdK0NdtOWVYWJBdNn5CBN87xT+sCFxGNXoINbyTJMv5MBWPSQZciCKfO
	mE/bcrFH0/2gPBDY=
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr6018822edw.397.1634807970653;
        Thu, 21 Oct 2021 02:19:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysB0WOA+GcSw7MOeSKySaJR3J/qCzA0iddgEvFoRmDo6hty3Xep7DE+xUVF8cKAa/tAi6SJQ==
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr6018793edw.397.1634807970388;
        Thu, 21 Oct 2021 02:19:30 -0700 (PDT)
Received: from localhost (net-188-218-17-84.cust.vodafonedsl.it. [188.218.17.84])
        by smtp.gmail.com with ESMTPSA id r3sm2280852ejr.79.2021.10.21.02.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 02:19:30 -0700 (PDT)
Date: Thu, 21 Oct 2021 11:19:29 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: Geliang Tang <geliang.tang@suse.com>,
	Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Message-ID: <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
 <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
 <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 20, 2021 at 04:49:35PM +0200, Matthieu Baerts wrote:
> Hi Davide,
> 
> On 20/10/2021 13:33, Davide Caratti wrote:
> > hi,
> > 
> > On Wed, Oct 20, 2021 at 12:40 PM Matthieu Baerts
> > <matthieu.baerts@tessares.net> wrote:
> >>
> > [...]
> > 
> >>>
> >>> I had a script that used TC flower and gact + pedit + csum actions to flip the 'PSH'
> >>> bit in the TCP header, I promised myself to change it to corrupt the DSS option.
> > 
> > FTR, that script was:
> > 
> > # convert PSH,ACK into ACK
> > # tc filter add dev vetha egress protocol ip prio 1000 flower ip_proto
> > tcp tcp_flags 0x18/0xff action pedit ex munge tcp flags set 0x10 pipe
> > csum tcp reclassify
> > # convert ACK into PSH,ACK, 1 each 10 packets
> > # tc filter add dev vetha egress protocol ip prio 1001 flower ip_proto
> > tcp tcp_flags 0x10/0xff action pass random determ pipe 10 pedit ex
> > munge tcp flags add 0x8 pipe csum tcp
> 
> Thank you for sharing that.
> 
> I managed to change the content of a TCP packet using:
> 
>   $ tc -n <ns> qdisc add dev <iface> root handle 1: htb
> 
>   $ tc -n <ns> filter add dev <iface> parent 1: protocol ip prio 1000
> flower ip_proto tcp action pedit munge offset 148 u32 invert pipe csum tcp
> 
> It looks like nothing happen for packets smaller than 148 bytes.
> 
> Note that I had to add these to the config file:
> 

> CONFIG_NET_SCH_HTB=m

I assume you are using HTB because it's a classful qdisc and it's used to
attach the flower classifier. You don't need it, just use the clsact
qdisc (CONFIG_NET_CLS_ACT=y + CONFIG_NET_SCH_INGRESS=y), it will allow
you inserting filters+actions even if no root qdisc is in place.

# tc qdisc add dev eth0 clsact
# tc filter add dev eth0 egress matchall action simple sdata "hello"

> 
> CONFIG_NET_ACT_CSUM=m
> 
> CONFIG_NET_ACT_GACT=m
> 
> CONFIG_GACT_PROB=y
> 
> CONFIG_NET_ACT_PEDIT=m
> 
> CONFIG_NET_CLS_FLOWER=m
> 
> 
> @Geliang: do you think you could use this command?
> 
> >>> The problem with this approach is, we can't assume that the DSS option has a fixed
> >>> offset from the IP header. So, the test might start corrupting other options that
> >>> are not MPTCP.
> >>
> >> If we corrupt any data in TCP Options or data and update the TCP
> >> Checksum, that's enough to corrupt the DSS. For example, we could flip
> >> the last bit of the TCP payload (if tcp.len > 0). Would it be possible
> >> to do this by adapting your script?
> > 
> > it's easier if it's the first bit, then...
> >
[...] 
 
> >> And using simple solutions like "tc netem corrupt" will be detectable by
> >> TCP csum.
> > 
> > this can be easily workarounded using the 'csum' TC action after the
> > netem dequeue.
> 
> Good point! So we would need to create a tree with first "netem" then
> "csum" action?

the problem is, netem acts *after* TC actions. But probably in your
setup you can overcome this by making netem corrupt when xmitting, and
install the TCP csum  at  the receiver ingress (also here clsact is
helpful):

# ip link add name vetha type veth peer name vethb
# tc qdisc add dev vetha root netem <...>
# tc qdisc a dev vethb clsact
# tc filter add dev vethb ingress protocol ip flower ip_proto tcp action csum tcp

> 
> The only thing is that netem will introduce errors at random positions,
> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
> command is enough, it might help to produce more controlled tests.

maybe TC flower + action is even more accurate then netem: because it leaves
you the freedom to "corrupt" only packets after the 3WHS (or only the 3WHS,
depending on the match arguments of flower).
You can obtain the same randomization as netem by using TC "act_gact" random
feature ("CONFIG_GACT_PROB=y")

 # tc filter add dev vetha egress protocol ip prio 1001 flower \
  > ip_proto tcp \
  > tcp_flags 0x10/0xff \ <-- only the ACK BIT is set 
  > action pass random determ pipe 10 \    <-- 1 packet every 10 goes to pedit, others go out unmodified
  > pedit munge offset 148 u32 invert pipe csum tcp <-- corrupt the payload and recompute checksum

 
> Indeed it looks like it is doable but if we could not add new
> dependences, I think that would be easier for us :)

Whatever works, it's good also for me :)

-- 
davide
 

