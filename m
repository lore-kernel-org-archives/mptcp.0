Content-Type: multipart/mixed; boundary="===============3092782293611184279=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH selftests 0/5] selftests: prepare for mptcp ipv6
 support
Date: Tue, 17 Sep 2019 11:28:50 +0200
Message-ID: <bdf327acdf5a9111936d9215a516bee48e0be962.camel@redhat.com>
In-Reply-To: 95584517a1ec13f9319d13e12d0214d80b4c6e3e.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1860

--===============3092782293611184279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 2019-09-16 at 13:50 -0700, Peter Krystad wrote:
> On Fri, 2019-09-13 at 11:45 +0200, Florian Westphal wrote:
> > This patch series inceases self test coverage:
> > =

> > 1. ipv6 support.  So all someone needs to do is actually implement ipv6
> >    support in mptcp.  Then, set ipv6=3Dtrue in the selftest script and =
it
> >    should 'just work'.
> =

> I am planning to begin work on IPv6 support, unless someone else wants to
> arm-wrestle me for it....

Thank you for doing that! =


I was also planning to try to estimate the effort there, but I sure do
not want to arm-wrestle you! I'll fallback to other tasks - recvmsg
cleanup? mp_join debug? - but please let me know if I can help somehow!

Thanks,

Paolo


--===============3092782293611184279==--
