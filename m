Content-Type: multipart/mixed; boundary="===============4597471313761477178=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/3] mptcp: add fastclose option
Date: Thu, 26 Nov 2020 15:35:03 +0100
Message-ID: <36da4a96-332b-5d17-54c8-1e37b730af59@tessares.net>
In-Reply-To: 20201125174956.9222-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6952

--===============4597471313761477178==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 25/11/2020 18:49, Florian Westphal wrote:
> This series adds receive side support for fastclose processing.
> First patch is needed to avoid UAF after enabling option processing
> for tcp resets. Second patch calls mptcp option parsing also for
> reset patckets so fastclose-on-tcp-reset is handled.
> =

> Last patch adds fastclose handling.
> =

> I've submitted a pull request vs. packetdrill to add test cases for
> this: https://github.com/multipath-tcp/packetdrill/pull/25
> =

> Those are the three test cases i posted earlier to this list plus
> a 4th test to also cover the 'two subflows closed via fastclose+reset' ca=
se.
> =

> I would send the fastclose tx side next.

Thank you for these patches, they are very good!

Just added at the end of our tree with my Reviewed-by tag (there were =

other reviewers on the previous patches, I can of course add more tags =

if the new version is OK for others):

- 6766eaff5c84: mptcp: hold mptcp socket before calling tcp_done
- 37a53605cd6b: tcp: parse mptcp options contained in reset packets
- 0b9d6f3f5a2b: mptcp: parse and act on incoming FASTCLOSE option
- Results: 9e11c1d2b8db..ba6c5ecb4ea5

Tests + export are in progress!

> I plan to hold the MPTCP reset patches back for the time being until
> netlink + mptcpd are aware of its existence.

I certainly missed something here but are you here talking about =

MP_TCPRST support? Or still about the send of fast-close?

If it is about fast-close, why netlink + mptcpd needs to be aware first? =

Could we eventually send fast-close when the userspace app (here using =

packetdrill format) does this:

     setsockopt(<fd>, SOL_SOCKET, SO_LINGER, {onoff=3D1, linger=3D0}, 8);
     close(<fd>);

(if we accept this socket option)
No rush of course, just in case these patches were already written :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4597471313761477178==--
