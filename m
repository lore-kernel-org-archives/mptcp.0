Content-Type: multipart/mixed; boundary="===============4153381639738353549=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/6] mptcp: allow partial cleaning of rtx head
 dfrag
Date: Mon, 11 Nov 2019 16:23:08 -0800
Message-ID: <alpine.OSX.2.21.1911111621010.7818@mjmartin-mac01.local>
In-Reply-To: 20191108220953.30904-3-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2475

--===============4153381639738353549==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 8 Nov 2019, Florian Westphal wrote:

> After adding wmem accouting for the mptcp socket we could get
> into a situation where the mptcp socket can't transmit more data,
> and mptcp_clean_una doesn't reduce wmem even if snd_una has advanced
> because it currently will only remove entire dfrags.
>
> Allow advancing the dfrag head sequence and reduce wmem,
> even though this isn't correct (as we can't release the page).

The approach seems ok to me, since it only ever has excess bytes from one =

page per MPTCP socket.

No changes to suggest in the code either.

Mat


>
> Because we will soon block on mptcp sk in case wmem is too large,
> call sk_stream_write_space() in case we reduced the backlog so
> userspace task blocked in sendmsg or poll will be woken up.
>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
> net/mptcp/protocol.c | 28 +++++++++++++++++++++++++---
> 1 file changed, 25 insertions(+), 3 deletions(-)
>

--
Mat Martineau
Intel
--===============4153381639738353549==--
