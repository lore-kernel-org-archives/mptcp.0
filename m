Content-Type: multipart/mixed; boundary="===============6613925870007111008=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] self-tests: catch poll errors
Date: Wed, 30 Oct 2019 11:43:44 +0100
Message-ID: <20191030104344.GD876@breakpoint.cc>
In-Reply-To: b2c3293ab707db2325b308d366541d3a9b221f08.1572430917.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2350

--===============6613925870007111008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Otherwise in case of a poll error, we end-up looping forever.

Did you see this happen in practice?

> +		if (fds.revents & (POLLERR | POLLNVAL)) {
> +			perror("poll");

errno should be 0 in this case, as poll had revents, i.e. this shows
"poll: success"

Maybe fprintf(stderr, "Unexpected revents: POLLERR/POLLNVAL (%x)\n",
fds.revents); or similar?
--===============6613925870007111008==--
