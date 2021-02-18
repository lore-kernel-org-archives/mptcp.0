Content-Type: multipart/mixed; boundary="===============2215074540142312005=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: reset 'first' and ack_hint on subflow close
Date: Thu, 18 Feb 2021 17:17:37 +0100
Message-ID: <4b24aff6aee0a095f295e0c44fdd708a28e7914d.camel@redhat.com>
In-Reply-To: 20210218155946.18540-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 7848

--===============2215074540142312005==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-02-18 at 16:59 +0100, Florian Westphal wrote:
> Just like with last_snd, we have to NULL 'first' on subflow close.
> =

> ack_hint isn't strictly required (its never dereferenced), but better to
> clear this as well.
> =

> msk->first is dereferenced unconditionally at accept time, but
> at that point the ssk is not on the conn_list yet -- this means
> worker can't see it when iterating the conn_list.

There is a __mptcp_flush_join_list() before __mptcp_close_subflow(),
could that matter? IIRC even the PM can move the subflow from join_list
to conn_list to take some actions.

not 110% related, we have a couple of !msk->first in =

mptcp_update_rcv_data_fin() and mptcp_check_data_fin() which are likely
obsoleted/to be removed.

Thanks!

Paolo

--===============2215074540142312005==--
