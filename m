Content-Type: multipart/mixed; boundary="===============1264977188080387670=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v5 09/11] tcp: Check for filled TCP
 option space before SACK
Date: Fri, 20 Dec 2019 07:27:54 -0800
Message-ID: <034d02ef-e760-3cfa-a6a4-4a1943e73783@gmail.com>
In-Reply-To: 20191219223434.19722-10-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3216

--===============1264977188080387670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/19/19 2:34 PM, Mat Martineau wrote:
> Update the SACK check to work with zero option space available, a case
> that's possible with MPTCP but not MD5+TS. Maintained only one
> conditional branch for insufficient SACK space.
> =

> v1 -> v2:
> - Moves the check inside the SACK branch by taking recent SACK fix:
> =

>     9424e2e7ad93 (tcp: md5: fix potential overestimation of TCP option sp=
ace)
> =

>   in to account, but modifies it to work in MPTCP scenarios beyond the
>   MD5+TS corner case.
> =

> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---

Reviewed-by: Eric Dumazet <edumazet(a)google.com>

--===============1264977188080387670==--
