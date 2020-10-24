Content-Type: multipart/mixed; boundary="===============5564106133028804572=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add link
 failure test case"
Date: Sat, 24 Oct 2020 20:32:48 +0200
Message-ID: <a0a4a96d-dd7e-7c4a-b67d-bd41cc389854@tessares.net>
In-Reply-To: 20201024121943.GL16895@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 6434

--===============5564106133028804572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 24/10/2020 14:19, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts(a)tessares.net> wrote:
>> Fix typo in files listed in the cleanup() function: $sin and $sout were
>> no longer removed at the end of the test.
> =

> Indeed, thanks for fixing this.

Thank you for the quick review! (now that I am thinking about that, I =

guess I don't really need reviews for such simple fixes :) )

- b2ef14a71ae1: Squash to "selftests: mptcp: add link failure test case"
- Results: d13ebf3a735c..aafb67e19a3a

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5564106133028804572==--
