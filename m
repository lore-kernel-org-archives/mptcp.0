Content-Type: multipart/mixed; boundary="===============6188790621719470011=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: add mptcp reset option support
Date: Thu, 25 Feb 2021 16:58:01 +0100
Message-ID: <f83318a5-c8b8-bb94-556f-da1a54531d45@tessares.net>
In-Reply-To: 20210224140338.978-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7956

--===============6188790621719470011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 24/02/2021 15:03, Florian Westphal wrote:
> The MPTCP reset option allows to carry a mptcp-specific error code that
> provides more information on the nature of a connection reset.
> =

> Reset option data received gets stored in the subflow context so it can
> be sent to userspace via the 'subflow closed' netlink event.
> =

> When a subflow is closed, the desired error code that should be sent to
> the peer is also placed in the subflow context structure.
> =

> If a reset is sent before subflow establishment could complete, e.g. on
> HMAC failure during an MP_JOIN operation, the mptcp skb extension is
> used to store the reset information.

Thank you for the patch and the review!

Now in our tree with Mat's RvB tag:

- 787b0423eb63: mptcp: add mptcp reset option support
- Results: 8a82f6b7cf01..99476ba54610

Tests + export have been queued!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6188790621719470011==--
