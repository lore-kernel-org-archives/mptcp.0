Content-Type: multipart/mixed; boundary="===============1853530624265752524=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp-next 0/2] mptcp: two minor improvements
Date: Fri, 12 Apr 2019 15:28:10 -0700
Message-ID: <alpine.OSX.2.21.1904121526180.54218@lipeng-mobl2.amr.corp.intel.com>
In-Reply-To: 20190411114325.29375-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 1066

--===============1853530624265752524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 11 Apr 2019, Florian Westphal wrote:

> First patch makes it so CONFIG_MPTCP=3Dn build is same as
> building a kernel with all mptcp patches reverted.
>
> Second patch provides minor size reduction of tcp_sock struct
> by closing a 6-byte hole in mptcp rx option struct.
>
> As usual, feel free to squash them as needed.

Thanks Florian.

I squashed the second patch in to the MPTCP patch series. Peter mentioned =

that he has some overlapping changes with your first patch so I haven't =

applied that.

--
Mat Martineau
Intel

--===============1853530624265752524==--
