Content-Type: multipart/mixed; boundary="===============5183299085439383450=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: RFCv2 for netdev: what's missing?
Date: Tue, 01 Oct 2019 22:26:15 +0200
Message-ID: <084dc8aa2f8cc66257f78dddea9fb3f1e5188710.camel@redhat.com>
In-Reply-To: 7ffdb764-0ba6-a8e7-afdf-9b38acf374a2@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1979

--===============5183299085439383450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-01 at 21:40 +0200, Matthieu Baerts wrote:
> On 01/10/2019 19:21, Mat Martineau wrote:
> > On Tue, 1 Oct 2019, Matthieu Baerts wrote:
> > =

> > > What do we still need to do?
> > > - the cover letter: Mat is it still OK to do it on your side?
> > =

> > Here's the cover letter draft:
> =

> Thank you for having prepared the new draft!

+1! ;)

> > """
> > The MPTCP upstreaming community has prepared a net-next RFCv2 patch set
> > for review.
> > =

> > Clone/fetch:
> > https://github.com/multipath-tcp/mptcp_net-next.git (tag: netdev-rfcv2)
> > =

> > Browse:
> > https://github.com/multipath-tcp/mptcp_net-next/tree/netdev-rfcv2
> > =

> > With CONFIG_MPTCP=3Dy, a socket created with IPPROTO_MPTCP will attempt=
 to
> > create an MPTCP connection but remains compatible with regular
> > TCP. IPPROTO_TCP socket behavior is unchanged.
> > =

> > This implementation makes use of ULP between the userspace-facing MPTCP
> > socket and the set of in-kernel TCP sockets it controls. ULP has been
> > extended for use with listening sockets. skb_ext is used to carry MPTCP
> > metadata.
> > =

> > The patch set includes self-tests to exercise MPTCP in various
> > connection and routing scenarios.
> > =

> > We have more work planned to reach the initial feature set for merging,
> > notably:
> > =

> > * IPv6
> > =

> > * Comply with MPTCPv1 (RFC6824bis). This patch set supports only
> >   MPTCPv0 (RFC 6824 / experimental)
> > =

> > * Proper MPTCP-level connection closing with DATA_FIN
> > =

> > * Couple receive windows across sibling subflow TCP sockets as required
> >   by RFC 6824
> > =

> > * Limit subflow ULP visibility to kernel space
> > =

> > * Simple transmit scheduler that respects subflow 'backup' flags
> =

> If we want to push a smaller patch upstream, will we implement all of
> these features?
> =

> Should we also mention that in this potential first part, if OK for
> upstream, we would expect to have everything up to commit introducing
> the kselftests + a new one introducing IPv6 support?

I think it would be a very good idea to try split all the above in 2 or
more slices. If there is agreement about that plan we could rephrase
with something alike:

"""
We have more work planned to reach the initial feature set notably:
"""

[same list as above]

"""
In order to simplify both the code review and the develpment process we
propose to split the above in smaller chunks, the first one including
everything presented here up to selftest, with the addition of basic
IPv6 support.
"""

WDYT?

Thanks,

Paolo

--===============5183299085439383450==--
