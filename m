Content-Type: multipart/mixed; boundary="===============3670260775338639666=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 2/7] selftests: mptcp: add accept/getpeer checks
Date: Thu, 24 Oct 2019 01:51:25 +0200
Message-ID: <20191023235125.GQ25052@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1910231503070.37761@rjszuste-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2302

--===============3670260775338639666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > +static void check_sockaddr(int pf, struct sockaddr_storage *ss,
> > +			   socklen_t salen)
> > +{
> > +	char addr[INET6_ADDRSTRLEN];
> > +	char serv[INET6_ADDRSTRLEN];
> =

> addr and serv are not used and cause a compile warning.

Note to self:  update your VM image :-/

Thanks, I'll fix this up for next iteration.
--===============3670260775338639666==--
