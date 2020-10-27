Content-Type: multipart/mixed; boundary="===============1799375569186894551=="
MIME-Version: 1.0
From: Philip Li <philip.li at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [selftests] f2ff7f11f9: WARNING:suspicious_RCU_usage
Date: Wed, 28 Oct 2020 07:00:39 +0800
Message-ID: <20201027230039.GA25647@intel.com>
In-Reply-To: c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6453

--===============1799375569186894551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 04:07:28PM +0100, Matthieu Baerts wrote:
> Hi all,
> =

> On 27/10/2020 14:16, kernel test robot wrote:
> > Greeting,
> > =

> > FYI, we noticed the following commit (built with gcc-9):
> > =

> > commit: f2ff7f11f9a74842245db52d685bf9bc7ac2c4b1 ("selftests: mptcp: ad=
d ADD_ADDR IPv6 test cases")
> > https://github.com/multipath-tcp/mptcp_net-next.git export
> =

> Thanks for the maintainer of the kernel test robot at Intel for this bug
> report!
thanks, you are welcome!

> =

> FYI, this was already reported earlier:
> =

>   https://github.com/multipath-tcp/mptcp_net-next/issues/102
Thanks for the info, we didn't notice this. We will take a look
of reported issues in future to avoid duplicated report.

> =

> And Geliang is working on a fix (a v2 is available).
> =

> Cheers,
> Matt
> -- =

> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============1799375569186894551==--
