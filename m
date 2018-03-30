Content-Type: multipart/mixed; boundary="===============3184733006992887776=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 1/9] Modify tcp structures to support function
 pointers
Date: Fri, 30 Mar 2018 10:32:23 -0700
Message-ID: <619b7db7-0613-4eb6-b3a9-08d21bed1b99@oracle.com>
In-Reply-To: 20180327093637.GA71178@MacBook-Pro-6.lan
X-Status: 
X-Keywords:                  
X-UID: 478

--===============3184733006992887776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/27/2018 02:36 AM, Christoph Paasch wrote:
>
> it is important to explain (in the commit-message) for each of these call=
backs
> why they are needed for an MPTCP implementation and why it can't be done
> without them.
>
> This is important to allow people to understand why the change is necessa=
ry and
> where it is leading to. Ignoring potential performance hits for a moment,
> callbacks also increase the code-maintenance overhead and thus each of th=
em
> will need to justified.
>
>
> Christoph
>
>
>
These callbacks are needed to make the code more readable and =

maintainable. These will be replace by the macro anyways so this does =

not matter.

Shoaib

--===============3184733006992887776==--
