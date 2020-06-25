Content-Type: multipart/mixed; boundary="===============6610118325931374695=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3 0/3] setsockopt: allow reuseport and
 ip6only
Date: Thu, 25 Jun 2020 17:59:06 +0200
Message-ID: <59506825-4b7c-1005-3a49-a2f3ca8df3ed@tessares.net>
In-Reply-To: 67ee87c768b20504453f443fe92df60e64068a98.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4806

--===============6610118325931374695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat, Paolo,

On 25/06/2020 10:59, Paolo Abeni wrote:
> On Thu, 2020-06-25 at 00:46 +0200, Florian Westphal wrote:
>> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>> On Wed, 24 Jun 2020, Florian Westphal wrote:
>>>
>>>> 3rd iteration.  I've incorporated feedback from Mat, so for
>>>> options other than reuseport/reuseaddr the generic handler gets called
>>>> instead of returning -EOPNOTSUPP.
>>>>
>>>> I've tested that ssh restart works on a a modified kernel that
>>>> enables mptcp for all IPPROTO_TCP sockets.
>>>
>>> Thanks for the v3 updates, changes look good. Should the patches go to =
the
>>> mptcp repo for some more test coverage or are you intending to post for
>>> net-next soon?
>>
>> The former, they depend on Paolos fallback refactoring which isn't in
>> net-next yet afaics.
> =

> I'd like to spool the token refactor first, which in turn will cause
> conflict without "mptcp: drop MP_JOIN request sock on syn cookies" -
> currently on -net only.
> =

> I'll ask Dave for a -net -> -net-next merge, so we can start spooling
> stuff.

Thank you for the patches and the reviews!

I just added the patches at the end of the series.

- 5433a4ffa2d6: net: use mptcp setsockopt function for SOL_SOCKET on =

mptcp sockets
- 681584082eab: mptcp: add REUSEADDR/REUSEPORT support
- cffa48f64125: mptcp: support IPV6_V6ONLY setsockopt

Tests + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6610118325931374695==--
