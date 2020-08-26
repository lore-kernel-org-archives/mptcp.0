Content-Type: multipart/mixed; boundary="===============1085376882781036571=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: packetdrill MP_JOIN failures
Date: Wed, 26 Aug 2020 12:03:33 +0200
Message-ID: <44cb02c4f51c749c6533d254d90e2a5c2f625856.camel@redhat.com>
In-Reply-To: c604be2ac566d83ca0f4c3e85594cf0552c6a887.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5626

--===============1085376882781036571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-25 at 22:47 +0200, Davide Caratti wrote:
> hello,
> =

> after commit 3960b799b496 ("mptcp: allow creating non-backup subflows"),
> the mp_join_client.pkt packetdrill scenario detects a mismatch in the
> contents of MP_JOIN SYN: when the server's additional address is
> transmitted through an ADD_ADDR, the client has no way to set the 'B'
> flag [1]. If I well understand, we can toggle the 'B' flag using the
> MP_PRIO suboption, but this is not yet in mptcp-net-next [2].
> =

> Given the current state of mptcp-net-next, I'm for removing the 'B' flag
> from the current test [2] and adding another specific test case once the
> support for MP_PRIO is implemented (by the way, in case nobody is
> already planning to do it I can have a look at it in the next days).
> =

> Any opinions/feedback appreciated, thank you in advance!

That looks the easier option and is looks reasonable to me.

Additionally and not completely related, we could extend the netlink
interface to let user space configure the backup flag for subflows
created in response to ADD_ADDR options.

@Christoph: how does mptcp.org behave WRT the above?

Thanks!

Paolo



--===============1085376882781036571==--
