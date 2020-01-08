Content-Type: multipart/mixed; boundary="===============6356626433652163250=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Rebase request
Date: Wed, 08 Jan 2020 09:40:11 +0100
Message-ID: <aaa5feb9-1515-81ac-b51b-965008622a60@tessares.net>
In-Reply-To: a54a945303550dd8ed624bb8801cdb3a780198d2.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3285

--===============6356626433652163250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 08/01/2020 02:31, Peter Krystad wrote:
> =

> I would like to switch the order of the two commits: "Add path manager
> interface" and "Add ADD_ADDR handling". The addition of ADD_ADDR option
> handling and adding the path manager interface is muddled between these t=
wo
> commits, this switch will clean this up and make further patches for
> optimizing mptcp_options_received structure cleaner.

Good idea!

> I've done the work here:
> =

> https://github.com/pkrystad/mptcp_net-next/tree/switched-0107
> =

> git diff 3f1306e95e7a..ecd861ac7dc9 (updated export branch today) is no
> changes, I only modified the two affected commits.
> =

> Matthieu: let me know how you want to proceed.

I am looking at that now!
I will do the modifications in the TopGit tree to ease the reviews.
> And Happy New Year everyone!

Thank you! Happy New Year!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6356626433652163250==--
