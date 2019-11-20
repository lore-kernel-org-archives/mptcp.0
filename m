Content-Type: multipart/mixed; boundary="===============7146216546647541431=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Feedback to the IETF
Date: Wed, 20 Nov 2019 11:46:25 +0100
Message-ID: <cf7749414de590bbc9757dd6f2dbd10689f67b17.camel@redhat.com>
In-Reply-To: 9641CA6A-FB2D-4411-9B79-D0F41009E40B@apple.com
X-Status: 
X-Keywords:                  
X-UID: 2611

--===============7146216546647541431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-20 at 17:31 +0800, Christoph Paasch wrote:
> On Nov 20, 2019, at 5:15 PM, Paolo Abeni <pabeni(a)redhat.com> wrote:
> > To be 110% honest, I don't see why HMAC is needed here, assuming
> > ADD_ADDR comes after MP_JOIN/MP_CAPABLE, we already authenticated both
> > peers, and if an attacker can inject malicious TCP packets inside the
> > stream we are at loss no matter what.
> =

> The problem here is that an attacker that is off-path would be able
> to get himself on-path with an ADD_ADDR-attack (described at =

> https://tools.ietf.org/html/rfc7430#section-2) and thus can observe
> all traffic. Sure, he still needs to guess sequence-numbers and port-
> numbers, but with a TCP-window of 2MB it is not all that hard.

Thanks for the pointer, now I think I understood the problem, and I
can't see how to avoid it without HMAC :(

/P

--===============7146216546647541431==--
