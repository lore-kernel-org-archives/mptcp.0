Content-Type: multipart/mixed; boundary="===============4729480623600267493=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/4] mptcp: warn once if exceeding tcp opt space
 for dss/mp_capable
Date: Thu, 14 Nov 2019 09:56:02 +0100
Message-ID: <1daf18505cf014c889bb182f9cc50940e9cee3ed.camel@redhat.com>
In-Reply-To: 18306f745c356048335f1196515db0d6ea28022e.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2526

--===============4729480623600267493==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 15:43 -0800, Peter Krystad wrote:
> On Tue, 2019-11-12 at 09:21 +0100, Paolo Abeni wrote:
> > AFAICS DSS, MP_CAPABLE and MP_JOIN are mutually esclusive, and the
> > bigger is DSS with 64 bytes ack/seq and csum with a total of 28 bytes -
> > which fit the TCP option space.
> =

> Just FYI, I should have mentioned this earlier, I have observed the mptcp=
.org
> kernel sending 32-bit DSS ack-only in the same header as final MP_CAPABLE=
 ACK
> so this statement isn't completely true.

Thank you for the info.

It looks like a .org bug to me ?!? the sender should not send DSS
before receiving the MP_CAPABLE ack, and the client should not send ack
before receving a DSS ?!?

Back to this series, do you prefer I'll revert to the existing checks?

Thanks,

Paolo

--===============4729480623600267493==--
