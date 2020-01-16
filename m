Content-Type: multipart/mixed; boundary="===============5511052401914342380=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "mptcp: add basic kselftest for mptcp"
Date: Thu, 16 Jan 2020 17:41:00 +0100
Message-ID: <f48fdb45-eee6-0d89-1ae6-be7e54ef4ede@tessares.net>
In-Reply-To: 15727d6eaf3ee36442eaf843da9e9f2bb49afdd6.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3377

--===============5511052401914342380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

On 13/01/2020 17:05, Paolo Abeni wrote:
> On Fri, 2020-01-10 at 17:10 -0800, Mat Martineau wrote:
>> I was helping the LKP/0-day team with information on running our tests,
>> and noticed some missing config options.
>>
>> It looks like a toss-up between 'm' and 'y' for these, so I set values
>> based on similar entries in tools/testing/selftests/net/config
>>
>> Did I miss any others that aren't in the default config?
> =

> I *think* this should be enough. LGTM, thanks!

Thank you for the patch and the review!

- b034f1904b8e: "squashed" in "mptcp: add basic kselftest for mptcp"
- b3a959af913e..704e4fa8a50c: result

Tests + export will be launched soon

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5511052401914342380==--
