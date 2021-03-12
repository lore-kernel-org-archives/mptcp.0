Content-Type: multipart/mixed; boundary="===============4884469711473560984=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 11th of March 2021
Date: Fri, 12 Mar 2021 09:16:50 +0100
Message-ID: <a3fc133d-9f62-0344-0212-ca4fb1b8b60c@tessares.net>
In-Reply-To: 865b24d1-aefd-1b85-a8c9-79ada156f5eb@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8108

--===============4884469711473560984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/03/2021 00:07, Mat Martineau wrote:
> On Thu, 11 Mar 2021, Matthieu Baerts wrote:
> =

>> =C2=A0=C2=A0 - news about Intel's kbuild? (Mat):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - some troubles that are not caused=
 by our stuff
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - no need to worry, they are fixing=
 that
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - report should be back soon
>>
> =

> Matthieu -
> =

> Could you cherry-pick this in to the export branch in the "fixes other =

> trees" section?
> =

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dl=
ocking/urgent&id=3D50bf8080a94d171e843fc013abec19d8ab9f50ae =

> =

> =

> The kbuild team says that commit should get their automated tests =

> running again.

Sure, easy to do!

- 3c04b4de6139: static_call: Fix the module key fixup
- Results: 56fa72b41205..c1ab0a28e2b1

Tests + export are going to be started soon! (just after having applied =

a patch from Dan)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4884469711473560984==--
