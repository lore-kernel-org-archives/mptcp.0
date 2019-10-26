Content-Type: multipart/mixed; boundary="===============3177251851248438797=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v4 0/9] selftests: add ipv6 support and reduce run
 time
Date: Sat, 26 Oct 2019 09:33:56 +0200
Message-ID: <56fa4737-63ad-e6c2-d3f4-bdfdaef3b130@tessares.net>
In-Reply-To: alpine.OSX.2.21.1910251635380.66912@srpullel-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2332

--===============3177251851248438797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 26/10/2019 01:38, Mat Martineau wrote:
> =

> On Fri, 25 Oct 2019, Florian Westphal wrote:
> =

>> This is the 4th iteration of the selftest patchset.
>>
>> Changes since v3:
>> - get rid of unused variable warnings in patch 2
>> - get rid of bogus fallthrough in patch 4
>> - add patch 8: Get rid of redundant test cases, no need to
>> =C2=A0 test tcp fallback for all netns combinations.
>> - add patch 9: allow to set delay/loss/reordering etc. to use.
>> =C2=A0 Default is random so selftests expose wider combinations.
>>
>> All changes can be squashed into "mptcp: add basic kselftest for mptcp".
>>
> =

> I think 1-8 are ready to merge, and patch 9 in combination with my =

> capture fix - if that works for Matthieu & Florian.

Thank you for the patches, the reviews and the fix!

Florian's patches:

- ccd8bd7d2946: "squashed" patch 1/9 in "mptcp: add basic kselftest for =

mptcp"
- ba7f2390a07b: "squashed" patch 2/9 in "mptcp: add basic kselftest for =

mptcp"
- 9558b127f5e2: "squashed" patch 3/9 in "mptcp: add basic kselftest for =

mptcp"
- 36d6878d373c: "squashed" patch 4/9 in "mptcp: add basic kselftest for =

mptcp"
- b78662240af1: "squashed" patch 5/9 in "mptcp: add basic kselftest for =

mptcp"
- c81c93c3b292: "squashed" patch 6/9 in "mptcp: add basic kselftest for =

mptcp"
- 088e08b5cc4d: "squashed" patch 7/9 in "mptcp: add basic kselftest for =

mptcp"
- bf62f70fceaa: "squashed" patch 8/9 in "mptcp: add basic kselftest for =

mptcp"
- fcd6f5fe56e1: "squashed" patch 9/9 in "mptcp: add basic kselftest for =

mptcp"
- all signed-off already there

Mat's patch:

- 847d38757173: "squashed" in "mptcp: add basic kselftest for mptcp"
- signed-off already there

460e610b3ca4..22b6803a0c48: result

Now in my quick tests, it took me max 44 seconds with the slowest env I =

have and the default options. But I guess the time is variable depending =

on the delays/losses/reorders that have been randomly picked.

Do you have a suggestion of new default timeout to set?

Also another question, when you use:

   make -C tools/testing/selftests TARGETS=3Dnet/mptcp run_tests

how do you pass arguments to mptcp_connect.sh script?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3177251851248438797==--
