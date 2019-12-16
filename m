Content-Type: multipart/mixed; boundary="===============3751315224549952765=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Mon, 16 Dec 2019 14:13:30 +0100
Message-ID: <d3bfb7e6-387c-378b-b013-08096e19ae9a@tessares.net>
In-Reply-To: a9ebee974914c23cc68877a188908d1a8fa07a5f.1576499362.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3078

--===============3751315224549952765==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 16/12/2019 13:31, Paolo Abeni wrote:
> move sk_pacing_shift to a separate field, so we can READ_ONCE() it.

Thank you addressing Eric's comments!

> Binary layout of struct sock dose not change (except for the
> sk_pacing_shift position)

Just to be sure, does the compiler will optimize the structure to remove =

the "hole" we have here? We use 24/32 bits of the "unsigned int" and =

then we declare the u8. But because we don't declare the "__packed__" =

attribute, the compiler will do his job and we don't increase the size. =

Right? :)

> ---
> This addresses Eric's upstream feedback on v1

I guess we should add this in the commit message.

Or:

   v1:
   - move sk_pacing_shift to a separate field, so we can READ_ONCE() it =

(Eric Dumazet)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============3751315224549952765==--
