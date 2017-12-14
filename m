Content-Type: multipart/mixed; boundary="===============4242612150745749343=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v3 04/15] tcp: Allow tcp_fast_parse_options to drop
 segments
Date: Thu, 14 Dec 2017 12:18:07 -0800
Message-ID: <20171214201807.GH64966@da0602a-dhcp135.apple.com>
In-Reply-To: 20171214201340.GG64966@da0602a-dhcp135.apple.com
X-Status: 
X-Keywords:                  
X-UID: 261

--===============4242612150745749343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 14/12/17 - 12:13:40, Christoph Paasch wrote:
> On 12/12/17 - 16:28:31, Mat Martineau wrote:
> > =

> > On Mon, 11 Dec 2017, Christoph Paasch wrote:
> > =

> > > The TCP extra-options parser might decide to drop the segment based on
> > > the present option. Especially, for TCP_MD5, we want to do this as so=
on
> > > as possible (thus, right after the parsing).
> > > =

> > > This patch allows to do this by splitting out tcp_fast_parse_options(=
) in
> > > tcp_validate_incoming().
> > > =

> > > Originally, tcp_fast_parse_options() returned false, when there is no
> > > timestamp option (except in the case of the slow-path processing thro=
ugh
> > > tcp_parse_options() where it always returns true.
> > =

> > Minor nitpick: unmatched paren above.
> =

> Thanks, I fixed this.

Also, changed the commit-message to the below text to avoid the mention of
extra-options explicitly:

=3D=3D=3D=3D=3D
tcp: Allow tcp_fast_parse_options to drop segments

After parsing the TCP-options, some option-kinds might trigger a drop of
the segment (e.g., as is the case for TCP_MD5). As we are moving to
consolidate the TCP_MD5-code in follow-up patches, we need to add the
capability to drop a segment right after parsing the options in
tcp_fast_parse_options().

Originally, tcp_fast_parse_options() returned false, when there is no
timestamp option, except in the case of the slow-path processing through
tcp_parse_options() where it always returns true.

So, the return-value of tcp_fast_parse_options() was kind of
inconsistent. With this patch, we make it return true when the segment
should get dropped based on the parsed options, and false otherwise.

In tcp_validate_incoming, we will then just check for
tp->rx_opt.saw_tstamp to see if we should verify PAWS.

The goto will be used in a follow-up patch to check whether one of the
options triggers a drop of the segment.


--===============4242612150745749343==--
