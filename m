Content-Type: multipart/mixed; boundary="===============2123493094515360971=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN processing for
 orphaned sockets.
Date: Wed, 17 Feb 2021 20:50:29 +0100
Message-ID: <6785d6bd-f2b7-d2f5-09f2-9757f305ea26@tessares.net>
In-Reply-To: 723de05edd19a88776331f585deb6ce72d959eca.1613398456.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7832

--===============2123493094515360971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 15/02/2021 15:14, Paolo Abeni wrote:
> Currently we move orphaned msk socket directly from FIN_WAIT2
> state to close, with the rationale that incoming additional
> data could be just dropped by the TCP stack/TW sockets.
> =

> Anyhow we miss sending MPTCP-level ack on incoming DATA_FIN,
> and that may hang the peers.
> =

> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Thank you for the patch and the review!

Just applied in our tree with Mat's RvB tag, without the dot at the end =

of the commit title and typos spotted by codespell.
@Paolo: please use this version if you send that to netdev :)

- 97e35721a7af: mptcp: fix DATA_FIN processing for orphaned sockets
- Results: 230a407eae19..afc69f9d3c92

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2123493094515360971==--
