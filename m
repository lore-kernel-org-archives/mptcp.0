Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924381378
	for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671180338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlffwgiZ+Z5k6HhZ1rCf8pU7sKNOIBF5KVP7lzhDgU8=;
	b=PbP0UsPQnw5PrN71GfaWjvCRyPjYY293sjAwOhfRUc74t7lXuSgEreXL2or06P+KzfQ/Rt
	aGg/69GlQb9OI8+soruqjLv6VW5IGaIxeoBMqO7HfIJ5m/1MjienMYwIVF+BvFIKHdTsji
	h302HkvlYSOYraMe3X0qhQIMs7itf7E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-V0RIF-UeOcuDWaDUUCCcAA-1; Fri, 16 Dec 2022 03:45:29 -0500
X-MC-Unique: V0RIF-UeOcuDWaDUUCCcAA-1
Received: by mail-wm1-f70.google.com with SMTP id bi19-20020a05600c3d9300b003cf9d6c4016so2296336wmb.8
        for <mptcp@lists.linux.dev>; Fri, 16 Dec 2022 00:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlffwgiZ+Z5k6HhZ1rCf8pU7sKNOIBF5KVP7lzhDgU8=;
        b=FCLdWiVyX+jQ07SgJ3lJvoRo1FMLbCDEEPEQbad65Pp7xsWss3HwLdfIc3yEpdQ/mg
         vD3hALJnvGlp55bVlMdXXaqInsII+dE+nirWuWQVYLJi0EwsD4pjssGp1To45KVkxDWI
         8ZlForsgJRkcWATKsrwqokh0L62epcbaq4uReUDcFm2+dP3rmEpjM/LIwQYp4F4ICXwt
         YkKSpHmAZJIYWx/CTEQvuajpUhSWkhk6g1vQguCx40KQf30AUjb/PFHBTJi1KR0/knf9
         eoozMKT1EuJP1Q8D66Ca/9Dv1nPevVUPfHDxK60P2nFMpxpfoutQM2e1krML/rIzVxUj
         PyBw==
X-Gm-Message-State: AFqh2krRIE1KKJZ2yQp/GQgt+ZcgnCBw7K1KBLFsC0DrHJPKFzzb5tk0
	5Ej5yLseMJm4fZJBCPyetoShQZCwkSa2twR7iCnlz5EO/xiGptiiUy1mi4tynFhGSWIfX/xsKQs
	he06wrkeC4HECt3A=
X-Received: by 2002:a05:600c:54ed:b0:3d3:3c74:dbd0 with SMTP id jb13-20020a05600c54ed00b003d33c74dbd0mr3569734wmb.13.1671180328656;
        Fri, 16 Dec 2022 00:45:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsHYMxpKSMH0p0+4nPDoXiC8kBjSvYhsju5aFOSsDTO1S8IPrc1VMjVAtNvaTonuZ7jeKEA1Q==
X-Received: by 2002:a05:600c:54ed:b0:3d3:3c74:dbd0 with SMTP id jb13-20020a05600c54ed00b003d33c74dbd0mr3569717wmb.13.1671180328349;
        Fri, 16 Dec 2022 00:45:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c092300b003b3307fb98fsm1736876wmp.24.2022.12.16.00.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 00:45:27 -0800 (PST)
Message-ID: <7da5b207620795939388bf906ebbc443b4d7fa75.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v8 2/4] mptcp: add statistics for mptcp
 socket in use
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>
Date: Fri, 16 Dec 2022 09:45:26 +0100
In-Reply-To: <CADxym3aXUg5uhwTvUYTh9PGXcCyUvM92h-C3Z_GbOap=fYvb9g@mail.gmail.com>
References: <20221208024543.113633-1-imagedong@tencent.com>
	 <20221208024543.113633-3-imagedong@tencent.com>
	 <d6bcf7e63c35d5769fd6496ae6d23a283e36a678.camel@redhat.com>
	 <CADxym3aXUg5uhwTvUYTh9PGXcCyUvM92h-C3Z_GbOap=fYvb9g@mail.gmail.com>
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

On Fri, 2022-12-16 at 16:01 +0800, Menglong Dong wrote:
> Hello,
> 
> On Tue, Dec 13, 2022 at 12:35 AM Paolo Abeni <pabeni@redhat.com> wrote:
> > 
> > On Thu, 2022-12-08 at 10:45 +0800, menglong8.dong@gmail.com wrote:
> > > From: Menglong Dong <imagedong@tencent.com>
> > > 
> > > Do the statistics of mptcp socket in use with sock_prot_inuse_add().
> > > Therefore, we can get the count of used mptcp socket from
> > > /proc/net/protocols:
> > > 
> > > & cat /proc/net/protocols
> > > protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> > > MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > > MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
> > > 
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> > > v8:
> > > - remove the MPTCP_INUSE flag and do the statistics according to the
> > >   creation and destruction of the token
> > > 
> > > v6:
> > > - introduce the 'MPTCP_INUSE' flag and check if msk is in use by it
> > > 
> > > v5:
> > > - rebase to solve merge conflict
> > > 
> > > v4:
> > > - rename MPTCP_DESTROIED to MPTCP_DESTROYED
> > > 
> > > v2:
> > > - decrease the statistics for listening mptcp socket inuse with
> > >   mptcp_listen_inuse_dec()
> > > - add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
> > >   called on the msk. For fallback case, we need to decrease the
> > > ---
> > >  net/mptcp/protocol.c | 16 +++++++++++++++-
> > >  net/mptcp/token.c    |  7 +++++++
> > >  2 files changed, 22 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index ffdccf26af99..775454a9d49b 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -3005,6 +3005,16 @@ void mptcp_copy_inaddrs(struct sock *msk, const struct sock *ssk)
> > >       inet_sk(msk)->inet_rcv_saddr = inet_sk(ssk)->inet_rcv_saddr;
> > >  }
> > > 
> > > +static void mptcp_listen_inuse_dec(struct sock *sk)
> > > +{
> > > +     struct mptcp_sock *msk = mptcp_sk(sk);
> > > +     struct socket *ssock;
> > > +
> > > +     ssock = __mptcp_nmpc_socket(msk);
> > > +     if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
> > 
> > Here I think you can check directly: sk->sk_state == TCP_LISTEN, which
> > should be both simpler and safer, since this should be called under the
> > (m)sk socket lock.
> > 
> 
> Then, mptcp_listen_inuse_dec() needs to be called before msk
> enters TCP_CLOSE state, which means __mptcp_close()
> and mptcp_disconnect(). Do I miss any case that a listening
> msk enters TCP_CLOSE state?

AFAIK, that is correct. Note that the number of hooks will not change
compared to the current patch revision (mptcp_disconnect() +
mptcp_destroy()).


Cheers,

Paolo

