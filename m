Content-Type: multipart/mixed; boundary="===============5390500759094401361=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 04/26] net: add a new sockptr_t type
Date: Thu, 23 Jul 2020 18:44:32 +0200
Message-ID: <20200723164432.GA20917@lst.de>
In-Reply-To: CANn89iJ3LKth-iWwh0+P3D3RqtDNv4AyXkkzhXr0oSEvE_JoRQ@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5254

--===============5390500759094401361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 09:40:27AM -0700, Eric Dumazet wrote:
> I am not sure why you chose sockptr_t   for something that really seems g=
eneric.
> =

> Or is it really meant to be exclusive to setsockopt() and/or getsockopt()=
 ?
> =

> If the first user of this had been futex code, we would have used
> futexptr_t, I guess.

It was originally intended to be generic and called uptr_t, based
on me misunderstanding that Linus wanted a file operation for it,
which he absolutely didn't and hate with passion.  So the plan is to
only use it for setsockopt for now, although there are some arguments
for also using it in sendmsg/recvmsg.  There is no need to use it for
getsockopt.
--===============5390500759094401361==--
