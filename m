Content-Type: multipart/mixed; boundary="===============5570510029169015442=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp-net-next 0/9] Remove some MPTCP-modules
Date: Tue, 01 May 2018 14:16:22 -0700
Message-ID: <alpine.OSX.2.21.1805011415550.6259@blkatz-mobl.amr.corp.intel.com>
In-Reply-To: 20180501203538.95477-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 596

--===============5570510029169015442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 1 May 2018, Christoph Paasch wrote:

> I had a bit of time, so just went through the code and removed some
> modules. These patches are based off of the mptcp-net-next repo's master.
>
> I would like to get rid of fullmesh/ndiffports as well, but need to see
> if I can do it such that I can run the net-next kernel on the
> server-side and still have my test-scripts succeed.
>
> Also, a next series could get rid of the scheduler module-selector.
>
> 2500 lines of code gone! ;-)
>
> Christoph Paasch (9):
>  mptcp: Remove Balia congestion control
>  mptcp: Remove wVegas congestion control
>  mptcp: Remove OLIA congestion control
>  mptcp: Remove Coupled congestion control
>  mptcp: Remove MCTCP Desync congestion control
>  mptcp: Remove Redundant scheduler
>  mptcp: Remove RoundRobin Scheduler
>  mptcp: Remove Binder Path-Manager
>  mptcp: Cleanup after removals

Thanks Christoph - all applied.

--
Mat Martineau
Intel OTC

--===============5570510029169015442==--
