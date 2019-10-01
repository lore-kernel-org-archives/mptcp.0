Content-Type: multipart/mixed; boundary="===============7282634711916695578=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 09:14:05 -0700
Message-ID: <982717412a581be545dfc284021bf71d8fab7327.camel@linux.intel.com>
In-Reply-To: 20191001153424.GF14819@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1957

--===============7282634711916695578==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-01 at 17:34 +0200, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > > For RFC I think it depends on how much work you want to
> > > get yourself into right now, as it would need to be squashed, sending
> > > it as extra patch is strange.
> > =

> > In general. It is linked to my message I sent on the thread linked to
> > the patch:
> =

> Ah, thanks for the pointer.
> =

> > > The main part of this patch is removing the parsing of the checksum
> > > option. But in the commits where this is introduced, we also parse
> > > other possible options we could have and we act differently if one
> > > option is not supported. And in these commits, it makes sense to do
> > > that.
> > > =

> > > We could see that as "we are parsing stuff we don't need". But we are
> > > already doing that for the "backup" bit for example. Or for the
> > > "MP_JOIN" while we don't support it when subflow_request_sock
> > > structure is introduced, etc.
> > > =

> > > In other words, do we really need to remove this code linked to the
> > > checksum? If we plan never to support it, it makes sense. But I guess
> > > in the near future, we will want to support it, no?
> > > =

> > > So should I continue applying this patch?
> =

> Oh, OK. I thought the consensus was to not support checksums.
> If we're going to add it for the initial mptcp v1 submission, the code
> should be kept.

I concur, my understanding was that we would not support checksums in the
initial upstreaming, and no one volunteered that they might add it later, b=
ut
only suggested that it wasn't a useful feature.

This is why I prepared the patch. Sorry it doesn't squash more easily....

Peter.



> OTOH, if we're going to add checksums later on -- after initial
> upstreaming -- I think its better to remove it now and resurrect it later
> once someone adds the feature.
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org

--===============7282634711916695578==--
