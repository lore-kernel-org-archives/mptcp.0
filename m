Content-Type: multipart/mixed; boundary="===============1223610548384227275=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH] mptcp: extends interim path manager
Date: Thu, 22 Aug 2019 15:57:07 +0200
Message-ID: <d543c918560e61e4c8318898f58b44a878dd07eb.camel@redhat.com>
In-Reply-To: 48c1899b-19a2-065e-571c-7cd4d6a6cc71@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1675

--===============1223610548384227275==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-22 at 15:29 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 22/08/2019 15:19, Paolo Abeni wrote:
> > This is on top of "mptcp: Implement interim path manager" and extends
> > the infrastructure there so that local address is configurable per ns
> > via sysctl.
> =

> I guess you have missed this other patch:
> https://lists.01.org/pipermail/mptcp/2019-August/001661.html
> Or is it to replace it? :)

Oops - almost mid-air collision! I looked at the ML after sending out
my patch, sorry.

I'm fine with your as I missed *pton helpers availability inside the
kernel and I likely abused the sysctl table already there.

I'd like to retain the ability to additionally bind the 2nd subflow on
the specified local address, so that we could do another step towards a
working active backup implementation (Should not be that far on top of
all pending bugs, modulo pending bugs ;)

Cheers,

Paolo


--===============1223610548384227275==--
