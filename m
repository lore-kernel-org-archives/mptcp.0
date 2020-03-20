Content-Type: multipart/mixed; boundary="===============8094397114910870594=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Additional part 3 squash suggestion
Date: Fri, 20 Mar 2020 17:20:14 +0100
Message-ID: <9311d261-d264-bc95-3d6b-be8caa358a4f@tessares.net>
In-Reply-To: 20200319233417.GA3305@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 4021

--===============8094397114910870594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Florian,

On 20/03/2020 00:34, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>
>> Florian and Matthieu -
>>
>>  From the meeting notes, it looks like "subflow: place further subflows =
on
>> new 'join_list'" is the commit that you're planning to squash.
>>
>> What do you think about also squashing "mptcp: increment MIB counters in=
 a
>> few places" in to the previous MIB commit? Seems like our patch count for
>> part 3 is still kind of high.
> =

> SGTM.  We could change the commit title as follows:
> =

> - mptcp: add MIB counter infrastructure
> + mptcp: add and use MIB counter infrastructure
> =

> and toss the commit description of the 'increment MIB' patch,
> it doesn't add any value.

Thank you for the idea and the instructions!

- 3eccc998b50b: mptcp: increment MIB counters in a few places
- 74ddb090f4a9: tg:msg: MIB counters are now used
- 1347fe98687a: tg: now depend on t/mptcp-add-MIB-counter-infrastructure
- 1f804516b871..c011ac35dcba: result (empty as expected)

Tests + export are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8094397114910870594==--
