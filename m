Content-Type: multipart/mixed; boundary="===============1458292856546582319=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: add ADD_ADDR IPv6
 support
Date: Mon, 21 Sep 2020 16:02:24 +0200
Message-ID: <be15bba9a03fe0f7153e00041041fd77954beac4.camel@redhat.com>
In-Reply-To: 20200921111222.GA27188@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 5963

--===============1458292856546582319==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-21 at 13:12 +0200, Florian Westphal wrote:
> Geliang Tang <geliangtang(a)gmail.com> wrote:
> > When ADD_ADDR suboption include an IPv6 address, the size is 28
> > octets.
> > It will not fit when other options are included, e.g. TCP
> > Timestamps. So
> > here we send out a mptcp dedicated packet to carry only mptcp
> > options.
> =

> Note that RFC 7323 requires TCP TS to be included for the remainder
> of
> the connection.  It even recommends TCP peers to drop segments that
> do
> not carry a timestamp option in case the connection has TCP TS
> enabled.

IIRC, we discussed the above some mtg ago, and mptcp.org is currently
doing that (dropping the TS option on forged ack packet to allow for
extra MPTCP-level opts). Still IIRC, the main point was that the TS
option will be dropped on very rare occasion and only on "duplicate"
ack/ack forged by MPTCP to pass along ADD_ADDR/DELETE_ADDR info or the
like - relevant timing information should not be lost.

@Christoph: is the above somewhat correct?

With a quick check, it looks like linux is not dropping packets with
missing TS option even when such option has been negotiated.

Cheers,

Paolo

--===============1458292856546582319==--
