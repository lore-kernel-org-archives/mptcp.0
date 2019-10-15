Content-Type: multipart/mixed; boundary="===============5335150453060299849=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp:pm: use mptcp_pm_init
Date: Tue, 15 Oct 2019 17:14:13 +0200
Message-ID: <1c57796d-bca1-093c-457f-53a963802c06@tessares.net>
In-Reply-To: 3c470d07-0539-317e-c890-0fd8b627e71d@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2151

--===============5335150453060299849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 15/10/2019 16:55, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 15/10/2019 16:49, Paolo Abeni wrote:
>> On Tue, 2019-10-15 at 16:06 +0200, Matthieu Baerts wrote:
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 3cef22193035..00ab1e7674eb 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1033,6 +1033,7 @@ void __init mptcp_init(void)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_stream_ops.shutdown =3D mptcp_shut=
down;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_subflow_init();
>>> +=C2=A0=C2=A0=C2=A0 mptcp_pm_init();
>>
>> uhmm.. it looks like this chunk will conflict ?!? I see:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0mptcp_subflow_init();
>> =C2=A0=C2=A0=C2=A0=C2=A0mptcp_basic_init();
>>
>> in the current git tree.
> =

> This patch is based on top of "mptcp: Add path manager interface" to =

> avoid a conflict when applying it. I will indeed have a conflict when =

> propagating this but I prefer not to have conflicts when applying the =

> patch :)
> =

>> Otherwise LGTM
> =

> Thank you for the review!
> =

> Because I did patches from different bases, I didn't group these 3 =

> patches. I will then wait for the review of the other patches to apply =

> them all in one :)

Thank you for the quick reviews!

- 46824bb16aa2: "squashed" the first patch (mptcp:pm: use mptcp_pm_init) =

in "mptcp: Add path manager interface"
- 300bf7cd9e1a: conflict in t/mptcp-Implement-basic-path-manager
- f97c5e2d0487: "squashed" the second patch (mptcp:pm: limit changes for =

basic in pm.c) in "mptcp: Implement basic path manager"
- e56cfd119d02: "squashed" the third patch (mptcp:pm: remove duplicated =

RM addr) in "mptcp: Add path manager interface"
- d7c09401756b..80df51ea7f87: result

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5335150453060299849==--
