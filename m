Content-Type: multipart/mixed; boundary="===============2518157335173720300=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 00/13] ADD_ADDR: ports support
Date: Wed, 18 Nov 2020 15:49:30 +0100
Message-ID: <c344ab41-cd46-e420-1f84-537849b9e4fc@tessares.net>
In-Reply-To: CA+WQbwuW0n-1giRdoeCgH-=TXh-D35DhYNqtd8479oYRDWUMnw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6774

--===============2518157335173720300==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 18/11/2020 13:24, Geliang Tang wrote:
> Hi Mat & Matt,
> =

> Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=
=B411=E6=9C=8812=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:49=E5=86=99=
=E9=81=93=EF=BC=9A
> =

>> On Tue, 10 Nov 2020, Geliang Tang wrote:
>>
>>> v4:
>>> - hold msk->pm.lock in mptcp_pm_sport_in_anno_list.
>>> - Merge the patchset 'Squash to "ADD_ADDR: ports support v3"' into v4.
>>
>> Thanks for the fixes in v4. In last week's meeting there was a
>> conversation about this patch series and the best way to handle addition=
al
>> ports. I think it will be good to talk about that some more this week and
>> how to coordinate that with merging the series to the export branch and
>> (later) net-next.
>>
> =

> Hi Mat & Matt,
> =

> I want to split this patchset into two parts.
> =

> Part 1, includes patch 1 to patch 8, is the basic for ADD_ADDR ports
> support. This part is ready for upstreaming. So please apply them into the
> export branch.

Sounds good to me!

Thanks for these patches and the reviews!

I just applied them and add Mat's Reviewed-by tag (I hope I understood =

that correctly!).

- 931436e108bf: mptcp: unify ADD_ADDR and echo suboptions writing
- 67250a067f8f: mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions writing
- 11881df9755f: mptcp: add port support for ADD_ADDR suboption writing
- 883c4aba78f1: mptcp: use adding up size to get ADD_ADDR length
- 5e04f8ac0a3d: mptcp: add the outgoing ADD_ADDR port support
- e58558aaa818: mptcp: send out dedicated packet for ADD_ADDR using port
- 79a30ba7de53: mptcp: add port parameter for mptcp_pm_announce_addr
- 485ad0ee9ca9: mptcp: print out port and ahmac when receiving ADD_ADDR
- Results: 9d1f3055c580..3c06d194dc8b

Tests + export are in progress!

> Part 2, includes patch 9 to patch 13, is for the testcases of ADD_ADDR
> ports support. This part still needs to be improved, like adding the
> listening socket in the kernel space. I'll send out the new iteration of
> part 2 recently.

Thanks for that!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2518157335173720300==--
