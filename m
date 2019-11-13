Content-Type: multipart/mixed; boundary="===============2723343936035288629=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Wed, 13 Nov 2019 14:24:27 +0100
Message-ID: <20191113132427.GH19558@breakpoint.cc>
In-Reply-To: 5c03bb048a837097d1846d00985c8215a9d62399.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2506

--===============2723343936035288629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
> > For simplicity's sake use directly sha256 primitives (and pull
> > them as a required build dep).
> > While extracting the data from the hash results, take in account
> > that sha256_final() swaps to be32.
> > Also rename functions and macro accordingly and fix some checkpatch
> > issue (long lines).
> =

> Note: the hmac changes are not trivial, and can't be trivially
> validated vs RFC 4231 test vectors, as the code poses several
> restriction on the input size.
> =

> I build the following ad-hoc test code (uses some of the rfc4231 test
> vector, trimmed to fit the mptcp keys/nonces and got the expected
> result from https://codebeautify.org/hmac-generator).

Thanks for doing this.

> It can't be included in a self-tests, as it's all in-kernel. I don't
> thing we want to include this kind of code, but any options welcome!

I think we can include it and add a Kconfig option for it.

(MPTCP_HMAC_SELFTEST or whatever), it can default to off.

--===============2723343936035288629==--
