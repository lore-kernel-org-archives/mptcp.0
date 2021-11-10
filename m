Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD672C80
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1636544766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XMS4fzGw6i9bZgm3ULt2pnfzrJ7SEbKA7DsQv6NDXdE=;
	b=fqU/me0LsHM+sC4oNkyCL++4M2xlDb9Ghjv4h8ZU7NLWQ42shT3Ek6kpjgrrkPEvvFCuyj
	4ef6nz1L1bny/mNxhdwKujKIVjC7q7gXnECDuomFheOrcmizhmGyw6vn+xRkEnJFA3ygFN
	x6VM4VcNeveT4puZs6KNGzcazDVfAYY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-uG_tLEBiP86gVruUHG2YkQ-1; Wed, 10 Nov 2021 06:46:05 -0500
X-MC-Unique: uG_tLEBiP86gVruUHG2YkQ-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cd00b003e35ea5357fso2114472edb.2
        for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 03:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XMS4fzGw6i9bZgm3ULt2pnfzrJ7SEbKA7DsQv6NDXdE=;
        b=s3tTIqEslzOr8bocd1b5x6i9vEm2sV3+knUuqSyLQvKmlDxyiZnhtpnOyPOmGq6hsz
         qMu34DHVmA340GeFp72zmxz8qa68wv4PsK/9BfTPdwkbWapmf8h5VKfO4RUD0ziCXybq
         d2V9tUQFEZHR7nJaipaF4y9Y8+i9ljLJWlmnWUiEv+cs0aRKVB/+K76tHak2M4rB/5Gt
         /bhF66niC3rwacAmjIjLAOsdNG/rMpLLpWhYtXdgqUWMMxmNm6+GOarxrvmYpDHx4KVM
         sOqhkmtq0SZMff3QRdHjxVMz06tpg1DcZiX3eVkbAZglnH/Myhg2/ATStctOhq8qJl3J
         5MUg==
X-Gm-Message-State: AOAM530JxtLDa99+bnQh8/ozVPhoxPs9RtOxLGvVUb5CR276q0tboW79
	6CCKhc0x4w4G4SeuxzbI5jwRSP60Uq5OfSepm2v1D/n11Twi4A9Q/MZshI39+FvqKvs7wRhD7N3
	Fxas0DvvhtQVJk/E=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr20050464edr.275.1636544764313;
        Wed, 10 Nov 2021 03:46:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxx0POOQacEAfQmTAeWxGQc7gvJSgw2m8MDg5yZlfbjEzsyjcA04UARYHcecg64uyiDLLYQJw==
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr20050433edr.275.1636544764078;
        Wed, 10 Nov 2021 03:46:04 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-224-97.dyn.eolo.it. [146.241.224.97])
        by smtp.gmail.com with ESMTPSA id ca4sm11103183ejb.1.2021.11.10.03.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:46:03 -0800 (PST)
Message-ID: <9ebe8731335efceb98088549fbdfd1f1a2bed92c.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 10 Nov 2021 12:45:59 +0100
In-Reply-To: <20211110113751.GG16363@breakpoint.cc>
References: <7bfe33f96550ffd6efaa3266f6027a8d7c500b70.camel@redhat.com>
	 <67929b99f9baaf448457bf2cd5efce430dd1a2d9.camel@redhat.com>
	 <20211110113751.GG16363@breakpoint.cc>
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

On Wed, 2021-11-10 at 12:37 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > Whoops, I omitted the ML in my reply, sorry...
> > 
> > @Florian: sorry for the dups! please reply to this one, if needed, to
> > re-include properly the ML into the thread.
> > 
> > On Wed, 2021-11-10 at 09:53 +0100, Florian Westphal wrote:
> > > Paolo Abeni <pabeni@redhat.com> wrote:
> > > > > +	if (sk->sk_state == TCP_LISTEN)
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> > > > > +		return 0;
> > > > > +
> > > > > +	delta = READ_ONCE(msk->write_seq) - v;
> > > > 
> > > > This is under the msk socket lock and write_seq is protected by the
> > > > full/plain msk socket lock so READ_ONCE should not be necessary, I
> > > > think. The same for 'snd_nxt' below. 
> > > 
> > > Then why is write_seq updated with WRITE_ONCE in lots of places?
> > 
> > 'write_seq' is read outside the msk socket lock scope in a few places. 
> 
> Bah.  You are right. TBH I do not understand READ|WRITE_ONCE usage in
> mptcp anymore.  Maybe its correct, who knows.
> 
> The different locking schemes are not easy to follow for me.

Indeed I agreed!

I *think* (mostly guess) some _ONCE() annotation are now obsoleted/made
unnecessary by the several re-factors.

For sure we need to document clarely the locking schema (where? how?
would comments on the protectect fields suffice?) and possibly/likely
review the current annotations.

> > BTW this always reports '1' on fallback sockets after shutdown, as
> > after shutdown write_seq is incremented by 1, but snd_una/snd_nxt are
> > not incremented when receiving the TCP fin. I guess the fix not
> > strictly related to this patch.
> 
> That should be ok, we should return nonzero inq hint when next read()
> would indicate EOF.

This is for the outq ?!? I think it should be 0 after all outstanding
data is acked ?!?

Thanks!

Paolo

