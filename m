Content-Type: multipart/mixed; boundary="===============1481070839396107970=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/4] mptcp: disable mptcp when md5sig is set on
 socket
Date: Mon, 11 Nov 2019 18:09:03 +0100
Message-ID: <08604590495a33e491ec4292db5c6a9740801454.camel@redhat.com>
In-Reply-To: 20191111165802.GB19558@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2471

--===============1481070839396107970==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 17:58 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
> > As per last public mtg discussion, md5sig will cause TCP option space
> > exaustion. Without md5sig we can't exhaust the TCP option space.
> =

> How can you enable MD5SIG on an mptcp socket? I don't think its
> possible, as we don't expose the subflow tcp sockets to userspace and
> we don't allow setsockotps anymore.

I think you can via:

socket(MPTCP)
setsockopt()
connect() // or listen/accept()

AFAICS we still allow setsockopt on the fallback socket and US can
create the MPTCP connection later.

Cheers,

Paolo=20

--===============1481070839396107970==--
