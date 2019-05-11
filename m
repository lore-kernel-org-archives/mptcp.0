Content-Type: multipart/mixed; boundary="===============4502463279712080311=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v3 0/3] mptcp: refactor xmit path
Date: Fri, 10 May 2019 17:43:44 -0700
Message-ID: <alpine.OSX.2.21.1905101738350.59728@julieann-mobl1.amr.corp.intel.com>
In-Reply-To: cover.1557497920.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1148

--===============4502463279712080311==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 10 May 2019, Paolo Abeni wrote:

> this series refactor the mptcp xmit path trying to make sendmsg behavior
> more consistent, memory efficent and improve its performances.
>
> Self-test results are not affected: tests fail in similar way before and
> after this series.
>
> To support MP_JOIN and multiple subflows, the idea is adding, with later
> patches, an RB-tree structure containing references to the pending page
> fragments, their length and the associated mptcp write_seq number (is sub=
flow
> rel_write_seq needed, too?).

rel_write_seq doesn't need to be stored for later, it will be different =

for every copy of the data that is sent.

> RB-tree node can be allocated using the same
> page frag used in this series for skb data. Each RB-tree node will own a
> reference to the page frag.

I think this is a nice improvement for the sendmsg code, the earlier =

issues are resolved and we should merge the series to mptcp_net-next.


Mat


>
> v2 -> v3:
> - rebased on top of "mptcp: refactor shutdown/close and conn_list handlin=
g"
> - cope with egres pkt with NULL ext
>
> v1  -> v2:
> - rebased on top of current git
> - fix handling of some corner cases
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
> net/mptcp/protocol.c | 190 ++++++++++++++++++++++++++++---------------
> 1 file changed, 123 insertions(+), 67 deletions(-)
>
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============4502463279712080311==--
