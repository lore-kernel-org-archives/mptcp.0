Content-Type: multipart/mixed; boundary="===============3800424774401832225=="
MIME-Version: 1.0
From: Eric Biggers <ebiggers at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/7] sha1 library cleanup
Date: Sun, 03 May 2020 09:45:39 -0700
Message-ID: <20200503164539.GA938@sol.localdomain>
In-Reply-To: CAHmME9oPqWfTwTtawM-29Lqck-N-kYo4nGr1-4hCW975DhB0Uw@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4304

--===============3800424774401832225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, May 02, 2020 at 03:05:46PM -0600, Jason A. Donenfeld wrote:
> Thanks for this series. I like the general idea. I think it might make
> sense, though, to separate things out into sha1.h and sha256.h. That
> will be nice preparation work for when we eventually move obsolete
> primitives into some <crypto/dangerous/> subdirectory.

That's basically what I suggested in the cover letter:

"As future work, we should split sha.h into sha1.h and sha2.h and try to
remove the remaining uses of SHA-1.  For example, the remaining use in
drivers/char/random.c is probably one that can be gotten rid of."

("sha2.h" rather than "sha256.h", since it would include SHA-512 too.
Also, we already have sha3.h, so having sha{1,2,3}.h would be logical.)

But there are 108 files that include <crypto/sha.h>, all of which would nee=
d to
be updated, which risks merge conflicts.  So this series seemed like a good
stopping point to get these initial changes in for 5.8.  Then in the next
release we can split up sha.h (and debate whether sha1.h should really be
"<crypto/dangerous/sha1.h>" or whatever).

There are 3 files where I added an include of sha.h, where we could go dire=
ctly
to sha1.h if we did it now.  But that's not much compared to the 108 files.

- Eric
--===============3800424774401832225==--
