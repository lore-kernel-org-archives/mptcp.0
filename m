Content-Type: multipart/mixed; boundary="===============7252147578296828799=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Wed, 13 Nov 2019 13:41:20 +0100
Message-ID: <be071fb9-edb9-3235-b7e6-f73d7cfdffc4@tessares.net>
In-Reply-To: 5c03bb048a837097d1846d00985c8215a9d62399.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2505

--===============7252147578296828799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/11/2019 13:03, Paolo Abeni wrote:
> On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
>> For simplicity's sake use directly sha256 primitives (and pull
>> them as a required build dep).
>> While extracting the data from the hash results, take in account
>> that sha256_final() swaps to be32.
>> Also rename functions and macro accordingly and fix some checkpatch
>> issue (long lines).
> =

> Note: the hmac changes are not trivial, and can't be trivially
> validated vs RFC 4231 test vectors, as the code poses several
> restriction on the input size.
> =

> I build the following ad-hoc test code (uses some of the rfc4231 test
> vector, trimmed to fit the mptcp keys/nonces and got the expected
> result from https://codebeautify.org/hmac-generator).
> =

> It can't be included in a self-tests, as it's all in-kernel. I don't
> thing we want to include this kind of code, but any options welcome!

Do you think we could use KUnit to do this validation?

https://kunit.dev
https://kunit.dev/third_party/kernel/docs/api/test.html

Cheers,
Matt

PS: I was off the last two days (11th was a bank holiday in Belgium), I =

hope being able to apply a maximum of patches today!
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7252147578296828799==--
