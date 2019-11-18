Content-Type: multipart/mixed; boundary="===============2742477095917089792=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 06/14] sendmsg: block until mptcp sk is writeable
Date: Mon, 18 Nov 2019 12:33:29 +0100
Message-ID: <2e46307342d3d1ccac131133e76a3a7aaae12077.camel@redhat.com>
In-Reply-To: c5c49589a929e651f957fee74b1eb264cdc35104.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2575

--===============2742477095917089792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-18 at 12:29 +0100, Paolo Abeni wrote:
> Can we move the above loop to the non fallback case only ? e.g. after
> the below !mptcp_subflow_get(msk) checks?
> =

> If so, we could have a single loop checking for:
> =

> !sk_stream_memory_free(sk) || !mptcp_subflow_get_send()
> =

> (together with the next patch)

Dumb me! I meant "with patch 9/14" - where a similar loop is added.

/P

--===============2742477095917089792==--
