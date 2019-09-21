Content-Type: multipart/mixed; boundary="===============5000349988897351062=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] mptcp: add MIB counter infrastructure
Date: Sat, 21 Sep 2019 09:28:19 +0200
Message-ID: <20190921072819.GV6961@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1909201652220.79505@tvtrimel-mobl5.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1898

--===============5000349988897351062==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> I went through all the code and don't have any changes to suggest. Regard=
ing
> the extra entries, there are some that have to do with features we aren't
> planning to support right away (checksum-related, mostly), but may be
> relevant later. Is it better to prune them and add back later, or just le=
ave
> them there?

Prune.  I can resubmit a v2 with only those counters left that are
likely going to be useful.

I can also start with adding the appropriate mib increments "for real"
rather than the toy patch i made.

Thanks,
Florian

--===============5000349988897351062==--
