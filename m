Content-Type: multipart/mixed; boundary="===============8507350354296785562=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/2] mptcp: fix deadlock in mptcp{,6}_release
Date: Tue, 02 Mar 2021 17:56:40 -0800
Message-ID: <b4c859e-ee94-8a8c-5ded-e9b7788f57f9@linux.intel.com>
In-Reply-To: cover.1614706783.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7983

--===============8507350354296785562==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Mar 2021, Paolo Abeni wrote:

> This address the issue the easy way: removing the bugged feature
> (mcast support :).
>
> AFAICS the mcast related sockopt manipulate a global state, so there
> could be existing working application doing setsockopt(mcast opt) on
> TCP sockets. This is why I did not disable mcast at the inet level
> for stream sockets.
>
> Still I'm wondering if we should take the opposite approach: explicitly
> forbitting all setsockopt except the one we implement in
> net/mptcp/protocol.c
>

I think there was mailing list discussion about having an allowed list of =

SOL_TCP options, but I think applying that idea to the inet level slipped =

by. It does seem better to only allow the options we implement.

(by the way: it's forbid/forbidding)


Mat


> Additionally this possibly overlap with wider task - a more
> comprehensive sockopt support. Ence the RFC tag.
>
> Side note: syzbot confirm this fixes issues/170
>
> Paolo Abeni (2):
>  mptcp: forbit mcast-related sockopt on MPTCP sockets
>  mptcp: revert "mptcp: provide subflow aware release function"$ ....$
>
> net/mptcp/protocol.c | 100 ++++++++++++++++++++-----------------------
> 1 file changed, 47 insertions(+), 53 deletions(-)
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
--===============8507350354296785562==--
