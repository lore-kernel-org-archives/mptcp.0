Content-Type: multipart/mixed; boundary="===============8833874965485019612=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp] net: mptcp: fix memory leak in case slab
 allocation fails
Date: Tue, 14 May 2019 18:10:52 +0200
Message-ID: <d09fcfbf-977e-3b23-cf68-f718ac39c81c@tessares.net>
In-Reply-To: f0f987fd1ff1e04c24ecb0ef2043bb80900cb044.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1169

--===============8833874965485019612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat,

Thank you for the fix and the review!

On 14/05/2019 09:59, Davide Caratti wrote:
> On Mon, 2019-05-13 at 16:36 -0700, Mat Martineau wrote:
>> On Mon, 13 May 2019, Davide Caratti wrote:
>>
>>> slab_name is allocated, but not freed, when slab allocation fails: ensu=
re
>>> it is freed in the error path of kmem_cache_create(...). While at it, f=
ix
>>> reverse christmas tree in subflow_ops-init() local variable declaration=
s.
>>
>> Davide -
>>
> Thanks for the leak fix. Looks good to me.
> =

> hi Mat, thanks a lot for reviewing.
> I forgot to mention, this can be squashed into
> aedec94346fb ("mptcp: Create SUBFLOW socket for incoming connections").

Just did as requested:

- Squash: c45d94e6a43d81af6ebead98d9eaa070cbbeedc8
- Signed-off: 959b71909d14072cf0bfbb38a642b7a87a53244a

Cheers,
Matt

> regards,
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============8833874965485019612==--
