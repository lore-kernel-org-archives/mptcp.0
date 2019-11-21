Content-Type: multipart/mixed; boundary="===============7556622535903230156=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/3] mptcp: fix for ipv6-related oops
Date: Thu, 21 Nov 2019 17:44:12 +0100
Message-ID: <c3dede1e-0961-4bf9-a816-50053eb3b874@tessares.net>
In-Reply-To: a73f71ce-248f-5b31-fc3e-dee1a7866b08@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2656

--===============7556622535903230156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/11/2019 16:58, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 21/11/2019 16:41, Paolo Abeni wrote:
>> We need to allocate a larger struct sock for mptcp v6 master sockets,
>> otherwise inet6_sk() will access mptcp related data instead of
>> struct ipv6_pinfo.
>>
>> This should fix the crash reported by Matt.
>>
>> The protocol.c code changes are split in 2 patches to simplify the
>> squashing.
>> (yep, I know we somewhat agreed to big giant rebase, but this specific
>> should be trivial).
>>
>> Additionally adds some fixlet for the ipv6 tests
>>
>> v1 -> v2:
>> =C2=A0 - address Matt feedback on patches 1 && 2
>> =C2=A0 - add missing mptcp_v6 proto registration (I don't know why the =

>> previous
>> =C2=A0=C2=A0=C2=A0 iteration of these patches did not explode without th=
at!!! :(((
> =

> Thank you for the new version and good catch for the proto registration!
> =

> The new version looks good to me. I am going to apply it if there is no =

> objections (post fixes are still possible of course).

Again thank you for the patches!

- 2a2dd30dbd33: "squashed" patch 1/3 in "mptcp: add basic kselftest for =

mptcp"
- 39d0ec7ab1eb..432a009dc917: result
- 4bf7842874f1: "squashed" patch 2/3 in "mptcp: Add MPTCP socket stubs"
- 3d4407546cc9: conflict in t/mptcp-Associate-MPTCP-context-with-TCP-socket
- 432a009dc917..458c883a09f8: result
- 972a3aab48ac: "squashed" patch 3/3 in "mptcp: Add key generation and =

token tree"
- 458c883a09f8..9dde928ded79: result

Tests are now OK again! Thanks for the fix!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7556622535903230156==--
