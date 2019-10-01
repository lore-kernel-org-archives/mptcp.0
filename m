Content-Type: multipart/mixed; boundary="===============9028939941293135354=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 18:07:14 +0200
Message-ID: <f0c3bf7a670c367beeda1ba8a79f8646730a52bb.camel@redhat.com>
In-Reply-To: 405a1158-e814-af18-80da-59fc7369070f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1955

--===============9028939941293135354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-01 at 17:07 +0200, Matthieu Baerts wrote:
> On 01/10/2019 16:58, Paolo Abeni wrote:
> > Hi,
> > =

> > Thank you for raising this topic!
> > =

> > On Tue, 2019-10-01 at 16:37 +0200, Matthieu Baerts wrote:
> > > At the last meeting, we said it would be good to send a new RFCv2 to
> > > netdev before the next meeting while windows are closed. I guess today
> > > would be good, no?
> > =

> > Agreed ;)
> > =

> > > What do we still need to do?
> > > - the cover letter: Mat is it still OK to do it on your side?
> > > - any other patches to apply before this?
> > =

> > I personally think we can go even with the current git tree.
> > If we want to flush part of the pending backlog I would go only for
> > already accepted patches:
> > =

> > [...]
> > > - mptcp: allow dumping subflow context to userspace: can be applied
> > > - mptcp: allow MPTCP sockets by default: can be applied
> > =

> > The above ones: ^^^
> > =

> > The above to avoid possible last minute issues.
> =

> Make sense, thank you!
> So better for you to wait before removing traces of the Checksum then?

No strong opinion on this point, I'm ok either way. Likely, if are not
going to include csum support in the short term, it would be better
drop it down.

Cheers,

Paolo

--===============9028939941293135354==--
