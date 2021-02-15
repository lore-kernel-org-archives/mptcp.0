Content-Type: multipart/mixed; boundary="===============8947755586637273938=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: fix DATA_FIN generation on early
 shutdown.
Date: Mon, 15 Feb 2021 20:10:05 +0100
Message-ID: <6237ad08-86bc-02f2-d17b-fe6d0adf2c0d@tessares.net>
In-Reply-To: d56e9a35-952c-8b2b-7665-c3a56fcd7147@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 7811

--===============8947755586637273938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 15/02/2021 16:29, Matthieu Baerts wrote:
>> The scenario is tested by a specific pktdrill tested,
>> already pushed
> =

> Thank you for that! (and for having use "mptcp-net" :) even if we can =

> change that if it is not OK).
> I just applied your patch at the bottom of the tree, after a patch from =

> Florian (mptcp: reset last_snd on subflow close). With Mat's RvB tag and =

> without a dot at the end of the title:
> =

> - b7ee76d557c4: mptcp: fix DATA_FIN generation on early shutdown
> - Results: 655ef2e493c8..82aaf8587e26

I had to move it in our tree after "mptcp: better msk receive window =

updates" which is not in net-next yet.

- 50ae59ab415b: mptcp: fix DATA_FIN generation on early shutdown
- Results: 82aaf8587e26..1de5e73fbb6c

Tests + export have been restarted. My CI is frequently hitting bug 160 =

-- it did here so I don't have all results -- but it is not as frequent =

on my local environment.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8947755586637273938==--
