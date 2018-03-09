Content-Type: multipart/mixed; boundary="===============3840927978034167090=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Restructuring of TCP code for implementing MPTCP
Date: Fri, 09 Mar 2018 14:19:54 -0800
Message-ID: <alpine.OSX.2.21.1803091355420.2360@msottenb-mobl1.amr.corp.intel.com>
In-Reply-To: 09dcd851-5fdc-f1ab-aa84-121fb2c3c65c@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 358

--===============3840927978034167090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao -

On Thu, 22 Feb 2018, Rao Shoaib wrote:

> Hi Folks,
>
> When we met with David Miller and Eric Dumazet about a year ago to discus=
s =

> how to include MPTCP in the main Linux distribution, they wanted to have =
some =

> code that could be evaluated and used at the basis for discussion.
>
> The patches that I have submitted are for starting that discussion only a=
nd =

> nothing else. If the approach is acceptable we can do more cleanup, If no=
t we =

> will have a discussion and hopefully agree on something.
>
> I would like to send the patches, perhaps a week from now to the netdev =

> mailing list to start a discussion there and come up with a plan to imple=
ment =

> MPTCP.
>
> Comments/Suggestions ?
>

I saw that you posted some questions on netdev this week and got some =

maintainer feedback: https://marc.info/?t=3D152039384300002&r=3D1&w=3D2

David mentions:

"""
Indirect calls are terrible and we are now looking at ways in which
we can remove them from as many parts of the networking as possible.
"""

It's not immediately clear which techniques are being looked at (and both =

Eric and David did not elaborate when you followed up). I'm trying to find =

out which alternatives he's referring to - anyone else seen information on =

this?

Regards,

--
Mat Martineau
Intel OTC

--===============3840927978034167090==--
