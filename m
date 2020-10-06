Content-Type: multipart/mixed; boundary="===============0929856989925631272=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/2] mptcp: cope better with tcp_sendpage
 allocation
Date: Tue, 06 Oct 2020 10:16:11 -0700
Message-ID: <alpine.OSX.2.23.453.2010061004110.22542@ccarpent-mobl.amr.corp.intel.com>
In-Reply-To: cover.1601982978.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6232

--===============0929856989925631272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 6 Oct 2020, Paolo Abeni wrote:

> The current export branch suffers of the following issue:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/97
>
> To fix the above, MPTCP needs to be able to cope with memory allocation
> failure in do_tcp_sendpages().
>
> In this attempt, the relevant code is factored out of do_tcp_sendpages(),
> in a smaller helper, so that mptcp_sendmsg_frag() can avoid touching
> ssk->sk_socket.
>
> There are other possible alternatives:
> - add an explicit check in do_tcp_sendpages() for NULL sk->sk_socket
>  pro: very simple and little invasive
>  cons: hackysh?!?
> - inline/open-code the relevant part of do_tcp_sendpages in mptcp_sendmsg=
_frag()
>  pro: no need to change core TCP code
>  cons: code duplication, need to change the scope for a couple of TCP int=
ernal
>        helpers (removing the 'static' keyword)
>
> As a follow-up I would try to pre-allocate skbs and extensions, so that
> push_pending could be called in BH context and we could avoid using the
> work queue.
>
> I'm looking for feedback on the less ugly/more upstreamable approach

I wouldn't object to the explicit sk->sk_socket check, it is simpler and =

handling that in the existing do_error path in do_tcp_sendpages() does =

make sense. It is, after all, an error that can be detected and handled.

I think factoring out do_tcp_sendfrag() is "nice" enough - while it seems =

like such a change might be preferred earlier in the net-next development =

cycle it doesn't seem too invasive. The drawback I see is that there are =

not likely to be other users of do_tcp_sendfrag().

Would like to avoid open-coding part of the do_tcp_sendpages() code in =

mptcp and having to maintain that.

Mat


>
> Paolo Abeni (2):
>  tcp: factor out do_tcp_sendfrag()
>  mptcp: use do_tcp_sendfrag()
>
> include/net/tcp.h    |   3 ++
> net/ipv4/tcp.c       | 120 ++++++++++++++++++++++++-------------------
> net/mptcp/protocol.c |  21 ++++----
> 3 files changed, 80 insertions(+), 64 deletions(-)
>
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0929856989925631272==--
