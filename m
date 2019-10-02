Content-Type: multipart/mixed; boundary="===============4875760249854831572=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: allow dumping subflow context to userspace
Date: Wed, 02 Oct 2019 20:27:29 +0200
Message-ID: <cf91f71f-5740-b39a-566e-636e3a4b0fb4@tessares.net>
In-Reply-To: 51a63ead-f3a2-67e6-a52a-bcfc72aaf09c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1998

--===============4875760249854831572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/10/2019 20:17, Matthieu Baerts wrote:
> Hi Davide,
> =

> On 02/10/2019 20:14, Matthieu Baerts wrote:
>> Hi Davide, Paolo,
>>
>> On 27/09/2019 22:51, Davide Caratti wrote:
>>> add ulp-specific diagnostic functions, so that subflow information can =
be
>>> dumped to userspace programs like 'ss'.
>>
>> Thank you for the patch and the review!
> =

> Just added at the end of the series.

Better with this build-fix :)

ff6bb9cae9a8: mptcp:diag: fix compilation error
6174b3ba132d..efbc02314f5d: result

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4875760249854831572==--
