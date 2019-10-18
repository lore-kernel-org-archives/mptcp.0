Content-Type: multipart/mixed; boundary="===============2740646187589539800=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/4] mptcp: recvmsg refactor follow-up
Date: Fri, 18 Oct 2019 10:16:47 +0200
Message-ID: <080d962b-bdc4-fce4-a6f2-3fa59cc3f4cd@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910171529130.17779@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2234

--===============2740646187589539800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 18/10/2019 00:31, Mat Martineau wrote:
> =

> On Thu, 17 Oct 2019, Paolo Abeni wrote:
> =

>> This series bring in a few fixes for the recent recevmsg refactor.
>> The patch addressing the reported failures is 2/4, while 1/4 avoids =

>> another
>> issue currently observable with debug enabled (recvmsg() do busy loop =

>> on some
>> corner cases).
>> Patch 3/4 fixes another possible deadlock issue, currently not =

>> reported by
>> the self-tests
>> Finally patch 4/4 updates the MIB accounting to the new code.
>> patches 1-3 should be squashed into "mptcp: Implement MPTCP receive =

>> path", while
>> patch 4 should be quashed into "mptcp: increment MIB counters in a few =

>> places".
>>
>> Notes:
>> - the last patch is a bit rough, at it abuses an existing MIB instead
>> of defining a new one, if there is no agreement about that it can be =

>> dropped.
>> - regardless of that, "mptcp: increment MIB counters in a few places" =

>> will
>> conflict on rebase, due to the changes introduced by the previous =

>> patches.
>>
>>
>> Paolo Abeni (3):
>> =C2=A0mptcp: clear data_avail flag if rtx queue is empty
>> =C2=A0mptcp: relax map checking
>> =C2=A0mptcp: deal better with out-of-sequence mapping
>> =C2=A0mptcp: account unsupported DSS mapping
>>
>> net/mptcp/subflow.c | 63 +++++++++++++++++++++------------------------
>> 1 file changed, 30 insertions(+), 33 deletions(-)
>>
> =

> This looks good for merging, based on patch review and some testing.
> =

> I did see some KASAN problems (not associated with these patches, I =

> think), and lots of flushing of duplicate recv data when testing with =

> multipath-tcp.org v0.95. I'll look in to that separately, but they =

> shouldn't delay these patches.

Thank you for the patches, the reviews and the tests!

- c337df474b7f: "squashed" patch 1/4 in "mptcp: Implement MPTCP receive =

path"
- 8ed52e220550: "squashed" patch 2/4 in "mptcp: Implement MPTCP receive =

path"
- 74a0a91c1236: "squashed" patch 3/4 in "mptcp: Implement MPTCP receive =

path"
- a1bfb0f562a5: conflict in t/mptcp-increment-MIB-counters-in-a-few-places
- 3031e75932d8: "squashed" patch 4/4 in "mptcp: increment MIB counters =

in a few places"
- c2238cc1cb6c: "Signed-off-by" + "Co-developed-by"
- 68a8b453521a..f112b4fbab2a: result

The CI just reported me that the different compilations are OK and the =

tests are now passing!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2740646187589539800==--
