Content-Type: multipart/mixed; boundary="===============3938965939070651180=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH MPTCP 0/2] mptcp: token api refactoring/cleanup
Date: Sat, 07 Sep 2019 17:56:27 +0200
Message-ID: <d22bb23e-76c7-5684-efd1-bb9e156e9455@tessares.net>
In-Reply-To: 57ad65189bf7d171641e71e936815f128e6f8b48.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1798

--===============3938965939070651180==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Peter,

On 05/09/2019 19:25, Peter Krystad wrote:
> =

> On Mon, 2019-09-02 at 13:09 +0200, Florian Westphal wrote:
>> I tried to fold the earlier 'RFC v2' in a way so that it allows
>> easy squashing.
>>
>> Patch #1 is the only one where this is painless.
>> For all others, things are not easy because conflicts exist all
>> over the place.
>>
>> So I see two ways forward:
>> 1. I rebase this myself and offer a pull request for the resulting series
>> 2. Only squash the first patch and keep the rest as extra patch.
>>
>> I suggest we go with #2.  The export tree already has a few patches
>> that need to be squashed anyway before sending a formal series.
>>
> This looks good and I'm fine with the extra patch for now, would just be =
too
> hard to split this up and squash to all kinds of different places.

Again, thank you for the patches and reviews!

- d02941b33b1a: first patch "squashed" into "mptcp: Add key generation
and token tree"
- 4b56d876cb96: signed-off
- f491c702f9c3..02bf3cf7f6d2: result of the first patch

The second patch has been added at the end.

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3938965939070651180==--
