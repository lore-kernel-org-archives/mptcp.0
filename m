Content-Type: multipart/mixed; boundary="===============4191534187328742257=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH/RFC 0/7] improve subflow join handling
Date: Tue, 26 Nov 2019 18:51:54 +0100
Message-ID: <ac0391d7-3f28-32c7-4b85-90614f29a5ab@tessares.net>
In-Reply-To: 6948f62b38443f7f737463d9e7fd915db09d058d.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2698

--===============4191534187328742257==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 26/11/2019 17:56, Paolo Abeni wrote:
> On Tue, 2019-11-26 at 17:45 +0100, Florian Westphal wrote:
>> Florian Westphal <fw(a)strlen.de> wrote:
>>> This set aims to improve handling of multiple subflows.
>>> There are multiple remaining problems, see below, but I wanted to send =
what
>>> I have now rather than keep this back.
>>>
>>> The first 3 patches are fixes to handle refcount leaks found while work=
ing
>>> on this, I've added the commit name of where they could be squashed to.
>>
>> I see those have been marked 'awaiting upstream', what does that mean in
>> mptcp context?
> =

> It means the patches are ready to be merged, waiting for someone
> (Matt?) to merge them.
> =

> It looks correct to me for the first 3 patches.

Sorry, I already merged them this afternoon but I was waiting for the CI =

to finish validating the new changes to send the email.
Everything done now, the "export" branch contains the 3 patches.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4191534187328742257==--
