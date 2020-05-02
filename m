Content-Type: multipart/mixed; boundary="===============9120392460864123947=="
MIME-Version: 1.0
From: Jason A. Donenfeld <Jason at zx2c4.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/7] sha1 library cleanup
Date: Sat, 02 May 2020 15:05:46 -0600
Message-ID: <CAHmME9oPqWfTwTtawM-29Lqck-N-kYo4nGr1-4hCW975DhB0Uw@mail.gmail.com>
In-Reply-To: 20200502182427.104383-1-ebiggers@kernel.org
X-Status: 
X-Keywords:                  
X-UID: 4301

--===============9120392460864123947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Thanks for this series. I like the general idea. I think it might make
sense, though, to separate things out into sha1.h and sha256.h. That
will be nice preparation work for when we eventually move obsolete
primitives into some <crypto/dangerous/> subdirectory.
--===============9120392460864123947==--
