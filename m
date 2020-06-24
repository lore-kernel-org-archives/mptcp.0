Content-Type: multipart/mixed; boundary="===============5811275221183676756=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v3 0/3] setsockopt: allow reuseport and
 ip6only
Date: Wed, 24 Jun 2020 15:08:49 -0700
Message-ID: <alpine.OSX.2.23.453.2006241502290.39721@adesai3-mobl.amr.corp.intel.com>
In-Reply-To: 20200624192448.20837-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4790

--===============5811275221183676756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 24 Jun 2020, Florian Westphal wrote:

> 3rd iteration.  I've incorporated feedback from Mat, so for
> options other than reuseport/reuseaddr the generic handler gets called
> instead of returning -EOPNOTSUPP.
>
> I've tested that ssh restart works on a a modified kernel that
> enables mptcp for all IPPROTO_TCP sockets.

Thanks for the v3 updates, changes look good. Should the patches go to the =

mptcp repo for some more test coverage or are you intending to post for =

net-next soon?

--
Mat Martineau
Intel
--===============5811275221183676756==--
