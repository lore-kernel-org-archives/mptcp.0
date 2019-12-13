Content-Type: multipart/mixed; boundary="===============5745897439906647491=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 11:43:12 +0100
Message-ID: <7a65d607-1a6f-1b01-7a18-3b830f97eebf@tessares.net>
In-Reply-To: alpine.OSX.2.21.1912051635040.57359@pminglan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2926

--===============5745897439906647491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 06/12/2019 01:41, Mat Martineau wrote:
> =

> Hello everyone -
> =

> As we discussed earlier today, here are draft cover letters for patch =

> set parts 1 & 2. Feedback appreciated!
> =

> =

> ------
> Part 1
> =

> Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites
> =

> The MPTCP upstreaming community has been collaborating on an
> upstreamable MPTCP implementation. David requested that we split this
> work in to multiple, smaller patch sets to build up MPTCP
> infrastructure. The scope of this first patch set is limited to
> prerequisite TCP core changes so we can get focused feedback in these
> areas.

Related to why I proposed on "Checklist before sending to netdev" ML, =

should we already introduce here the fact that we are going to send 3 =

different patch sets and why we cannot send all in one or less patches?

Something like:

     - The protocol is what it is and having a minimal set of features =

already signifies a lot of code.
     - This minimal set of features includes: the possibility for the =

userspace to establish and properly terminate MPTCP connections but =

limited to one subflow while still being able to transfer data in both =

directions
     - We decided to split everything in 3 parts to ease the reviews:
         - Part 1: Prerequisite TCP core changes
         - Part 2: MPTCP minimal set of features including selftests
         - Part 3: a switch from MPTCPv0 (RFC 6824) to MPTCPv1 (new RFC =

8684 going to obsolete the previous one in the coming days)
     - The idea would be to apply everything in the same "merge window".

Feel free to improve this of course :)

For the rest, it looks good to me!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5745897439906647491==--
