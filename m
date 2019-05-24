Content-Type: multipart/mixed; boundary="===============7248401542117413051=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v2] net: mptcp: don't leak 'slab' and
 'slab_name' on exit
Date: Fri, 24 May 2019 13:02:37 +0200
Message-ID: <3f76ed71-ead7-edea-ffdc-63a27b721c22@tessares.net>
In-Reply-To: alpine.OSX.2.21.1905231525190.41618@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 1237

--===============7248401542117413051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide, Mat,

On 24/05/2019 00:26, Mat Martineau wrote:
> =

> On Thu, 23 May 2019, Davide Caratti wrote:
> =

>> fix leak of subflows' slab and slab_name in the (rare) case where
>> proto_register(mptcp_prot, 1) returns -ENOBUFS.
>>
>> changes since v1:
>> - use string literal for slab_name rather than allocating it with
>> =C2=A0 kasprintf(), thanks to Mat Martineau
> =

> Ok, patch looks good!

Thank you for the v2 and the review!

> Mat
> =

> =

>>
>> Fixes: e203b1359cf77 ("mptcp: Associate MPTCP context with TCP socket")

I didn't squash it in this commit but in c89487ccb15b (mptcp: Create
SUBFLOW socket for incoming connections) where subflow_ops_init() was
introduced.

- 9b5faeebe499: "squash"
- /           : signed-off was already there
- 4413b0a0064d: conflict
- 02f4d5051237..d159107059dd: result

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============7248401542117413051==--
