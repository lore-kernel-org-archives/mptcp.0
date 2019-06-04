Content-Type: multipart/mixed; boundary="===============2238152389418353290=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests: errors last night (20190604)
Date: Wed, 05 Jun 2019 00:12:52 +0200
Message-ID: <20190604221252.zb5fpsrumklsqyoa@breakpoint.cc>
In-Reply-To: alpine.OSX.2.21.1906041357030.13961@slseaman-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1282

--===============2238152389418353290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > The same tests were running fine just before without KASAN and
> > PROVE_LOCKING.
> > =

> > I just re-launched the tests and I no longer have this error.
> > =

> > Anyone else saw this error?
> =

> Before Paolo fixed the skb_ext copying problem, I used to see this poll
> timeout regularly, but I haven't seen it in a while. I will keep a look o=
ut
> for the error and try to reproduce it if it comes up again.

Paolo thinks its just because of the test script change that added
qdiscs with random loss and delay/reordering.

I've started a test run now (a ton of test script repeats) and will
test with just raising the timeout.

If that fixes things then Paolo is right and i will submit a test script
patch.

--===============2238152389418353290==--
