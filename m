Content-Type: multipart/mixed; boundary="===============7117130074360730803=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/2] selftests:mptcp: increase timeout
Date: Wed, 23 Oct 2019 08:21:06 +0200
Message-ID: <376d3ac3-6be1-9632-1a0d-e607fb116dce@tessares.net>
In-Reply-To: 20191022202419.GK25052@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2271

--===============7117130074360730803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 22/10/2019 22:24, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> +time_end=3D$(date +%s)
>> +tiem_run=3D$((time_end-time_start))
>     ^^^^^^^
> =

> Ahem...  Other than that, this looks good, thanks.

Thank you for your review!
My bad, I hesitated to keep this "feature", then I renamed the variables =

just before sending the patch, in a hurry already thinking about what I =

would put on my pizza... I will avoid redoing that next time!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7117130074360730803==--
