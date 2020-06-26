Content-Type: multipart/mixed; boundary="===============0835225725669626005=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: add MPTCP socket diag interface
Date: Fri, 26 Jun 2020 09:19:51 -0700
Message-ID: <20200626161951.GG2513@MacBook-Pro-64.local>
In-Reply-To: 796242d444a52afeaed649affb6a2401aa43c48c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4821

--===============0835225725669626005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/26/20 - 12:33, Davide Caratti wrote:
> On Fri, 2020-06-26 at 09:53 +0200, Paolo Abeni wrote:
> > I can replace 'can_ack' and 'fallback' with a 32bit flags. =

> =

> I support this: in the future we might want to add additinal states to
> control TCP fallback (specifically, add the possibility to disallow it)

+1 for 32bit flags.

> > Perhaps I can use a better name for the first bit (suggestion welcome!)=
 I
> > would opt for 'remote_key', WDYT?
> =

> this variable becomes true when it's possible to use the 64-bit key
> received by the peer, generate the DACK4 / DACK8 number (probably it's
> used also for other purposes, right?) if so, what about 'remote_key_valid'
> ?

Or "remote_key_set" or "remote_key_received" ?

Because "valid" has a notion that the remote-key could also become "invalid=
",
which is not really the case.


Christoph

--===============0835225725669626005==--
