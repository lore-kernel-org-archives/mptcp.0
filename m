Content-Type: multipart/mixed; boundary="===============0653154393381287928=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix dd command line option
Date: Thu, 12 Dec 2019 22:23:28 +0100
Message-ID: <ecaec2a8-cb09-0a34-0ec3-acacc059567e@tessares.net>
In-Reply-To: 12e000ed-44a7-a00a-30bd-a448371696a9@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2894

--===============0653154393381287928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 12/12/2019 17:34, Matthieu Baerts wrote:
> Hi Mat,
> =

> On 07/12/2019 01:10, Mat Martineau wrote:
>> "conv=3D" is a valid command line parameter, but "conf=3D" is not. The e=
rror
>> message is redirected to /dev/null so it is not obvious when running
>> tests. The tests seem to pass either way, so it's not clear that even
>> the "conv=3D" is really needed.
> =

> Good catch!
> =

> It looks good to me!
> =

> I will apply it once we sort out what we can do with Paolo and Davide's =

> modifications. Let's discuss that at the meeting.

Just applied:

- a245ffca5256: "squashed" in "mptcp: add basic kselftest for mptcp"
- 4b28d355242e..a3f47d5cab03: result

I didn't relaunch the tests for this one, going to launch them soon with =

the next applied patches.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============0653154393381287928==--
