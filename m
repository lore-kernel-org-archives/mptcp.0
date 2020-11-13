Content-Type: multipart/mixed; boundary="===============1085364097882112089=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: refactor shutdown and
 close" again
Date: Fri, 13 Nov 2020 17:24:50 +0100
Message-ID: <46534e77-88c8-b819-37cf-3b4d3db9a4c9@tessares.net>
In-Reply-To: 9527070ab1b0bb6d890d2a7960ada035a610edae.1605283639.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6714

--===============1085364097882112089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/11/2020 17:07, Paolo Abeni wrote:
> fix bad mask and fallback shutdown

Thank you for the patch!

As agreed on IRC, I added your patch after "mptcp: refactor shutdown and =

close". If a v3 is needed for upstream, I can squash this into the =

parent commit.

- 49c0a2e04f14: Squash-to: "mptcp: refactor shutdown and close" again
- Results: 220dff67a96e..8ad8e1a1ec77

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============1085364097882112089==--
