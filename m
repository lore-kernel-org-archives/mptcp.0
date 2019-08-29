Content-Type: multipart/mixed; boundary="===============4168760758606050553=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC v2 00/10] mptcp: cleanup token code
Date: Thu, 29 Aug 2019 12:11:53 +0200
Message-ID: <26441ef6-3f8e-0c11-0c24-afc19609a0bc@tessares.net>
In-Reply-To: 20190829090659.766-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1754

--===============4168760758606050553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On 29/08/2019 11:06, Florian Westphal wrote:
> This series again marked RFC so noone bothers to squash all of
> this into the mptcp tree.
> =

> In this second round, I've addressed all comments from Matthieu
> and Peter.  As a result, even more code was pruned from token.c
> and placed as static helper in subflow.c.
> =

> I've added a 'v2' mini-changelog to all affected patches.

Thank you for this new v2!

After a quick review, it looks good to me. Just a small detail, maybe
not relevant but no need to send a new version just for that.

I guess Peter will do another pass on this patch set.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============4168760758606050553==--
