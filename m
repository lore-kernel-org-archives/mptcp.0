Content-Type: multipart/mixed; boundary="===============8745772716711636769=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Fri, 22 Nov 2019 11:37:44 +0100
Message-ID: <0f60694f2bab24f26e16c6fcd506b44f3a8c1477.camel@redhat.com>
In-Reply-To: e7a9f364c5ff6799dba2624b3724d9e9fb14a423.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2658

--===============8745772716711636769==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-21 at 17:20 -0800, Peter Krystad wrote:
> On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
> > For simplicity's sake use directly sha256 primitives (and pull
> > them as a required build dep).
> > While extracting the data from the hash results, take in account
> > that sha256_final() swaps to be32.
> > Also rename functions and macro accordingly and fix some checkpatch
> > issue (long lines).
> > =

> > Open questions: do we want to squash this into the current patches?
> > Otherwise, should I push some cleanup the existing patches, to reduce
> > the change introduced here?
> =

> Hi Paolo -
> =

> Not sure if it's too late to comment here. =


NP! still on time. Luckily I changed my minds and I had to restart from
scratch several times ;)

> If you do one patch that renames
> =

> mptcp_crypto_key_sha1 to mptcp_crypto_key_sha AND
> mptcp_crypto_hmac_sha1 to mptcp_crypto_hmac_sha AND
> mptcp_cryptio_key_gen_sha1 to mptcp_crypto_key_gen_sha AND
> MPTCP_CAP_HMAC_SHA1 to MPTCP_CAP_HMAC_SHA
> =

> and squash it then the standalone change patch will only have changes for=
 the
> sha routines themselves.

Good idea! I'll do. Additionally I'm refactoring a bit the crypto code
so that transitioning to sha256 primitives will be hopefully more
smooth.

Thanks,

Paolo

--===============8745772716711636769==--
