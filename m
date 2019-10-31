Content-Type: multipart/mixed; boundary="===============3316831110622986616=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] self-tests: catch poll errors
Date: Thu, 31 Oct 2019 16:53:27 +0100
Message-ID: <3fe85210-f7f1-4291-507c-4436cec2817e@tessares.net>
In-Reply-To: 20191030160750.GF876@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 2376

--===============3316831110622986616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Florian,

On 30/10/2019 17:07, Florian Westphal wrote:
> Paolo Abeni <pabeni(a)redhat.com> wrote:
>> Otherwise in case of a poll error, we end-up looping forever.
>>
>> Squash-to: "mptcp: add basic kselftest for mptcp"
> =

> Looks good, thanks Paolo.

Thank you for the patch and the review, just applied:

- 166eae7a8b48: "squashed" in "mptcp: add basic kselftest for mptcp"
- already has signed-off
- 7e53f6ec6dd0..663eb10b8a4f: result

Cheers
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3316831110622986616==--
