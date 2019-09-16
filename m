Content-Type: multipart/mixed; boundary="===============5698055179280584378=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH selftests 0/5] selftests: prepare for mptcp ipv6
 support
Date: Mon, 16 Sep 2019 13:50:49 -0700
Message-ID: <95584517a1ec13f9319d13e12d0214d80b4c6e3e.camel@linux.intel.com>
In-Reply-To: 20190913094528.3163-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1855

--===============5698055179280584378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-13 at 11:45 +0200, Florian Westphal wrote:
> This patch series inceases self test coverage:
> =

> 1. ipv6 support.  So all someone needs to do is actually implement ipv6
>    support in mptcp.  Then, set ipv6=3Dtrue in the selftest script and it
>    should 'just work'.

I am planning to begin work on IPv6 support, unless someone else wants to
arm-wrestle me for it....

Peter.

> 2. Check accept/getpeername.  In case of connect side, we also check
>    that getpeername returned addresses are the ones we connected to.
> 3. less predictable topology: tso/gso/gro and tc parameters are more
>    random.
> =

> I suggest to apply them with no squashing, once we go for another RFC
> tests/selftest can be a single patch and all commits can be squashed.
> =

> If you disagree, I don't mind if this gets squashed right away.
> =

> No changes to mptcp stack itself here.
> =

> =

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============5698055179280584378==--
