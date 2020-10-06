Content-Type: multipart/mixed; boundary="===============1937882691246867203=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: mptcp: move page frag
 allocation in mptcp_sendmsg()
Date: Tue, 06 Oct 2020 14:20:35 +0200
Message-ID: <57cb8722-066d-7354-bf42-50420b436c74@tessares.net>
In-Reply-To: 6176a5b0d2a773b4b623e00e11c86fb784457756.1601888417.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6214

--===============1937882691246867203==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 05/10/2020 11:00, Paolo Abeni wrote:
> This, as suggested by Florian, avoid probe coalescing, which
> will hit a later WARN_ON_ONCE() and will cause stream corruption.
> =

> Additionally bail early when the MPTCP win is closed an no
> probe.

Thank you for the patch!

I guess it was for "mptcp: keep track of advertised windows right edge" =

commit and not "mptcp: move page frag allocation in mptcp_sendmsg()".

- 04554e1b1dfa: "squashed" in "mptcp: keep track of advertised windows =

right edge"
- Results: 345ad770cca7..10c53117392d

tests + export are going to be started soon.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1937882691246867203==--
