Content-Type: multipart/mixed; boundary="===============2928713431580802217=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Minor patches [Remaining two]
Date: Tue, 11 Jun 2019 15:01:55 +0200
Message-ID: <b19bd6ee-3bdc-ddff-d350-c8cfc69e7d64@tessares.net>
In-Reply-To: 20190608004040.3426-1-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1332

--===============2928713431580802217==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 08/06/2019 02:40, Peter Krystad wrote:
> Responding to comments and rebase.
> =

> Peter Krystad (2):
>   mptcp: reduce number of pr_debug() calls.
>   mptcp: Refactor mptcp_established_options() to single hook

I just applied your second patch in the repo but not the first one:
please see the corresponding email to see what is blocking me.

I can also apply everything except the small change at the end of this
second patch and see what to do later. I mean: I can help integrating a
part of it not to block the release of your MP_JOIN support.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============2928713431580802217==--
