Content-Type: multipart/mixed; boundary="===============4530681939301677337=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: free acked data before waiting
 for more memory
Date: Fri, 28 Aug 2020 21:15:08 +0200
Message-ID: <5a369970-0b91-7dfc-21ac-deef15d45b41@tessares.net>
In-Reply-To: 20200821133910.6599-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5661

--===============4530681939301677337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 21/08/2020 15:39, Florian Westphal wrote:
> After subflow lock is dropped, more wmem might have been made available.
> =

> This fixes a deadlock in mptcp_connect.sh 'mmap' mode: wmem is exhausted.
> But as the mptcp socket holds on to already-acked data (for retransmit)
> no wakeup will occur.
> =

> Using 'goto restart' calls mptcp_clean_una(sk) which will free pages
> that have been acked completely in the mean time.
> =

> Fixes: fb529e62d3f3 ("mptcp: break and restart in case mptcp sndbuf is fu=
ll")
> Signed-off-by: Florian Westphal <fw(a)strlen.de>

Thank you for the patch and the review!

Applied at the beginning of the series because it was already applied in =

-net.

Tests + export are in progress!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4530681939301677337==--
