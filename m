Content-Type: multipart/mixed; boundary="===============8200324182777412904=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] mptcp: refactor xmit path
Date: Thu, 18 Apr 2019 16:58:24 -0700
Message-ID: <alpine.OSX.2.21.1904181656080.41859@scottgi-mobl.amr.corp.intel.com>
In-Reply-To: cover.1555342070.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1079

--===============8200324182777412904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 15 Apr 2019, Paolo Abeni wrote:

> his series refactor the mptcp xmit path trying to make sendmsg behavior
> more consistent, memory efficent and improve its performances.
>
> The code is also available here:
>
> https://github.com/pabeni/mptcp/tree/mptcp-proposal-devel
>
> To support MP_JOIN and multiple subflows, the idea is adding, with later
> patches, an RB-tree structure containing references to the pending page
> fragments, their length and the associated mptcp write_seq number (is sub=
flow
> rel_write_seq needed, too?). RB-tree node can be allocated using the same
> page frag used in this series for skb data. Each RB-tree node will own a
> reference to the page frag.
>
> RFC -> v1:
> - addressed Mat's feedback, dropping patch 3/4 and switching
>   to per msk page frag use, and checking mptcp seq number for coalescing
>
> Paolo Abeni (3):
>  mptcp: use sk_page_frag() in sendmsg
>  mptcp: sendmsg() do spool all the provided data
>  mptcp: allow collapsing consecutive sendpages on the same substream
>
> net/mptcp/protocol.c | 181 ++++++++++++++++++++++++++++---------------
> 1 file changed, 119 insertions(+), 62 deletions(-)
>
> -- =

> 2.20.1

Paolo -

Thanks for the updated patch set. I had a few comments on patch 3, and the =

rest look good. I'll wait on applying them for now, I think you said =

you're checking on a possible bug. If I should go ahead and apply them, =

please let me know.

--
Mat Martineau
Intel

--===============8200324182777412904==--
