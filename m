Content-Type: multipart/mixed; boundary="===============8811654201041853823=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Wed, 13 Nov 2019 16:22:09 +0100
Message-ID: <c93d419fa809b1ced87a529f9f4aae54ed170974.camel@redhat.com>
In-Reply-To: be071fb9-edb9-3235-b7e6-f73d7cfdffc4@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2508

--===============8811654201041853823==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-11-13 at 13:41 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 13/11/2019 13:03, Paolo Abeni wrote:
> > On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
> > > For simplicity's sake use directly sha256 primitives (and pull
> > > them as a required build dep).
> > > While extracting the data from the hash results, take in account
> > > that sha256_final() swaps to be32.
> > > Also rename functions and macro accordingly and fix some checkpatch
> > > issue (long lines).
> > =

> > Note: the hmac changes are not trivial, and can't be trivially
> > validated vs RFC 4231 test vectors, as the code poses several
> > restriction on the input size.
> > =

> > I build the following ad-hoc test code (uses some of the rfc4231 test
> > vector, trimmed to fit the mptcp keys/nonces and got the expected
> > result from https://codebeautify.org/hmac-generator).
> > =

> > It can't be included in a self-tests, as it's all in-kernel. I don't
> > thing we want to include this kind of code, but any options welcome!
> =

> Do you think we could use KUnit to do this validation?
> =

> https://kunit.dev
> https://kunit.dev/third_party/kernel/docs/api/test.html

Looks like KUNIT is not there, yet:

https://patchwork.kernel.org/cover/11112577/

will land in net-next in next cycle.

I'll go for custom 'selftest' build option and I'll merge the test with
the hmac patch

Cheers,

Paolo

--===============8811654201041853823==--
