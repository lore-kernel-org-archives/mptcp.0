Content-Type: multipart/mixed; boundary="===============1542387978351050042=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] tcp: clean ext on tx recycle
Date: Wed, 15 May 2019 15:26:02 +0200
Message-ID: <34692166aaa0a6070fb34186a5dc82e11fd7980b.camel@redhat.com>
In-Reply-To: 96a9b626-ffd4-3afc-214f-bd16fdcc632c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1180

--===============1542387978351050042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-15 at 15:14 +0200, Matthieu Baerts wrote:
> On 15/05/2019 12:22, Paolo Abeni wrote:
> > Note that setting/allocating the MPTCP ext in sk_stream_alloc_skb
> > for MPTCP socket, we also resolve the fixme in mptcp_sendmsg_frag().
> =

> Are you talking about the case where skb_ext_add() returns NULL?

Yes. The problem with the current code is that it can possibly fail
after the data already travered the TCP stack, and AFAICS we should
roll-back some internal status, not easily accessible.

Paolo


--===============1542387978351050042==--
