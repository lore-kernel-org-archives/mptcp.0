Content-Type: multipart/mixed; boundary="===============3779618711909943175=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Cover letters for part1/part2 netdev patchsets
Date: Fri, 13 Dec 2019 11:19:19 -0800
Message-ID: <alpine.OSX.2.21.1912130913330.33632@amhui-mobl1.amr.corp.intel.com>
In-Reply-To: 7a65d607-1a6f-1b01-7a18-3b830f97eebf@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2978

--===============3779618711909943175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Fri, 13 Dec 2019, Matthieu Baerts wrote:

> Hi Mat,
>
> On 06/12/2019 01:41, Mat Martineau wrote:
>> =

>> Hello everyone -
>> =

>> As we discussed earlier today, here are draft cover letters for patch se=
t =

>> parts 1 & 2. Feedback appreciated!
>> =

>> =

>> ------
>> Part 1
>> =

>> Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites
>> =

>> The MPTCP upstreaming community has been collaborating on an
>> upstreamable MPTCP implementation. David requested that we split this
>> work in to multiple, smaller patch sets to build up MPTCP
>> infrastructure. The scope of this first patch set is limited to
>> prerequisite TCP core changes so we can get focused feedback in these
>> areas.
>
> Related to why I proposed on "Checklist before sending to netdev" ML, sho=
uld =

> we already introduce here the fact that we are going to send 3 different =

> patch sets and why we cannot send all in one or less patches?
>
> Something like:
>
>    - The protocol is what it is and having a minimal set of features alre=
ady =

> signifies a lot of code.
>    - This minimal set of features includes: the possibility for the =

> userspace to establish and properly terminate MPTCP connections but limit=
ed =

> to one subflow while still being able to transfer data in both directions
>    - We decided to split everything in 3 parts to ease the reviews:
>        - Part 1: Prerequisite TCP core changes
>        - Part 2: MPTCP minimal set of features including selftests
>        - Part 3: a switch from MPTCPv0 (RFC 6824) to MPTCPv1 (new RFC 868=
4 =

> going to obsolete the previous one in the coming days)
>    - The idea would be to apply everything in the same "merge window".
>
> Feel free to improve this of course :)

Thanks Matthieu, good suggestion. Am I correct in thinking the plan is to =

have part 4 in this window as well, just in January sometime?

Updated draft:

----
Subject: [PATCH net-next 0/0] Multipath TCP part 1: Prerequisites

The MPTCP upstreaming community has been collaborating on an upstreamable =

MPTCP implementation that complies with RFC 8684. A minimal set of =

features to comply with the specification involves a sizeable set of code =

changes, so David requested that we split this work in to multiple, =

smaller patch sets to build up MPTCP infrastructure.

The minimal MPTCP feature set we are proposing for the v5.6 timeframe is =

split in to these parts for review:

Part 1 (this patch set): MPTCP prerequisites. Introduce some MPTCP =

definitions, additional ULP and skb extension features, TCP option space =

checking, and a few exported symbols.

Part 2: Single subflow implementation and self tests.

Part 3: Switch from MPTCP v0 (RFC 6824) to MPTCP v1 (new RFC 8684, =

publication expected in the next few days).

Part 4: Multiple subflow support.

<git tree references at github>

Thank you for your review. You can find us at mptcp(a)lists.01.org and
https://is.gd/mptcp_upstream



--
Mat Martineau
Intel
--===============3779618711909943175==--
