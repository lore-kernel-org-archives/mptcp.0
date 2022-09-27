Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0523BE
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664287924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MBQlkzNVqnxVMG6dUP/GQGnPLyiblZeKd25PeiTSQ0w=;
	b=GDsXa7Kf9SQjXeaamRANEc8V7Lm0p1lfk5fpuwZrPRSW7XEKdkonYKLNq25La3C/UtRIN+
	iO/2kSkf/hHvqYXWLCfY75afYVEoWwDUQYUngouS0oM0qkMr1phoHBOb35c9/D4pLl7DEm
	GihRDMVIifgQMZphGz+NYfltNGjNag8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-550-SdMHTaULNby8mmpuSyKNDw-1; Tue, 27 Sep 2022 10:12:03 -0400
X-MC-Unique: SdMHTaULNby8mmpuSyKNDw-1
Received: by mail-qk1-f200.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so7404967qkp.19
        for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=MBQlkzNVqnxVMG6dUP/GQGnPLyiblZeKd25PeiTSQ0w=;
        b=e0OhiZ8QwSo11wUZWFW4x/Ov/eqQdT4Cpfp4qMwGBLwAukhIkqwg+BJnVov33BvfPO
         2cXQ4ve7P0EtOesnm9uoEYdsffIO/ob5nzEtWiNrJwn3O2MQOpBdE1qwon7zFRKjvELF
         PkVE1yVjdEelP8Fc+aRqJzbozHn/QYrblr3a4SSZGNJkK7/zTebVy97ZJgrjbYItl+xg
         EDDdcIRxa4MHBFhJEksZ6qkMke1atLSbhInFnqqHWpnmrAQvIz/QN/9yvWDI3Q56yNIi
         waEDi3kjzDtvQ3rCeHPsk66F+bf5DkVlzp0WNzHiLqqxw46km/mbAErIHOTTHYpwXLX3
         qvBg==
X-Gm-Message-State: ACrzQf2uu6Kix1Ujj4MT5KwTZjvVjc7rrR0I7gkc/oBdQpG7xStFy1jn
	0Z+nXOgL0mbZPFnwvKVOsyyTO/AChz8E546bgQjb3y56vErf0jfKqTDkzHH+J51SH/r5JFA9BSh
	Fq8qHoA5OjWeEKog=
X-Received: by 2002:a05:6214:2a47:b0:4af:61e4:3934 with SMTP id jf7-20020a0562142a4700b004af61e43934mr11381511qvb.97.1664287922267;
        Tue, 27 Sep 2022 07:12:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM67lNhmq/oq+XZbsW3pfJYt+M7UjkNOMv6ROyGsNC04ReX0KEDPT2yOI2Z79evLND2ekgZy5Q==
X-Received: by 2002:a05:6214:2a47:b0:4af:61e4:3934 with SMTP id jf7-20020a0562142a4700b004af61e43934mr11381487qvb.97.1664287921913;
        Tue, 27 Sep 2022 07:12:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id dm12-20020a05620a1d4c00b006ceda7a9283sm1106038qkb.48.2022.09.27.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:12:01 -0700 (PDT)
Message-ID: <0a6a01130bc558691a0fcd8dab0f2ac77fda199f.camel@redhat.com>
Subject: Re: MPTCP upstreaming, week of 26-Sept-2022
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 27 Sep 2022 16:11:58 +0200
In-Reply-To: <2d24f789-9fc1-0229-4b37-ff570c4be080@tessares.net>
References: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>
	 <2d24f789-9fc1-0229-4b37-ff570c4be080@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2022-09-27 at 10:07 +0200, Matthieu Baerts wrote:
> Hi Mat, Paolo,
> 
> On 27/09/2022 02:10, Mat Martineau wrote:
> > 
> > Matthieu and Paolo -
> > 
> > I upstreamed the fastopen changes for net-next today, so those are in
> > the patchwork queue for the netdev maintainers:
> > 
> > https://patchwork.kernel.org/project/netdevbpf/list/?series=680767
> 
> Thank you!
> 
> > The other patch sets we discussed upstreaming in the meeting last week
> > were:
> > 
> >     - Fixes for -net:
> > 
> >         - [6e827151a607] mptcp: factor out __mptcp_close() without
> > socket lock (Menglong Dong)
> >         - [62b5536f77f6] mptcp: fix unreleased socket in accept queue
> > (Menglong Dong):
> >             - can wait a bit more and can be sent next week
> > 
> > 
> >     - Features for net-next:
> > 
> >         - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
> >         - [885cab8b5203] mptcp: use fastclose on more edge scenarios
> > (Paolo Abeni)
> >         - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose
> > test-cases (Paolo Abeni):
> >             - can wait a bit, Paolo would like to have a look at the
> > modification on packetdrill side
> > 
> > 
> > I'm planning to upstream the two -net patches on Tuesday unless someone
> > objects.
> 
> Sounds good to me.
> 
> > The net-next patches are slightly more complicated:
> > 
> >  * They were updated with a squash-to patch today
> >  * Need to wait until fastopen patches are merged
> 
> We should at least wait for the fastopen patches to be applied I suppose.
> 
> >  * There is a minor conflict with the -net patches (just diff context)
> >    in "mptcp: use fastclose on more edge scenarios".
> > 
> > 
> > Regarding the conflict, I could wait until Friday for a likely
> > net/net-next sync.
> > 
> > Another option is to modify the patch slightly by moving
> > mptcp_check_readable() before __mptcp_check_send_data_fin(), it doesn't
> > make the diff any larger and avoids the -net conflict. What do you think?
> 
> We can also add a note in the commit and explain how to fix this
> conflict. I think the function is at the right place but it can also be
> moved if it eases stuff.


I think there is no rush for that patches. If the net patches will land
upstream soon, they will be likely merged by EoW. If there will be
another RC, we can rebase the net-next and send out still for 6.1,
othewise the fastclose patches can wait IMHO a few more weeks.

Cheers,

Paolo

