Content-Type: multipart/mixed; boundary="===============1034859915561936797=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 5/6] mptcp: add ack work queue
Date: Mon, 11 Nov 2019 16:21:02 +0100
Message-ID: <20191111152102.GA19558@breakpoint.cc>
In-Reply-To: ab80d76332d747c1b44ae39bc46503826b7b5b27.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2463

--===============1034859915561936797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Since mptcp_ack_work() matches closely the initial bits of
> mptcp_retransmit(), In this specific scenario I think reusing the
> existing worker (plus flag) would be better.

Done: https://git.breakpoint.cc/cgit/fw/mptcp-next.git/commit/?h=3Dwmem_acc=
t_05&id=3Dfea55d959e29da51c605dad9c5e84544622d1b49

I'll resend once others had a chance to look at this series as well.
--===============1034859915561936797==--
