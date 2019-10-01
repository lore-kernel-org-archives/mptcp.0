Content-Type: multipart/mixed; boundary="===============4627525550283324105=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 17:34:24 +0200
Message-ID: <20191001153424.GF14819@breakpoint.cc>
In-Reply-To: 4a7f4996-eac5-2601-2a8f-ff720b9bec4f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1954

--===============4627525550283324105==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
> > For RFC I think it depends on how much work you want to
> > get yourself into right now, as it would need to be squashed, sending
> > it as extra patch is strange.
> =

> In general. It is linked to my message I sent on the thread linked to
> the patch:

Ah, thanks for the pointer.

> > The main part of this patch is removing the parsing of the checksum
> > option. But in the commits where this is introduced, we also parse
> > other possible options we could have and we act differently if one
> > option is not supported. And in these commits, it makes sense to do
> > that.
> >
> > We could see that as "we are parsing stuff we don't need". But we are
> > already doing that for the "backup" bit for example. Or for the
> > "MP_JOIN" while we don't support it when subflow_request_sock
> > structure is introduced, etc.
> >
> > In other words, do we really need to remove this code linked to the
> > checksum? If we plan never to support it, it makes sense. But I guess
> > in the near future, we will want to support it, no?
> >
> > So should I continue applying this patch?

Oh, OK. I thought the consensus was to not support checksums.
If we're going to add it for the initial mptcp v1 submission, the code
should be kept.

OTOH, if we're going to add checksums later on -- after initial
upstreaming -- I think its better to remove it now and resurrect it later
once someone adds the feature.
--===============4627525550283324105==--
