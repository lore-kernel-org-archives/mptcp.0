Content-Type: multipart/mixed; boundary="===============7369726872676996041=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Wed, 11 Dec 2019 22:36:33 +0100
Message-ID: <d12073942de5dbde42a79f8a1045e16c11e581e5.camel@redhat.com>
In-Reply-To: 20191211192209.GM795@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2878

--===============7369726872676996041==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 20:22 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > @Florian: I tested the whole tree vs self-tests - so MP_JOIN is not
> > really tested. Are you ok to merge as-is and then look after eventual
> > bug introduced by me here?
> =

> Maybe, can you explain __mptcp_flush_join_list() usage?

mp_join subflow are appended to join_list by mptcp_finish_join(), for
passive connections, at when the tcp subflow become established.

We can't add directly to conn_list, or we will hit the ABBA locking
schema the fallback cleanup tried to avoid.

The code tries to splice join list into conn_list every just before
each conn_list traversing, so that that later lookup/access have to
cope only with conn_list.

> AFAICS subflow on join list can be moved to conn_list at 'random'
> point in time, even if its not fully established yet?

passive subflow are moved into join_list when they are 'established' at
the tcp level, but the MP_JOIN handshake is not completed (fourth ack
still not reached). Should be ok for recvmsg() - as we check the
'data_ready' field - and close(), possibly we need some additional care
for mptcp_subflow_get_send().

Cheers,

Paolo

--===============7369726872676996041==--
