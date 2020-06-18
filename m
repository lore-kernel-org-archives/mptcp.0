Content-Type: multipart/mixed; boundary="===============5031907486653979656=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/3] add MP_PRIO,
 MP_FAIL and MP_FASTCLOSE suboptions handling
Date: Thu, 18 Jun 2020 14:27:37 +0800
Message-ID: <20200618062737.GA21303@OptiPlex>
In-Reply-To: 04ae76d9-231a-de8e-ad33-1e4e80bb314c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4724

--===============5031907486653979656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 05:18:56PM +0200, Matthieu Baerts wrote:
> Hi Geliang
> =

> On 16/06/2020 08:47, Geliang Tang wrote:
> > Add handling for sending and receiving the MP_PRIO, MP_FAIL, and
> > MP_FASTCLOSE suboptions.
> =

> Thank you for the patches!
> =

> Unfortunately, I don't think it would be wise to accept them now: for the
> moment, these suboptions are ignored at the reception. If we accept them =
and
> change some variables like you did, we would need to make sure the kernel=
 is
> still acting correctly. In other words, we would need tests:
> * For MP_PRIO, there are still quite some works to do regarding the
> scheduling of the packets between the different MPTCP subflows to do befo=
re
> supporting this.
> * For MP_FAIL, we should forward the info to the path manager.
> * For MP_FASTCLOSE, we should close connections and ACK this.
> =

> Also, net-next is closed for the moment:
> http://vger.kernel.org/~davem/net-next.html
> =

> I would suggest you to discuss about that on MPTCP mailing list. We also
> have meetings every Thursday. New devs are always welcome to contribute to
> new features and bug-fixes!
> =


Hi Matt,

Thanks for your reply. I will do these tests and improve my patches.

-Geliang

> Cheers,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============5031907486653979656==--
