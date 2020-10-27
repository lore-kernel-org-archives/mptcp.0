Content-Type: multipart/mixed; boundary="===============3025247727773327284=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [selftests] f2ff7f11f9: WARNING:suspicious_RCU_usage
Date: Tue, 27 Oct 2020 16:07:28 +0100
Message-ID: <c971b9f8-fd4a-292f-a7d8-8f6ef43c347e@tessares.net>
In-Reply-To: 20201027131624.GO31092@shao2-debian
X-Status: 
X-Keywords:                  
X-UID: 6445

--===============3025247727773327284==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

On 27/10/2020 14:16, kernel test robot wrote:
> Greeting,
> =

> FYI, we noticed the following commit (built with gcc-9):
> =

> commit: f2ff7f11f9a74842245db52d685bf9bc7ac2c4b1 ("selftests: mptcp: add =
ADD_ADDR IPv6 test cases")
> https://github.com/multipath-tcp/mptcp_net-next.git export

Thanks for the maintainer of the kernel test robot at Intel for this bug =

report!

FYI, this was already reported earlier:

   https://github.com/multipath-tcp/mptcp_net-next/issues/102

And Geliang is working on a fix (a v2 is available).

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3025247727773327284==--
