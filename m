Content-Type: multipart/mixed; boundary="===============8817418716782593663=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/2] add support for mptcp netlink interface.
Date: Thu, 09 Apr 2020 15:22:54 +0200
Message-ID: <183baa0aed65d86f04671ac803b293754cd069dd.camel@redhat.com>
In-Reply-To: 1498339d66eabf2a8669c102da401b4ed7caedfe.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4147

--===============8817418716782593663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-09 at 12:56 +0200, Paolo Abeni wrote:
> I'm wondering if something quite different, alike 'endpoint' would fit
> better ?!? in

the advantage of using an acronym is: you don't need to know what it
means, just spell it correctly :) =

what about =


# ip mptcp advertise-ma

where ma can be "multihomed (host) address", like mentioned in RFC 8684 =C2=
=A7
2.3 ?

-- =

davide

=20

--===============8817418716782593663==--
