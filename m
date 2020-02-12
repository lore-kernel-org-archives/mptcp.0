Content-Type: multipart/mixed; boundary="===============3221258253708479400=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Wed, 12 Feb 2020 10:39:39 +0100
Message-ID: <2feb5b6dd24cafd2cbd347b5029f7038220c8ea2.camel@redhat.com>
In-Reply-To: d762e4800137fb8ae4b3368edc34573e293d072e.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3623

--===============3221258253708479400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-02-11 at 18:42 +0100, Paolo Abeni wrote:
> BTW I'm wondering if we are behaving correctly WRT TCP fallback for
> passive sockets (msk->subflow =3D NULL): __mptcp_tcp_fallback() currently
> returns NULL, even if the subflow has fallback to TCP. I think/fear
> recvmsg should hang in that scenario?!? (as the server still does a
> full bloat mptcp_recvmsg(), while the client does not provide the DSS
> options).
> =

> @Davide: do we have a packetdrill to test the above? e.g. the packet
> socket is the client, it initiates an MP_CAPABLE handshake, causes
> fallback on the 3rd ack, then sends some data and (kernel) server try
> to read it with recvmsg() (possibly hanging on top of current net-next)

hi Paolo, I'm just re-building and doing a test right now. @Matthieu,
while we are at this, what do you expect for the "official" packetdrill
branch 'mptcp-net-next' [1]? can I do a pull request from my GH to that
one for those tests that are currently passing (e.g. mp_capable v1, TCP
fallback and DSN8/DACK8?)

thanks!
-- =

davide

[1] https://github.com/multipath-tcp/packetdrill

--===============3221258253708479400==--
