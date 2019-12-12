Content-Type: multipart/mixed; boundary="===============9192708152817551927=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Fix dd command line option
Date: Thu, 12 Dec 2019 17:34:08 +0100
Message-ID: <12e000ed-44a7-a00a-30bd-a448371696a9@tessares.net>
In-Reply-To: 20191207001022.20098-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2890

--===============9192708152817551927==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

On 07/12/2019 01:10, Mat Martineau wrote:
> "conv=3D" is a valid command line parameter, but "conf=3D" is not. The er=
ror
> message is redirected to /dev/null so it is not obvious when running
> tests. The tests seem to pass either way, so it's not clear that even
> the "conv=3D" is really needed.

Good catch!

It looks good to me!

I will apply it once we sort out what we can do with Paolo and Davide's =

modifications. Let's discuss that at the meeting.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============9192708152817551927==--
